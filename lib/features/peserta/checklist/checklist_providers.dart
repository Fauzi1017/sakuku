import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/database_providers.dart';
import '../../../data/local/daos/sku_dao.dart';

class ChecklistArgs {
  final String anggotaId;
  final String golongan;
  final String tingkat;

  const ChecklistArgs({
    required this.anggotaId,
    required this.golongan,
    required this.tingkat,
  });

  @override
  bool operator ==(Object other) =>
      other is ChecklistArgs &&
      other.anggotaId == anggotaId &&
      other.golongan == golongan &&
      other.tingkat == tingkat;

  @override
  int get hashCode => Object.hash(anggotaId, golongan, tingkat);
}

final skuChecklistProvider =
    StreamProvider.family<List<SkuChecklistRow>, ChecklistArgs>((ref, args) {
  return ref.watch(skuDaoProvider).watchChecklist(
        anggotaId: args.anggotaId,
        golongan: args.golongan,
        tingkat: args.tingkat,
      );
});
