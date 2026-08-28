import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_client.dart';
import '../network/api_config.dart';
import '../providers/database_providers.dart';
import '../providers/network_providers.dart';
import '../../features/auth/auth_provider.dart';
import 'connectivity_provider.dart';
import 'sync_status.dart';

/// Combined sync indicator: offline > pending outbox > online.
final syncStatusProvider = StreamProvider<SyncStatus>((ref) {
  final controller = StreamController<SyncStatus>();

  void recompute(bool online, int pendingCount) {
    if (!online) {
      controller.add(SyncStatus.offline);
    } else if (pendingCount > 0) {
      controller.add(SyncStatus.pending);
    } else {
      controller.add(SyncStatus.online);
    }
  }

  var lastOnline = false;
  var lastPending = 0;

  ref.listen<AsyncValue<bool>>(isOnlineProvider, (prev, next) {
    lastOnline = next.valueOrNull ?? false;
    recompute(lastOnline, lastPending);
  }, fireImmediately: true);

  final pendingSub =
      ref.watch(syncQueueDaoProvider).watchPendingCount().listen((count) {
    lastPending = count;
    recompute(lastOnline, lastPending);
  });

  ref.onDispose(() {
    pendingSub.cancel();
    controller.close();
  });

  return controller.stream;
});

const _prefsKeyPullCursor = 'sync_pull_cursor';

/// Drains the local outbox (`sync_queue`) against the real API (`api/`,
/// self-hosted per `deploy/vps_setup.sh`) whenever connectivity is
/// available, then pulls whatever changed elsewhere since the last
/// cursor — the two together are the client half of PRD §6.1/§6.4/P0-7
/// ("<30 detik setelah koneksi tersedia, tanpa user harus klik sync").
///
/// A push/pull round only runs when the current session carries a JWT
/// (i.e. this device has logged in online at least once — PRD §6.2) and
/// a backend is actually configured ([ApiConfig.isConfigured]); pure
/// local-only demo use (no backend) is left completely untouched.
class SyncService {
  SyncService(this.ref) {
    _connectivitySub = ref.listen<AsyncValue<bool>>(isOnlineProvider, (prev, next) {
      final online = next.valueOrNull ?? false;
      if (online) unawaited(_run());
    }, fireImmediately: true);

    _pendingSub = ref
        .read(syncQueueDaoProvider)
        .watchPendingCount()
        .listen((count) {
      if (count > 0) unawaited(_run());
    });
  }

  final Ref ref;
  late final ProviderSubscription<AsyncValue<bool>> _connectivitySub;
  late final StreamSubscription<int> _pendingSub;
  bool _busy = false;

  Future<void> _run() async {
    if (_busy || !ApiConfig.isConfigured) return;
    final auth = ref.read(authControllerProvider);
    if (auth is! AuthAuthenticated || auth.token == null) return;

    _busy = true;
    try {
      final deviceId = await ref.read(deviceIdProvider.future);
      await _push(auth.token!, deviceId);
      await _pull(auth.token!);
    } on ApiUnreachableException {
      // Connectivity flapped mid-sync; the next online event retries.
    } finally {
      _busy = false;
    }
  }

  Future<void> _push(String token, String deviceId) async {
    final dao = ref.read(syncQueueDaoProvider);
    final pending = await dao.pending();
    if (pending.isEmpty) return;

    final items = pending
        .map((row) => {
              'id': row.id,
              'entityType': row.entityType,
              'entityId': row.entityId,
              'aksi': row.aksi,
              'payload': jsonDecode(row.payloadJson),
            })
        .toList();

    final response = await ref.read(apiClientProvider).syncPush(
          token: token,
          deviceId: deviceId,
          items: items,
        );
    final accepted = (response['accepted'] as List).cast<String>();
    await dao.markSynced(accepted);
    // Rejected items (malformed payload, etc.) stay pending and are
    // retried on the next round rather than silently dropped.
  }

  Future<void> _pull(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final cursorStr = prefs.getString(_prefsKeyPullCursor);
    final since = cursorStr != null ? DateTime.parse(cursorStr) : DateTime.utc(2000);

    final response = await ref.read(apiClientProvider).syncPull(
          token: token,
          since: since,
        );

    await ref.read(skuDaoProvider).mergeFromPull(
          skuProgress: response['skuProgress'] as List,
          skuEventRows: response['skuEvents'] as List,
        );
    await ref.read(pelantikanDaoProvider).mergeFromPull(response['pelantikan'] as List);

    await prefs.setString(_prefsKeyPullCursor, response['serverTime'] as String);
  }

  void dispose() {
    _connectivitySub.close();
    _pendingSub.cancel();
  }
}

final syncServiceProvider = Provider<SyncService>((ref) {
  final service = SyncService(ref);
  ref.onDispose(service.dispose);
  return service;
});
