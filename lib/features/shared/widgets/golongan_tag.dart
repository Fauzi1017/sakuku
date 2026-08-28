import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// Tag warna aksen sesuai golongan (siaga/penggalang/penegak/pandega).
class GolonganTag extends StatelessWidget {
  const GolonganTag({super.key, required this.golongan, required this.label});

  final String golongan;
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.golonganAksen(golongan);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s3,
        vertical: AppSpacing.s1,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textInverse,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
