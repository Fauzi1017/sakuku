import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/database_providers.dart';
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

/// Drains the local outbox (`sync_queue`) once connectivity is available.
///
/// **This is a stub.** The PRD (§6.2) specifies a REST sync endpoint on a
/// Next.js/Express backend that does not exist yet — there is nothing to
/// push to. What's implemented here is the client-side half described in
/// §6.1/§6.4/P0-7: every offline write already lands in `sync_queue`
/// (see `SkuDao.appendEvent`, `PelantikanDao.catatPelantikan`), and this
/// service demonstrates draining that queue within the "<30 seconds after
/// connectivity returns" budget from P0-7's acceptance criteria. Swap
/// [_pushBatch] for a real HTTP call against the sync endpoint once it
/// exists; the queue/outbox plumbing around it does not need to change.
class SyncService {
  SyncService(this.ref) {
    _sub = ref.listen<AsyncValue<bool>>(isOnlineProvider, (prev, next) {
      final online = next.valueOrNull ?? false;
      if (online) unawaited(_drainQueue());
    });
  }

  final Ref ref;
  late final ProviderSubscription<AsyncValue<bool>> _sub;
  bool _draining = false;

  Future<void> _drainQueue() async {
    if (_draining) return;
    _draining = true;
    try {
      final dao = ref.read(syncQueueDaoProvider);
      final pending = await dao.pending();
      if (pending.isEmpty) return;

      final pushed = await _pushBatch(pending.map((e) => e.id));
      await dao.markSynced(pushed);
    } finally {
      _draining = false;
    }
  }

  /// Simulated push — replace with a real REST call once the backend sync
  /// endpoint from PRD §6.2 exists. Returns the ids that were accepted by
  /// the server so the caller can mark only those as synced.
  Future<List<String>> _pushBatch(Iterable<String> ids) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return ids.toList();
  }

  void dispose() => _sub.close();
}

final syncServiceProvider = Provider<SyncService>((ref) {
  final service = SyncService(ref);
  ref.onDispose(service.dispose);
  return service;
});
