import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// Portofolio digital — riwayat pelantikan TKU/TKK anggota (PRD §8, P0-8).
class PortofolioScreen extends ConsumerWidget {
  const PortofolioScreen({super.key, required this.anggotaId});

  final String anggotaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riwayatAsync =
        ref.watch(_riwayatProvider(anggotaId));

    return riwayatAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Gagal memuat: $err')),
      data: (riwayat) {
        if (riwayat.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.s6),
              child: Text(
                'Belum ada riwayat pelantikan. Selesaikan seluruh poin SKU '
                'untuk direkomendasikan pelantikan oleh pembina.',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final formatter = DateFormat('d MMMM yyyy', 'id_ID');
        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.s4),
          itemCount: riwayat.length,
          itemBuilder: (context, index) {
            final p = riwayat[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s3),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.brand100,
                    child: Icon(
                      p.jenis == 'TKU'
                          ? Icons.military_tech_outlined
                          : Icons.workspace_premium_outlined,
                      color: AppColors.brand700,
                    ),
                  ),
                  title: Text(p.referensiLabel),
                  subtitle: Text(
                    () {
                      try {
                        return formatter.format(p.tanggal);
                      } catch (_) {
                        return p.tanggal.toIso8601String().split('T').first;
                      }
                    }(),
                  ),
                  trailing: Chip(label: Text(p.jenis)),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

final _riwayatProvider = StreamProvider.family((ref, String anggotaId) {
  return ref.watch(pelantikanDaoProvider).watchRiwayat(anggotaId);
});
