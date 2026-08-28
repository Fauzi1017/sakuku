import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/domain.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/local/daos/sku_dao.dart';
import '../../../data/local/database.dart';
import '../../shared/widgets/status_badge.dart';
import 'checklist_providers.dart';
import 'sku_item_detail_sheet.dart';

class SkuChecklistScreen extends ConsumerWidget {
  const SkuChecklistScreen({super.key, required this.anggota});

  final Anggota anggota;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final golongan = anggota.golongan;
    final tingkat = anggota.tingkatSaatIni;

    if (golongan != 'penggalang' || tingkat == null) {
      return const _UnsupportedGolongan();
    }

    final args = ChecklistArgs(
      anggotaId: anggota.id,
      golongan: golongan,
      tingkat: tingkat,
    );
    final checklist = ref.watch(skuChecklistProvider(args));

    return checklist.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Gagal memuat: $err')),
      data: (rows) {
        if (rows.isEmpty) {
          return const Center(child: Text('Belum ada poin SKU untuk tingkat ini.'));
        }

        final byKategori = <String, List<SkuChecklistRow>>{};
        for (final row in rows) {
          final k = row.item.kategori ?? 'Lainnya';
          byKategori.putIfAbsent(k, () => []).add(row);
        }

        final disahkan = rows
            .where((r) => r.status == ProgressStatus.disahkan)
            .length;

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.s4,
                  AppSpacing.s4,
                  AppSpacing.s4,
                  AppSpacing.s2,
                ),
                child: _ProgressSummary(total: rows.length, disahkan: disahkan),
              ),
            ),
            for (final entry in byKategori.entries) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.s4,
                    AppSpacing.s4,
                    AppSpacing.s4,
                    AppSpacing.s1,
                  ),
                  child: Text(
                    _kategoriLabel(entry.key),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              SliverList.builder(
                itemCount: entry.value.length,
                itemBuilder: (context, index) {
                  final row = entry.value[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s4,
                      vertical: AppSpacing.s1,
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          row.item.deskripsi,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: CircleAvatar(
                          child: Text('${row.item.nomorUrut}'),
                        ),
                        trailing: StatusBadge(status: row.status),
                        onTap: () => showSkuItemDetailSheet(
                          context,
                          ref,
                          row: row,
                          anggota: anggota,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.s8)),
          ],
        );
      },
    );
  }

  String _kategoriLabel(String key) => switch (key) {
        'spiritual' => 'Spiritual',
        'kenegaraan' => 'Kenegaraan',
        'fisik' => 'Fisik & Kesehatan',
        'keterampilan' => 'Keterampilan',
        'sosial' => 'Sosial',
        _ => key,
      };
}

class _ProgressSummary extends StatelessWidget {
  const _ProgressSummary({required this.total, required this.disahkan});

  final int total;
  final int disahkan;

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : disahkan / total;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress SKU: $disahkan / $total poin',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.s2),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.full),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
              ),
            ),
            if (progress >= 1.0) ...[
              const SizedBox(height: AppSpacing.s2),
              Text(
                'Semua poin disahkan — siap dilantik!',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _UnsupportedGolongan extends StatelessWidget {
  const _UnsupportedGolongan();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.s6),
        child: Text(
          'Checklist SKU untuk golongan ini belum tersedia di v1 '
          '(cakupan awal: Penggalang — lihat PRD §5).',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
