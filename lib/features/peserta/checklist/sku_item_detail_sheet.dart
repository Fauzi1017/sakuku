import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/domain.dart';
import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/local/daos/sku_dao.dart';
import '../../../data/local/database.dart';
import '../../auth/auth_provider.dart';
import '../../materi/materi_detail_screen.dart';
import '../../shared/widgets/status_badge.dart';

Future<void> showSkuItemDetailSheet(
  BuildContext context,
  WidgetRef ref, {
  required SkuChecklistRow row,
  required Anggota anggota,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => _SkuItemDetailSheet(row: row, anggota: anggota),
  );
}

class _SkuItemDetailSheet extends ConsumerStatefulWidget {
  const _SkuItemDetailSheet({required this.row, required this.anggota});

  final SkuChecklistRow row;
  final Anggota anggota;

  @override
  ConsumerState<_SkuItemDetailSheet> createState() =>
      _SkuItemDetailSheetState();
}

class _SkuItemDetailSheetState extends ConsumerState<_SkuItemDetailSheet> {
  bool _submitting = false;
  List<MateriUnit>? _materi;

  @override
  void initState() {
    super.initState();
    ref
        .read(materiDaoProvider)
        .materiUntukSkuItem(widget.row.item.id)
        .then((value) {
      if (mounted) setState(() => _materi = value);
    });
  }

  Future<void> _ajukanUji() async {
    final auth = ref.read(authControllerProvider);
    if (auth is! AuthAuthenticated) return;

    setState(() => _submitting = true);
    final deviceId = await ref.read(deviceIdProvider.future);
    await ref.read(skuDaoProvider).appendEvent(
          anggotaId: widget.anggota.id,
          skuItemId: widget.row.item.id,
          aktorId: auth.pengguna.id,
          aksi: EventAksi.ajukan,
          deviceId: deviceId,
        );
    if (mounted) {
      setState(() => _submitting = false);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Diajukan untuk diuji pembina.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.row.item;
    final status = widget.row.status;
    final canAjukan =
        status == ProgressStatus.belum || status == ProgressStatus.ditolak;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.s6,
          right: AppSpacing.s6,
          top: AppSpacing.s6,
          bottom: AppSpacing.s6 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Poin #${item.nomorUrut}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                StatusBadge(status: status),
              ],
            ),
            const SizedBox(height: AppSpacing.s3),
            Text(item.deskripsi, style: Theme.of(context).textTheme.bodyLarge),
            if (item.kategori != null) ...[
              const SizedBox(height: AppSpacing.s2),
              Text(
                'Kategori: ${item.kategori}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            if (widget.row.progress?.status == ProgressStatus.ditolak.name) ...[
              const SizedBox(height: AppSpacing.s3),
              Container(
                padding: const EdgeInsets.all(AppSpacing.s3),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  'Pengajuan sebelumnya ditolak. Pelajari kembali materi lalu ajukan ulang.',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.error),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.s5),
            if (_materi != null && _materi!.isNotEmpty) ...[
              Text('Materi terkait', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: AppSpacing.s2),
              ..._materi!.map(
                (m) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.menu_book_outlined),
                    title: Text(m.judul),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MateriDetailScreen(
                            materiUnitId: m.id,
                            anggotaId: widget.anggota.id,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.s4),
            ],
            if (canAjukan)
              ElevatedButton.icon(
                onPressed: _submitting ? null : _ajukanUji,
                icon: _submitting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.textInverse,
                        ),
                      )
                    : const Icon(Icons.send_outlined),
                label: const Text('Ajukan untuk diuji'),
              )
            else if (status == ProgressStatus.diajukan)
              const _InfoBanner(text: 'Menunggu diuji oleh pembina.')
            else if (status == ProgressStatus.disahkan)
              const _InfoBanner(
                text: 'Sudah disahkan.',
                color: AppColors.statusDisahkan,
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({required this.text, this.color = AppColors.statusDiajukan});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
      ),
    );
  }
}
