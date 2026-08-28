import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/providers/database_providers.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/password_hash.dart';
import '../../../data/local/database.dart';

const _uuid = Uuid();

/// Form tambah anggota — Admin Gudep P0-6 (CRUD anggota, tervalidasi
/// email/nomor unik). Membuat baris `pengguna` (role peserta_didik) +
/// `anggota` sekaligus, sesuai relasi 1:1 pada schema.sql.
Future<void> showAddAnggotaDialog(
  BuildContext context,
  WidgetRef ref, {
  required String gudepId,
}) {
  return showDialog(
    context: context,
    builder: (context) => _AddAnggotaDialog(gudepId: gudepId),
  );
}

class _AddAnggotaDialog extends ConsumerStatefulWidget {
  const _AddAnggotaDialog({required this.gudepId});

  final String gudepId;

  @override
  ConsumerState<_AddAnggotaDialog> createState() => _AddAnggotaDialogState();
}

class _AddAnggotaDialogState extends ConsumerState<_AddAnggotaDialog> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _nisController = TextEditingController();
  final _reguController = TextEditingController();
  String _golongan = 'penggalang';
  String _tingkat = 'ramu';
  bool _submitting = false;

  static const _tingkatByGolongan = {
    'siaga': ['mula', 'bantu', 'tata'],
    'penggalang': ['ramu', 'rakit', 'terap'],
    'penegak': ['bantara', 'laksana'],
    'pandega': ['pandega'],
  };

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _nisController.dispose();
    _reguController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);

    final dao = ref.read(penggunaDaoProvider);
    final email = _emailController.text.trim();
    final existing = await dao.findByEmail(email);
    if (existing != null) {
      setState(() => _submitting = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email sudah terdaftar.')),
        );
      }
      return;
    }

    final penggunaId = _uuid.v4();
    await dao.insertPengguna(
      PenggunasCompanion.insert(
        id: penggunaId,
        gudepId: widget.gudepId,
        nama: _namaController.text.trim(),
        email: Value(email),
        passwordHash: PasswordHash.hash('pramuka123'),
        role: 'peserta_didik',
      ),
    );
    await dao.insertAnggota(
      AnggotasCompanion.insert(
        id: _uuid.v4(),
        penggunaId: penggunaId,
        nis: Value(_nisController.text.trim().isEmpty
            ? null
            : _nisController.text.trim()),
        golongan: _golongan,
        tingkatSaatIni: Value(_tingkat),
        reguPasukan: Value(_reguController.text.trim().isEmpty
            ? null
            : _reguController.text.trim()),
      ),
    );

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final tingkatOptions = _tingkatByGolongan[_golongan]!;
    if (!tingkatOptions.contains(_tingkat)) {
      _tingkat = tingkatOptions.first;
    }

    return AlertDialog(
      title: const Text('Tambah Anggota'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: AppSpacing.s3),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => (v == null || v.isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: AppSpacing.s3),
              TextFormField(
                controller: _nisController,
                decoration: const InputDecoration(labelText: 'NIS (opsional)'),
              ),
              const SizedBox(height: AppSpacing.s3),
              TextFormField(
                controller: _reguController,
                decoration: const InputDecoration(labelText: 'Regu/Pasukan (opsional)'),
              ),
              const SizedBox(height: AppSpacing.s3),
              DropdownButtonFormField<String>(
                initialValue: _golongan,
                decoration: const InputDecoration(labelText: 'Golongan'),
                items: _tingkatByGolongan.keys
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (v) => setState(() {
                  _golongan = v!;
                  _tingkat = _tingkatByGolongan[_golongan]!.first;
                }),
              ),
              const SizedBox(height: AppSpacing.s3),
              DropdownButtonFormField<String>(
                initialValue: _tingkat,
                decoration: const InputDecoration(labelText: 'Tingkat'),
                items: tingkatOptions
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _tingkat = v!),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: _submitting ? null : _submit,
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
