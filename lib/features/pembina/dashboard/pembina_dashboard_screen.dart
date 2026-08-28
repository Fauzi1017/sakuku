import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/local/daos/sku_dao.dart';
import '../../../data/local/database.dart';
import '../../auth/auth_provider.dart';
import '../../shared/widgets/golongan_tag.dart';

/// Dashboard progress seluruh anggota binaan (PRD user story pembina:
/// "melihat progress seluruh anggota binaannya"). Anggota yang sudah
/// menyelesaikan seluruh poin SKU mendapat badge "Siap dilantik"
/// (P0-4) dan pembina dapat langsung mencatat pelantikan dari sini.
class PembinaDashboardScreen extends ConsumerWidget {
  const PembinaDashboardScreen({super.key, required this.gudepId});

  final String gudepId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final anggotaAsync = ref.watch(_anggotaSeGudepProvider(gudepId));

    return anggotaAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Gagal memuat: $err')),
      data: (rows) {
        final peserta =
            rows.where((r) => r.$2.role == 'peserta_didik').toList();
        if (peserta.isEmpty) {
          return const Center(child: Text('Belum ada anggota terdaftar.'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.s4),
          itemCount: peserta.length,
          itemBuilder: (context, index) {
            final (anggota, pengguna) = peserta[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s3),
              child: _AnggotaProgressCard(anggota: anggota, namaPengguna: pengguna.nama),
            );
          },
        );
      },
    );
  }
}

final _anggotaSeGudepProvider =
    StreamProvider.family((ref, String gudepId) {
  return ref.watch(penggunaDaoProvider).watchAnggotaSeGudep(gudepId);
});

class _AnggotaProgressCard extends ConsumerWidget {
  const _AnggotaProgressCard({required this.anggota, required this.namaPengguna});

  final Anggota anggota;
  final String namaPengguna;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tingkat = anggota.tingkatSaatIni;
    if (anggota.golongan != 'penggalang' || tingkat == null) {
      return Card(
        child: ListTile(
          title: Text(namaPengguna),
          subtitle: const Text('Golongan belum didukung di v1'),
          trailing: GolonganTag(golongan: anggota.golongan, label: anggota.golongan),
        ),
      );
    }

    return FutureBuilder<SkuProgressSummary>(
      future: ref.read(skuDaoProvider).progressSummary(
            anggotaId: anggota.id,
            golongan: anggota.golongan,
            tingkat: tingkat,
          ),
      builder: (context, snapshot) {
        final summary = snapshot.data;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        namaPengguna,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    GolonganTag(golongan: anggota.golongan, label: tingkat),
                  ],
                ),
                const SizedBox(height: AppSpacing.s2),
                if (summary == null)
                  const LinearProgressIndicator()
                else ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    child: LinearProgressIndicator(
                      value: summary.total == 0
                          ? 0
                          : summary.disahkan / summary.total,
                      minHeight: 8,
                      color: summary.siapDilantik
                          ? AppColors.statusDisahkan
                          : AppColors.brand500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s2),
                  Text(
                    '${summary.disahkan} / ${summary.total} poin disahkan',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (summary.siapDilantik) ...[
                    const SizedBox(height: AppSpacing.s3),
                    Row(
                      children: [
                        const Icon(Icons.celebration_outlined,
                            color: AppColors.statusDisahkan, size: 18),
                        const SizedBox(width: AppSpacing.s1),
                        Text(
                          'Siap dilantik',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: AppColors.statusDisahkan,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const Spacer(),
                        FilledButton.tonal(
                          onPressed: () => _catatPelantikan(context, ref),
                          child: const Text('Catat Pelantikan'),
                        ),
                      ],
                    ),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _catatPelantikan(BuildContext context, WidgetRef ref) async {
    final auth = ref.read(authControllerProvider);
    if (auth is! AuthAuthenticated) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Catat Pelantikan'),
        content: Text(
          'Catat pelantikan TKU "${_tingkatLabel(anggota.tingkatSaatIni!)}" '
          'untuk $namaPengguna?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Catat'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final deviceId = await ref.read(deviceIdProvider.future);
    await ref.read(pelantikanDaoProvider).catatPelantikan(
          anggotaId: anggota.id,
          jenis: 'TKU',
          referensiLabel:
              'Penggalang ${_tingkatLabel(anggota.tingkatSaatIni!)}',
          tanggal: DateTime.now(),
          pembinaId: auth.pengguna.id,
          deviceId: deviceId,
        );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pelantikan tercatat.')),
      );
    }
  }

  String _tingkatLabel(String tingkat) => switch (tingkat) {
        'ramu' => 'Ramu',
        'rakit' => 'Rakit',
        'terap' => 'Terap',
        _ => tingkat,
      };
}
