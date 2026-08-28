import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/database_providers.dart';
import '../../core/theme/app_spacing.dart';
import 'materi_detail_screen.dart';

/// Perpustakaan materi mandiri — dijelajah bebas per kategori/topik
/// (PRD §7.2), semuanya sudah berada di DB lokal sehingga otomatis
/// tersedia offline.
class MateriLibraryScreen extends ConsumerWidget {
  const MateriLibraryScreen({super.key, required this.anggotaId});

  final String anggotaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kategoriAsync = ref.watch(_kategoriProvider);

    return kategoriAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Gagal memuat: $err')),
      data: (kategoriList) => ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.s4),
        itemCount: kategoriList.length,
        itemBuilder: (context, index) {
          final kategori = kategoriList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.s3),
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.folder_outlined),
                title: Text(kategori.nama),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => _TopikScreen(
                      kategoriId: kategori.id,
                      kategoriNama: kategori.nama,
                      anggotaId: anggotaId,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

final _kategoriProvider = StreamProvider((ref) {
  return ref.watch(materiDaoProvider).watchKategori();
});

final _topikProvider = StreamProvider.family((ref, String kategoriId) {
  return ref.watch(materiDaoProvider).watchTopik(kategoriId);
});

final _unitProvider = StreamProvider.family((ref, String topikId) {
  return ref.watch(materiDaoProvider).watchUnit(topikId);
});

class _TopikScreen extends ConsumerWidget {
  const _TopikScreen({
    required this.kategoriId,
    required this.kategoriNama,
    required this.anggotaId,
  });

  final String kategoriId;
  final String kategoriNama;
  final String anggotaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topikAsync = ref.watch(_topikProvider(kategoriId));

    return Scaffold(
      appBar: AppBar(title: Text(kategoriNama)),
      body: topikAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Gagal memuat: $err')),
        data: (topikList) => ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.s4),
          itemCount: topikList.length,
          itemBuilder: (context, index) {
            final topik = topikList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.s3),
              child: Card(
                child: ExpansionTile(
                  title: Text(topik.nama),
                  children: [_UnitList(topikId: topik.id, anggotaId: anggotaId)],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _UnitList extends ConsumerWidget {
  const _UnitList({required this.topikId, required this.anggotaId});

  final String topikId;
  final String anggotaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitAsync = ref.watch(_unitProvider(topikId));
    return unitAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(AppSpacing.s3),
        child: LinearProgressIndicator(),
      ),
      error: (err, _) => Padding(
        padding: const EdgeInsets.all(AppSpacing.s3),
        child: Text('Gagal memuat: $err'),
      ),
      data: (unitList) => Column(
        children: unitList
            .map(
              (unit) => ListTile(
                leading: const Icon(Icons.description_outlined),
                title: Text(unit.judul),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MateriDetailScreen(
                      materiUnitId: unit.id,
                      anggotaId: anggotaId,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
