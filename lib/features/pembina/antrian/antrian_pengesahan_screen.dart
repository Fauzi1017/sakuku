import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../shared/widgets/golongan_tag.dart';
import '../pengesahan_dialog.dart';

/// Antrian pengesahan — seluruh poin `diajukan` di gudep ini, agar pembina
/// bisa menguji & mengesahkan langsung di lapangan tanpa internet (PRD
/// P0-3, user story "melihat daftar anggota yang mengajukan uji").
class AntrianPengesahanScreen extends ConsumerWidget {
  const AntrianPengesahanScreen({super.key, required this.gudepId});

  final String gudepId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final antrianAsync = ref.watch(_antrianProvider(gudepId));

    return antrianAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Gagal memuat: $err')),
      data: (rows) {
        if (rows.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.s6),
              child: Text(
                'Belum ada pengajuan uji yang menunggu.',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.s4),
          itemCount: rows.length,
          itemBuilder: (context, index) {
            final row = rows[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s3),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.statusDiajukan.withValues(alpha: 0.15),
                    child: const Icon(Icons.hourglass_top_outlined, color: AppColors.statusDiajukan),
                  ),
                  title: Text(row.penggunaAnggota.nama),
                  subtitle: Text('#${row.item.nomorUrut} — ${row.item.deskripsi}'),
                  isThreeLine: true,
                  trailing: GolonganTag(
                    golongan: row.anggota.golongan,
                    label: row.anggota.tingkatSaatIni ?? row.anggota.golongan,
                  ),
                  onTap: () => showPengesahanDialog(context, ref, row: row),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

final _antrianProvider = StreamProvider.family((ref, String gudepId) {
  return ref.watch(skuDaoProvider).watchAntrian(gudepId);
});
