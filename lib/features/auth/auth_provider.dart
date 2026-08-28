import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/domain.dart';
import '../../core/providers/database_providers.dart';
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
  const AuthAuthenticated(this.pengguna, this.anggota);

  RoleType get role => RoleType.fromDb(pengguna.role);
}

const _prefsKeyPenggunaId = 'session_pengguna_id';

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
    state = AuthAuthenticated(pengguna, anggota);
  }

  /// Login is checked entirely against the local database — see
  /// [PasswordHash] for why. PRD §6.2 requires the *first ever* login to
  /// happen online against the real backend; once that backend exists,
  /// this method should attempt an online login first and fall back to
  /// comparing against the last-synced local credentials when offline.
  Future<void> login(String email, String password) async {
    state = const AuthLoading();
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

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKeyPenggunaId, pengguna.id);

    final anggota = await dao.anggotaForPengguna(pengguna.id);
    state = AuthAuthenticated(pengguna, anggota);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKeyPenggunaId);
    state = const AuthUnauthenticated();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(ref),
);
