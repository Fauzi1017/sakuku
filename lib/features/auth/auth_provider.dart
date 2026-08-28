import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/domain.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_config.dart';
import '../../core/providers/database_providers.dart';
import '../../core/providers/network_providers.dart';
import '../../core/utils/password_hash.dart';
import '../../data/local/database.dart';

sealed class AuthState {
  const AuthState();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthUnauthenticated extends AuthState {
  final String? error;
  const AuthUnauthenticated({this.error});
}

class AuthAuthenticated extends AuthState {
  final Pengguna pengguna;
  final Anggota? anggota;
  /// Null when this session was authenticated via the local-only
  /// fallback (offline, or no backend configured) — see [AuthController.login].
  final String? token;
  const AuthAuthenticated(this.pengguna, this.anggota, {this.token});

  RoleType get role => RoleType.fromDb(pengguna.role);
}

const _prefsKeyPenggunaId = 'session_pengguna_id';
const _prefsKeyToken = 'session_jwt_token';

class AuthController extends StateNotifier<AuthState> {
  AuthController(this.ref) : super(const AuthLoading()) {
    _restoreSession();
  }

  final Ref ref;

  Future<void> _restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_prefsKeyPenggunaId);
    if (id == null) {
      state = const AuthUnauthenticated();
      return;
    }
    final dao = ref.read(penggunaDaoProvider);
    final pengguna = await dao.findById(id);
    if (pengguna == null) {
      state = const AuthUnauthenticated();
      return;
    }
    final anggota = await dao.anggotaForPengguna(pengguna.id);
    state = AuthAuthenticated(pengguna, anggota, token: prefs.getString(_prefsKeyToken));
  }

  /// PRD §6.2: "login awal wajib online sekali" + "refresh saat online".
  /// When a backend is configured, every login attempts the API first —
  /// on success the account is cached locally (including a local
  /// password hash of what was just typed) so later logins work offline
  /// too. Only a network failure falls back to comparing against that
  /// local cache; a rejected password (401) is reported immediately
  /// without a local fallback, since the server is the source of truth
  /// whenever it's reachable.
  Future<void> login(String email, String password) async {
    state = const AuthLoading();

    if (ApiConfig.isConfigured) {
      try {
        final result = await ref.read(apiClientProvider).login(email, password);
        await _cacheAccountLocally(result, password);
        await _persistSession(
          penggunaId: result.pengguna['id'] as String,
          token: result.token,
        );
        await _loadAuthenticatedState(result.pengguna['id'] as String, token: result.token);
        return;
      } on ApiRequestException catch (e) {
        state = AuthUnauthenticated(
          error: e.statusCode == 401 ? 'Email atau kata sandi salah.' : e.message,
        );
        return;
      } on ApiUnreachableException {
        // Offline — fall through to the local-only check below.
      }
    }

    final dao = ref.read(penggunaDaoProvider);
    final pengguna = await dao.findByEmail(email.trim());

    if (pengguna == null ||
        !PasswordHash.verify(password, pengguna.passwordHash)) {
      state = const AuthUnauthenticated(error: 'Email atau kata sandi salah.');
      return;
    }
    if (pengguna.status != 'aktif') {
      state = const AuthUnauthenticated(error: 'Akun tidak aktif.');
      return;
    }

    await _persistSession(penggunaId: pengguna.id, token: null);
    final anggota = await dao.anggotaForPengguna(pengguna.id);
    state = AuthAuthenticated(pengguna, anggota);
  }

  Future<void> _cacheAccountLocally(LoginResult result, String plainPassword) async {
    final dao = ref.read(penggunaDaoProvider);
    final pengguna = result.pengguna;
    final gudepId = pengguna['gudep_id'] as String;

    await dao.ensureGudep(gudepId);
    await dao.upsertPenggunaFromApi(
      id: pengguna['id'] as String,
      gudepId: gudepId,
      nama: pengguna['nama'] as String,
      email: pengguna['email'] as String?,
      role: pengguna['role'] as String,
      status: pengguna['status'] as String,
      passwordHash: PasswordHash.hash(plainPassword),
    );

    final anggota = result.anggota;
    if (anggota != null) {
      await dao.upsertAnggotaFromApi(
        id: anggota['id'] as String,
        penggunaId: anggota['pengguna_id'] as String,
        nis: anggota['nis'] as String?,
        golongan: anggota['golongan'] as String,
        tingkatSaatIni: anggota['tingkat_saat_ini'] as String?,
        reguPasukan: anggota['regu_pasukan'] as String?,
      );
    }
  }

  Future<void> _loadAuthenticatedState(String penggunaId, {String? token}) async {
    final dao = ref.read(penggunaDaoProvider);
    final pengguna = await dao.findById(penggunaId);
    if (pengguna == null) {
      state = const AuthUnauthenticated(error: 'Gagal memuat akun lokal.');
      return;
    }
    final anggota = await dao.anggotaForPengguna(pengguna.id);
    state = AuthAuthenticated(pengguna, anggota, token: token);
  }

  Future<void> _persistSession({required String penggunaId, String? token}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKeyPenggunaId, penggunaId);
    if (token != null) {
      await prefs.setString(_prefsKeyToken, token);
    } else {
      await prefs.remove(_prefsKeyToken);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKeyPenggunaId);
    await prefs.remove(_prefsKeyToken);
    state = const AuthUnauthenticated();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(ref),
);
