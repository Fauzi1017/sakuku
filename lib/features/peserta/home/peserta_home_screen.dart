import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../auth/auth_provider.dart';
import '../../materi/materi_library_screen.dart';
import '../../shared/widgets/sync_status_chip.dart';
import '../checklist/sku_checklist_screen.dart';
import '../portofolio/portofolio_screen.dart';
import 'beranda_screen.dart';

class PesertaHomeScreen extends ConsumerStatefulWidget {
  const PesertaHomeScreen({super.key});

  @override
  ConsumerState<PesertaHomeScreen> createState() => _PesertaHomeScreenState();
}

class _PesertaHomeScreenState extends ConsumerState<PesertaHomeScreen> {
  int _index = 0;

  static const _titles = ['Beranda', 'Checklist SKU', 'Materi', 'Portofolio'];

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    if (auth is! AuthAuthenticated || auth.anggota == null) {
      return const Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.s6),
            child: Text(
              'Akun ini belum terhubung ke data anggota. Hubungi Admin Gudep.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final anggota = auth.anggota!;
    final pages = [
      BerandaScreen(
        anggota: anggota,
        namaPengguna: auth.pengguna.nama,
        onOpenChecklist: () => setState(() => _index = 1),
      ),
      SkuChecklistScreen(anggota: anggota),
      MateriLibraryScreen(anggotaId: anggota.id),
      PortofolioScreen(anggotaId: anggota.id),
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
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            selectedIcon: Icon(Icons.checklist),
            label: 'Checklist',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Materi',
          ),
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge),
            label: 'Portofolio',
          ),
        ],
      ),
    );
  }
}
