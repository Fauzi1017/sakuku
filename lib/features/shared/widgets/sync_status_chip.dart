import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/sync/sync_service.dart';
import '../../../core/sync/sync_status.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// Small offline/pending/online indicator — uses the
/// `--color-sync-online/pending/offline` tokens (designtokens.css).
class SyncStatusChip extends ConsumerWidget {
  const SyncStatusChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(syncStatusProvider).valueOrNull;
    // Ensure the drain-on-reconnect service is alive for the app session.
    ref.watch(syncServiceProvider);

    final (color, label, icon) = switch (status) {
      SyncStatus.online => (AppColors.syncOnline, 'Tersinkron', Icons.cloud_done_outlined),
      SyncStatus.pending => (AppColors.syncPending, 'Menunggu sinkron', Icons.cloud_sync_outlined),
      SyncStatus.offline => (AppColors.syncOffline, 'Offline', Icons.cloud_off_outlined),
      null => (AppColors.syncOffline, 'Memuat...', Icons.cloud_outlined),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s3,
        vertical: AppSpacing.s1,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: AppSpacing.s1),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
