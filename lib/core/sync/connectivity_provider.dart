import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

bool _hasConnection(List<ConnectivityResult> results) =>
    results.any((r) => r != ConnectivityResult.none);

/// True when at least one active network interface is reported. This is a
/// reachability signal, not a guarantee the sync endpoint itself is
/// reachable — good enough to drive the [SyncStatus] indicator
/// (PRD §6.4/6.5).
final isOnlineProvider = StreamProvider<bool>((ref) async* {
  final connectivity = Connectivity();
  yield _hasConnection(await connectivity.checkConnectivity());
  yield* connectivity.onConnectivityChanged.map(_hasConnection);
});
