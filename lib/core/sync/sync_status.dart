/// Mirrors the `--color-sync-*` design tokens: three states shown to the
/// user via [SyncStatusChip].
enum SyncStatus {
  /// Online and the local outbox is empty.
  online,

  /// There are unsynced local writes — either because we're offline, or
  /// because a push is in flight.
  pending,

  /// No network connectivity.
  offline,
}
