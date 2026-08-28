import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/domain.dart';
import '../../core/providers/database_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/local/daos/sku_dao.dart';
import '../auth/auth_provider.dart';

/// Dialog pengesahan/penolakan poin SKU oleh pembina — setiap keputusan
/// tercatat siapa (aktor), kapan, status, dan catatan opsional (PRD P0-3).
Future<void> showPengesahanDialog(
  BuildContext context,
  WidgetRef ref, {
  required AntrianRow row,
}) {
  return showDialog(
    context: context,
    builder: (context) => _PengesahanDialog(row: row),
  );
}

class _PengesahanDialog extends ConsumerStatefulWidget {
  const _PengesahanDialog({required this.row});

  final AntrianRow row;

  @override
  ConsumerState<_PengesahanDialog> createState() => _PengesahanDialogState();
}

class _PengesahanDialogState extends ConsumerState<_PengesahanDialog> {
  final _catatanController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _catatanController.dispose();
    super.dispose();
  }

  Future<void> _keputusan(EventAksi aksi) async {
    final auth = ref.read(authControllerProvider);
    if (auth is! AuthAuthenticated) return;

    setState(() => _submitting = true);
    final deviceId = await ref.read(deviceIdProvider.future);
    await ref.read(skuDaoProvider).appendEvent(
          anggotaId: widget.row.anggota.id,
          skuItemId: widget.row.item.id,
          aktorId: auth.pengguna.id,
          aksi: aksi,
          catatan: _catatanController.text.trim().isEmpty
              ? null
              : _catatanController.text.trim(),
          deviceId: deviceId,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final row = widget.row;
    return AlertDialog(
      title: Text(row.penggunaAnggota.nama),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Poin #${row.item.nomorUrut}: ${row.item.deskripsi}'),
          const SizedBox(height: AppSpacing.s4),
          TextField(
            controller: _catatanController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Catatan (opsional)',
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        OutlinedButton(
          onPressed: _submitting ? null : () => _keputusan(EventAksi.tolak),
          style: OutlinedButton.styleFrom(foregroundColor: AppColors.error),
          child: const Text('Tolak'),
        ),
        ElevatedButton(
          onPressed: _submitting ? null : () => _keputusan(EventAksi.sahkan),
          child: const Text('Sahkan'),
        ),
      ],
    );
  }
}
