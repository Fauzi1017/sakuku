import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_spacing.dart';
import '../auth/auth_provider.dart';
import '../shared/widgets/sync_status_chip.dart';
import 'antrian/antrian_pengesahan_screen.dart';
import 'dashboard/pembina_dashboard_screen.dart';

class PembinaHomeScreen extends ConsumerStatefulWidget {
  const PembinaHomeScreen({super.key});

  @override
  ConsumerState<PembinaHomeScreen> createState() => _PembinaHomeScreenState();
}

class _PembinaHomeScreenState extends ConsumerState<PembinaHomeScreen> {
  int _index = 0;

  static const _titles = ['Antrian Pengesahan', 'Dashboard Anggota'];

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    if (auth is! AuthAuthenticated) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final gudepId = auth.pengguna.gudepId;
    final pages = [
      AntrianPengesahanScreen(gudepId: gudepId),
      PembinaDashboardScreen(gudepId: gudepId),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
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
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.fact_check_outlined),
            selectedIcon: Icon(Icons.fact_check),
            label: 'Antrian',
          ),
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}
