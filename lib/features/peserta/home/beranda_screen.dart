import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/local/database.dart';

/// Beranda — landing tab for Peserta Didik: browse by golongan, a news
/// digest, and a way to share the app. Only **Penggalang** has a working
/// checklist in v1 (PRD §5); the other golongan cards are shown for
/// wayfinding/consistency with the full Gerakan Pramuka structure but say
/// so when tapped rather than pretending to work.
class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key, required this.anggota, required this.namaPengguna, required this.onOpenChecklist});

  final Anggota anggota;
  final String namaPengguna;
  final VoidCallback onOpenChecklist;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.s4),
      children: [
        _Welcome(nama: namaPengguna),
        const SizedBox(height: AppSpacing.s6),
        _GolonganGrid(anggotaGolongan: anggota.golongan, onOpenChecklist: onOpenChecklist),
        const SizedBox(height: AppSpacing.s8),
        _SectionHeader(
          title: 'News Update',
          actionLabel: 'Lihat semua',
          onAction: () => _showComingSoon(context, 'Kumpulan berita kepramukaan'),
        ),
        const SizedBox(height: AppSpacing.s3),
        const _NewsCarousel(),
        const SizedBox(height: AppSpacing.s8),
        const _ShareCard(),
        const SizedBox(height: AppSpacing.s4),
      ],
    );
  }

  static void _showComingSoon(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label akan hadir di versi berikutnya.')),
    );
  }
}

class _Welcome extends StatelessWidget {
  const _Welcome({required this.nama});

  final String nama;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Halo, $nama! 👋', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.s1),
        Text(
          'Yuk lanjutkan progress SKU-mu hari ini.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _GolonganEntry {
  final String key;
  final String label;
  final Color color;
  final IconData icon;
  final bool supported;

  const _GolonganEntry({
    required this.key,
    required this.label,
    required this.color,
    required this.icon,
    required this.supported,
  });
}

class _GolonganGrid extends StatelessWidget {
  const _GolonganGrid({required this.anggotaGolongan, required this.onOpenChecklist});

  final String anggotaGolongan;
  final VoidCallback onOpenChecklist;

  static final _entries = [
    _GolonganEntry(
      key: 'pra_siaga',
      label: 'Pra Siaga',
      color: AppColors.brand300,
      icon: Icons.child_care_outlined,
      supported: false,
    ),
    _GolonganEntry(
      key: 'siaga',
      label: 'Siaga',
      color: AppColors.siaga,
      icon: Icons.menu_book_outlined,
      supported: false,
    ),
    _GolonganEntry(
      key: 'penggalang',
      label: 'Penggalang',
      color: AppColors.penggalang,
      icon: Icons.local_fire_department_outlined,
      supported: true,
    ),
    _GolonganEntry(
      key: 'penegak',
      label: 'Penegak',
      color: AppColors.penegak,
      icon: Icons.flashlight_on_outlined,
      supported: false,
    ),
    _GolonganEntry(
      key: 'pandega',
      label: 'Pandega',
      color: AppColors.pandega,
      icon: Icons.handyman_outlined,
      supported: false,
    ),
    _GolonganEntry(
      key: 'umum',
      label: 'Umum',
      color: AppColors.info,
      icon: Icons.groups_outlined,
      supported: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.s3,
      crossAxisSpacing: AppSpacing.s3,
      childAspectRatio: 1.4,
      children: _entries.map((entry) {
        final isCurrentGolongan = entry.key == anggotaGolongan;
        return _GolonganCard(
          entry: entry,
          highlighted: isCurrentGolongan,
          onTap: () {
            if (entry.supported) {
              onOpenChecklist();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Checklist ${entry.label} belum tersedia di v1 — cakupan awal adalah Penggalang.',
                  ),
                ),
              );
            }
          },
        );
      }).toList(),
    );
  }
}

class _GolonganCard extends StatelessWidget {
  const _GolonganCard({required this.entry, required this.onTap, required this.highlighted});

  final _GolonganEntry entry;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final background = Color.lerp(entry.color, Colors.white, 0.78)!;
    final foreground = Color.lerp(entry.color, Colors.black, 0.15)!;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s3,
            vertical: AppSpacing.s2,
          ),
          decoration: highlighted
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: entry.color, width: 2),
                )
              : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      entry.label,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: foreground,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    if (!entry.supported) ...[
                      const SizedBox(height: AppSpacing.s1),
                      Text(
                        'Segera hadir',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: foreground.withValues(alpha: 0.7),
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(entry.icon, color: foreground, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.actionLabel, this.onAction});

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(actionLabel!),
                const SizedBox(width: 2),
                const Icon(Icons.chevron_right, size: 18),
              ],
            ),
          ),
      ],
    );
  }
}

class _NewsItem {
  final String title;
  final String source;
  final IconData icon;
  final Color color;

  const _NewsItem(this.title, this.source, this.icon, this.color);
}

/// Static placeholder content — there is no news feed backend yet (out of
/// PRD scope, §3). Swap for a real feed once one exists; the UI shape is
/// ready either way.
class _NewsCarousel extends StatelessWidget {
  const _NewsCarousel();

  static const _items = [
    _NewsItem(
      'Indonesia Raih World Messengers of Peace Hero Award',
      'PRAMUKA.ID',
      Icons.emoji_events_outlined,
      AppColors.brand500,
    ),
    _NewsItem(
      'Tips Aman Berkemah di Musim Hujan',
      'PRAMUKA.ID',
      Icons.terrain_outlined,
      AppColors.info,
    ),
    _NewsItem(
      'Jambore Nasional: Jadwal dan Persiapan',
      'PRAMUKA.ID',
      Icons.hiking_outlined,
      AppColors.penegak,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 184,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s3),
        itemBuilder: (context, index) {
          final item = _items[index];
          return SizedBox(
            width: 260,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 84,
                    color: Color.lerp(item.color, Colors.white, 0.82),
                    alignment: Alignment.center,
                    child: Icon(item.icon, size: 32, color: item.color),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.s3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: AppSpacing.s1),
                        Text(item.source, style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ShareCard extends StatelessWidget {
  const _ShareCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s4),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bagikan aplikasi', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.s1),
                  Text(
                    'Ajak teman seregumu ikut mengisi SKU secara digital.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.s3),
            IconButton.filled(
              onPressed: () => Share.share(
                'Yuk pakai Rimba untuk isi SKU/SKK Pramuka secara digital!',
              ),
              icon: const Icon(Icons.ios_share),
            ),
          ],
        ),
      ),
    );
  }
}
