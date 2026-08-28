import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/database_providers.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/local/database.dart';

/// Materi teori — konten sudah tersimpan penuh di database lokal begitu
/// pernah di-sync, sehingga rendering di sini tidak butuh koneksi sama
/// sekali (PRD §7.2 "mode baca offline penuh").
class MateriDetailScreen extends ConsumerStatefulWidget {
  const MateriDetailScreen({
    super.key,
    required this.materiUnitId,
    required this.anggotaId,
  });

  final String materiUnitId;
  final String anggotaId;

  @override
  ConsumerState<MateriDetailScreen> createState() => _MateriDetailScreenState();
}

class _MateriDetailScreenState extends ConsumerState<MateriDetailScreen> {
  MateriUnit? _unit;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final dao = ref.read(materiDaoProvider);
    final unit = await dao.unitById(widget.materiUnitId);
    if (mounted) setState(() => _unit = unit);
    await dao.tandaiSudahDibaca(
      anggotaId: widget.anggotaId,
      materiUnitId: widget.materiUnitId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final unit = _unit;
    return Scaffold(
      appBar: AppBar(title: Text(unit?.judul ?? 'Materi')),
      body: unit == null
          ? const Center(child: CircularProgressIndicator())
          : Markdown(
              padding: const EdgeInsets.all(AppSpacing.s4),
              data: unit.kontenMarkdown,
            ),
    );
  }
}
