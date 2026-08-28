import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/database_providers.dart';
import '../../core/theme/app_colors.dart';

/// Shown while seed data loads and the persisted session (if any) is
/// restored; [app_router] redirects away as soon as auth state resolves.
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final init = ref.watch(appInitProvider);

    return Scaffold(
      backgroundColor: AppColors.brand500,
      body: Center(
        child: init.when(
          data: (_) => const CircularProgressIndicator(
            color: AppColors.textInverse,
          ),
          loading: () => const CircularProgressIndicator(
            color: AppColors.textInverse,
          ),
          error: (err, stack) => Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Gagal memuat data lokal:\n$err',
              style: const TextStyle(color: AppColors.textInverse),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
