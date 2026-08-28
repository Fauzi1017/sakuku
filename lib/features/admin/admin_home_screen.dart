import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_spacing.dart';
import '../auth/auth_provider.dart';
import '../shared/widgets/sync_status_chip.dart';
import 'anggota/anggota_list_screen.dart';

class AdminHomeScreen extends ConsumerWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    if (auth is! AuthAuthenticated) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anggota Gudep'),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: AppSpacing.s3),
            child: SyncStatusChip(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Keluar',
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: AnggotaListScreen(gudepId: auth.pengguna.gudepId),
    );
  }
}
