import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_spacing.dart';
import '../../shared/widgets/golongan_tag.dart';
import 'add_anggota_dialog.dart';

/// Kelola data anggota, golongan, dan (via `pembina_profil`) assign
/// pembina — Admin Gudep P0-6.
class AnggotaListScreen extends ConsumerStatefulWidget {
  const AnggotaListScreen({super.key, required this.gudepId});

  final String gudepId;

  @override
  ConsumerState<AnggotaListScreen> createState() => _AnggotaListScreenState();
}

class _AnggotaListScreenState extends ConsumerState<AnggotaListScreen> {
  String? _filterGolongan;

  @override
  Widget build(BuildContext context) {
    final rowsAsync = ref.watch(_anggotaSeGudepProvider(widget.gudepId));

    return Scaffold(
      body: rowsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Gagal memuat: $err')),
        data: (rows) {
          final peserta = rows.where((r) => r.$2.role == 'peserta_didik');
          final filtered = _filterGolongan == null
              ? peserta.toList()
              : peserta.where((r) => r.$1.golongan == _filterGolongan).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.s3),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'Semua',
                        selected: _filterGolongan == null,
                        onTap: () => setState(() => _filterGolongan = null),
                      ),
                      for (final g in const ['siaga', 'penggalang', 'penegak', 'pandega'])
                        Padding(
                          padding: const EdgeInsets.only(left: AppSpacing.s2),
                          child: _FilterChip(
                            label: g,
                            selected: _filterGolongan == g,
                            onTap: () => setState(() => _filterGolongan = g),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? const Center(child: Text('Belum ada anggota.'))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final (anggota, pengguna) = filtered[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.s2),
                            child: Card(
                              child: ListTile(
                                title: Text(pengguna.nama),
                                subtitle: Text(
                                  [
                                    if (anggota.nis != null) 'NIS ${anggota.nis}',
                                    if (anggota.reguPasukan != null) anggota.reguPasukan!,
                                    pengguna.email ?? '',
                                  ].where((s) => s.isNotEmpty).join(' · '),
                                ),
                                trailing: GolonganTag(
                                  golongan: anggota.golongan,
                                  label: anggota.tingkatSaatIni ?? anggota.golongan,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddAnggotaDialog(context, ref, gudepId: widget.gudepId),
        icon: const Icon(Icons.person_add_outlined),
        label: const Text('Tambah Anggota'),
      ),
    );
  }
}

final _anggotaSeGudepProvider = StreamProvider.family((ref, String gudepId) {
  return ref.watch(penggunaDaoProvider).watchAnggotaSeGudep(gudepId);
});

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}
