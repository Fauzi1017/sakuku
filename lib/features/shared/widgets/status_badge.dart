import 'package:flutter/material.dart';

import '../../../core/constants/domain.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// Badge tampilan status SKU/SKK (belum/diajukan/disahkan/ditolak).
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final ProgressStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      ProgressStatus.belum => AppColors.statusBelum,
      ProgressStatus.diajukan => AppColors.statusDiajukan,
      ProgressStatus.disahkan => AppColors.statusDisahkan,
      ProgressStatus.ditolak => AppColors.statusDitolak,
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s3,
        vertical: AppSpacing.s1,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        status.label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
