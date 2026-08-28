// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $GudepsTable extends Gudeps with TableInfo<$GudepsTable, Gudep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GudepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alamatMeta = const VerificationMeta('alamat');
  @override
  late final GeneratedColumn<String> alamat = GeneratedColumn<String>(
    'alamat',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kwarcabMeta = const VerificationMeta(
    'kwarcab',
  );
  @override
  late final GeneratedColumn<String> kwarcab = GeneratedColumn<String>(
    'kwarcab',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nama,
    alamat,
    kwarcab,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gudeps';
  @override
  VerificationContext validateIntegrity(
    Insertable<Gudep> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('alamat')) {
      context.handle(
        _alamatMeta,
        alamat.isAcceptableOrUnknown(data['alamat']!, _alamatMeta),
      );
    }
    if (data.containsKey('kwarcab')) {
      context.handle(
        _kwarcabMeta,
        kwarcab.isAcceptableOrUnknown(data['kwarcab']!, _kwarcabMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Gudep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Gudep(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      alamat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alamat'],
      ),
      kwarcab: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kwarcab'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GudepsTable createAlias(String alias) {
    return $GudepsTable(attachedDatabase, alias);
  }
}

class Gudep extends DataClass implements Insertable<Gudep> {
  final String id;
  final String nama;
  final String? alamat;
  final String? kwarcab;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Gudep({
    required this.id,
    required this.nama,
    this.alamat,
    this.kwarcab,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nama'] = Variable<String>(nama);
    if (!nullToAbsent || alamat != null) {
      map['alamat'] = Variable<String>(alamat);
    }
    if (!nullToAbsent || kwarcab != null) {
      map['kwarcab'] = Variable<String>(kwarcab);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GudepsCompanion toCompanion(bool nullToAbsent) {
    return GudepsCompanion(
      id: Value(id),
      nama: Value(nama),
      alamat: alamat == null && nullToAbsent
          ? const Value.absent()
          : Value(alamat),
      kwarcab: kwarcab == null && nullToAbsent
          ? const Value.absent()
          : Value(kwarcab),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Gudep.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Gudep(
      id: serializer.fromJson<String>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      alamat: serializer.fromJson<String?>(json['alamat']),
      kwarcab: serializer.fromJson<String?>(json['kwarcab']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nama': serializer.toJson<String>(nama),
      'alamat': serializer.toJson<String?>(alamat),
      'kwarcab': serializer.toJson<String?>(kwarcab),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Gudep copyWith({
    String? id,
    String? nama,
    Value<String?> alamat = const Value.absent(),
    Value<String?> kwarcab = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Gudep(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    alamat: alamat.present ? alamat.value : this.alamat,
    kwarcab: kwarcab.present ? kwarcab.value : this.kwarcab,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Gudep copyWithCompanion(GudepsCompanion data) {
    return Gudep(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      alamat: data.alamat.present ? data.alamat.value : this.alamat,
      kwarcab: data.kwarcab.present ? data.kwarcab.value : this.kwarcab,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Gudep(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('alamat: $alamat, ')
          ..write('kwarcab: $kwarcab, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nama, alamat, kwarcab, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Gudep &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.alamat == this.alamat &&
          other.kwarcab == this.kwarcab &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GudepsCompanion extends UpdateCompanion<Gudep> {
  final Value<String> id;
  final Value<String> nama;
  final Value<String?> alamat;
  final Value<String?> kwarcab;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GudepsCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.alamat = const Value.absent(),
    this.kwarcab = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GudepsCompanion.insert({
    required String id,
    required String nama,
    this.alamat = const Value.absent(),
    this.kwarcab = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nama = Value(nama);
  static Insertable<Gudep> custom({
    Expression<String>? id,
    Expression<String>? nama,
    Expression<String>? alamat,
    Expression<String>? kwarcab,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (alamat != null) 'alamat': alamat,
      if (kwarcab != null) 'kwarcab': kwarcab,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GudepsCompanion copyWith({
    Value<String>? id,
    Value<String>? nama,
    Value<String?>? alamat,
    Value<String?>? kwarcab,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return GudepsCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      alamat: alamat ?? this.alamat,
      kwarcab: kwarcab ?? this.kwarcab,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (alamat.present) {
      map['alamat'] = Variable<String>(alamat.value);
    }
    if (kwarcab.present) {
      map['kwarcab'] = Variable<String>(kwarcab.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GudepsCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('alamat: $alamat, ')
          ..write('kwarcab: $kwarcab, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PenggunasTable extends Penggunas
    with TableInfo<$PenggunasTable, Pengguna> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PenggunasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gudepIdMeta = const VerificationMeta(
    'gudepId',
  );
  @override
  late final GeneratedColumn<String> gudepId = GeneratedColumn<String>(
    'gudep_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noHpMeta = const VerificationMeta('noHp');
  @override
  late final GeneratedColumn<String> noHp = GeneratedColumn<String>(
    'no_hp',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('aktif'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gudepId,
    nama,
    email,
    noHp,
    passwordHash,
    role,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'penggunas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pengguna> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('gudep_id')) {
      context.handle(
        _gudepIdMeta,
        gudepId.isAcceptableOrUnknown(data['gudep_id']!, _gudepIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gudepIdMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('no_hp')) {
      context.handle(
        _noHpMeta,
        noHp.isAcceptableOrUnknown(data['no_hp']!, _noHpMeta),
      );
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pengguna map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pengguna(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gudepId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gudep_id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      noHp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}no_hp'],
      ),
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PenggunasTable createAlias(String alias) {
    return $PenggunasTable(attachedDatabase, alias);
  }
}

class Pengguna extends DataClass implements Insertable<Pengguna> {
  final String id;
  final String gudepId;
  final String nama;
  final String? email;
  final String? noHp;
  final String passwordHash;
  final String role;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Pengguna({
    required this.id,
    required this.gudepId,
    required this.nama,
    this.email,
    this.noHp,
    required this.passwordHash,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['gudep_id'] = Variable<String>(gudepId);
    map['nama'] = Variable<String>(nama);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || noHp != null) {
      map['no_hp'] = Variable<String>(noHp);
    }
    map['password_hash'] = Variable<String>(passwordHash);
    map['role'] = Variable<String>(role);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PenggunasCompanion toCompanion(bool nullToAbsent) {
    return PenggunasCompanion(
      id: Value(id),
      gudepId: Value(gudepId),
      nama: Value(nama),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      noHp: noHp == null && nullToAbsent ? const Value.absent() : Value(noHp),
      passwordHash: Value(passwordHash),
      role: Value(role),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Pengguna.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pengguna(
      id: serializer.fromJson<String>(json['id']),
      gudepId: serializer.fromJson<String>(json['gudepId']),
      nama: serializer.fromJson<String>(json['nama']),
      email: serializer.fromJson<String?>(json['email']),
      noHp: serializer.fromJson<String?>(json['noHp']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      role: serializer.fromJson<String>(json['role']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gudepId': serializer.toJson<String>(gudepId),
      'nama': serializer.toJson<String>(nama),
      'email': serializer.toJson<String?>(email),
      'noHp': serializer.toJson<String?>(noHp),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'role': serializer.toJson<String>(role),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Pengguna copyWith({
    String? id,
    String? gudepId,
    String? nama,
    Value<String?> email = const Value.absent(),
    Value<String?> noHp = const Value.absent(),
    String? passwordHash,
    String? role,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Pengguna(
    id: id ?? this.id,
    gudepId: gudepId ?? this.gudepId,
    nama: nama ?? this.nama,
    email: email.present ? email.value : this.email,
    noHp: noHp.present ? noHp.value : this.noHp,
    passwordHash: passwordHash ?? this.passwordHash,
    role: role ?? this.role,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Pengguna copyWithCompanion(PenggunasCompanion data) {
    return Pengguna(
      id: data.id.present ? data.id.value : this.id,
      gudepId: data.gudepId.present ? data.gudepId.value : this.gudepId,
      nama: data.nama.present ? data.nama.value : this.nama,
      email: data.email.present ? data.email.value : this.email,
      noHp: data.noHp.present ? data.noHp.value : this.noHp,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      role: data.role.present ? data.role.value : this.role,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pengguna(')
          ..write('id: $id, ')
          ..write('gudepId: $gudepId, ')
          ..write('nama: $nama, ')
          ..write('email: $email, ')
          ..write('noHp: $noHp, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gudepId,
    nama,
    email,
    noHp,
    passwordHash,
    role,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pengguna &&
          other.id == this.id &&
          other.gudepId == this.gudepId &&
          other.nama == this.nama &&
          other.email == this.email &&
          other.noHp == this.noHp &&
          other.passwordHash == this.passwordHash &&
          other.role == this.role &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PenggunasCompanion extends UpdateCompanion<Pengguna> {
  final Value<String> id;
  final Value<String> gudepId;
  final Value<String> nama;
  final Value<String?> email;
  final Value<String?> noHp;
  final Value<String> passwordHash;
  final Value<String> role;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PenggunasCompanion({
    this.id = const Value.absent(),
    this.gudepId = const Value.absent(),
    this.nama = const Value.absent(),
    this.email = const Value.absent(),
    this.noHp = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.role = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PenggunasCompanion.insert({
    required String id,
    required String gudepId,
    required String nama,
    this.email = const Value.absent(),
    this.noHp = const Value.absent(),
    required String passwordHash,
    required String role,
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gudepId = Value(gudepId),
       nama = Value(nama),
       passwordHash = Value(passwordHash),
       role = Value(role);
  static Insertable<Pengguna> custom({
    Expression<String>? id,
    Expression<String>? gudepId,
    Expression<String>? nama,
    Expression<String>? email,
    Expression<String>? noHp,
    Expression<String>? passwordHash,
    Expression<String>? role,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gudepId != null) 'gudep_id': gudepId,
      if (nama != null) 'nama': nama,
      if (email != null) 'email': email,
      if (noHp != null) 'no_hp': noHp,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (role != null) 'role': role,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PenggunasCompanion copyWith({
    Value<String>? id,
    Value<String>? gudepId,
    Value<String>? nama,
    Value<String?>? email,
    Value<String?>? noHp,
    Value<String>? passwordHash,
    Value<String>? role,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PenggunasCompanion(
      id: id ?? this.id,
      gudepId: gudepId ?? this.gudepId,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      noHp: noHp ?? this.noHp,
      passwordHash: passwordHash ?? this.passwordHash,
      role: role ?? this.role,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gudepId.present) {
      map['gudep_id'] = Variable<String>(gudepId.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (noHp.present) {
      map['no_hp'] = Variable<String>(noHp.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PenggunasCompanion(')
          ..write('id: $id, ')
          ..write('gudepId: $gudepId, ')
          ..write('nama: $nama, ')
          ..write('email: $email, ')
          ..write('noHp: $noHp, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnggotasTable extends Anggotas with TableInfo<$AnggotasTable, Anggota> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnggotasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _penggunaIdMeta = const VerificationMeta(
    'penggunaId',
  );
  @override
  late final GeneratedColumn<String> penggunaId = GeneratedColumn<String>(
    'pengguna_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nisMeta = const VerificationMeta('nis');
  @override
  late final GeneratedColumn<String> nis = GeneratedColumn<String>(
    'nis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _golonganMeta = const VerificationMeta(
    'golongan',
  );
  @override
  late final GeneratedColumn<String> golongan = GeneratedColumn<String>(
    'golongan',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tingkatSaatIniMeta = const VerificationMeta(
    'tingkatSaatIni',
  );
  @override
  late final GeneratedColumn<String> tingkatSaatIni = GeneratedColumn<String>(
    'tingkat_saat_ini',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tanggalLahirMeta = const VerificationMeta(
    'tanggalLahir',
  );
  @override
  late final GeneratedColumn<DateTime> tanggalLahir = GeneratedColumn<DateTime>(
    'tanggal_lahir',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _namaWaliMeta = const VerificationMeta(
    'namaWali',
  );
  @override
  late final GeneratedColumn<String> namaWali = GeneratedColumn<String>(
    'nama_wali',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kontakWaliMeta = const VerificationMeta(
    'kontakWali',
  );
  @override
  late final GeneratedColumn<String> kontakWali = GeneratedColumn<String>(
    'kontak_wali',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reguPasukanMeta = const VerificationMeta(
    'reguPasukan',
  );
  @override
  late final GeneratedColumn<String> reguPasukan = GeneratedColumn<String>(
    'regu_pasukan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    penggunaId,
    nis,
    golongan,
    tingkatSaatIni,
    tanggalLahir,
    namaWali,
    kontakWali,
    reguPasukan,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'anggotas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Anggota> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pengguna_id')) {
      context.handle(
        _penggunaIdMeta,
        penggunaId.isAcceptableOrUnknown(data['pengguna_id']!, _penggunaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_penggunaIdMeta);
    }
    if (data.containsKey('nis')) {
      context.handle(
        _nisMeta,
        nis.isAcceptableOrUnknown(data['nis']!, _nisMeta),
      );
    }
    if (data.containsKey('golongan')) {
      context.handle(
        _golonganMeta,
        golongan.isAcceptableOrUnknown(data['golongan']!, _golonganMeta),
      );
    } else if (isInserting) {
      context.missing(_golonganMeta);
    }
    if (data.containsKey('tingkat_saat_ini')) {
      context.handle(
        _tingkatSaatIniMeta,
        tingkatSaatIni.isAcceptableOrUnknown(
          data['tingkat_saat_ini']!,
          _tingkatSaatIniMeta,
        ),
      );
    }
    if (data.containsKey('tanggal_lahir')) {
      context.handle(
        _tanggalLahirMeta,
        tanggalLahir.isAcceptableOrUnknown(
          data['tanggal_lahir']!,
          _tanggalLahirMeta,
        ),
      );
    }
    if (data.containsKey('nama_wali')) {
      context.handle(
        _namaWaliMeta,
        namaWali.isAcceptableOrUnknown(data['nama_wali']!, _namaWaliMeta),
      );
    }
    if (data.containsKey('kontak_wali')) {
      context.handle(
        _kontakWaliMeta,
        kontakWali.isAcceptableOrUnknown(data['kontak_wali']!, _kontakWaliMeta),
      );
    }
    if (data.containsKey('regu_pasukan')) {
      context.handle(
        _reguPasukanMeta,
        reguPasukan.isAcceptableOrUnknown(
          data['regu_pasukan']!,
          _reguPasukanMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Anggota map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Anggota(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      penggunaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pengguna_id'],
      )!,
      nis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nis'],
      ),
      golongan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}golongan'],
      )!,
      tingkatSaatIni: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tingkat_saat_ini'],
      ),
      tanggalLahir: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal_lahir'],
      ),
      namaWali: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama_wali'],
      ),
      kontakWali: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kontak_wali'],
      ),
      reguPasukan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}regu_pasukan'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AnggotasTable createAlias(String alias) {
    return $AnggotasTable(attachedDatabase, alias);
  }
}

class Anggota extends DataClass implements Insertable<Anggota> {
  final String id;
  final String penggunaId;
  final String? nis;
  final String golongan;
  final String? tingkatSaatIni;
  final DateTime? tanggalLahir;
  final String? namaWali;
  final String? kontakWali;
  final String? reguPasukan;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Anggota({
    required this.id,
    required this.penggunaId,
    this.nis,
    required this.golongan,
    this.tingkatSaatIni,
    this.tanggalLahir,
    this.namaWali,
    this.kontakWali,
    this.reguPasukan,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pengguna_id'] = Variable<String>(penggunaId);
    if (!nullToAbsent || nis != null) {
      map['nis'] = Variable<String>(nis);
    }
    map['golongan'] = Variable<String>(golongan);
    if (!nullToAbsent || tingkatSaatIni != null) {
      map['tingkat_saat_ini'] = Variable<String>(tingkatSaatIni);
    }
    if (!nullToAbsent || tanggalLahir != null) {
      map['tanggal_lahir'] = Variable<DateTime>(tanggalLahir);
    }
    if (!nullToAbsent || namaWali != null) {
      map['nama_wali'] = Variable<String>(namaWali);
    }
    if (!nullToAbsent || kontakWali != null) {
      map['kontak_wali'] = Variable<String>(kontakWali);
    }
    if (!nullToAbsent || reguPasukan != null) {
      map['regu_pasukan'] = Variable<String>(reguPasukan);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AnggotasCompanion toCompanion(bool nullToAbsent) {
    return AnggotasCompanion(
      id: Value(id),
      penggunaId: Value(penggunaId),
      nis: nis == null && nullToAbsent ? const Value.absent() : Value(nis),
      golongan: Value(golongan),
      tingkatSaatIni: tingkatSaatIni == null && nullToAbsent
          ? const Value.absent()
          : Value(tingkatSaatIni),
      tanggalLahir: tanggalLahir == null && nullToAbsent
          ? const Value.absent()
          : Value(tanggalLahir),
      namaWali: namaWali == null && nullToAbsent
          ? const Value.absent()
          : Value(namaWali),
      kontakWali: kontakWali == null && nullToAbsent
          ? const Value.absent()
          : Value(kontakWali),
      reguPasukan: reguPasukan == null && nullToAbsent
          ? const Value.absent()
          : Value(reguPasukan),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Anggota.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Anggota(
      id: serializer.fromJson<String>(json['id']),
      penggunaId: serializer.fromJson<String>(json['penggunaId']),
      nis: serializer.fromJson<String?>(json['nis']),
      golongan: serializer.fromJson<String>(json['golongan']),
      tingkatSaatIni: serializer.fromJson<String?>(json['tingkatSaatIni']),
      tanggalLahir: serializer.fromJson<DateTime?>(json['tanggalLahir']),
      namaWali: serializer.fromJson<String?>(json['namaWali']),
      kontakWali: serializer.fromJson<String?>(json['kontakWali']),
      reguPasukan: serializer.fromJson<String?>(json['reguPasukan']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'penggunaId': serializer.toJson<String>(penggunaId),
      'nis': serializer.toJson<String?>(nis),
      'golongan': serializer.toJson<String>(golongan),
      'tingkatSaatIni': serializer.toJson<String?>(tingkatSaatIni),
      'tanggalLahir': serializer.toJson<DateTime?>(tanggalLahir),
      'namaWali': serializer.toJson<String?>(namaWali),
      'kontakWali': serializer.toJson<String?>(kontakWali),
      'reguPasukan': serializer.toJson<String?>(reguPasukan),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Anggota copyWith({
    String? id,
    String? penggunaId,
    Value<String?> nis = const Value.absent(),
    String? golongan,
    Value<String?> tingkatSaatIni = const Value.absent(),
    Value<DateTime?> tanggalLahir = const Value.absent(),
    Value<String?> namaWali = const Value.absent(),
    Value<String?> kontakWali = const Value.absent(),
    Value<String?> reguPasukan = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Anggota(
    id: id ?? this.id,
    penggunaId: penggunaId ?? this.penggunaId,
    nis: nis.present ? nis.value : this.nis,
    golongan: golongan ?? this.golongan,
    tingkatSaatIni: tingkatSaatIni.present
        ? tingkatSaatIni.value
        : this.tingkatSaatIni,
    tanggalLahir: tanggalLahir.present ? tanggalLahir.value : this.tanggalLahir,
    namaWali: namaWali.present ? namaWali.value : this.namaWali,
    kontakWali: kontakWali.present ? kontakWali.value : this.kontakWali,
    reguPasukan: reguPasukan.present ? reguPasukan.value : this.reguPasukan,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Anggota copyWithCompanion(AnggotasCompanion data) {
    return Anggota(
      id: data.id.present ? data.id.value : this.id,
      penggunaId: data.penggunaId.present
          ? data.penggunaId.value
          : this.penggunaId,
      nis: data.nis.present ? data.nis.value : this.nis,
      golongan: data.golongan.present ? data.golongan.value : this.golongan,
      tingkatSaatIni: data.tingkatSaatIni.present
          ? data.tingkatSaatIni.value
          : this.tingkatSaatIni,
      tanggalLahir: data.tanggalLahir.present
          ? data.tanggalLahir.value
          : this.tanggalLahir,
      namaWali: data.namaWali.present ? data.namaWali.value : this.namaWali,
      kontakWali: data.kontakWali.present
          ? data.kontakWali.value
          : this.kontakWali,
      reguPasukan: data.reguPasukan.present
          ? data.reguPasukan.value
          : this.reguPasukan,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Anggota(')
          ..write('id: $id, ')
          ..write('penggunaId: $penggunaId, ')
          ..write('nis: $nis, ')
          ..write('golongan: $golongan, ')
          ..write('tingkatSaatIni: $tingkatSaatIni, ')
          ..write('tanggalLahir: $tanggalLahir, ')
          ..write('namaWali: $namaWali, ')
          ..write('kontakWali: $kontakWali, ')
          ..write('reguPasukan: $reguPasukan, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    penggunaId,
    nis,
    golongan,
    tingkatSaatIni,
    tanggalLahir,
    namaWali,
    kontakWali,
    reguPasukan,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Anggota &&
          other.id == this.id &&
          other.penggunaId == this.penggunaId &&
          other.nis == this.nis &&
          other.golongan == this.golongan &&
          other.tingkatSaatIni == this.tingkatSaatIni &&
          other.tanggalLahir == this.tanggalLahir &&
          other.namaWali == this.namaWali &&
          other.kontakWali == this.kontakWali &&
          other.reguPasukan == this.reguPasukan &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AnggotasCompanion extends UpdateCompanion<Anggota> {
  final Value<String> id;
  final Value<String> penggunaId;
  final Value<String?> nis;
  final Value<String> golongan;
  final Value<String?> tingkatSaatIni;
  final Value<DateTime?> tanggalLahir;
  final Value<String?> namaWali;
  final Value<String?> kontakWali;
  final Value<String?> reguPasukan;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AnggotasCompanion({
    this.id = const Value.absent(),
    this.penggunaId = const Value.absent(),
    this.nis = const Value.absent(),
    this.golongan = const Value.absent(),
    this.tingkatSaatIni = const Value.absent(),
    this.tanggalLahir = const Value.absent(),
    this.namaWali = const Value.absent(),
    this.kontakWali = const Value.absent(),
    this.reguPasukan = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnggotasCompanion.insert({
    required String id,
    required String penggunaId,
    this.nis = const Value.absent(),
    required String golongan,
    this.tingkatSaatIni = const Value.absent(),
    this.tanggalLahir = const Value.absent(),
    this.namaWali = const Value.absent(),
    this.kontakWali = const Value.absent(),
    this.reguPasukan = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       penggunaId = Value(penggunaId),
       golongan = Value(golongan);
  static Insertable<Anggota> custom({
    Expression<String>? id,
    Expression<String>? penggunaId,
    Expression<String>? nis,
    Expression<String>? golongan,
    Expression<String>? tingkatSaatIni,
    Expression<DateTime>? tanggalLahir,
    Expression<String>? namaWali,
    Expression<String>? kontakWali,
    Expression<String>? reguPasukan,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (penggunaId != null) 'pengguna_id': penggunaId,
      if (nis != null) 'nis': nis,
      if (golongan != null) 'golongan': golongan,
      if (tingkatSaatIni != null) 'tingkat_saat_ini': tingkatSaatIni,
      if (tanggalLahir != null) 'tanggal_lahir': tanggalLahir,
      if (namaWali != null) 'nama_wali': namaWali,
      if (kontakWali != null) 'kontak_wali': kontakWali,
      if (reguPasukan != null) 'regu_pasukan': reguPasukan,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnggotasCompanion copyWith({
    Value<String>? id,
    Value<String>? penggunaId,
    Value<String?>? nis,
    Value<String>? golongan,
    Value<String?>? tingkatSaatIni,
    Value<DateTime?>? tanggalLahir,
    Value<String?>? namaWali,
    Value<String?>? kontakWali,
    Value<String?>? reguPasukan,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AnggotasCompanion(
      id: id ?? this.id,
      penggunaId: penggunaId ?? this.penggunaId,
      nis: nis ?? this.nis,
      golongan: golongan ?? this.golongan,
      tingkatSaatIni: tingkatSaatIni ?? this.tingkatSaatIni,
      tanggalLahir: tanggalLahir ?? this.tanggalLahir,
      namaWali: namaWali ?? this.namaWali,
      kontakWali: kontakWali ?? this.kontakWali,
      reguPasukan: reguPasukan ?? this.reguPasukan,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (penggunaId.present) {
      map['pengguna_id'] = Variable<String>(penggunaId.value);
    }
    if (nis.present) {
      map['nis'] = Variable<String>(nis.value);
    }
    if (golongan.present) {
      map['golongan'] = Variable<String>(golongan.value);
    }
    if (tingkatSaatIni.present) {
      map['tingkat_saat_ini'] = Variable<String>(tingkatSaatIni.value);
    }
    if (tanggalLahir.present) {
      map['tanggal_lahir'] = Variable<DateTime>(tanggalLahir.value);
    }
    if (namaWali.present) {
      map['nama_wali'] = Variable<String>(namaWali.value);
    }
    if (kontakWali.present) {
      map['kontak_wali'] = Variable<String>(kontakWali.value);
    }
    if (reguPasukan.present) {
      map['regu_pasukan'] = Variable<String>(reguPasukan.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnggotasCompanion(')
          ..write('id: $id, ')
          ..write('penggunaId: $penggunaId, ')
          ..write('nis: $nis, ')
          ..write('golongan: $golongan, ')
          ..write('tingkatSaatIni: $tingkatSaatIni, ')
          ..write('tanggalLahir: $tanggalLahir, ')
          ..write('namaWali: $namaWali, ')
          ..write('kontakWali: $kontakWali, ')
          ..write('reguPasukan: $reguPasukan, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PembinaProfilsTable extends PembinaProfils
    with TableInfo<$PembinaProfilsTable, PembinaProfil> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PembinaProfilsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _penggunaIdMeta = const VerificationMeta(
    'penggunaId',
  );
  @override
  late final GeneratedColumn<String> penggunaId = GeneratedColumn<String>(
    'pengguna_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _bidangKeahlianMeta = const VerificationMeta(
    'bidangKeahlian',
  );
  @override
  late final GeneratedColumn<String> bidangKeahlian = GeneratedColumn<String>(
    'bidang_keahlian',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keteranganMeta = const VerificationMeta(
    'keterangan',
  );
  @override
  late final GeneratedColumn<String> keterangan = GeneratedColumn<String>(
    'keterangan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    penggunaId,
    bidangKeahlian,
    keterangan,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pembina_profils';
  @override
  VerificationContext validateIntegrity(
    Insertable<PembinaProfil> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pengguna_id')) {
      context.handle(
        _penggunaIdMeta,
        penggunaId.isAcceptableOrUnknown(data['pengguna_id']!, _penggunaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_penggunaIdMeta);
    }
    if (data.containsKey('bidang_keahlian')) {
      context.handle(
        _bidangKeahlianMeta,
        bidangKeahlian.isAcceptableOrUnknown(
          data['bidang_keahlian']!,
          _bidangKeahlianMeta,
        ),
      );
    }
    if (data.containsKey('keterangan')) {
      context.handle(
        _keteranganMeta,
        keterangan.isAcceptableOrUnknown(data['keterangan']!, _keteranganMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PembinaProfil map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PembinaProfil(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      penggunaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pengguna_id'],
      )!,
      bidangKeahlian: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bidang_keahlian'],
      ),
      keterangan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}keterangan'],
      ),
    );
  }

  @override
  $PembinaProfilsTable createAlias(String alias) {
    return $PembinaProfilsTable(attachedDatabase, alias);
  }
}

class PembinaProfil extends DataClass implements Insertable<PembinaProfil> {
  final String id;
  final String penggunaId;
  final String? bidangKeahlian;
  final String? keterangan;
  const PembinaProfil({
    required this.id,
    required this.penggunaId,
    this.bidangKeahlian,
    this.keterangan,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pengguna_id'] = Variable<String>(penggunaId);
    if (!nullToAbsent || bidangKeahlian != null) {
      map['bidang_keahlian'] = Variable<String>(bidangKeahlian);
    }
    if (!nullToAbsent || keterangan != null) {
      map['keterangan'] = Variable<String>(keterangan);
    }
    return map;
  }

  PembinaProfilsCompanion toCompanion(bool nullToAbsent) {
    return PembinaProfilsCompanion(
      id: Value(id),
      penggunaId: Value(penggunaId),
      bidangKeahlian: bidangKeahlian == null && nullToAbsent
          ? const Value.absent()
          : Value(bidangKeahlian),
      keterangan: keterangan == null && nullToAbsent
          ? const Value.absent()
          : Value(keterangan),
    );
  }

  factory PembinaProfil.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PembinaProfil(
      id: serializer.fromJson<String>(json['id']),
      penggunaId: serializer.fromJson<String>(json['penggunaId']),
      bidangKeahlian: serializer.fromJson<String?>(json['bidangKeahlian']),
      keterangan: serializer.fromJson<String?>(json['keterangan']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'penggunaId': serializer.toJson<String>(penggunaId),
      'bidangKeahlian': serializer.toJson<String?>(bidangKeahlian),
      'keterangan': serializer.toJson<String?>(keterangan),
    };
  }

  PembinaProfil copyWith({
    String? id,
    String? penggunaId,
    Value<String?> bidangKeahlian = const Value.absent(),
    Value<String?> keterangan = const Value.absent(),
  }) => PembinaProfil(
    id: id ?? this.id,
    penggunaId: penggunaId ?? this.penggunaId,
    bidangKeahlian: bidangKeahlian.present
        ? bidangKeahlian.value
        : this.bidangKeahlian,
    keterangan: keterangan.present ? keterangan.value : this.keterangan,
  );
  PembinaProfil copyWithCompanion(PembinaProfilsCompanion data) {
    return PembinaProfil(
      id: data.id.present ? data.id.value : this.id,
      penggunaId: data.penggunaId.present
          ? data.penggunaId.value
          : this.penggunaId,
      bidangKeahlian: data.bidangKeahlian.present
          ? data.bidangKeahlian.value
          : this.bidangKeahlian,
      keterangan: data.keterangan.present
          ? data.keterangan.value
          : this.keterangan,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PembinaProfil(')
          ..write('id: $id, ')
          ..write('penggunaId: $penggunaId, ')
          ..write('bidangKeahlian: $bidangKeahlian, ')
          ..write('keterangan: $keterangan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, penggunaId, bidangKeahlian, keterangan);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PembinaProfil &&
          other.id == this.id &&
          other.penggunaId == this.penggunaId &&
          other.bidangKeahlian == this.bidangKeahlian &&
          other.keterangan == this.keterangan);
}

class PembinaProfilsCompanion extends UpdateCompanion<PembinaProfil> {
  final Value<String> id;
  final Value<String> penggunaId;
  final Value<String?> bidangKeahlian;
  final Value<String?> keterangan;
  final Value<int> rowid;
  const PembinaProfilsCompanion({
    this.id = const Value.absent(),
    this.penggunaId = const Value.absent(),
    this.bidangKeahlian = const Value.absent(),
    this.keterangan = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PembinaProfilsCompanion.insert({
    required String id,
    required String penggunaId,
    this.bidangKeahlian = const Value.absent(),
    this.keterangan = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       penggunaId = Value(penggunaId);
  static Insertable<PembinaProfil> custom({
    Expression<String>? id,
    Expression<String>? penggunaId,
    Expression<String>? bidangKeahlian,
    Expression<String>? keterangan,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (penggunaId != null) 'pengguna_id': penggunaId,
      if (bidangKeahlian != null) 'bidang_keahlian': bidangKeahlian,
      if (keterangan != null) 'keterangan': keterangan,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PembinaProfilsCompanion copyWith({
    Value<String>? id,
    Value<String>? penggunaId,
    Value<String?>? bidangKeahlian,
    Value<String?>? keterangan,
    Value<int>? rowid,
  }) {
    return PembinaProfilsCompanion(
      id: id ?? this.id,
      penggunaId: penggunaId ?? this.penggunaId,
      bidangKeahlian: bidangKeahlian ?? this.bidangKeahlian,
      keterangan: keterangan ?? this.keterangan,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (penggunaId.present) {
      map['pengguna_id'] = Variable<String>(penggunaId.value);
    }
    if (bidangKeahlian.present) {
      map['bidang_keahlian'] = Variable<String>(bidangKeahlian.value);
    }
    if (keterangan.present) {
      map['keterangan'] = Variable<String>(keterangan.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PembinaProfilsCompanion(')
          ..write('id: $id, ')
          ..write('penggunaId: $penggunaId, ')
          ..write('bidangKeahlian: $bidangKeahlian, ')
          ..write('keterangan: $keterangan, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkuItemsTable extends SkuItems with TableInfo<$SkuItemsTable, SkuItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkuItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _golonganMeta = const VerificationMeta(
    'golongan',
  );
  @override
  late final GeneratedColumn<String> golongan = GeneratedColumn<String>(
    'golongan',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tingkatMeta = const VerificationMeta(
    'tingkat',
  );
  @override
  late final GeneratedColumn<String> tingkat = GeneratedColumn<String>(
    'tingkat',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomorUrutMeta = const VerificationMeta(
    'nomorUrut',
  );
  @override
  late final GeneratedColumn<int> nomorUrut = GeneratedColumn<int>(
    'nomor_urut',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deskripsiMeta = const VerificationMeta(
    'deskripsi',
  );
  @override
  late final GeneratedColumn<String> deskripsi = GeneratedColumn<String>(
    'deskripsi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kategoriMeta = const VerificationMeta(
    'kategori',
  );
  @override
  late final GeneratedColumn<String> kategori = GeneratedColumn<String>(
    'kategori',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aktifMeta = const VerificationMeta('aktif');
  @override
  late final GeneratedColumn<bool> aktif = GeneratedColumn<bool>(
    'aktif',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("aktif" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    golongan,
    tingkat,
    nomorUrut,
    deskripsi,
    kategori,
    aktif,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sku_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkuItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('golongan')) {
      context.handle(
        _golonganMeta,
        golongan.isAcceptableOrUnknown(data['golongan']!, _golonganMeta),
      );
    } else if (isInserting) {
      context.missing(_golonganMeta);
    }
    if (data.containsKey('tingkat')) {
      context.handle(
        _tingkatMeta,
        tingkat.isAcceptableOrUnknown(data['tingkat']!, _tingkatMeta),
      );
    } else if (isInserting) {
      context.missing(_tingkatMeta);
    }
    if (data.containsKey('nomor_urut')) {
      context.handle(
        _nomorUrutMeta,
        nomorUrut.isAcceptableOrUnknown(data['nomor_urut']!, _nomorUrutMeta),
      );
    } else if (isInserting) {
      context.missing(_nomorUrutMeta);
    }
    if (data.containsKey('deskripsi')) {
      context.handle(
        _deskripsiMeta,
        deskripsi.isAcceptableOrUnknown(data['deskripsi']!, _deskripsiMeta),
      );
    } else if (isInserting) {
      context.missing(_deskripsiMeta);
    }
    if (data.containsKey('kategori')) {
      context.handle(
        _kategoriMeta,
        kategori.isAcceptableOrUnknown(data['kategori']!, _kategoriMeta),
      );
    }
    if (data.containsKey('aktif')) {
      context.handle(
        _aktifMeta,
        aktif.isAcceptableOrUnknown(data['aktif']!, _aktifMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SkuItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkuItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      golongan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}golongan'],
      )!,
      tingkat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tingkat'],
      )!,
      nomorUrut: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nomor_urut'],
      )!,
      deskripsi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deskripsi'],
      )!,
      kategori: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kategori'],
      ),
      aktif: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}aktif'],
      )!,
    );
  }

  @override
  $SkuItemsTable createAlias(String alias) {
    return $SkuItemsTable(attachedDatabase, alias);
  }
}

class SkuItem extends DataClass implements Insertable<SkuItem> {
  final String id;
  final String golongan;
  final String tingkat;
  final int nomorUrut;
  final String deskripsi;
  final String? kategori;
  final bool aktif;
  const SkuItem({
    required this.id,
    required this.golongan,
    required this.tingkat,
    required this.nomorUrut,
    required this.deskripsi,
    this.kategori,
    required this.aktif,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['golongan'] = Variable<String>(golongan);
    map['tingkat'] = Variable<String>(tingkat);
    map['nomor_urut'] = Variable<int>(nomorUrut);
    map['deskripsi'] = Variable<String>(deskripsi);
    if (!nullToAbsent || kategori != null) {
      map['kategori'] = Variable<String>(kategori);
    }
    map['aktif'] = Variable<bool>(aktif);
    return map;
  }

  SkuItemsCompanion toCompanion(bool nullToAbsent) {
    return SkuItemsCompanion(
      id: Value(id),
      golongan: Value(golongan),
      tingkat: Value(tingkat),
      nomorUrut: Value(nomorUrut),
      deskripsi: Value(deskripsi),
      kategori: kategori == null && nullToAbsent
          ? const Value.absent()
          : Value(kategori),
      aktif: Value(aktif),
    );
  }

  factory SkuItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkuItem(
      id: serializer.fromJson<String>(json['id']),
      golongan: serializer.fromJson<String>(json['golongan']),
      tingkat: serializer.fromJson<String>(json['tingkat']),
      nomorUrut: serializer.fromJson<int>(json['nomorUrut']),
      deskripsi: serializer.fromJson<String>(json['deskripsi']),
      kategori: serializer.fromJson<String?>(json['kategori']),
      aktif: serializer.fromJson<bool>(json['aktif']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'golongan': serializer.toJson<String>(golongan),
      'tingkat': serializer.toJson<String>(tingkat),
      'nomorUrut': serializer.toJson<int>(nomorUrut),
      'deskripsi': serializer.toJson<String>(deskripsi),
      'kategori': serializer.toJson<String?>(kategori),
      'aktif': serializer.toJson<bool>(aktif),
    };
  }

  SkuItem copyWith({
    String? id,
    String? golongan,
    String? tingkat,
    int? nomorUrut,
    String? deskripsi,
    Value<String?> kategori = const Value.absent(),
    bool? aktif,
  }) => SkuItem(
    id: id ?? this.id,
    golongan: golongan ?? this.golongan,
    tingkat: tingkat ?? this.tingkat,
    nomorUrut: nomorUrut ?? this.nomorUrut,
    deskripsi: deskripsi ?? this.deskripsi,
    kategori: kategori.present ? kategori.value : this.kategori,
    aktif: aktif ?? this.aktif,
  );
  SkuItem copyWithCompanion(SkuItemsCompanion data) {
    return SkuItem(
      id: data.id.present ? data.id.value : this.id,
      golongan: data.golongan.present ? data.golongan.value : this.golongan,
      tingkat: data.tingkat.present ? data.tingkat.value : this.tingkat,
      nomorUrut: data.nomorUrut.present ? data.nomorUrut.value : this.nomorUrut,
      deskripsi: data.deskripsi.present ? data.deskripsi.value : this.deskripsi,
      kategori: data.kategori.present ? data.kategori.value : this.kategori,
      aktif: data.aktif.present ? data.aktif.value : this.aktif,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkuItem(')
          ..write('id: $id, ')
          ..write('golongan: $golongan, ')
          ..write('tingkat: $tingkat, ')
          ..write('nomorUrut: $nomorUrut, ')
          ..write('deskripsi: $deskripsi, ')
          ..write('kategori: $kategori, ')
          ..write('aktif: $aktif')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, golongan, tingkat, nomorUrut, deskripsi, kategori, aktif);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkuItem &&
          other.id == this.id &&
          other.golongan == this.golongan &&
          other.tingkat == this.tingkat &&
          other.nomorUrut == this.nomorUrut &&
          other.deskripsi == this.deskripsi &&
          other.kategori == this.kategori &&
          other.aktif == this.aktif);
}

class SkuItemsCompanion extends UpdateCompanion<SkuItem> {
  final Value<String> id;
  final Value<String> golongan;
  final Value<String> tingkat;
  final Value<int> nomorUrut;
  final Value<String> deskripsi;
  final Value<String?> kategori;
  final Value<bool> aktif;
  final Value<int> rowid;
  const SkuItemsCompanion({
    this.id = const Value.absent(),
    this.golongan = const Value.absent(),
    this.tingkat = const Value.absent(),
    this.nomorUrut = const Value.absent(),
    this.deskripsi = const Value.absent(),
    this.kategori = const Value.absent(),
    this.aktif = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkuItemsCompanion.insert({
    required String id,
    required String golongan,
    required String tingkat,
    required int nomorUrut,
    required String deskripsi,
    this.kategori = const Value.absent(),
    this.aktif = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       golongan = Value(golongan),
       tingkat = Value(tingkat),
       nomorUrut = Value(nomorUrut),
       deskripsi = Value(deskripsi);
  static Insertable<SkuItem> custom({
    Expression<String>? id,
    Expression<String>? golongan,
    Expression<String>? tingkat,
    Expression<int>? nomorUrut,
    Expression<String>? deskripsi,
    Expression<String>? kategori,
    Expression<bool>? aktif,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (golongan != null) 'golongan': golongan,
      if (tingkat != null) 'tingkat': tingkat,
      if (nomorUrut != null) 'nomor_urut': nomorUrut,
      if (deskripsi != null) 'deskripsi': deskripsi,
      if (kategori != null) 'kategori': kategori,
      if (aktif != null) 'aktif': aktif,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkuItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? golongan,
    Value<String>? tingkat,
    Value<int>? nomorUrut,
    Value<String>? deskripsi,
    Value<String?>? kategori,
    Value<bool>? aktif,
    Value<int>? rowid,
  }) {
    return SkuItemsCompanion(
      id: id ?? this.id,
      golongan: golongan ?? this.golongan,
      tingkat: tingkat ?? this.tingkat,
      nomorUrut: nomorUrut ?? this.nomorUrut,
      deskripsi: deskripsi ?? this.deskripsi,
      kategori: kategori ?? this.kategori,
      aktif: aktif ?? this.aktif,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (golongan.present) {
      map['golongan'] = Variable<String>(golongan.value);
    }
    if (tingkat.present) {
      map['tingkat'] = Variable<String>(tingkat.value);
    }
    if (nomorUrut.present) {
      map['nomor_urut'] = Variable<int>(nomorUrut.value);
    }
    if (deskripsi.present) {
      map['deskripsi'] = Variable<String>(deskripsi.value);
    }
    if (kategori.present) {
      map['kategori'] = Variable<String>(kategori.value);
    }
    if (aktif.present) {
      map['aktif'] = Variable<bool>(aktif.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkuItemsCompanion(')
          ..write('id: $id, ')
          ..write('golongan: $golongan, ')
          ..write('tingkat: $tingkat, ')
          ..write('nomorUrut: $nomorUrut, ')
          ..write('deskripsi: $deskripsi, ')
          ..write('kategori: $kategori, ')
          ..write('aktif: $aktif, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkuProgressesTable extends SkuProgresses
    with TableInfo<$SkuProgressesTable, SkuProgress> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkuProgressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _anggotaIdMeta = const VerificationMeta(
    'anggotaId',
  );
  @override
  late final GeneratedColumn<String> anggotaId = GeneratedColumn<String>(
    'anggota_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skuItemIdMeta = const VerificationMeta(
    'skuItemId',
  );
  @override
  late final GeneratedColumn<String> skuItemId = GeneratedColumn<String>(
    'sku_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('belum'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    anggotaId,
    skuItemId,
    status,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sku_progresses';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkuProgress> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('anggota_id')) {
      context.handle(
        _anggotaIdMeta,
        anggotaId.isAcceptableOrUnknown(data['anggota_id']!, _anggotaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_anggotaIdMeta);
    }
    if (data.containsKey('sku_item_id')) {
      context.handle(
        _skuItemIdMeta,
        skuItemId.isAcceptableOrUnknown(data['sku_item_id']!, _skuItemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_skuItemIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {anggotaId, skuItemId},
  ];
  @override
  SkuProgress map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkuProgress(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      anggotaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}anggota_id'],
      )!,
      skuItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku_item_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SkuProgressesTable createAlias(String alias) {
    return $SkuProgressesTable(attachedDatabase, alias);
  }
}

class SkuProgress extends DataClass implements Insertable<SkuProgress> {
  final String id;
  final String anggotaId;
  final String skuItemId;
  final String status;
  final DateTime updatedAt;
  const SkuProgress({
    required this.id,
    required this.anggotaId,
    required this.skuItemId,
    required this.status,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['anggota_id'] = Variable<String>(anggotaId);
    map['sku_item_id'] = Variable<String>(skuItemId);
    map['status'] = Variable<String>(status);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SkuProgressesCompanion toCompanion(bool nullToAbsent) {
    return SkuProgressesCompanion(
      id: Value(id),
      anggotaId: Value(anggotaId),
      skuItemId: Value(skuItemId),
      status: Value(status),
      updatedAt: Value(updatedAt),
    );
  }

  factory SkuProgress.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkuProgress(
      id: serializer.fromJson<String>(json['id']),
      anggotaId: serializer.fromJson<String>(json['anggotaId']),
      skuItemId: serializer.fromJson<String>(json['skuItemId']),
      status: serializer.fromJson<String>(json['status']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'anggotaId': serializer.toJson<String>(anggotaId),
      'skuItemId': serializer.toJson<String>(skuItemId),
      'status': serializer.toJson<String>(status),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SkuProgress copyWith({
    String? id,
    String? anggotaId,
    String? skuItemId,
    String? status,
    DateTime? updatedAt,
  }) => SkuProgress(
    id: id ?? this.id,
    anggotaId: anggotaId ?? this.anggotaId,
    skuItemId: skuItemId ?? this.skuItemId,
    status: status ?? this.status,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SkuProgress copyWithCompanion(SkuProgressesCompanion data) {
    return SkuProgress(
      id: data.id.present ? data.id.value : this.id,
      anggotaId: data.anggotaId.present ? data.anggotaId.value : this.anggotaId,
      skuItemId: data.skuItemId.present ? data.skuItemId.value : this.skuItemId,
      status: data.status.present ? data.status.value : this.status,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkuProgress(')
          ..write('id: $id, ')
          ..write('anggotaId: $anggotaId, ')
          ..write('skuItemId: $skuItemId, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, anggotaId, skuItemId, status, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkuProgress &&
          other.id == this.id &&
          other.anggotaId == this.anggotaId &&
          other.skuItemId == this.skuItemId &&
          other.status == this.status &&
          other.updatedAt == this.updatedAt);
}

class SkuProgressesCompanion extends UpdateCompanion<SkuProgress> {
  final Value<String> id;
  final Value<String> anggotaId;
  final Value<String> skuItemId;
  final Value<String> status;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SkuProgressesCompanion({
    this.id = const Value.absent(),
    this.anggotaId = const Value.absent(),
    this.skuItemId = const Value.absent(),
    this.status = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkuProgressesCompanion.insert({
    required String id,
    required String anggotaId,
    required String skuItemId,
    this.status = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       anggotaId = Value(anggotaId),
       skuItemId = Value(skuItemId);
  static Insertable<SkuProgress> custom({
    Expression<String>? id,
    Expression<String>? anggotaId,
    Expression<String>? skuItemId,
    Expression<String>? status,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (anggotaId != null) 'anggota_id': anggotaId,
      if (skuItemId != null) 'sku_item_id': skuItemId,
      if (status != null) 'status': status,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkuProgressesCompanion copyWith({
    Value<String>? id,
    Value<String>? anggotaId,
    Value<String>? skuItemId,
    Value<String>? status,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SkuProgressesCompanion(
      id: id ?? this.id,
      anggotaId: anggotaId ?? this.anggotaId,
      skuItemId: skuItemId ?? this.skuItemId,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (anggotaId.present) {
      map['anggota_id'] = Variable<String>(anggotaId.value);
    }
    if (skuItemId.present) {
      map['sku_item_id'] = Variable<String>(skuItemId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkuProgressesCompanion(')
          ..write('id: $id, ')
          ..write('anggotaId: $anggotaId, ')
          ..write('skuItemId: $skuItemId, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkuEventsTable extends SkuEvents
    with TableInfo<$SkuEventsTable, SkuEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkuEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skuProgressIdMeta = const VerificationMeta(
    'skuProgressId',
  );
  @override
  late final GeneratedColumn<String> skuProgressId = GeneratedColumn<String>(
    'sku_progress_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aktorIdMeta = const VerificationMeta(
    'aktorId',
  );
  @override
  late final GeneratedColumn<String> aktorId = GeneratedColumn<String>(
    'aktor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aksiMeta = const VerificationMeta('aksi');
  @override
  late final GeneratedColumn<String> aksi = GeneratedColumn<String>(
    'aksi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _catatanMeta = const VerificationMeta(
    'catatan',
  );
  @override
  late final GeneratedColumn<String> catatan = GeneratedColumn<String>(
    'catatan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    skuProgressId,
    aktorId,
    aksi,
    catatan,
    deviceId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sku_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkuEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sku_progress_id')) {
      context.handle(
        _skuProgressIdMeta,
        skuProgressId.isAcceptableOrUnknown(
          data['sku_progress_id']!,
          _skuProgressIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_skuProgressIdMeta);
    }
    if (data.containsKey('aktor_id')) {
      context.handle(
        _aktorIdMeta,
        aktorId.isAcceptableOrUnknown(data['aktor_id']!, _aktorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_aktorIdMeta);
    }
    if (data.containsKey('aksi')) {
      context.handle(
        _aksiMeta,
        aksi.isAcceptableOrUnknown(data['aksi']!, _aksiMeta),
      );
    } else if (isInserting) {
      context.missing(_aksiMeta);
    }
    if (data.containsKey('catatan')) {
      context.handle(
        _catatanMeta,
        catatan.isAcceptableOrUnknown(data['catatan']!, _catatanMeta),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SkuEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkuEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      skuProgressId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku_progress_id'],
      )!,
      aktorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aktor_id'],
      )!,
      aksi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aksi'],
      )!,
      catatan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}catatan'],
      ),
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SkuEventsTable createAlias(String alias) {
    return $SkuEventsTable(attachedDatabase, alias);
  }
}

class SkuEvent extends DataClass implements Insertable<SkuEvent> {
  final String id;
  final String skuProgressId;
  final String aktorId;
  final String aksi;
  final String? catatan;
  final String? deviceId;
  final DateTime createdAt;
  const SkuEvent({
    required this.id,
    required this.skuProgressId,
    required this.aktorId,
    required this.aksi,
    this.catatan,
    this.deviceId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sku_progress_id'] = Variable<String>(skuProgressId);
    map['aktor_id'] = Variable<String>(aktorId);
    map['aksi'] = Variable<String>(aksi);
    if (!nullToAbsent || catatan != null) {
      map['catatan'] = Variable<String>(catatan);
    }
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SkuEventsCompanion toCompanion(bool nullToAbsent) {
    return SkuEventsCompanion(
      id: Value(id),
      skuProgressId: Value(skuProgressId),
      aktorId: Value(aktorId),
      aksi: Value(aksi),
      catatan: catatan == null && nullToAbsent
          ? const Value.absent()
          : Value(catatan),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      createdAt: Value(createdAt),
    );
  }

  factory SkuEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkuEvent(
      id: serializer.fromJson<String>(json['id']),
      skuProgressId: serializer.fromJson<String>(json['skuProgressId']),
      aktorId: serializer.fromJson<String>(json['aktorId']),
      aksi: serializer.fromJson<String>(json['aksi']),
      catatan: serializer.fromJson<String?>(json['catatan']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'skuProgressId': serializer.toJson<String>(skuProgressId),
      'aktorId': serializer.toJson<String>(aktorId),
      'aksi': serializer.toJson<String>(aksi),
      'catatan': serializer.toJson<String?>(catatan),
      'deviceId': serializer.toJson<String?>(deviceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SkuEvent copyWith({
    String? id,
    String? skuProgressId,
    String? aktorId,
    String? aksi,
    Value<String?> catatan = const Value.absent(),
    Value<String?> deviceId = const Value.absent(),
    DateTime? createdAt,
  }) => SkuEvent(
    id: id ?? this.id,
    skuProgressId: skuProgressId ?? this.skuProgressId,
    aktorId: aktorId ?? this.aktorId,
    aksi: aksi ?? this.aksi,
    catatan: catatan.present ? catatan.value : this.catatan,
    deviceId: deviceId.present ? deviceId.value : this.deviceId,
    createdAt: createdAt ?? this.createdAt,
  );
  SkuEvent copyWithCompanion(SkuEventsCompanion data) {
    return SkuEvent(
      id: data.id.present ? data.id.value : this.id,
      skuProgressId: data.skuProgressId.present
          ? data.skuProgressId.value
          : this.skuProgressId,
      aktorId: data.aktorId.present ? data.aktorId.value : this.aktorId,
      aksi: data.aksi.present ? data.aksi.value : this.aksi,
      catatan: data.catatan.present ? data.catatan.value : this.catatan,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkuEvent(')
          ..write('id: $id, ')
          ..write('skuProgressId: $skuProgressId, ')
          ..write('aktorId: $aktorId, ')
          ..write('aksi: $aksi, ')
          ..write('catatan: $catatan, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    skuProgressId,
    aktorId,
    aksi,
    catatan,
    deviceId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkuEvent &&
          other.id == this.id &&
          other.skuProgressId == this.skuProgressId &&
          other.aktorId == this.aktorId &&
          other.aksi == this.aksi &&
          other.catatan == this.catatan &&
          other.deviceId == this.deviceId &&
          other.createdAt == this.createdAt);
}

class SkuEventsCompanion extends UpdateCompanion<SkuEvent> {
  final Value<String> id;
  final Value<String> skuProgressId;
  final Value<String> aktorId;
  final Value<String> aksi;
  final Value<String?> catatan;
  final Value<String?> deviceId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SkuEventsCompanion({
    this.id = const Value.absent(),
    this.skuProgressId = const Value.absent(),
    this.aktorId = const Value.absent(),
    this.aksi = const Value.absent(),
    this.catatan = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkuEventsCompanion.insert({
    required String id,
    required String skuProgressId,
    required String aktorId,
    required String aksi,
    this.catatan = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       skuProgressId = Value(skuProgressId),
       aktorId = Value(aktorId),
       aksi = Value(aksi);
  static Insertable<SkuEvent> custom({
    Expression<String>? id,
    Expression<String>? skuProgressId,
    Expression<String>? aktorId,
    Expression<String>? aksi,
    Expression<String>? catatan,
    Expression<String>? deviceId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (skuProgressId != null) 'sku_progress_id': skuProgressId,
      if (aktorId != null) 'aktor_id': aktorId,
      if (aksi != null) 'aksi': aksi,
      if (catatan != null) 'catatan': catatan,
      if (deviceId != null) 'device_id': deviceId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkuEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? skuProgressId,
    Value<String>? aktorId,
    Value<String>? aksi,
    Value<String?>? catatan,
    Value<String?>? deviceId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SkuEventsCompanion(
      id: id ?? this.id,
      skuProgressId: skuProgressId ?? this.skuProgressId,
      aktorId: aktorId ?? this.aktorId,
      aksi: aksi ?? this.aksi,
      catatan: catatan ?? this.catatan,
      deviceId: deviceId ?? this.deviceId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (skuProgressId.present) {
      map['sku_progress_id'] = Variable<String>(skuProgressId.value);
    }
    if (aktorId.present) {
      map['aktor_id'] = Variable<String>(aktorId.value);
    }
    if (aksi.present) {
      map['aksi'] = Variable<String>(aksi.value);
    }
    if (catatan.present) {
      map['catatan'] = Variable<String>(catatan.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkuEventsCompanion(')
          ..write('id: $id, ')
          ..write('skuProgressId: $skuProgressId, ')
          ..write('aktorId: $aktorId, ')
          ..write('aksi: $aksi, ')
          ..write('catatan: $catatan, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkkBidangsTable extends SkkBidangs
    with TableInfo<$SkkBidangsTable, SkkBidang> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkkBidangsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kelompokMeta = const VerificationMeta(
    'kelompok',
  );
  @override
  late final GeneratedColumn<String> kelompok = GeneratedColumn<String>(
    'kelompok',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nama, kelompok, level];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skk_bidangs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkkBidang> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('kelompok')) {
      context.handle(
        _kelompokMeta,
        kelompok.isAcceptableOrUnknown(data['kelompok']!, _kelompokMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {nama, level},
  ];
  @override
  SkkBidang map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkkBidang(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      kelompok: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kelompok'],
      ),
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      )!,
    );
  }

  @override
  $SkkBidangsTable createAlias(String alias) {
    return $SkkBidangsTable(attachedDatabase, alias);
  }
}

class SkkBidang extends DataClass implements Insertable<SkkBidang> {
  final String id;
  final String nama;
  final String? kelompok;
  final String level;
  const SkkBidang({
    required this.id,
    required this.nama,
    this.kelompok,
    required this.level,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nama'] = Variable<String>(nama);
    if (!nullToAbsent || kelompok != null) {
      map['kelompok'] = Variable<String>(kelompok);
    }
    map['level'] = Variable<String>(level);
    return map;
  }

  SkkBidangsCompanion toCompanion(bool nullToAbsent) {
    return SkkBidangsCompanion(
      id: Value(id),
      nama: Value(nama),
      kelompok: kelompok == null && nullToAbsent
          ? const Value.absent()
          : Value(kelompok),
      level: Value(level),
    );
  }

  factory SkkBidang.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkkBidang(
      id: serializer.fromJson<String>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      kelompok: serializer.fromJson<String?>(json['kelompok']),
      level: serializer.fromJson<String>(json['level']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nama': serializer.toJson<String>(nama),
      'kelompok': serializer.toJson<String?>(kelompok),
      'level': serializer.toJson<String>(level),
    };
  }

  SkkBidang copyWith({
    String? id,
    String? nama,
    Value<String?> kelompok = const Value.absent(),
    String? level,
  }) => SkkBidang(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    kelompok: kelompok.present ? kelompok.value : this.kelompok,
    level: level ?? this.level,
  );
  SkkBidang copyWithCompanion(SkkBidangsCompanion data) {
    return SkkBidang(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      kelompok: data.kelompok.present ? data.kelompok.value : this.kelompok,
      level: data.level.present ? data.level.value : this.level,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkkBidang(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('kelompok: $kelompok, ')
          ..write('level: $level')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nama, kelompok, level);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkkBidang &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.kelompok == this.kelompok &&
          other.level == this.level);
}

class SkkBidangsCompanion extends UpdateCompanion<SkkBidang> {
  final Value<String> id;
  final Value<String> nama;
  final Value<String?> kelompok;
  final Value<String> level;
  final Value<int> rowid;
  const SkkBidangsCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.kelompok = const Value.absent(),
    this.level = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkkBidangsCompanion.insert({
    required String id,
    required String nama,
    this.kelompok = const Value.absent(),
    required String level,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nama = Value(nama),
       level = Value(level);
  static Insertable<SkkBidang> custom({
    Expression<String>? id,
    Expression<String>? nama,
    Expression<String>? kelompok,
    Expression<String>? level,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (kelompok != null) 'kelompok': kelompok,
      if (level != null) 'level': level,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkkBidangsCompanion copyWith({
    Value<String>? id,
    Value<String>? nama,
    Value<String?>? kelompok,
    Value<String>? level,
    Value<int>? rowid,
  }) {
    return SkkBidangsCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      kelompok: kelompok ?? this.kelompok,
      level: level ?? this.level,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (kelompok.present) {
      map['kelompok'] = Variable<String>(kelompok.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkkBidangsCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('kelompok: $kelompok, ')
          ..write('level: $level, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkkItemsTable extends SkkItems with TableInfo<$SkkItemsTable, SkkItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkkItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skkBidangIdMeta = const VerificationMeta(
    'skkBidangId',
  );
  @override
  late final GeneratedColumn<String> skkBidangId = GeneratedColumn<String>(
    'skk_bidang_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomorUrutMeta = const VerificationMeta(
    'nomorUrut',
  );
  @override
  late final GeneratedColumn<int> nomorUrut = GeneratedColumn<int>(
    'nomor_urut',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deskripsiSyaratMeta = const VerificationMeta(
    'deskripsiSyarat',
  );
  @override
  late final GeneratedColumn<String> deskripsiSyarat = GeneratedColumn<String>(
    'deskripsi_syarat',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    skkBidangId,
    nomorUrut,
    deskripsiSyarat,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skk_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkkItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('skk_bidang_id')) {
      context.handle(
        _skkBidangIdMeta,
        skkBidangId.isAcceptableOrUnknown(
          data['skk_bidang_id']!,
          _skkBidangIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_skkBidangIdMeta);
    }
    if (data.containsKey('nomor_urut')) {
      context.handle(
        _nomorUrutMeta,
        nomorUrut.isAcceptableOrUnknown(data['nomor_urut']!, _nomorUrutMeta),
      );
    } else if (isInserting) {
      context.missing(_nomorUrutMeta);
    }
    if (data.containsKey('deskripsi_syarat')) {
      context.handle(
        _deskripsiSyaratMeta,
        deskripsiSyarat.isAcceptableOrUnknown(
          data['deskripsi_syarat']!,
          _deskripsiSyaratMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deskripsiSyaratMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SkkItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkkItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      skkBidangId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skk_bidang_id'],
      )!,
      nomorUrut: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nomor_urut'],
      )!,
      deskripsiSyarat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deskripsi_syarat'],
      )!,
    );
  }

  @override
  $SkkItemsTable createAlias(String alias) {
    return $SkkItemsTable(attachedDatabase, alias);
  }
}

class SkkItem extends DataClass implements Insertable<SkkItem> {
  final String id;
  final String skkBidangId;
  final int nomorUrut;
  final String deskripsiSyarat;
  const SkkItem({
    required this.id,
    required this.skkBidangId,
    required this.nomorUrut,
    required this.deskripsiSyarat,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['skk_bidang_id'] = Variable<String>(skkBidangId);
    map['nomor_urut'] = Variable<int>(nomorUrut);
    map['deskripsi_syarat'] = Variable<String>(deskripsiSyarat);
    return map;
  }

  SkkItemsCompanion toCompanion(bool nullToAbsent) {
    return SkkItemsCompanion(
      id: Value(id),
      skkBidangId: Value(skkBidangId),
      nomorUrut: Value(nomorUrut),
      deskripsiSyarat: Value(deskripsiSyarat),
    );
  }

  factory SkkItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkkItem(
      id: serializer.fromJson<String>(json['id']),
      skkBidangId: serializer.fromJson<String>(json['skkBidangId']),
      nomorUrut: serializer.fromJson<int>(json['nomorUrut']),
      deskripsiSyarat: serializer.fromJson<String>(json['deskripsiSyarat']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'skkBidangId': serializer.toJson<String>(skkBidangId),
      'nomorUrut': serializer.toJson<int>(nomorUrut),
      'deskripsiSyarat': serializer.toJson<String>(deskripsiSyarat),
    };
  }

  SkkItem copyWith({
    String? id,
    String? skkBidangId,
    int? nomorUrut,
    String? deskripsiSyarat,
  }) => SkkItem(
    id: id ?? this.id,
    skkBidangId: skkBidangId ?? this.skkBidangId,
    nomorUrut: nomorUrut ?? this.nomorUrut,
    deskripsiSyarat: deskripsiSyarat ?? this.deskripsiSyarat,
  );
  SkkItem copyWithCompanion(SkkItemsCompanion data) {
    return SkkItem(
      id: data.id.present ? data.id.value : this.id,
      skkBidangId: data.skkBidangId.present
          ? data.skkBidangId.value
          : this.skkBidangId,
      nomorUrut: data.nomorUrut.present ? data.nomorUrut.value : this.nomorUrut,
      deskripsiSyarat: data.deskripsiSyarat.present
          ? data.deskripsiSyarat.value
          : this.deskripsiSyarat,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkkItem(')
          ..write('id: $id, ')
          ..write('skkBidangId: $skkBidangId, ')
          ..write('nomorUrut: $nomorUrut, ')
          ..write('deskripsiSyarat: $deskripsiSyarat')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, skkBidangId, nomorUrut, deskripsiSyarat);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkkItem &&
          other.id == this.id &&
          other.skkBidangId == this.skkBidangId &&
          other.nomorUrut == this.nomorUrut &&
          other.deskripsiSyarat == this.deskripsiSyarat);
}

class SkkItemsCompanion extends UpdateCompanion<SkkItem> {
  final Value<String> id;
  final Value<String> skkBidangId;
  final Value<int> nomorUrut;
  final Value<String> deskripsiSyarat;
  final Value<int> rowid;
  const SkkItemsCompanion({
    this.id = const Value.absent(),
    this.skkBidangId = const Value.absent(),
    this.nomorUrut = const Value.absent(),
    this.deskripsiSyarat = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkkItemsCompanion.insert({
    required String id,
    required String skkBidangId,
    required int nomorUrut,
    required String deskripsiSyarat,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       skkBidangId = Value(skkBidangId),
       nomorUrut = Value(nomorUrut),
       deskripsiSyarat = Value(deskripsiSyarat);
  static Insertable<SkkItem> custom({
    Expression<String>? id,
    Expression<String>? skkBidangId,
    Expression<int>? nomorUrut,
    Expression<String>? deskripsiSyarat,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (skkBidangId != null) 'skk_bidang_id': skkBidangId,
      if (nomorUrut != null) 'nomor_urut': nomorUrut,
      if (deskripsiSyarat != null) 'deskripsi_syarat': deskripsiSyarat,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkkItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? skkBidangId,
    Value<int>? nomorUrut,
    Value<String>? deskripsiSyarat,
    Value<int>? rowid,
  }) {
    return SkkItemsCompanion(
      id: id ?? this.id,
      skkBidangId: skkBidangId ?? this.skkBidangId,
      nomorUrut: nomorUrut ?? this.nomorUrut,
      deskripsiSyarat: deskripsiSyarat ?? this.deskripsiSyarat,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (skkBidangId.present) {
      map['skk_bidang_id'] = Variable<String>(skkBidangId.value);
    }
    if (nomorUrut.present) {
      map['nomor_urut'] = Variable<int>(nomorUrut.value);
    }
    if (deskripsiSyarat.present) {
      map['deskripsi_syarat'] = Variable<String>(deskripsiSyarat.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkkItemsCompanion(')
          ..write('id: $id, ')
          ..write('skkBidangId: $skkBidangId, ')
          ..write('nomorUrut: $nomorUrut, ')
          ..write('deskripsiSyarat: $deskripsiSyarat, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkkProgressesTable extends SkkProgresses
    with TableInfo<$SkkProgressesTable, SkkProgress> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkkProgressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _anggotaIdMeta = const VerificationMeta(
    'anggotaId',
  );
  @override
  late final GeneratedColumn<String> anggotaId = GeneratedColumn<String>(
    'anggota_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skkItemIdMeta = const VerificationMeta(
    'skkItemId',
  );
  @override
  late final GeneratedColumn<String> skkItemId = GeneratedColumn<String>(
    'skk_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('belum'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    anggotaId,
    skkItemId,
    status,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skk_progresses';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkkProgress> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('anggota_id')) {
      context.handle(
        _anggotaIdMeta,
        anggotaId.isAcceptableOrUnknown(data['anggota_id']!, _anggotaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_anggotaIdMeta);
    }
    if (data.containsKey('skk_item_id')) {
      context.handle(
        _skkItemIdMeta,
        skkItemId.isAcceptableOrUnknown(data['skk_item_id']!, _skkItemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_skkItemIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {anggotaId, skkItemId},
  ];
  @override
  SkkProgress map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkkProgress(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      anggotaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}anggota_id'],
      )!,
      skkItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skk_item_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SkkProgressesTable createAlias(String alias) {
    return $SkkProgressesTable(attachedDatabase, alias);
  }
}

class SkkProgress extends DataClass implements Insertable<SkkProgress> {
  final String id;
  final String anggotaId;
  final String skkItemId;
  final String status;
  final DateTime updatedAt;
  const SkkProgress({
    required this.id,
    required this.anggotaId,
    required this.skkItemId,
    required this.status,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['anggota_id'] = Variable<String>(anggotaId);
    map['skk_item_id'] = Variable<String>(skkItemId);
    map['status'] = Variable<String>(status);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SkkProgressesCompanion toCompanion(bool nullToAbsent) {
    return SkkProgressesCompanion(
      id: Value(id),
      anggotaId: Value(anggotaId),
      skkItemId: Value(skkItemId),
      status: Value(status),
      updatedAt: Value(updatedAt),
    );
  }

  factory SkkProgress.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkkProgress(
      id: serializer.fromJson<String>(json['id']),
      anggotaId: serializer.fromJson<String>(json['anggotaId']),
      skkItemId: serializer.fromJson<String>(json['skkItemId']),
      status: serializer.fromJson<String>(json['status']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'anggotaId': serializer.toJson<String>(anggotaId),
      'skkItemId': serializer.toJson<String>(skkItemId),
      'status': serializer.toJson<String>(status),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SkkProgress copyWith({
    String? id,
    String? anggotaId,
    String? skkItemId,
    String? status,
    DateTime? updatedAt,
  }) => SkkProgress(
    id: id ?? this.id,
    anggotaId: anggotaId ?? this.anggotaId,
    skkItemId: skkItemId ?? this.skkItemId,
    status: status ?? this.status,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SkkProgress copyWithCompanion(SkkProgressesCompanion data) {
    return SkkProgress(
      id: data.id.present ? data.id.value : this.id,
      anggotaId: data.anggotaId.present ? data.anggotaId.value : this.anggotaId,
      skkItemId: data.skkItemId.present ? data.skkItemId.value : this.skkItemId,
      status: data.status.present ? data.status.value : this.status,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkkProgress(')
          ..write('id: $id, ')
          ..write('anggotaId: $anggotaId, ')
          ..write('skkItemId: $skkItemId, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, anggotaId, skkItemId, status, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkkProgress &&
          other.id == this.id &&
          other.anggotaId == this.anggotaId &&
          other.skkItemId == this.skkItemId &&
          other.status == this.status &&
          other.updatedAt == this.updatedAt);
}

class SkkProgressesCompanion extends UpdateCompanion<SkkProgress> {
  final Value<String> id;
  final Value<String> anggotaId;
  final Value<String> skkItemId;
  final Value<String> status;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SkkProgressesCompanion({
    this.id = const Value.absent(),
    this.anggotaId = const Value.absent(),
    this.skkItemId = const Value.absent(),
    this.status = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkkProgressesCompanion.insert({
    required String id,
    required String anggotaId,
    required String skkItemId,
    this.status = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       anggotaId = Value(anggotaId),
       skkItemId = Value(skkItemId);
  static Insertable<SkkProgress> custom({
    Expression<String>? id,
    Expression<String>? anggotaId,
    Expression<String>? skkItemId,
    Expression<String>? status,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (anggotaId != null) 'anggota_id': anggotaId,
      if (skkItemId != null) 'skk_item_id': skkItemId,
      if (status != null) 'status': status,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkkProgressesCompanion copyWith({
    Value<String>? id,
    Value<String>? anggotaId,
    Value<String>? skkItemId,
    Value<String>? status,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SkkProgressesCompanion(
      id: id ?? this.id,
      anggotaId: anggotaId ?? this.anggotaId,
      skkItemId: skkItemId ?? this.skkItemId,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (anggotaId.present) {
      map['anggota_id'] = Variable<String>(anggotaId.value);
    }
    if (skkItemId.present) {
      map['skk_item_id'] = Variable<String>(skkItemId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkkProgressesCompanion(')
          ..write('id: $id, ')
          ..write('anggotaId: $anggotaId, ')
          ..write('skkItemId: $skkItemId, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkkEventsTable extends SkkEvents
    with TableInfo<$SkkEventsTable, SkkEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkkEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skkProgressIdMeta = const VerificationMeta(
    'skkProgressId',
  );
  @override
  late final GeneratedColumn<String> skkProgressId = GeneratedColumn<String>(
    'skk_progress_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aktorIdMeta = const VerificationMeta(
    'aktorId',
  );
  @override
  late final GeneratedColumn<String> aktorId = GeneratedColumn<String>(
    'aktor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aksiMeta = const VerificationMeta('aksi');
  @override
  late final GeneratedColumn<String> aksi = GeneratedColumn<String>(
    'aksi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _catatanMeta = const VerificationMeta(
    'catatan',
  );
  @override
  late final GeneratedColumn<String> catatan = GeneratedColumn<String>(
    'catatan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    skkProgressId,
    aktorId,
    aksi,
    catatan,
    deviceId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skk_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkkEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('skk_progress_id')) {
      context.handle(
        _skkProgressIdMeta,
        skkProgressId.isAcceptableOrUnknown(
          data['skk_progress_id']!,
          _skkProgressIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_skkProgressIdMeta);
    }
    if (data.containsKey('aktor_id')) {
      context.handle(
        _aktorIdMeta,
        aktorId.isAcceptableOrUnknown(data['aktor_id']!, _aktorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_aktorIdMeta);
    }
    if (data.containsKey('aksi')) {
      context.handle(
        _aksiMeta,
        aksi.isAcceptableOrUnknown(data['aksi']!, _aksiMeta),
      );
    } else if (isInserting) {
      context.missing(_aksiMeta);
    }
    if (data.containsKey('catatan')) {
      context.handle(
        _catatanMeta,
        catatan.isAcceptableOrUnknown(data['catatan']!, _catatanMeta),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SkkEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkkEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      skkProgressId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skk_progress_id'],
      )!,
      aktorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aktor_id'],
      )!,
      aksi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aksi'],
      )!,
      catatan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}catatan'],
      ),
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SkkEventsTable createAlias(String alias) {
    return $SkkEventsTable(attachedDatabase, alias);
  }
}

class SkkEvent extends DataClass implements Insertable<SkkEvent> {
  final String id;
  final String skkProgressId;
  final String aktorId;
  final String aksi;
  final String? catatan;
  final String? deviceId;
  final DateTime createdAt;
  const SkkEvent({
    required this.id,
    required this.skkProgressId,
    required this.aktorId,
    required this.aksi,
    this.catatan,
    this.deviceId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['skk_progress_id'] = Variable<String>(skkProgressId);
    map['aktor_id'] = Variable<String>(aktorId);
    map['aksi'] = Variable<String>(aksi);
    if (!nullToAbsent || catatan != null) {
      map['catatan'] = Variable<String>(catatan);
    }
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SkkEventsCompanion toCompanion(bool nullToAbsent) {
    return SkkEventsCompanion(
      id: Value(id),
      skkProgressId: Value(skkProgressId),
      aktorId: Value(aktorId),
      aksi: Value(aksi),
      catatan: catatan == null && nullToAbsent
          ? const Value.absent()
          : Value(catatan),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      createdAt: Value(createdAt),
    );
  }

  factory SkkEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkkEvent(
      id: serializer.fromJson<String>(json['id']),
      skkProgressId: serializer.fromJson<String>(json['skkProgressId']),
      aktorId: serializer.fromJson<String>(json['aktorId']),
      aksi: serializer.fromJson<String>(json['aksi']),
      catatan: serializer.fromJson<String?>(json['catatan']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'skkProgressId': serializer.toJson<String>(skkProgressId),
      'aktorId': serializer.toJson<String>(aktorId),
      'aksi': serializer.toJson<String>(aksi),
      'catatan': serializer.toJson<String?>(catatan),
      'deviceId': serializer.toJson<String?>(deviceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SkkEvent copyWith({
    String? id,
    String? skkProgressId,
    String? aktorId,
    String? aksi,
    Value<String?> catatan = const Value.absent(),
    Value<String?> deviceId = const Value.absent(),
    DateTime? createdAt,
  }) => SkkEvent(
    id: id ?? this.id,
    skkProgressId: skkProgressId ?? this.skkProgressId,
    aktorId: aktorId ?? this.aktorId,
    aksi: aksi ?? this.aksi,
    catatan: catatan.present ? catatan.value : this.catatan,
    deviceId: deviceId.present ? deviceId.value : this.deviceId,
    createdAt: createdAt ?? this.createdAt,
  );
  SkkEvent copyWithCompanion(SkkEventsCompanion data) {
    return SkkEvent(
      id: data.id.present ? data.id.value : this.id,
      skkProgressId: data.skkProgressId.present
          ? data.skkProgressId.value
          : this.skkProgressId,
      aktorId: data.aktorId.present ? data.aktorId.value : this.aktorId,
      aksi: data.aksi.present ? data.aksi.value : this.aksi,
      catatan: data.catatan.present ? data.catatan.value : this.catatan,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkkEvent(')
          ..write('id: $id, ')
          ..write('skkProgressId: $skkProgressId, ')
          ..write('aktorId: $aktorId, ')
          ..write('aksi: $aksi, ')
          ..write('catatan: $catatan, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    skkProgressId,
    aktorId,
    aksi,
    catatan,
    deviceId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkkEvent &&
          other.id == this.id &&
          other.skkProgressId == this.skkProgressId &&
          other.aktorId == this.aktorId &&
          other.aksi == this.aksi &&
          other.catatan == this.catatan &&
          other.deviceId == this.deviceId &&
          other.createdAt == this.createdAt);
}

class SkkEventsCompanion extends UpdateCompanion<SkkEvent> {
  final Value<String> id;
  final Value<String> skkProgressId;
  final Value<String> aktorId;
  final Value<String> aksi;
  final Value<String?> catatan;
  final Value<String?> deviceId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SkkEventsCompanion({
    this.id = const Value.absent(),
    this.skkProgressId = const Value.absent(),
    this.aktorId = const Value.absent(),
    this.aksi = const Value.absent(),
    this.catatan = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkkEventsCompanion.insert({
    required String id,
    required String skkProgressId,
    required String aktorId,
    required String aksi,
    this.catatan = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       skkProgressId = Value(skkProgressId),
       aktorId = Value(aktorId),
       aksi = Value(aksi);
  static Insertable<SkkEvent> custom({
    Expression<String>? id,
    Expression<String>? skkProgressId,
    Expression<String>? aktorId,
    Expression<String>? aksi,
    Expression<String>? catatan,
    Expression<String>? deviceId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (skkProgressId != null) 'skk_progress_id': skkProgressId,
      if (aktorId != null) 'aktor_id': aktorId,
      if (aksi != null) 'aksi': aksi,
      if (catatan != null) 'catatan': catatan,
      if (deviceId != null) 'device_id': deviceId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkkEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? skkProgressId,
    Value<String>? aktorId,
    Value<String>? aksi,
    Value<String?>? catatan,
    Value<String?>? deviceId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SkkEventsCompanion(
      id: id ?? this.id,
      skkProgressId: skkProgressId ?? this.skkProgressId,
      aktorId: aktorId ?? this.aktorId,
      aksi: aksi ?? this.aksi,
      catatan: catatan ?? this.catatan,
      deviceId: deviceId ?? this.deviceId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (skkProgressId.present) {
      map['skk_progress_id'] = Variable<String>(skkProgressId.value);
    }
    if (aktorId.present) {
      map['aktor_id'] = Variable<String>(aktorId.value);
    }
    if (aksi.present) {
      map['aksi'] = Variable<String>(aksi.value);
    }
    if (catatan.present) {
      map['catatan'] = Variable<String>(catatan.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkkEventsCompanion(')
          ..write('id: $id, ')
          ..write('skkProgressId: $skkProgressId, ')
          ..write('aktorId: $aktorId, ')
          ..write('aksi: $aksi, ')
          ..write('catatan: $catatan, ')
          ..write('deviceId: $deviceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PelantikansTable extends Pelantikans
    with TableInfo<$PelantikansTable, Pelantikan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PelantikansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _anggotaIdMeta = const VerificationMeta(
    'anggotaId',
  );
  @override
  late final GeneratedColumn<String> anggotaId = GeneratedColumn<String>(
    'anggota_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jenisMeta = const VerificationMeta('jenis');
  @override
  late final GeneratedColumn<String> jenis = GeneratedColumn<String>(
    'jenis',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referensiLabelMeta = const VerificationMeta(
    'referensiLabel',
  );
  @override
  late final GeneratedColumn<String> referensiLabel = GeneratedColumn<String>(
    'referensi_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tanggalMeta = const VerificationMeta(
    'tanggal',
  );
  @override
  late final GeneratedColumn<DateTime> tanggal = GeneratedColumn<DateTime>(
    'tanggal',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pembinaIdMeta = const VerificationMeta(
    'pembinaId',
  );
  @override
  late final GeneratedColumn<String> pembinaId = GeneratedColumn<String>(
    'pembina_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _catatanMeta = const VerificationMeta(
    'catatan',
  );
  @override
  late final GeneratedColumn<String> catatan = GeneratedColumn<String>(
    'catatan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sertifikatUrlMeta = const VerificationMeta(
    'sertifikatUrl',
  );
  @override
  late final GeneratedColumn<String> sertifikatUrl = GeneratedColumn<String>(
    'sertifikat_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    anggotaId,
    jenis,
    referensiLabel,
    tanggal,
    pembinaId,
    catatan,
    sertifikatUrl,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pelantikans';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pelantikan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('anggota_id')) {
      context.handle(
        _anggotaIdMeta,
        anggotaId.isAcceptableOrUnknown(data['anggota_id']!, _anggotaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_anggotaIdMeta);
    }
    if (data.containsKey('jenis')) {
      context.handle(
        _jenisMeta,
        jenis.isAcceptableOrUnknown(data['jenis']!, _jenisMeta),
      );
    } else if (isInserting) {
      context.missing(_jenisMeta);
    }
    if (data.containsKey('referensi_label')) {
      context.handle(
        _referensiLabelMeta,
        referensiLabel.isAcceptableOrUnknown(
          data['referensi_label']!,
          _referensiLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referensiLabelMeta);
    }
    if (data.containsKey('tanggal')) {
      context.handle(
        _tanggalMeta,
        tanggal.isAcceptableOrUnknown(data['tanggal']!, _tanggalMeta),
      );
    } else if (isInserting) {
      context.missing(_tanggalMeta);
    }
    if (data.containsKey('pembina_id')) {
      context.handle(
        _pembinaIdMeta,
        pembinaId.isAcceptableOrUnknown(data['pembina_id']!, _pembinaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pembinaIdMeta);
    }
    if (data.containsKey('catatan')) {
      context.handle(
        _catatanMeta,
        catatan.isAcceptableOrUnknown(data['catatan']!, _catatanMeta),
      );
    }
    if (data.containsKey('sertifikat_url')) {
      context.handle(
        _sertifikatUrlMeta,
        sertifikatUrl.isAcceptableOrUnknown(
          data['sertifikat_url']!,
          _sertifikatUrlMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pelantikan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pelantikan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      anggotaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}anggota_id'],
      )!,
      jenis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jenis'],
      )!,
      referensiLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}referensi_label'],
      )!,
      tanggal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}tanggal'],
      )!,
      pembinaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pembina_id'],
      )!,
      catatan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}catatan'],
      ),
      sertifikatUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sertifikat_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PelantikansTable createAlias(String alias) {
    return $PelantikansTable(attachedDatabase, alias);
  }
}

class Pelantikan extends DataClass implements Insertable<Pelantikan> {
  final String id;
  final String anggotaId;
  final String jenis;
  final String referensiLabel;
  final DateTime tanggal;
  final String pembinaId;
  final String? catatan;
  final String? sertifikatUrl;
  final DateTime createdAt;
  const Pelantikan({
    required this.id,
    required this.anggotaId,
    required this.jenis,
    required this.referensiLabel,
    required this.tanggal,
    required this.pembinaId,
    this.catatan,
    this.sertifikatUrl,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['anggota_id'] = Variable<String>(anggotaId);
    map['jenis'] = Variable<String>(jenis);
    map['referensi_label'] = Variable<String>(referensiLabel);
    map['tanggal'] = Variable<DateTime>(tanggal);
    map['pembina_id'] = Variable<String>(pembinaId);
    if (!nullToAbsent || catatan != null) {
      map['catatan'] = Variable<String>(catatan);
    }
    if (!nullToAbsent || sertifikatUrl != null) {
      map['sertifikat_url'] = Variable<String>(sertifikatUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PelantikansCompanion toCompanion(bool nullToAbsent) {
    return PelantikansCompanion(
      id: Value(id),
      anggotaId: Value(anggotaId),
      jenis: Value(jenis),
      referensiLabel: Value(referensiLabel),
      tanggal: Value(tanggal),
      pembinaId: Value(pembinaId),
      catatan: catatan == null && nullToAbsent
          ? const Value.absent()
          : Value(catatan),
      sertifikatUrl: sertifikatUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(sertifikatUrl),
      createdAt: Value(createdAt),
    );
  }

  factory Pelantikan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pelantikan(
      id: serializer.fromJson<String>(json['id']),
      anggotaId: serializer.fromJson<String>(json['anggotaId']),
      jenis: serializer.fromJson<String>(json['jenis']),
      referensiLabel: serializer.fromJson<String>(json['referensiLabel']),
      tanggal: serializer.fromJson<DateTime>(json['tanggal']),
      pembinaId: serializer.fromJson<String>(json['pembinaId']),
      catatan: serializer.fromJson<String?>(json['catatan']),
      sertifikatUrl: serializer.fromJson<String?>(json['sertifikatUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'anggotaId': serializer.toJson<String>(anggotaId),
      'jenis': serializer.toJson<String>(jenis),
      'referensiLabel': serializer.toJson<String>(referensiLabel),
      'tanggal': serializer.toJson<DateTime>(tanggal),
      'pembinaId': serializer.toJson<String>(pembinaId),
      'catatan': serializer.toJson<String?>(catatan),
      'sertifikatUrl': serializer.toJson<String?>(sertifikatUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Pelantikan copyWith({
    String? id,
    String? anggotaId,
    String? jenis,
    String? referensiLabel,
    DateTime? tanggal,
    String? pembinaId,
    Value<String?> catatan = const Value.absent(),
    Value<String?> sertifikatUrl = const Value.absent(),
    DateTime? createdAt,
  }) => Pelantikan(
    id: id ?? this.id,
    anggotaId: anggotaId ?? this.anggotaId,
    jenis: jenis ?? this.jenis,
    referensiLabel: referensiLabel ?? this.referensiLabel,
    tanggal: tanggal ?? this.tanggal,
    pembinaId: pembinaId ?? this.pembinaId,
    catatan: catatan.present ? catatan.value : this.catatan,
    sertifikatUrl: sertifikatUrl.present
        ? sertifikatUrl.value
        : this.sertifikatUrl,
    createdAt: createdAt ?? this.createdAt,
  );
  Pelantikan copyWithCompanion(PelantikansCompanion data) {
    return Pelantikan(
      id: data.id.present ? data.id.value : this.id,
      anggotaId: data.anggotaId.present ? data.anggotaId.value : this.anggotaId,
      jenis: data.jenis.present ? data.jenis.value : this.jenis,
      referensiLabel: data.referensiLabel.present
          ? data.referensiLabel.value
          : this.referensiLabel,
      tanggal: data.tanggal.present ? data.tanggal.value : this.tanggal,
      pembinaId: data.pembinaId.present ? data.pembinaId.value : this.pembinaId,
      catatan: data.catatan.present ? data.catatan.value : this.catatan,
      sertifikatUrl: data.sertifikatUrl.present
          ? data.sertifikatUrl.value
          : this.sertifikatUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pelantikan(')
          ..write('id: $id, ')
          ..write('anggotaId: $anggotaId, ')
          ..write('jenis: $jenis, ')
          ..write('referensiLabel: $referensiLabel, ')
          ..write('tanggal: $tanggal, ')
          ..write('pembinaId: $pembinaId, ')
          ..write('catatan: $catatan, ')
          ..write('sertifikatUrl: $sertifikatUrl, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    anggotaId,
    jenis,
    referensiLabel,
    tanggal,
    pembinaId,
    catatan,
    sertifikatUrl,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pelantikan &&
          other.id == this.id &&
          other.anggotaId == this.anggotaId &&
          other.jenis == this.jenis &&
          other.referensiLabel == this.referensiLabel &&
          other.tanggal == this.tanggal &&
          other.pembinaId == this.pembinaId &&
          other.catatan == this.catatan &&
          other.sertifikatUrl == this.sertifikatUrl &&
          other.createdAt == this.createdAt);
}

class PelantikansCompanion extends UpdateCompanion<Pelantikan> {
  final Value<String> id;
  final Value<String> anggotaId;
  final Value<String> jenis;
  final Value<String> referensiLabel;
  final Value<DateTime> tanggal;
  final Value<String> pembinaId;
  final Value<String?> catatan;
  final Value<String?> sertifikatUrl;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PelantikansCompanion({
    this.id = const Value.absent(),
    this.anggotaId = const Value.absent(),
    this.jenis = const Value.absent(),
    this.referensiLabel = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.pembinaId = const Value.absent(),
    this.catatan = const Value.absent(),
    this.sertifikatUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PelantikansCompanion.insert({
    required String id,
    required String anggotaId,
    required String jenis,
    required String referensiLabel,
    required DateTime tanggal,
    required String pembinaId,
    this.catatan = const Value.absent(),
    this.sertifikatUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       anggotaId = Value(anggotaId),
       jenis = Value(jenis),
       referensiLabel = Value(referensiLabel),
       tanggal = Value(tanggal),
       pembinaId = Value(pembinaId);
  static Insertable<Pelantikan> custom({
    Expression<String>? id,
    Expression<String>? anggotaId,
    Expression<String>? jenis,
    Expression<String>? referensiLabel,
    Expression<DateTime>? tanggal,
    Expression<String>? pembinaId,
    Expression<String>? catatan,
    Expression<String>? sertifikatUrl,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (anggotaId != null) 'anggota_id': anggotaId,
      if (jenis != null) 'jenis': jenis,
      if (referensiLabel != null) 'referensi_label': referensiLabel,
      if (tanggal != null) 'tanggal': tanggal,
      if (pembinaId != null) 'pembina_id': pembinaId,
      if (catatan != null) 'catatan': catatan,
      if (sertifikatUrl != null) 'sertifikat_url': sertifikatUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PelantikansCompanion copyWith({
    Value<String>? id,
    Value<String>? anggotaId,
    Value<String>? jenis,
    Value<String>? referensiLabel,
    Value<DateTime>? tanggal,
    Value<String>? pembinaId,
    Value<String?>? catatan,
    Value<String?>? sertifikatUrl,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PelantikansCompanion(
      id: id ?? this.id,
      anggotaId: anggotaId ?? this.anggotaId,
      jenis: jenis ?? this.jenis,
      referensiLabel: referensiLabel ?? this.referensiLabel,
      tanggal: tanggal ?? this.tanggal,
      pembinaId: pembinaId ?? this.pembinaId,
      catatan: catatan ?? this.catatan,
      sertifikatUrl: sertifikatUrl ?? this.sertifikatUrl,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (anggotaId.present) {
      map['anggota_id'] = Variable<String>(anggotaId.value);
    }
    if (jenis.present) {
      map['jenis'] = Variable<String>(jenis.value);
    }
    if (referensiLabel.present) {
      map['referensi_label'] = Variable<String>(referensiLabel.value);
    }
    if (tanggal.present) {
      map['tanggal'] = Variable<DateTime>(tanggal.value);
    }
    if (pembinaId.present) {
      map['pembina_id'] = Variable<String>(pembinaId.value);
    }
    if (catatan.present) {
      map['catatan'] = Variable<String>(catatan.value);
    }
    if (sertifikatUrl.present) {
      map['sertifikat_url'] = Variable<String>(sertifikatUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PelantikansCompanion(')
          ..write('id: $id, ')
          ..write('anggotaId: $anggotaId, ')
          ..write('jenis: $jenis, ')
          ..write('referensiLabel: $referensiLabel, ')
          ..write('tanggal: $tanggal, ')
          ..write('pembinaId: $pembinaId, ')
          ..write('catatan: $catatan, ')
          ..write('sertifikatUrl: $sertifikatUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MateriKategorisTable extends MateriKategoris
    with TableInfo<$MateriKategorisTable, MateriKategori> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MateriKategorisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urutanMeta = const VerificationMeta('urutan');
  @override
  late final GeneratedColumn<int> urutan = GeneratedColumn<int>(
    'urutan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ikonMeta = const VerificationMeta('ikon');
  @override
  late final GeneratedColumn<String> ikon = GeneratedColumn<String>(
    'ikon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nama, urutan, ikon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'materi_kategoris';
  @override
  VerificationContext validateIntegrity(
    Insertable<MateriKategori> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('urutan')) {
      context.handle(
        _urutanMeta,
        urutan.isAcceptableOrUnknown(data['urutan']!, _urutanMeta),
      );
    }
    if (data.containsKey('ikon')) {
      context.handle(
        _ikonMeta,
        ikon.isAcceptableOrUnknown(data['ikon']!, _ikonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MateriKategori map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MateriKategori(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      urutan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}urutan'],
      )!,
      ikon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ikon'],
      ),
    );
  }

  @override
  $MateriKategorisTable createAlias(String alias) {
    return $MateriKategorisTable(attachedDatabase, alias);
  }
}

class MateriKategori extends DataClass implements Insertable<MateriKategori> {
  final String id;
  final String nama;
  final int urutan;
  final String? ikon;
  const MateriKategori({
    required this.id,
    required this.nama,
    required this.urutan,
    this.ikon,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nama'] = Variable<String>(nama);
    map['urutan'] = Variable<int>(urutan);
    if (!nullToAbsent || ikon != null) {
      map['ikon'] = Variable<String>(ikon);
    }
    return map;
  }

  MateriKategorisCompanion toCompanion(bool nullToAbsent) {
    return MateriKategorisCompanion(
      id: Value(id),
      nama: Value(nama),
      urutan: Value(urutan),
      ikon: ikon == null && nullToAbsent ? const Value.absent() : Value(ikon),
    );
  }

  factory MateriKategori.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MateriKategori(
      id: serializer.fromJson<String>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      urutan: serializer.fromJson<int>(json['urutan']),
      ikon: serializer.fromJson<String?>(json['ikon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nama': serializer.toJson<String>(nama),
      'urutan': serializer.toJson<int>(urutan),
      'ikon': serializer.toJson<String?>(ikon),
    };
  }

  MateriKategori copyWith({
    String? id,
    String? nama,
    int? urutan,
    Value<String?> ikon = const Value.absent(),
  }) => MateriKategori(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    urutan: urutan ?? this.urutan,
    ikon: ikon.present ? ikon.value : this.ikon,
  );
  MateriKategori copyWithCompanion(MateriKategorisCompanion data) {
    return MateriKategori(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      urutan: data.urutan.present ? data.urutan.value : this.urutan,
      ikon: data.ikon.present ? data.ikon.value : this.ikon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MateriKategori(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('urutan: $urutan, ')
          ..write('ikon: $ikon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nama, urutan, ikon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MateriKategori &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.urutan == this.urutan &&
          other.ikon == this.ikon);
}

class MateriKategorisCompanion extends UpdateCompanion<MateriKategori> {
  final Value<String> id;
  final Value<String> nama;
  final Value<int> urutan;
  final Value<String?> ikon;
  final Value<int> rowid;
  const MateriKategorisCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.urutan = const Value.absent(),
    this.ikon = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MateriKategorisCompanion.insert({
    required String id,
    required String nama,
    this.urutan = const Value.absent(),
    this.ikon = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nama = Value(nama);
  static Insertable<MateriKategori> custom({
    Expression<String>? id,
    Expression<String>? nama,
    Expression<int>? urutan,
    Expression<String>? ikon,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (urutan != null) 'urutan': urutan,
      if (ikon != null) 'ikon': ikon,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MateriKategorisCompanion copyWith({
    Value<String>? id,
    Value<String>? nama,
    Value<int>? urutan,
    Value<String?>? ikon,
    Value<int>? rowid,
  }) {
    return MateriKategorisCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      urutan: urutan ?? this.urutan,
      ikon: ikon ?? this.ikon,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (urutan.present) {
      map['urutan'] = Variable<int>(urutan.value);
    }
    if (ikon.present) {
      map['ikon'] = Variable<String>(ikon.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MateriKategorisCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('urutan: $urutan, ')
          ..write('ikon: $ikon, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MateriTopiksTable extends MateriTopiks
    with TableInfo<$MateriTopiksTable, MateriTopik> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MateriTopiksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kategoriIdMeta = const VerificationMeta(
    'kategoriId',
  );
  @override
  late final GeneratedColumn<String> kategoriId = GeneratedColumn<String>(
    'kategori_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urutanMeta = const VerificationMeta('urutan');
  @override
  late final GeneratedColumn<int> urutan = GeneratedColumn<int>(
    'urutan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, kategoriId, nama, urutan];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'materi_topiks';
  @override
  VerificationContext validateIntegrity(
    Insertable<MateriTopik> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('kategori_id')) {
      context.handle(
        _kategoriIdMeta,
        kategoriId.isAcceptableOrUnknown(data['kategori_id']!, _kategoriIdMeta),
      );
    } else if (isInserting) {
      context.missing(_kategoriIdMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('urutan')) {
      context.handle(
        _urutanMeta,
        urutan.isAcceptableOrUnknown(data['urutan']!, _urutanMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MateriTopik map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MateriTopik(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      kategoriId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kategori_id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      urutan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}urutan'],
      )!,
    );
  }

  @override
  $MateriTopiksTable createAlias(String alias) {
    return $MateriTopiksTable(attachedDatabase, alias);
  }
}

class MateriTopik extends DataClass implements Insertable<MateriTopik> {
  final String id;
  final String kategoriId;
  final String nama;
  final int urutan;
  const MateriTopik({
    required this.id,
    required this.kategoriId,
    required this.nama,
    required this.urutan,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['kategori_id'] = Variable<String>(kategoriId);
    map['nama'] = Variable<String>(nama);
    map['urutan'] = Variable<int>(urutan);
    return map;
  }

  MateriTopiksCompanion toCompanion(bool nullToAbsent) {
    return MateriTopiksCompanion(
      id: Value(id),
      kategoriId: Value(kategoriId),
      nama: Value(nama),
      urutan: Value(urutan),
    );
  }

  factory MateriTopik.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MateriTopik(
      id: serializer.fromJson<String>(json['id']),
      kategoriId: serializer.fromJson<String>(json['kategoriId']),
      nama: serializer.fromJson<String>(json['nama']),
      urutan: serializer.fromJson<int>(json['urutan']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'kategoriId': serializer.toJson<String>(kategoriId),
      'nama': serializer.toJson<String>(nama),
      'urutan': serializer.toJson<int>(urutan),
    };
  }

  MateriTopik copyWith({
    String? id,
    String? kategoriId,
    String? nama,
    int? urutan,
  }) => MateriTopik(
    id: id ?? this.id,
    kategoriId: kategoriId ?? this.kategoriId,
    nama: nama ?? this.nama,
    urutan: urutan ?? this.urutan,
  );
  MateriTopik copyWithCompanion(MateriTopiksCompanion data) {
    return MateriTopik(
      id: data.id.present ? data.id.value : this.id,
      kategoriId: data.kategoriId.present
          ? data.kategoriId.value
          : this.kategoriId,
      nama: data.nama.present ? data.nama.value : this.nama,
      urutan: data.urutan.present ? data.urutan.value : this.urutan,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MateriTopik(')
          ..write('id: $id, ')
          ..write('kategoriId: $kategoriId, ')
          ..write('nama: $nama, ')
          ..write('urutan: $urutan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kategoriId, nama, urutan);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MateriTopik &&
          other.id == this.id &&
          other.kategoriId == this.kategoriId &&
          other.nama == this.nama &&
          other.urutan == this.urutan);
}

class MateriTopiksCompanion extends UpdateCompanion<MateriTopik> {
  final Value<String> id;
  final Value<String> kategoriId;
  final Value<String> nama;
  final Value<int> urutan;
  final Value<int> rowid;
  const MateriTopiksCompanion({
    this.id = const Value.absent(),
    this.kategoriId = const Value.absent(),
    this.nama = const Value.absent(),
    this.urutan = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MateriTopiksCompanion.insert({
    required String id,
    required String kategoriId,
    required String nama,
    this.urutan = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       kategoriId = Value(kategoriId),
       nama = Value(nama);
  static Insertable<MateriTopik> custom({
    Expression<String>? id,
    Expression<String>? kategoriId,
    Expression<String>? nama,
    Expression<int>? urutan,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kategoriId != null) 'kategori_id': kategoriId,
      if (nama != null) 'nama': nama,
      if (urutan != null) 'urutan': urutan,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MateriTopiksCompanion copyWith({
    Value<String>? id,
    Value<String>? kategoriId,
    Value<String>? nama,
    Value<int>? urutan,
    Value<int>? rowid,
  }) {
    return MateriTopiksCompanion(
      id: id ?? this.id,
      kategoriId: kategoriId ?? this.kategoriId,
      nama: nama ?? this.nama,
      urutan: urutan ?? this.urutan,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kategoriId.present) {
      map['kategori_id'] = Variable<String>(kategoriId.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (urutan.present) {
      map['urutan'] = Variable<int>(urutan.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MateriTopiksCompanion(')
          ..write('id: $id, ')
          ..write('kategoriId: $kategoriId, ')
          ..write('nama: $nama, ')
          ..write('urutan: $urutan, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MateriUnitsTable extends MateriUnits
    with TableInfo<$MateriUnitsTable, MateriUnit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MateriUnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _topikIdMeta = const VerificationMeta(
    'topikId',
  );
  @override
  late final GeneratedColumn<String> topikId = GeneratedColumn<String>(
    'topik_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _judulMeta = const VerificationMeta('judul');
  @override
  late final GeneratedColumn<String> judul = GeneratedColumn<String>(
    'judul',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kontenMarkdownMeta = const VerificationMeta(
    'kontenMarkdown',
  );
  @override
  late final GeneratedColumn<String> kontenMarkdown = GeneratedColumn<String>(
    'konten_markdown',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediaUrlsJsonMeta = const VerificationMeta(
    'mediaUrlsJson',
  );
  @override
  late final GeneratedColumn<String> mediaUrlsJson = GeneratedColumn<String>(
    'media_urls_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versiMeta = const VerificationMeta('versi');
  @override
  late final GeneratedColumn<int> versi = GeneratedColumn<int>(
    'versi',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _urutanMeta = const VerificationMeta('urutan');
  @override
  late final GeneratedColumn<int> urutan = GeneratedColumn<int>(
    'urutan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    topikId,
    judul,
    kontenMarkdown,
    mediaUrlsJson,
    versi,
    urutan,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'materi_units';
  @override
  VerificationContext validateIntegrity(
    Insertable<MateriUnit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('topik_id')) {
      context.handle(
        _topikIdMeta,
        topikId.isAcceptableOrUnknown(data['topik_id']!, _topikIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topikIdMeta);
    }
    if (data.containsKey('judul')) {
      context.handle(
        _judulMeta,
        judul.isAcceptableOrUnknown(data['judul']!, _judulMeta),
      );
    } else if (isInserting) {
      context.missing(_judulMeta);
    }
    if (data.containsKey('konten_markdown')) {
      context.handle(
        _kontenMarkdownMeta,
        kontenMarkdown.isAcceptableOrUnknown(
          data['konten_markdown']!,
          _kontenMarkdownMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kontenMarkdownMeta);
    }
    if (data.containsKey('media_urls_json')) {
      context.handle(
        _mediaUrlsJsonMeta,
        mediaUrlsJson.isAcceptableOrUnknown(
          data['media_urls_json']!,
          _mediaUrlsJsonMeta,
        ),
      );
    }
    if (data.containsKey('versi')) {
      context.handle(
        _versiMeta,
        versi.isAcceptableOrUnknown(data['versi']!, _versiMeta),
      );
    }
    if (data.containsKey('urutan')) {
      context.handle(
        _urutanMeta,
        urutan.isAcceptableOrUnknown(data['urutan']!, _urutanMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MateriUnit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MateriUnit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      topikId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topik_id'],
      )!,
      judul: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}judul'],
      )!,
      kontenMarkdown: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}konten_markdown'],
      )!,
      mediaUrlsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_urls_json'],
      ),
      versi: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}versi'],
      )!,
      urutan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}urutan'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MateriUnitsTable createAlias(String alias) {
    return $MateriUnitsTable(attachedDatabase, alias);
  }
}

class MateriUnit extends DataClass implements Insertable<MateriUnit> {
  final String id;
  final String topikId;
  final String judul;
  final String kontenMarkdown;
  final String? mediaUrlsJson;
  final int versi;
  final int urutan;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MateriUnit({
    required this.id,
    required this.topikId,
    required this.judul,
    required this.kontenMarkdown,
    this.mediaUrlsJson,
    required this.versi,
    required this.urutan,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['topik_id'] = Variable<String>(topikId);
    map['judul'] = Variable<String>(judul);
    map['konten_markdown'] = Variable<String>(kontenMarkdown);
    if (!nullToAbsent || mediaUrlsJson != null) {
      map['media_urls_json'] = Variable<String>(mediaUrlsJson);
    }
    map['versi'] = Variable<int>(versi);
    map['urutan'] = Variable<int>(urutan);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MateriUnitsCompanion toCompanion(bool nullToAbsent) {
    return MateriUnitsCompanion(
      id: Value(id),
      topikId: Value(topikId),
      judul: Value(judul),
      kontenMarkdown: Value(kontenMarkdown),
      mediaUrlsJson: mediaUrlsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaUrlsJson),
      versi: Value(versi),
      urutan: Value(urutan),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MateriUnit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MateriUnit(
      id: serializer.fromJson<String>(json['id']),
      topikId: serializer.fromJson<String>(json['topikId']),
      judul: serializer.fromJson<String>(json['judul']),
      kontenMarkdown: serializer.fromJson<String>(json['kontenMarkdown']),
      mediaUrlsJson: serializer.fromJson<String?>(json['mediaUrlsJson']),
      versi: serializer.fromJson<int>(json['versi']),
      urutan: serializer.fromJson<int>(json['urutan']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'topikId': serializer.toJson<String>(topikId),
      'judul': serializer.toJson<String>(judul),
      'kontenMarkdown': serializer.toJson<String>(kontenMarkdown),
      'mediaUrlsJson': serializer.toJson<String?>(mediaUrlsJson),
      'versi': serializer.toJson<int>(versi),
      'urutan': serializer.toJson<int>(urutan),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MateriUnit copyWith({
    String? id,
    String? topikId,
    String? judul,
    String? kontenMarkdown,
    Value<String?> mediaUrlsJson = const Value.absent(),
    int? versi,
    int? urutan,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MateriUnit(
    id: id ?? this.id,
    topikId: topikId ?? this.topikId,
    judul: judul ?? this.judul,
    kontenMarkdown: kontenMarkdown ?? this.kontenMarkdown,
    mediaUrlsJson: mediaUrlsJson.present
        ? mediaUrlsJson.value
        : this.mediaUrlsJson,
    versi: versi ?? this.versi,
    urutan: urutan ?? this.urutan,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MateriUnit copyWithCompanion(MateriUnitsCompanion data) {
    return MateriUnit(
      id: data.id.present ? data.id.value : this.id,
      topikId: data.topikId.present ? data.topikId.value : this.topikId,
      judul: data.judul.present ? data.judul.value : this.judul,
      kontenMarkdown: data.kontenMarkdown.present
          ? data.kontenMarkdown.value
          : this.kontenMarkdown,
      mediaUrlsJson: data.mediaUrlsJson.present
          ? data.mediaUrlsJson.value
          : this.mediaUrlsJson,
      versi: data.versi.present ? data.versi.value : this.versi,
      urutan: data.urutan.present ? data.urutan.value : this.urutan,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MateriUnit(')
          ..write('id: $id, ')
          ..write('topikId: $topikId, ')
          ..write('judul: $judul, ')
          ..write('kontenMarkdown: $kontenMarkdown, ')
          ..write('mediaUrlsJson: $mediaUrlsJson, ')
          ..write('versi: $versi, ')
          ..write('urutan: $urutan, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    topikId,
    judul,
    kontenMarkdown,
    mediaUrlsJson,
    versi,
    urutan,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MateriUnit &&
          other.id == this.id &&
          other.topikId == this.topikId &&
          other.judul == this.judul &&
          other.kontenMarkdown == this.kontenMarkdown &&
          other.mediaUrlsJson == this.mediaUrlsJson &&
          other.versi == this.versi &&
          other.urutan == this.urutan &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MateriUnitsCompanion extends UpdateCompanion<MateriUnit> {
  final Value<String> id;
  final Value<String> topikId;
  final Value<String> judul;
  final Value<String> kontenMarkdown;
  final Value<String?> mediaUrlsJson;
  final Value<int> versi;
  final Value<int> urutan;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MateriUnitsCompanion({
    this.id = const Value.absent(),
    this.topikId = const Value.absent(),
    this.judul = const Value.absent(),
    this.kontenMarkdown = const Value.absent(),
    this.mediaUrlsJson = const Value.absent(),
    this.versi = const Value.absent(),
    this.urutan = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MateriUnitsCompanion.insert({
    required String id,
    required String topikId,
    required String judul,
    required String kontenMarkdown,
    this.mediaUrlsJson = const Value.absent(),
    this.versi = const Value.absent(),
    this.urutan = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       topikId = Value(topikId),
       judul = Value(judul),
       kontenMarkdown = Value(kontenMarkdown);
  static Insertable<MateriUnit> custom({
    Expression<String>? id,
    Expression<String>? topikId,
    Expression<String>? judul,
    Expression<String>? kontenMarkdown,
    Expression<String>? mediaUrlsJson,
    Expression<int>? versi,
    Expression<int>? urutan,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (topikId != null) 'topik_id': topikId,
      if (judul != null) 'judul': judul,
      if (kontenMarkdown != null) 'konten_markdown': kontenMarkdown,
      if (mediaUrlsJson != null) 'media_urls_json': mediaUrlsJson,
      if (versi != null) 'versi': versi,
      if (urutan != null) 'urutan': urutan,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MateriUnitsCompanion copyWith({
    Value<String>? id,
    Value<String>? topikId,
    Value<String>? judul,
    Value<String>? kontenMarkdown,
    Value<String?>? mediaUrlsJson,
    Value<int>? versi,
    Value<int>? urutan,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MateriUnitsCompanion(
      id: id ?? this.id,
      topikId: topikId ?? this.topikId,
      judul: judul ?? this.judul,
      kontenMarkdown: kontenMarkdown ?? this.kontenMarkdown,
      mediaUrlsJson: mediaUrlsJson ?? this.mediaUrlsJson,
      versi: versi ?? this.versi,
      urutan: urutan ?? this.urutan,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (topikId.present) {
      map['topik_id'] = Variable<String>(topikId.value);
    }
    if (judul.present) {
      map['judul'] = Variable<String>(judul.value);
    }
    if (kontenMarkdown.present) {
      map['konten_markdown'] = Variable<String>(kontenMarkdown.value);
    }
    if (mediaUrlsJson.present) {
      map['media_urls_json'] = Variable<String>(mediaUrlsJson.value);
    }
    if (versi.present) {
      map['versi'] = Variable<int>(versi.value);
    }
    if (urutan.present) {
      map['urutan'] = Variable<int>(urutan.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MateriUnitsCompanion(')
          ..write('id: $id, ')
          ..write('topikId: $topikId, ')
          ..write('judul: $judul, ')
          ..write('kontenMarkdown: $kontenMarkdown, ')
          ..write('mediaUrlsJson: $mediaUrlsJson, ')
          ..write('versi: $versi, ')
          ..write('urutan: $urutan, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MateriRelasisTable extends MateriRelasis
    with TableInfo<$MateriRelasisTable, MateriRelasi> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MateriRelasisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _materiUnitIdMeta = const VerificationMeta(
    'materiUnitId',
  );
  @override
  late final GeneratedColumn<String> materiUnitId = GeneratedColumn<String>(
    'materi_unit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skuItemIdMeta = const VerificationMeta(
    'skuItemId',
  );
  @override
  late final GeneratedColumn<String> skuItemId = GeneratedColumn<String>(
    'sku_item_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _skkItemIdMeta = const VerificationMeta(
    'skkItemId',
  );
  @override
  late final GeneratedColumn<String> skkItemId = GeneratedColumn<String>(
    'skk_item_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    materiUnitId,
    skuItemId,
    skkItemId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'materi_relasis';
  @override
  VerificationContext validateIntegrity(
    Insertable<MateriRelasi> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('materi_unit_id')) {
      context.handle(
        _materiUnitIdMeta,
        materiUnitId.isAcceptableOrUnknown(
          data['materi_unit_id']!,
          _materiUnitIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_materiUnitIdMeta);
    }
    if (data.containsKey('sku_item_id')) {
      context.handle(
        _skuItemIdMeta,
        skuItemId.isAcceptableOrUnknown(data['sku_item_id']!, _skuItemIdMeta),
      );
    }
    if (data.containsKey('skk_item_id')) {
      context.handle(
        _skkItemIdMeta,
        skkItemId.isAcceptableOrUnknown(data['skk_item_id']!, _skkItemIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MateriRelasi map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MateriRelasi(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      materiUnitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}materi_unit_id'],
      )!,
      skuItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku_item_id'],
      ),
      skkItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skk_item_id'],
      ),
    );
  }

  @override
  $MateriRelasisTable createAlias(String alias) {
    return $MateriRelasisTable(attachedDatabase, alias);
  }
}

class MateriRelasi extends DataClass implements Insertable<MateriRelasi> {
  final String id;
  final String materiUnitId;
  final String? skuItemId;
  final String? skkItemId;
  const MateriRelasi({
    required this.id,
    required this.materiUnitId,
    this.skuItemId,
    this.skkItemId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['materi_unit_id'] = Variable<String>(materiUnitId);
    if (!nullToAbsent || skuItemId != null) {
      map['sku_item_id'] = Variable<String>(skuItemId);
    }
    if (!nullToAbsent || skkItemId != null) {
      map['skk_item_id'] = Variable<String>(skkItemId);
    }
    return map;
  }

  MateriRelasisCompanion toCompanion(bool nullToAbsent) {
    return MateriRelasisCompanion(
      id: Value(id),
      materiUnitId: Value(materiUnitId),
      skuItemId: skuItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(skuItemId),
      skkItemId: skkItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(skkItemId),
    );
  }

  factory MateriRelasi.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MateriRelasi(
      id: serializer.fromJson<String>(json['id']),
      materiUnitId: serializer.fromJson<String>(json['materiUnitId']),
      skuItemId: serializer.fromJson<String?>(json['skuItemId']),
      skkItemId: serializer.fromJson<String?>(json['skkItemId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'materiUnitId': serializer.toJson<String>(materiUnitId),
      'skuItemId': serializer.toJson<String?>(skuItemId),
      'skkItemId': serializer.toJson<String?>(skkItemId),
    };
  }

  MateriRelasi copyWith({
    String? id,
    String? materiUnitId,
    Value<String?> skuItemId = const Value.absent(),
    Value<String?> skkItemId = const Value.absent(),
  }) => MateriRelasi(
    id: id ?? this.id,
    materiUnitId: materiUnitId ?? this.materiUnitId,
    skuItemId: skuItemId.present ? skuItemId.value : this.skuItemId,
    skkItemId: skkItemId.present ? skkItemId.value : this.skkItemId,
  );
  MateriRelasi copyWithCompanion(MateriRelasisCompanion data) {
    return MateriRelasi(
      id: data.id.present ? data.id.value : this.id,
      materiUnitId: data.materiUnitId.present
          ? data.materiUnitId.value
          : this.materiUnitId,
      skuItemId: data.skuItemId.present ? data.skuItemId.value : this.skuItemId,
      skkItemId: data.skkItemId.present ? data.skkItemId.value : this.skkItemId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MateriRelasi(')
          ..write('id: $id, ')
          ..write('materiUnitId: $materiUnitId, ')
          ..write('skuItemId: $skuItemId, ')
          ..write('skkItemId: $skkItemId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, materiUnitId, skuItemId, skkItemId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MateriRelasi &&
          other.id == this.id &&
          other.materiUnitId == this.materiUnitId &&
          other.skuItemId == this.skuItemId &&
          other.skkItemId == this.skkItemId);
}

class MateriRelasisCompanion extends UpdateCompanion<MateriRelasi> {
  final Value<String> id;
  final Value<String> materiUnitId;
  final Value<String?> skuItemId;
  final Value<String?> skkItemId;
  final Value<int> rowid;
  const MateriRelasisCompanion({
    this.id = const Value.absent(),
    this.materiUnitId = const Value.absent(),
    this.skuItemId = const Value.absent(),
    this.skkItemId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MateriRelasisCompanion.insert({
    required String id,
    required String materiUnitId,
    this.skuItemId = const Value.absent(),
    this.skkItemId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       materiUnitId = Value(materiUnitId);
  static Insertable<MateriRelasi> custom({
    Expression<String>? id,
    Expression<String>? materiUnitId,
    Expression<String>? skuItemId,
    Expression<String>? skkItemId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (materiUnitId != null) 'materi_unit_id': materiUnitId,
      if (skuItemId != null) 'sku_item_id': skuItemId,
      if (skkItemId != null) 'skk_item_id': skkItemId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MateriRelasisCompanion copyWith({
    Value<String>? id,
    Value<String>? materiUnitId,
    Value<String?>? skuItemId,
    Value<String?>? skkItemId,
    Value<int>? rowid,
  }) {
    return MateriRelasisCompanion(
      id: id ?? this.id,
      materiUnitId: materiUnitId ?? this.materiUnitId,
      skuItemId: skuItemId ?? this.skuItemId,
      skkItemId: skkItemId ?? this.skkItemId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (materiUnitId.present) {
      map['materi_unit_id'] = Variable<String>(materiUnitId.value);
    }
    if (skuItemId.present) {
      map['sku_item_id'] = Variable<String>(skuItemId.value);
    }
    if (skkItemId.present) {
      map['skk_item_id'] = Variable<String>(skkItemId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MateriRelasisCompanion(')
          ..write('id: $id, ')
          ..write('materiUnitId: $materiUnitId, ')
          ..write('skuItemId: $skuItemId, ')
          ..write('skkItemId: $skkItemId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MateriProgressBacasTable extends MateriProgressBacas
    with TableInfo<$MateriProgressBacasTable, MateriProgressBaca> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MateriProgressBacasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _anggotaIdMeta = const VerificationMeta(
    'anggotaId',
  );
  @override
  late final GeneratedColumn<String> anggotaId = GeneratedColumn<String>(
    'anggota_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _materiUnitIdMeta = const VerificationMeta(
    'materiUnitId',
  );
  @override
  late final GeneratedColumn<String> materiUnitId = GeneratedColumn<String>(
    'materi_unit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dibacaPadaMeta = const VerificationMeta(
    'dibacaPada',
  );
  @override
  late final GeneratedColumn<DateTime> dibacaPada = GeneratedColumn<DateTime>(
    'dibaca_pada',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    anggotaId,
    materiUnitId,
    dibacaPada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'materi_progress_bacas';
  @override
  VerificationContext validateIntegrity(
    Insertable<MateriProgressBaca> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('anggota_id')) {
      context.handle(
        _anggotaIdMeta,
        anggotaId.isAcceptableOrUnknown(data['anggota_id']!, _anggotaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_anggotaIdMeta);
    }
    if (data.containsKey('materi_unit_id')) {
      context.handle(
        _materiUnitIdMeta,
        materiUnitId.isAcceptableOrUnknown(
          data['materi_unit_id']!,
          _materiUnitIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_materiUnitIdMeta);
    }
    if (data.containsKey('dibaca_pada')) {
      context.handle(
        _dibacaPadaMeta,
        dibacaPada.isAcceptableOrUnknown(data['dibaca_pada']!, _dibacaPadaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {anggotaId, materiUnitId},
  ];
  @override
  MateriProgressBaca map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MateriProgressBaca(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      anggotaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}anggota_id'],
      )!,
      materiUnitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}materi_unit_id'],
      )!,
      dibacaPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dibaca_pada'],
      )!,
    );
  }

  @override
  $MateriProgressBacasTable createAlias(String alias) {
    return $MateriProgressBacasTable(attachedDatabase, alias);
  }
}

class MateriProgressBaca extends DataClass
    implements Insertable<MateriProgressBaca> {
  final String id;
  final String anggotaId;
  final String materiUnitId;
  final DateTime dibacaPada;
  const MateriProgressBaca({
    required this.id,
    required this.anggotaId,
    required this.materiUnitId,
    required this.dibacaPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['anggota_id'] = Variable<String>(anggotaId);
    map['materi_unit_id'] = Variable<String>(materiUnitId);
    map['dibaca_pada'] = Variable<DateTime>(dibacaPada);
    return map;
  }

  MateriProgressBacasCompanion toCompanion(bool nullToAbsent) {
    return MateriProgressBacasCompanion(
      id: Value(id),
      anggotaId: Value(anggotaId),
      materiUnitId: Value(materiUnitId),
      dibacaPada: Value(dibacaPada),
    );
  }

  factory MateriProgressBaca.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MateriProgressBaca(
      id: serializer.fromJson<String>(json['id']),
      anggotaId: serializer.fromJson<String>(json['anggotaId']),
      materiUnitId: serializer.fromJson<String>(json['materiUnitId']),
      dibacaPada: serializer.fromJson<DateTime>(json['dibacaPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'anggotaId': serializer.toJson<String>(anggotaId),
      'materiUnitId': serializer.toJson<String>(materiUnitId),
      'dibacaPada': serializer.toJson<DateTime>(dibacaPada),
    };
  }

  MateriProgressBaca copyWith({
    String? id,
    String? anggotaId,
    String? materiUnitId,
    DateTime? dibacaPada,
  }) => MateriProgressBaca(
    id: id ?? this.id,
    anggotaId: anggotaId ?? this.anggotaId,
    materiUnitId: materiUnitId ?? this.materiUnitId,
    dibacaPada: dibacaPada ?? this.dibacaPada,
  );
  MateriProgressBaca copyWithCompanion(MateriProgressBacasCompanion data) {
    return MateriProgressBaca(
      id: data.id.present ? data.id.value : this.id,
      anggotaId: data.anggotaId.present ? data.anggotaId.value : this.anggotaId,
      materiUnitId: data.materiUnitId.present
          ? data.materiUnitId.value
          : this.materiUnitId,
      dibacaPada: data.dibacaPada.present
          ? data.dibacaPada.value
          : this.dibacaPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MateriProgressBaca(')
          ..write('id: $id, ')
          ..write('anggotaId: $anggotaId, ')
          ..write('materiUnitId: $materiUnitId, ')
          ..write('dibacaPada: $dibacaPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, anggotaId, materiUnitId, dibacaPada);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MateriProgressBaca &&
          other.id == this.id &&
          other.anggotaId == this.anggotaId &&
          other.materiUnitId == this.materiUnitId &&
          other.dibacaPada == this.dibacaPada);
}

class MateriProgressBacasCompanion extends UpdateCompanion<MateriProgressBaca> {
  final Value<String> id;
  final Value<String> anggotaId;
  final Value<String> materiUnitId;
  final Value<DateTime> dibacaPada;
  final Value<int> rowid;
  const MateriProgressBacasCompanion({
    this.id = const Value.absent(),
    this.anggotaId = const Value.absent(),
    this.materiUnitId = const Value.absent(),
    this.dibacaPada = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MateriProgressBacasCompanion.insert({
    required String id,
    required String anggotaId,
    required String materiUnitId,
    this.dibacaPada = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       anggotaId = Value(anggotaId),
       materiUnitId = Value(materiUnitId);
  static Insertable<MateriProgressBaca> custom({
    Expression<String>? id,
    Expression<String>? anggotaId,
    Expression<String>? materiUnitId,
    Expression<DateTime>? dibacaPada,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (anggotaId != null) 'anggota_id': anggotaId,
      if (materiUnitId != null) 'materi_unit_id': materiUnitId,
      if (dibacaPada != null) 'dibaca_pada': dibacaPada,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MateriProgressBacasCompanion copyWith({
    Value<String>? id,
    Value<String>? anggotaId,
    Value<String>? materiUnitId,
    Value<DateTime>? dibacaPada,
    Value<int>? rowid,
  }) {
    return MateriProgressBacasCompanion(
      id: id ?? this.id,
      anggotaId: anggotaId ?? this.anggotaId,
      materiUnitId: materiUnitId ?? this.materiUnitId,
      dibacaPada: dibacaPada ?? this.dibacaPada,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (anggotaId.present) {
      map['anggota_id'] = Variable<String>(anggotaId.value);
    }
    if (materiUnitId.present) {
      map['materi_unit_id'] = Variable<String>(materiUnitId.value);
    }
    if (dibacaPada.present) {
      map['dibaca_pada'] = Variable<DateTime>(dibacaPada.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MateriProgressBacasCompanion(')
          ..write('id: $id, ')
          ..write('anggotaId: $anggotaId, ')
          ..write('materiUnitId: $materiUnitId, ')
          ..write('dibacaPada: $dibacaPada, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueItemsTable extends SyncQueueItems
    with TableInfo<$SyncQueueItemsTable, SyncQueueItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _penggunaIdMeta = const VerificationMeta(
    'penggunaId',
  );
  @override
  late final GeneratedColumn<String> penggunaId = GeneratedColumn<String>(
    'pengguna_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aksiMeta = const VerificationMeta('aksi');
  @override
  late final GeneratedColumn<String> aksi = GeneratedColumn<String>(
    'aksi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deviceId,
    penggunaId,
    entityType,
    entityId,
    aksi,
    payloadJson,
    createdAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('pengguna_id')) {
      context.handle(
        _penggunaIdMeta,
        penggunaId.isAcceptableOrUnknown(data['pengguna_id']!, _penggunaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_penggunaIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('aksi')) {
      context.handle(
        _aksiMeta,
        aksi.isAcceptableOrUnknown(data['aksi']!, _aksiMeta),
      );
    } else if (isInserting) {
      context.missing(_aksiMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      penggunaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pengguna_id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      aksi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aksi'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $SyncQueueItemsTable createAlias(String alias) {
    return $SyncQueueItemsTable(attachedDatabase, alias);
  }
}

class SyncQueueItem extends DataClass implements Insertable<SyncQueueItem> {
  final String id;
  final String deviceId;
  final String penggunaId;
  final String entityType;
  final String entityId;
  final String aksi;
  final String payloadJson;
  final DateTime createdAt;
  final DateTime? syncedAt;
  const SyncQueueItem({
    required this.id,
    required this.deviceId,
    required this.penggunaId,
    required this.entityType,
    required this.entityId,
    required this.aksi,
    required this.payloadJson,
    required this.createdAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['device_id'] = Variable<String>(deviceId);
    map['pengguna_id'] = Variable<String>(penggunaId);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['aksi'] = Variable<String>(aksi);
    map['payload_json'] = Variable<String>(payloadJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  SyncQueueItemsCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueItemsCompanion(
      id: Value(id),
      deviceId: Value(deviceId),
      penggunaId: Value(penggunaId),
      entityType: Value(entityType),
      entityId: Value(entityId),
      aksi: Value(aksi),
      payloadJson: Value(payloadJson),
      createdAt: Value(createdAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory SyncQueueItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueItem(
      id: serializer.fromJson<String>(json['id']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      penggunaId: serializer.fromJson<String>(json['penggunaId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      aksi: serializer.fromJson<String>(json['aksi']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'deviceId': serializer.toJson<String>(deviceId),
      'penggunaId': serializer.toJson<String>(penggunaId),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'aksi': serializer.toJson<String>(aksi),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  SyncQueueItem copyWith({
    String? id,
    String? deviceId,
    String? penggunaId,
    String? entityType,
    String? entityId,
    String? aksi,
    String? payloadJson,
    DateTime? createdAt,
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => SyncQueueItem(
    id: id ?? this.id,
    deviceId: deviceId ?? this.deviceId,
    penggunaId: penggunaId ?? this.penggunaId,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    aksi: aksi ?? this.aksi,
    payloadJson: payloadJson ?? this.payloadJson,
    createdAt: createdAt ?? this.createdAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  SyncQueueItem copyWithCompanion(SyncQueueItemsCompanion data) {
    return SyncQueueItem(
      id: data.id.present ? data.id.value : this.id,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      penggunaId: data.penggunaId.present
          ? data.penggunaId.value
          : this.penggunaId,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      aksi: data.aksi.present ? data.aksi.value : this.aksi,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueItem(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('penggunaId: $penggunaId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('aksi: $aksi, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    deviceId,
    penggunaId,
    entityType,
    entityId,
    aksi,
    payloadJson,
    createdAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueItem &&
          other.id == this.id &&
          other.deviceId == this.deviceId &&
          other.penggunaId == this.penggunaId &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.aksi == this.aksi &&
          other.payloadJson == this.payloadJson &&
          other.createdAt == this.createdAt &&
          other.syncedAt == this.syncedAt);
}

class SyncQueueItemsCompanion extends UpdateCompanion<SyncQueueItem> {
  final Value<String> id;
  final Value<String> deviceId;
  final Value<String> penggunaId;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> aksi;
  final Value<String> payloadJson;
  final Value<DateTime> createdAt;
  final Value<DateTime?> syncedAt;
  final Value<int> rowid;
  const SyncQueueItemsCompanion({
    this.id = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.penggunaId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.aksi = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueItemsCompanion.insert({
    required String id,
    required String deviceId,
    required String penggunaId,
    required String entityType,
    required String entityId,
    required String aksi,
    required String payloadJson,
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       deviceId = Value(deviceId),
       penggunaId = Value(penggunaId),
       entityType = Value(entityType),
       entityId = Value(entityId),
       aksi = Value(aksi),
       payloadJson = Value(payloadJson);
  static Insertable<SyncQueueItem> custom({
    Expression<String>? id,
    Expression<String>? deviceId,
    Expression<String>? penggunaId,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? aksi,
    Expression<String>? payloadJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deviceId != null) 'device_id': deviceId,
      if (penggunaId != null) 'pengguna_id': penggunaId,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (aksi != null) 'aksi': aksi,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAt != null) 'created_at': createdAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? deviceId,
    Value<String>? penggunaId,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? aksi,
    Value<String>? payloadJson,
    Value<DateTime>? createdAt,
    Value<DateTime?>? syncedAt,
    Value<int>? rowid,
  }) {
    return SyncQueueItemsCompanion(
      id: id ?? this.id,
      deviceId: deviceId ?? this.deviceId,
      penggunaId: penggunaId ?? this.penggunaId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      aksi: aksi ?? this.aksi,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (penggunaId.present) {
      map['pengguna_id'] = Variable<String>(penggunaId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (aksi.present) {
      map['aksi'] = Variable<String>(aksi.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueItemsCompanion(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('penggunaId: $penggunaId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('aksi: $aksi, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GudepsTable gudeps = $GudepsTable(this);
  late final $PenggunasTable penggunas = $PenggunasTable(this);
  late final $AnggotasTable anggotas = $AnggotasTable(this);
  late final $PembinaProfilsTable pembinaProfils = $PembinaProfilsTable(this);
  late final $SkuItemsTable skuItems = $SkuItemsTable(this);
  late final $SkuProgressesTable skuProgresses = $SkuProgressesTable(this);
  late final $SkuEventsTable skuEvents = $SkuEventsTable(this);
  late final $SkkBidangsTable skkBidangs = $SkkBidangsTable(this);
  late final $SkkItemsTable skkItems = $SkkItemsTable(this);
  late final $SkkProgressesTable skkProgresses = $SkkProgressesTable(this);
  late final $SkkEventsTable skkEvents = $SkkEventsTable(this);
  late final $PelantikansTable pelantikans = $PelantikansTable(this);
  late final $MateriKategorisTable materiKategoris = $MateriKategorisTable(
    this,
  );
  late final $MateriTopiksTable materiTopiks = $MateriTopiksTable(this);
  late final $MateriUnitsTable materiUnits = $MateriUnitsTable(this);
  late final $MateriRelasisTable materiRelasis = $MateriRelasisTable(this);
  late final $MateriProgressBacasTable materiProgressBacas =
      $MateriProgressBacasTable(this);
  late final $SyncQueueItemsTable syncQueueItems = $SyncQueueItemsTable(this);
  late final PenggunaDao penggunaDao = PenggunaDao(this as AppDatabase);
  late final SkuDao skuDao = SkuDao(this as AppDatabase);
  late final MateriDao materiDao = MateriDao(this as AppDatabase);
  late final PelantikanDao pelantikanDao = PelantikanDao(this as AppDatabase);
  late final SyncQueueDao syncQueueDao = SyncQueueDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    gudeps,
    penggunas,
    anggotas,
    pembinaProfils,
    skuItems,
    skuProgresses,
    skuEvents,
    skkBidangs,
    skkItems,
    skkProgresses,
    skkEvents,
    pelantikans,
    materiKategoris,
    materiTopiks,
    materiUnits,
    materiRelasis,
    materiProgressBacas,
    syncQueueItems,
  ];
}

typedef $$GudepsTableCreateCompanionBuilder =
    GudepsCompanion Function({
      required String id,
      required String nama,
      Value<String?> alamat,
      Value<String?> kwarcab,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$GudepsTableUpdateCompanionBuilder =
    GudepsCompanion Function({
      Value<String> id,
      Value<String> nama,
      Value<String?> alamat,
      Value<String?> kwarcab,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$GudepsTableFilterComposer
    extends Composer<_$AppDatabase, $GudepsTable> {
  $$GudepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alamat => $composableBuilder(
    column: $table.alamat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kwarcab => $composableBuilder(
    column: $table.kwarcab,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GudepsTableOrderingComposer
    extends Composer<_$AppDatabase, $GudepsTable> {
  $$GudepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alamat => $composableBuilder(
    column: $table.alamat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kwarcab => $composableBuilder(
    column: $table.kwarcab,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GudepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GudepsTable> {
  $$GudepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<String> get alamat =>
      $composableBuilder(column: $table.alamat, builder: (column) => column);

  GeneratedColumn<String> get kwarcab =>
      $composableBuilder(column: $table.kwarcab, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$GudepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GudepsTable,
          Gudep,
          $$GudepsTableFilterComposer,
          $$GudepsTableOrderingComposer,
          $$GudepsTableAnnotationComposer,
          $$GudepsTableCreateCompanionBuilder,
          $$GudepsTableUpdateCompanionBuilder,
          (Gudep, BaseReferences<_$AppDatabase, $GudepsTable, Gudep>),
          Gudep,
          PrefetchHooks Function()
        > {
  $$GudepsTableTableManager(_$AppDatabase db, $GudepsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GudepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GudepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GudepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<String?> alamat = const Value.absent(),
                Value<String?> kwarcab = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GudepsCompanion(
                id: id,
                nama: nama,
                alamat: alamat,
                kwarcab: kwarcab,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nama,
                Value<String?> alamat = const Value.absent(),
                Value<String?> kwarcab = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GudepsCompanion.insert(
                id: id,
                nama: nama,
                alamat: alamat,
                kwarcab: kwarcab,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GudepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GudepsTable,
      Gudep,
      $$GudepsTableFilterComposer,
      $$GudepsTableOrderingComposer,
      $$GudepsTableAnnotationComposer,
      $$GudepsTableCreateCompanionBuilder,
      $$GudepsTableUpdateCompanionBuilder,
      (Gudep, BaseReferences<_$AppDatabase, $GudepsTable, Gudep>),
      Gudep,
      PrefetchHooks Function()
    >;
typedef $$PenggunasTableCreateCompanionBuilder =
    PenggunasCompanion Function({
      required String id,
      required String gudepId,
      required String nama,
      Value<String?> email,
      Value<String?> noHp,
      required String passwordHash,
      required String role,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$PenggunasTableUpdateCompanionBuilder =
    PenggunasCompanion Function({
      Value<String> id,
      Value<String> gudepId,
      Value<String> nama,
      Value<String?> email,
      Value<String?> noHp,
      Value<String> passwordHash,
      Value<String> role,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$PenggunasTableFilterComposer
    extends Composer<_$AppDatabase, $PenggunasTable> {
  $$PenggunasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gudepId => $composableBuilder(
    column: $table.gudepId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noHp => $composableBuilder(
    column: $table.noHp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PenggunasTableOrderingComposer
    extends Composer<_$AppDatabase, $PenggunasTable> {
  $$PenggunasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gudepId => $composableBuilder(
    column: $table.gudepId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noHp => $composableBuilder(
    column: $table.noHp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PenggunasTableAnnotationComposer
    extends Composer<_$AppDatabase, $PenggunasTable> {
  $$PenggunasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gudepId =>
      $composableBuilder(column: $table.gudepId, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get noHp =>
      $composableBuilder(column: $table.noHp, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PenggunasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PenggunasTable,
          Pengguna,
          $$PenggunasTableFilterComposer,
          $$PenggunasTableOrderingComposer,
          $$PenggunasTableAnnotationComposer,
          $$PenggunasTableCreateCompanionBuilder,
          $$PenggunasTableUpdateCompanionBuilder,
          (Pengguna, BaseReferences<_$AppDatabase, $PenggunasTable, Pengguna>),
          Pengguna,
          PrefetchHooks Function()
        > {
  $$PenggunasTableTableManager(_$AppDatabase db, $PenggunasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PenggunasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PenggunasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PenggunasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gudepId = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> noHp = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PenggunasCompanion(
                id: id,
                gudepId: gudepId,
                nama: nama,
                email: email,
                noHp: noHp,
                passwordHash: passwordHash,
                role: role,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gudepId,
                required String nama,
                Value<String?> email = const Value.absent(),
                Value<String?> noHp = const Value.absent(),
                required String passwordHash,
                required String role,
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PenggunasCompanion.insert(
                id: id,
                gudepId: gudepId,
                nama: nama,
                email: email,
                noHp: noHp,
                passwordHash: passwordHash,
                role: role,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PenggunasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PenggunasTable,
      Pengguna,
      $$PenggunasTableFilterComposer,
      $$PenggunasTableOrderingComposer,
      $$PenggunasTableAnnotationComposer,
      $$PenggunasTableCreateCompanionBuilder,
      $$PenggunasTableUpdateCompanionBuilder,
      (Pengguna, BaseReferences<_$AppDatabase, $PenggunasTable, Pengguna>),
      Pengguna,
      PrefetchHooks Function()
    >;
typedef $$AnggotasTableCreateCompanionBuilder =
    AnggotasCompanion Function({
      required String id,
      required String penggunaId,
      Value<String?> nis,
      required String golongan,
      Value<String?> tingkatSaatIni,
      Value<DateTime?> tanggalLahir,
      Value<String?> namaWali,
      Value<String?> kontakWali,
      Value<String?> reguPasukan,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AnggotasTableUpdateCompanionBuilder =
    AnggotasCompanion Function({
      Value<String> id,
      Value<String> penggunaId,
      Value<String?> nis,
      Value<String> golongan,
      Value<String?> tingkatSaatIni,
      Value<DateTime?> tanggalLahir,
      Value<String?> namaWali,
      Value<String?> kontakWali,
      Value<String?> reguPasukan,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AnggotasTableFilterComposer
    extends Composer<_$AppDatabase, $AnggotasTable> {
  $$AnggotasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get penggunaId => $composableBuilder(
    column: $table.penggunaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nis => $composableBuilder(
    column: $table.nis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get golongan => $composableBuilder(
    column: $table.golongan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tingkatSaatIni => $composableBuilder(
    column: $table.tingkatSaatIni,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggalLahir => $composableBuilder(
    column: $table.tanggalLahir,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get namaWali => $composableBuilder(
    column: $table.namaWali,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kontakWali => $composableBuilder(
    column: $table.kontakWali,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reguPasukan => $composableBuilder(
    column: $table.reguPasukan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AnggotasTableOrderingComposer
    extends Composer<_$AppDatabase, $AnggotasTable> {
  $$AnggotasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get penggunaId => $composableBuilder(
    column: $table.penggunaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nis => $composableBuilder(
    column: $table.nis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get golongan => $composableBuilder(
    column: $table.golongan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tingkatSaatIni => $composableBuilder(
    column: $table.tingkatSaatIni,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggalLahir => $composableBuilder(
    column: $table.tanggalLahir,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get namaWali => $composableBuilder(
    column: $table.namaWali,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kontakWali => $composableBuilder(
    column: $table.kontakWali,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reguPasukan => $composableBuilder(
    column: $table.reguPasukan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnggotasTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnggotasTable> {
  $$AnggotasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get penggunaId => $composableBuilder(
    column: $table.penggunaId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nis =>
      $composableBuilder(column: $table.nis, builder: (column) => column);

  GeneratedColumn<String> get golongan =>
      $composableBuilder(column: $table.golongan, builder: (column) => column);

  GeneratedColumn<String> get tingkatSaatIni => $composableBuilder(
    column: $table.tingkatSaatIni,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get tanggalLahir => $composableBuilder(
    column: $table.tanggalLahir,
    builder: (column) => column,
  );

  GeneratedColumn<String> get namaWali =>
      $composableBuilder(column: $table.namaWali, builder: (column) => column);

  GeneratedColumn<String> get kontakWali => $composableBuilder(
    column: $table.kontakWali,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reguPasukan => $composableBuilder(
    column: $table.reguPasukan,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AnggotasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnggotasTable,
          Anggota,
          $$AnggotasTableFilterComposer,
          $$AnggotasTableOrderingComposer,
          $$AnggotasTableAnnotationComposer,
          $$AnggotasTableCreateCompanionBuilder,
          $$AnggotasTableUpdateCompanionBuilder,
          (Anggota, BaseReferences<_$AppDatabase, $AnggotasTable, Anggota>),
          Anggota,
          PrefetchHooks Function()
        > {
  $$AnggotasTableTableManager(_$AppDatabase db, $AnggotasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnggotasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnggotasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnggotasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> penggunaId = const Value.absent(),
                Value<String?> nis = const Value.absent(),
                Value<String> golongan = const Value.absent(),
                Value<String?> tingkatSaatIni = const Value.absent(),
                Value<DateTime?> tanggalLahir = const Value.absent(),
                Value<String?> namaWali = const Value.absent(),
                Value<String?> kontakWali = const Value.absent(),
                Value<String?> reguPasukan = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnggotasCompanion(
                id: id,
                penggunaId: penggunaId,
                nis: nis,
                golongan: golongan,
                tingkatSaatIni: tingkatSaatIni,
                tanggalLahir: tanggalLahir,
                namaWali: namaWali,
                kontakWali: kontakWali,
                reguPasukan: reguPasukan,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String penggunaId,
                Value<String?> nis = const Value.absent(),
                required String golongan,
                Value<String?> tingkatSaatIni = const Value.absent(),
                Value<DateTime?> tanggalLahir = const Value.absent(),
                Value<String?> namaWali = const Value.absent(),
                Value<String?> kontakWali = const Value.absent(),
                Value<String?> reguPasukan = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnggotasCompanion.insert(
                id: id,
                penggunaId: penggunaId,
                nis: nis,
                golongan: golongan,
                tingkatSaatIni: tingkatSaatIni,
                tanggalLahir: tanggalLahir,
                namaWali: namaWali,
                kontakWali: kontakWali,
                reguPasukan: reguPasukan,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AnggotasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnggotasTable,
      Anggota,
      $$AnggotasTableFilterComposer,
      $$AnggotasTableOrderingComposer,
      $$AnggotasTableAnnotationComposer,
      $$AnggotasTableCreateCompanionBuilder,
      $$AnggotasTableUpdateCompanionBuilder,
      (Anggota, BaseReferences<_$AppDatabase, $AnggotasTable, Anggota>),
      Anggota,
      PrefetchHooks Function()
    >;
typedef $$PembinaProfilsTableCreateCompanionBuilder =
    PembinaProfilsCompanion Function({
      required String id,
      required String penggunaId,
      Value<String?> bidangKeahlian,
      Value<String?> keterangan,
      Value<int> rowid,
    });
typedef $$PembinaProfilsTableUpdateCompanionBuilder =
    PembinaProfilsCompanion Function({
      Value<String> id,
      Value<String> penggunaId,
      Value<String?> bidangKeahlian,
      Value<String?> keterangan,
      Value<int> rowid,
    });

class $$PembinaProfilsTableFilterComposer
    extends Composer<_$AppDatabase, $PembinaProfilsTable> {
  $$PembinaProfilsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get penggunaId => $composableBuilder(
    column: $table.penggunaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bidangKeahlian => $composableBuilder(
    column: $table.bidangKeahlian,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keterangan => $composableBuilder(
    column: $table.keterangan,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PembinaProfilsTableOrderingComposer
    extends Composer<_$AppDatabase, $PembinaProfilsTable> {
  $$PembinaProfilsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get penggunaId => $composableBuilder(
    column: $table.penggunaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bidangKeahlian => $composableBuilder(
    column: $table.bidangKeahlian,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keterangan => $composableBuilder(
    column: $table.keterangan,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PembinaProfilsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PembinaProfilsTable> {
  $$PembinaProfilsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get penggunaId => $composableBuilder(
    column: $table.penggunaId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bidangKeahlian => $composableBuilder(
    column: $table.bidangKeahlian,
    builder: (column) => column,
  );

  GeneratedColumn<String> get keterangan => $composableBuilder(
    column: $table.keterangan,
    builder: (column) => column,
  );
}

class $$PembinaProfilsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PembinaProfilsTable,
          PembinaProfil,
          $$PembinaProfilsTableFilterComposer,
          $$PembinaProfilsTableOrderingComposer,
          $$PembinaProfilsTableAnnotationComposer,
          $$PembinaProfilsTableCreateCompanionBuilder,
          $$PembinaProfilsTableUpdateCompanionBuilder,
          (
            PembinaProfil,
            BaseReferences<_$AppDatabase, $PembinaProfilsTable, PembinaProfil>,
          ),
          PembinaProfil,
          PrefetchHooks Function()
        > {
  $$PembinaProfilsTableTableManager(
    _$AppDatabase db,
    $PembinaProfilsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PembinaProfilsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PembinaProfilsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PembinaProfilsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> penggunaId = const Value.absent(),
                Value<String?> bidangKeahlian = const Value.absent(),
                Value<String?> keterangan = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PembinaProfilsCompanion(
                id: id,
                penggunaId: penggunaId,
                bidangKeahlian: bidangKeahlian,
                keterangan: keterangan,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String penggunaId,
                Value<String?> bidangKeahlian = const Value.absent(),
                Value<String?> keterangan = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PembinaProfilsCompanion.insert(
                id: id,
                penggunaId: penggunaId,
                bidangKeahlian: bidangKeahlian,
                keterangan: keterangan,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PembinaProfilsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PembinaProfilsTable,
      PembinaProfil,
      $$PembinaProfilsTableFilterComposer,
      $$PembinaProfilsTableOrderingComposer,
      $$PembinaProfilsTableAnnotationComposer,
      $$PembinaProfilsTableCreateCompanionBuilder,
      $$PembinaProfilsTableUpdateCompanionBuilder,
      (
        PembinaProfil,
        BaseReferences<_$AppDatabase, $PembinaProfilsTable, PembinaProfil>,
      ),
      PembinaProfil,
      PrefetchHooks Function()
    >;
typedef $$SkuItemsTableCreateCompanionBuilder =
    SkuItemsCompanion Function({
      required String id,
      required String golongan,
      required String tingkat,
      required int nomorUrut,
      required String deskripsi,
      Value<String?> kategori,
      Value<bool> aktif,
      Value<int> rowid,
    });
typedef $$SkuItemsTableUpdateCompanionBuilder =
    SkuItemsCompanion Function({
      Value<String> id,
      Value<String> golongan,
      Value<String> tingkat,
      Value<int> nomorUrut,
      Value<String> deskripsi,
      Value<String?> kategori,
      Value<bool> aktif,
      Value<int> rowid,
    });

class $$SkuItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SkuItemsTable> {
  $$SkuItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get golongan => $composableBuilder(
    column: $table.golongan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tingkat => $composableBuilder(
    column: $table.tingkat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nomorUrut => $composableBuilder(
    column: $table.nomorUrut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deskripsi => $composableBuilder(
    column: $table.deskripsi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get aktif => $composableBuilder(
    column: $table.aktif,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SkuItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkuItemsTable> {
  $$SkuItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get golongan => $composableBuilder(
    column: $table.golongan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tingkat => $composableBuilder(
    column: $table.tingkat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nomorUrut => $composableBuilder(
    column: $table.nomorUrut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deskripsi => $composableBuilder(
    column: $table.deskripsi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get aktif => $composableBuilder(
    column: $table.aktif,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkuItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkuItemsTable> {
  $$SkuItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get golongan =>
      $composableBuilder(column: $table.golongan, builder: (column) => column);

  GeneratedColumn<String> get tingkat =>
      $composableBuilder(column: $table.tingkat, builder: (column) => column);

  GeneratedColumn<int> get nomorUrut =>
      $composableBuilder(column: $table.nomorUrut, builder: (column) => column);

  GeneratedColumn<String> get deskripsi =>
      $composableBuilder(column: $table.deskripsi, builder: (column) => column);

  GeneratedColumn<String> get kategori =>
      $composableBuilder(column: $table.kategori, builder: (column) => column);

  GeneratedColumn<bool> get aktif =>
      $composableBuilder(column: $table.aktif, builder: (column) => column);
}

class $$SkuItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkuItemsTable,
          SkuItem,
          $$SkuItemsTableFilterComposer,
          $$SkuItemsTableOrderingComposer,
          $$SkuItemsTableAnnotationComposer,
          $$SkuItemsTableCreateCompanionBuilder,
          $$SkuItemsTableUpdateCompanionBuilder,
          (SkuItem, BaseReferences<_$AppDatabase, $SkuItemsTable, SkuItem>),
          SkuItem,
          PrefetchHooks Function()
        > {
  $$SkuItemsTableTableManager(_$AppDatabase db, $SkuItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkuItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkuItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkuItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> golongan = const Value.absent(),
                Value<String> tingkat = const Value.absent(),
                Value<int> nomorUrut = const Value.absent(),
                Value<String> deskripsi = const Value.absent(),
                Value<String?> kategori = const Value.absent(),
                Value<bool> aktif = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkuItemsCompanion(
                id: id,
                golongan: golongan,
                tingkat: tingkat,
                nomorUrut: nomorUrut,
                deskripsi: deskripsi,
                kategori: kategori,
                aktif: aktif,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String golongan,
                required String tingkat,
                required int nomorUrut,
                required String deskripsi,
                Value<String?> kategori = const Value.absent(),
                Value<bool> aktif = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkuItemsCompanion.insert(
                id: id,
                golongan: golongan,
                tingkat: tingkat,
                nomorUrut: nomorUrut,
                deskripsi: deskripsi,
                kategori: kategori,
                aktif: aktif,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SkuItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkuItemsTable,
      SkuItem,
      $$SkuItemsTableFilterComposer,
      $$SkuItemsTableOrderingComposer,
      $$SkuItemsTableAnnotationComposer,
      $$SkuItemsTableCreateCompanionBuilder,
      $$SkuItemsTableUpdateCompanionBuilder,
      (SkuItem, BaseReferences<_$AppDatabase, $SkuItemsTable, SkuItem>),
      SkuItem,
      PrefetchHooks Function()
    >;
typedef $$SkuProgressesTableCreateCompanionBuilder =
    SkuProgressesCompanion Function({
      required String id,
      required String anggotaId,
      required String skuItemId,
      Value<String> status,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$SkuProgressesTableUpdateCompanionBuilder =
    SkuProgressesCompanion Function({
      Value<String> id,
      Value<String> anggotaId,
      Value<String> skuItemId,
      Value<String> status,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SkuProgressesTableFilterComposer
    extends Composer<_$AppDatabase, $SkuProgressesTable> {
  $$SkuProgressesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get anggotaId => $composableBuilder(
    column: $table.anggotaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skuItemId => $composableBuilder(
    column: $table.skuItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SkuProgressesTableOrderingComposer
    extends Composer<_$AppDatabase, $SkuProgressesTable> {
  $$SkuProgressesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get anggotaId => $composableBuilder(
    column: $table.anggotaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skuItemId => $composableBuilder(
    column: $table.skuItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkuProgressesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkuProgressesTable> {
  $$SkuProgressesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get anggotaId =>
      $composableBuilder(column: $table.anggotaId, builder: (column) => column);

  GeneratedColumn<String> get skuItemId =>
      $composableBuilder(column: $table.skuItemId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SkuProgressesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkuProgressesTable,
          SkuProgress,
          $$SkuProgressesTableFilterComposer,
          $$SkuProgressesTableOrderingComposer,
          $$SkuProgressesTableAnnotationComposer,
          $$SkuProgressesTableCreateCompanionBuilder,
          $$SkuProgressesTableUpdateCompanionBuilder,
          (
            SkuProgress,
            BaseReferences<_$AppDatabase, $SkuProgressesTable, SkuProgress>,
          ),
          SkuProgress,
          PrefetchHooks Function()
        > {
  $$SkuProgressesTableTableManager(_$AppDatabase db, $SkuProgressesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkuProgressesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkuProgressesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkuProgressesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> anggotaId = const Value.absent(),
                Value<String> skuItemId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkuProgressesCompanion(
                id: id,
                anggotaId: anggotaId,
                skuItemId: skuItemId,
                status: status,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String anggotaId,
                required String skuItemId,
                Value<String> status = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkuProgressesCompanion.insert(
                id: id,
                anggotaId: anggotaId,
                skuItemId: skuItemId,
                status: status,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SkuProgressesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkuProgressesTable,
      SkuProgress,
      $$SkuProgressesTableFilterComposer,
      $$SkuProgressesTableOrderingComposer,
      $$SkuProgressesTableAnnotationComposer,
      $$SkuProgressesTableCreateCompanionBuilder,
      $$SkuProgressesTableUpdateCompanionBuilder,
      (
        SkuProgress,
        BaseReferences<_$AppDatabase, $SkuProgressesTable, SkuProgress>,
      ),
      SkuProgress,
      PrefetchHooks Function()
    >;
typedef $$SkuEventsTableCreateCompanionBuilder =
    SkuEventsCompanion Function({
      required String id,
      required String skuProgressId,
      required String aktorId,
      required String aksi,
      Value<String?> catatan,
      Value<String?> deviceId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$SkuEventsTableUpdateCompanionBuilder =
    SkuEventsCompanion Function({
      Value<String> id,
      Value<String> skuProgressId,
      Value<String> aktorId,
      Value<String> aksi,
      Value<String?> catatan,
      Value<String?> deviceId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SkuEventsTableFilterComposer
    extends Composer<_$AppDatabase, $SkuEventsTable> {
  $$SkuEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skuProgressId => $composableBuilder(
    column: $table.skuProgressId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aktorId => $composableBuilder(
    column: $table.aktorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aksi => $composableBuilder(
    column: $table.aksi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SkuEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkuEventsTable> {
  $$SkuEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skuProgressId => $composableBuilder(
    column: $table.skuProgressId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aktorId => $composableBuilder(
    column: $table.aktorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aksi => $composableBuilder(
    column: $table.aksi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkuEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkuEventsTable> {
  $$SkuEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get skuProgressId => $composableBuilder(
    column: $table.skuProgressId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aktorId =>
      $composableBuilder(column: $table.aktorId, builder: (column) => column);

  GeneratedColumn<String> get aksi =>
      $composableBuilder(column: $table.aksi, builder: (column) => column);

  GeneratedColumn<String> get catatan =>
      $composableBuilder(column: $table.catatan, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SkuEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkuEventsTable,
          SkuEvent,
          $$SkuEventsTableFilterComposer,
          $$SkuEventsTableOrderingComposer,
          $$SkuEventsTableAnnotationComposer,
          $$SkuEventsTableCreateCompanionBuilder,
          $$SkuEventsTableUpdateCompanionBuilder,
          (SkuEvent, BaseReferences<_$AppDatabase, $SkuEventsTable, SkuEvent>),
          SkuEvent,
          PrefetchHooks Function()
        > {
  $$SkuEventsTableTableManager(_$AppDatabase db, $SkuEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkuEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkuEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkuEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> skuProgressId = const Value.absent(),
                Value<String> aktorId = const Value.absent(),
                Value<String> aksi = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkuEventsCompanion(
                id: id,
                skuProgressId: skuProgressId,
                aktorId: aktorId,
                aksi: aksi,
                catatan: catatan,
                deviceId: deviceId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String skuProgressId,
                required String aktorId,
                required String aksi,
                Value<String?> catatan = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkuEventsCompanion.insert(
                id: id,
                skuProgressId: skuProgressId,
                aktorId: aktorId,
                aksi: aksi,
                catatan: catatan,
                deviceId: deviceId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SkuEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkuEventsTable,
      SkuEvent,
      $$SkuEventsTableFilterComposer,
      $$SkuEventsTableOrderingComposer,
      $$SkuEventsTableAnnotationComposer,
      $$SkuEventsTableCreateCompanionBuilder,
      $$SkuEventsTableUpdateCompanionBuilder,
      (SkuEvent, BaseReferences<_$AppDatabase, $SkuEventsTable, SkuEvent>),
      SkuEvent,
      PrefetchHooks Function()
    >;
typedef $$SkkBidangsTableCreateCompanionBuilder =
    SkkBidangsCompanion Function({
      required String id,
      required String nama,
      Value<String?> kelompok,
      required String level,
      Value<int> rowid,
    });
typedef $$SkkBidangsTableUpdateCompanionBuilder =
    SkkBidangsCompanion Function({
      Value<String> id,
      Value<String> nama,
      Value<String?> kelompok,
      Value<String> level,
      Value<int> rowid,
    });

class $$SkkBidangsTableFilterComposer
    extends Composer<_$AppDatabase, $SkkBidangsTable> {
  $$SkkBidangsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kelompok => $composableBuilder(
    column: $table.kelompok,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SkkBidangsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkkBidangsTable> {
  $$SkkBidangsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kelompok => $composableBuilder(
    column: $table.kelompok,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkkBidangsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkkBidangsTable> {
  $$SkkBidangsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<String> get kelompok =>
      $composableBuilder(column: $table.kelompok, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);
}

class $$SkkBidangsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkkBidangsTable,
          SkkBidang,
          $$SkkBidangsTableFilterComposer,
          $$SkkBidangsTableOrderingComposer,
          $$SkkBidangsTableAnnotationComposer,
          $$SkkBidangsTableCreateCompanionBuilder,
          $$SkkBidangsTableUpdateCompanionBuilder,
          (
            SkkBidang,
            BaseReferences<_$AppDatabase, $SkkBidangsTable, SkkBidang>,
          ),
          SkkBidang,
          PrefetchHooks Function()
        > {
  $$SkkBidangsTableTableManager(_$AppDatabase db, $SkkBidangsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkkBidangsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkkBidangsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkkBidangsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<String?> kelompok = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkkBidangsCompanion(
                id: id,
                nama: nama,
                kelompok: kelompok,
                level: level,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nama,
                Value<String?> kelompok = const Value.absent(),
                required String level,
                Value<int> rowid = const Value.absent(),
              }) => SkkBidangsCompanion.insert(
                id: id,
                nama: nama,
                kelompok: kelompok,
                level: level,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SkkBidangsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkkBidangsTable,
      SkkBidang,
      $$SkkBidangsTableFilterComposer,
      $$SkkBidangsTableOrderingComposer,
      $$SkkBidangsTableAnnotationComposer,
      $$SkkBidangsTableCreateCompanionBuilder,
      $$SkkBidangsTableUpdateCompanionBuilder,
      (SkkBidang, BaseReferences<_$AppDatabase, $SkkBidangsTable, SkkBidang>),
      SkkBidang,
      PrefetchHooks Function()
    >;
typedef $$SkkItemsTableCreateCompanionBuilder =
    SkkItemsCompanion Function({
      required String id,
      required String skkBidangId,
      required int nomorUrut,
      required String deskripsiSyarat,
      Value<int> rowid,
    });
typedef $$SkkItemsTableUpdateCompanionBuilder =
    SkkItemsCompanion Function({
      Value<String> id,
      Value<String> skkBidangId,
      Value<int> nomorUrut,
      Value<String> deskripsiSyarat,
      Value<int> rowid,
    });

class $$SkkItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SkkItemsTable> {
  $$SkkItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skkBidangId => $composableBuilder(
    column: $table.skkBidangId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nomorUrut => $composableBuilder(
    column: $table.nomorUrut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deskripsiSyarat => $composableBuilder(
    column: $table.deskripsiSyarat,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SkkItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkkItemsTable> {
  $$SkkItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skkBidangId => $composableBuilder(
    column: $table.skkBidangId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nomorUrut => $composableBuilder(
    column: $table.nomorUrut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deskripsiSyarat => $composableBuilder(
    column: $table.deskripsiSyarat,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkkItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkkItemsTable> {
  $$SkkItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get skkBidangId => $composableBuilder(
    column: $table.skkBidangId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nomorUrut =>
      $composableBuilder(column: $table.nomorUrut, builder: (column) => column);

  GeneratedColumn<String> get deskripsiSyarat => $composableBuilder(
    column: $table.deskripsiSyarat,
    builder: (column) => column,
  );
}

class $$SkkItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkkItemsTable,
          SkkItem,
          $$SkkItemsTableFilterComposer,
          $$SkkItemsTableOrderingComposer,
          $$SkkItemsTableAnnotationComposer,
          $$SkkItemsTableCreateCompanionBuilder,
          $$SkkItemsTableUpdateCompanionBuilder,
          (SkkItem, BaseReferences<_$AppDatabase, $SkkItemsTable, SkkItem>),
          SkkItem,
          PrefetchHooks Function()
        > {
  $$SkkItemsTableTableManager(_$AppDatabase db, $SkkItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkkItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkkItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkkItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> skkBidangId = const Value.absent(),
                Value<int> nomorUrut = const Value.absent(),
                Value<String> deskripsiSyarat = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkkItemsCompanion(
                id: id,
                skkBidangId: skkBidangId,
                nomorUrut: nomorUrut,
                deskripsiSyarat: deskripsiSyarat,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String skkBidangId,
                required int nomorUrut,
                required String deskripsiSyarat,
                Value<int> rowid = const Value.absent(),
              }) => SkkItemsCompanion.insert(
                id: id,
                skkBidangId: skkBidangId,
                nomorUrut: nomorUrut,
                deskripsiSyarat: deskripsiSyarat,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SkkItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkkItemsTable,
      SkkItem,
      $$SkkItemsTableFilterComposer,
      $$SkkItemsTableOrderingComposer,
      $$SkkItemsTableAnnotationComposer,
      $$SkkItemsTableCreateCompanionBuilder,
      $$SkkItemsTableUpdateCompanionBuilder,
      (SkkItem, BaseReferences<_$AppDatabase, $SkkItemsTable, SkkItem>),
      SkkItem,
      PrefetchHooks Function()
    >;
typedef $$SkkProgressesTableCreateCompanionBuilder =
    SkkProgressesCompanion Function({
      required String id,
      required String anggotaId,
      required String skkItemId,
      Value<String> status,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$SkkProgressesTableUpdateCompanionBuilder =
    SkkProgressesCompanion Function({
      Value<String> id,
      Value<String> anggotaId,
      Value<String> skkItemId,
      Value<String> status,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SkkProgressesTableFilterComposer
    extends Composer<_$AppDatabase, $SkkProgressesTable> {
  $$SkkProgressesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get anggotaId => $composableBuilder(
    column: $table.anggotaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skkItemId => $composableBuilder(
    column: $table.skkItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SkkProgressesTableOrderingComposer
    extends Composer<_$AppDatabase, $SkkProgressesTable> {
  $$SkkProgressesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get anggotaId => $composableBuilder(
    column: $table.anggotaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skkItemId => $composableBuilder(
    column: $table.skkItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkkProgressesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkkProgressesTable> {
  $$SkkProgressesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get anggotaId =>
      $composableBuilder(column: $table.anggotaId, builder: (column) => column);

  GeneratedColumn<String> get skkItemId =>
      $composableBuilder(column: $table.skkItemId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SkkProgressesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkkProgressesTable,
          SkkProgress,
          $$SkkProgressesTableFilterComposer,
          $$SkkProgressesTableOrderingComposer,
          $$SkkProgressesTableAnnotationComposer,
          $$SkkProgressesTableCreateCompanionBuilder,
          $$SkkProgressesTableUpdateCompanionBuilder,
          (
            SkkProgress,
            BaseReferences<_$AppDatabase, $SkkProgressesTable, SkkProgress>,
          ),
          SkkProgress,
          PrefetchHooks Function()
        > {
  $$SkkProgressesTableTableManager(_$AppDatabase db, $SkkProgressesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkkProgressesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkkProgressesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkkProgressesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> anggotaId = const Value.absent(),
                Value<String> skkItemId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkkProgressesCompanion(
                id: id,
                anggotaId: anggotaId,
                skkItemId: skkItemId,
                status: status,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String anggotaId,
                required String skkItemId,
                Value<String> status = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkkProgressesCompanion.insert(
                id: id,
                anggotaId: anggotaId,
                skkItemId: skkItemId,
                status: status,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SkkProgressesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkkProgressesTable,
      SkkProgress,
      $$SkkProgressesTableFilterComposer,
      $$SkkProgressesTableOrderingComposer,
      $$SkkProgressesTableAnnotationComposer,
      $$SkkProgressesTableCreateCompanionBuilder,
      $$SkkProgressesTableUpdateCompanionBuilder,
      (
        SkkProgress,
        BaseReferences<_$AppDatabase, $SkkProgressesTable, SkkProgress>,
      ),
      SkkProgress,
      PrefetchHooks Function()
    >;
typedef $$SkkEventsTableCreateCompanionBuilder =
    SkkEventsCompanion Function({
      required String id,
      required String skkProgressId,
      required String aktorId,
      required String aksi,
      Value<String?> catatan,
      Value<String?> deviceId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$SkkEventsTableUpdateCompanionBuilder =
    SkkEventsCompanion Function({
      Value<String> id,
      Value<String> skkProgressId,
      Value<String> aktorId,
      Value<String> aksi,
      Value<String?> catatan,
      Value<String?> deviceId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SkkEventsTableFilterComposer
    extends Composer<_$AppDatabase, $SkkEventsTable> {
  $$SkkEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skkProgressId => $composableBuilder(
    column: $table.skkProgressId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aktorId => $composableBuilder(
    column: $table.aktorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aksi => $composableBuilder(
    column: $table.aksi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SkkEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkkEventsTable> {
  $$SkkEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skkProgressId => $composableBuilder(
    column: $table.skkProgressId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aktorId => $composableBuilder(
    column: $table.aktorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aksi => $composableBuilder(
    column: $table.aksi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkkEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkkEventsTable> {
  $$SkkEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get skkProgressId => $composableBuilder(
    column: $table.skkProgressId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aktorId =>
      $composableBuilder(column: $table.aktorId, builder: (column) => column);

  GeneratedColumn<String> get aksi =>
      $composableBuilder(column: $table.aksi, builder: (column) => column);

  GeneratedColumn<String> get catatan =>
      $composableBuilder(column: $table.catatan, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SkkEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkkEventsTable,
          SkkEvent,
          $$SkkEventsTableFilterComposer,
          $$SkkEventsTableOrderingComposer,
          $$SkkEventsTableAnnotationComposer,
          $$SkkEventsTableCreateCompanionBuilder,
          $$SkkEventsTableUpdateCompanionBuilder,
          (SkkEvent, BaseReferences<_$AppDatabase, $SkkEventsTable, SkkEvent>),
          SkkEvent,
          PrefetchHooks Function()
        > {
  $$SkkEventsTableTableManager(_$AppDatabase db, $SkkEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkkEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkkEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkkEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> skkProgressId = const Value.absent(),
                Value<String> aktorId = const Value.absent(),
                Value<String> aksi = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkkEventsCompanion(
                id: id,
                skkProgressId: skkProgressId,
                aktorId: aktorId,
                aksi: aksi,
                catatan: catatan,
                deviceId: deviceId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String skkProgressId,
                required String aktorId,
                required String aksi,
                Value<String?> catatan = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkkEventsCompanion.insert(
                id: id,
                skkProgressId: skkProgressId,
                aktorId: aktorId,
                aksi: aksi,
                catatan: catatan,
                deviceId: deviceId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SkkEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkkEventsTable,
      SkkEvent,
      $$SkkEventsTableFilterComposer,
      $$SkkEventsTableOrderingComposer,
      $$SkkEventsTableAnnotationComposer,
      $$SkkEventsTableCreateCompanionBuilder,
      $$SkkEventsTableUpdateCompanionBuilder,
      (SkkEvent, BaseReferences<_$AppDatabase, $SkkEventsTable, SkkEvent>),
      SkkEvent,
      PrefetchHooks Function()
    >;
typedef $$PelantikansTableCreateCompanionBuilder =
    PelantikansCompanion Function({
      required String id,
      required String anggotaId,
      required String jenis,
      required String referensiLabel,
      required DateTime tanggal,
      required String pembinaId,
      Value<String?> catatan,
      Value<String?> sertifikatUrl,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PelantikansTableUpdateCompanionBuilder =
    PelantikansCompanion Function({
      Value<String> id,
      Value<String> anggotaId,
      Value<String> jenis,
      Value<String> referensiLabel,
      Value<DateTime> tanggal,
      Value<String> pembinaId,
      Value<String?> catatan,
      Value<String?> sertifikatUrl,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$PelantikansTableFilterComposer
    extends Composer<_$AppDatabase, $PelantikansTable> {
  $$PelantikansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get anggotaId => $composableBuilder(
    column: $table.anggotaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referensiLabel => $composableBuilder(
    column: $table.referensiLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pembinaId => $composableBuilder(
    column: $table.pembinaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sertifikatUrl => $composableBuilder(
    column: $table.sertifikatUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PelantikansTableOrderingComposer
    extends Composer<_$AppDatabase, $PelantikansTable> {
  $$PelantikansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get anggotaId => $composableBuilder(
    column: $table.anggotaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referensiLabel => $composableBuilder(
    column: $table.referensiLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pembinaId => $composableBuilder(
    column: $table.pembinaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sertifikatUrl => $composableBuilder(
    column: $table.sertifikatUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PelantikansTableAnnotationComposer
    extends Composer<_$AppDatabase, $PelantikansTable> {
  $$PelantikansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get anggotaId =>
      $composableBuilder(column: $table.anggotaId, builder: (column) => column);

  GeneratedColumn<String> get jenis =>
      $composableBuilder(column: $table.jenis, builder: (column) => column);

  GeneratedColumn<String> get referensiLabel => $composableBuilder(
    column: $table.referensiLabel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get tanggal =>
      $composableBuilder(column: $table.tanggal, builder: (column) => column);

  GeneratedColumn<String> get pembinaId =>
      $composableBuilder(column: $table.pembinaId, builder: (column) => column);

  GeneratedColumn<String> get catatan =>
      $composableBuilder(column: $table.catatan, builder: (column) => column);

  GeneratedColumn<String> get sertifikatUrl => $composableBuilder(
    column: $table.sertifikatUrl,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PelantikansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PelantikansTable,
          Pelantikan,
          $$PelantikansTableFilterComposer,
          $$PelantikansTableOrderingComposer,
          $$PelantikansTableAnnotationComposer,
          $$PelantikansTableCreateCompanionBuilder,
          $$PelantikansTableUpdateCompanionBuilder,
          (
            Pelantikan,
            BaseReferences<_$AppDatabase, $PelantikansTable, Pelantikan>,
          ),
          Pelantikan,
          PrefetchHooks Function()
        > {
  $$PelantikansTableTableManager(_$AppDatabase db, $PelantikansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PelantikansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PelantikansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PelantikansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> anggotaId = const Value.absent(),
                Value<String> jenis = const Value.absent(),
                Value<String> referensiLabel = const Value.absent(),
                Value<DateTime> tanggal = const Value.absent(),
                Value<String> pembinaId = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
                Value<String?> sertifikatUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PelantikansCompanion(
                id: id,
                anggotaId: anggotaId,
                jenis: jenis,
                referensiLabel: referensiLabel,
                tanggal: tanggal,
                pembinaId: pembinaId,
                catatan: catatan,
                sertifikatUrl: sertifikatUrl,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String anggotaId,
                required String jenis,
                required String referensiLabel,
                required DateTime tanggal,
                required String pembinaId,
                Value<String?> catatan = const Value.absent(),
                Value<String?> sertifikatUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PelantikansCompanion.insert(
                id: id,
                anggotaId: anggotaId,
                jenis: jenis,
                referensiLabel: referensiLabel,
                tanggal: tanggal,
                pembinaId: pembinaId,
                catatan: catatan,
                sertifikatUrl: sertifikatUrl,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PelantikansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PelantikansTable,
      Pelantikan,
      $$PelantikansTableFilterComposer,
      $$PelantikansTableOrderingComposer,
      $$PelantikansTableAnnotationComposer,
      $$PelantikansTableCreateCompanionBuilder,
      $$PelantikansTableUpdateCompanionBuilder,
      (
        Pelantikan,
        BaseReferences<_$AppDatabase, $PelantikansTable, Pelantikan>,
      ),
      Pelantikan,
      PrefetchHooks Function()
    >;
typedef $$MateriKategorisTableCreateCompanionBuilder =
    MateriKategorisCompanion Function({
      required String id,
      required String nama,
      Value<int> urutan,
      Value<String?> ikon,
      Value<int> rowid,
    });
typedef $$MateriKategorisTableUpdateCompanionBuilder =
    MateriKategorisCompanion Function({
      Value<String> id,
      Value<String> nama,
      Value<int> urutan,
      Value<String?> ikon,
      Value<int> rowid,
    });

class $$MateriKategorisTableFilterComposer
    extends Composer<_$AppDatabase, $MateriKategorisTable> {
  $$MateriKategorisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get urutan => $composableBuilder(
    column: $table.urutan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ikon => $composableBuilder(
    column: $table.ikon,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MateriKategorisTableOrderingComposer
    extends Composer<_$AppDatabase, $MateriKategorisTable> {
  $$MateriKategorisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get urutan => $composableBuilder(
    column: $table.urutan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ikon => $composableBuilder(
    column: $table.ikon,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MateriKategorisTableAnnotationComposer
    extends Composer<_$AppDatabase, $MateriKategorisTable> {
  $$MateriKategorisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<int> get urutan =>
      $composableBuilder(column: $table.urutan, builder: (column) => column);

  GeneratedColumn<String> get ikon =>
      $composableBuilder(column: $table.ikon, builder: (column) => column);
}

class $$MateriKategorisTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MateriKategorisTable,
          MateriKategori,
          $$MateriKategorisTableFilterComposer,
          $$MateriKategorisTableOrderingComposer,
          $$MateriKategorisTableAnnotationComposer,
          $$MateriKategorisTableCreateCompanionBuilder,
          $$MateriKategorisTableUpdateCompanionBuilder,
          (
            MateriKategori,
            BaseReferences<
              _$AppDatabase,
              $MateriKategorisTable,
              MateriKategori
            >,
          ),
          MateriKategori,
          PrefetchHooks Function()
        > {
  $$MateriKategorisTableTableManager(
    _$AppDatabase db,
    $MateriKategorisTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MateriKategorisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MateriKategorisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MateriKategorisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<int> urutan = const Value.absent(),
                Value<String?> ikon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MateriKategorisCompanion(
                id: id,
                nama: nama,
                urutan: urutan,
                ikon: ikon,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nama,
                Value<int> urutan = const Value.absent(),
                Value<String?> ikon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MateriKategorisCompanion.insert(
                id: id,
                nama: nama,
                urutan: urutan,
                ikon: ikon,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MateriKategorisTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MateriKategorisTable,
      MateriKategori,
      $$MateriKategorisTableFilterComposer,
      $$MateriKategorisTableOrderingComposer,
      $$MateriKategorisTableAnnotationComposer,
      $$MateriKategorisTableCreateCompanionBuilder,
      $$MateriKategorisTableUpdateCompanionBuilder,
      (
        MateriKategori,
        BaseReferences<_$AppDatabase, $MateriKategorisTable, MateriKategori>,
      ),
      MateriKategori,
      PrefetchHooks Function()
    >;
typedef $$MateriTopiksTableCreateCompanionBuilder =
    MateriTopiksCompanion Function({
      required String id,
      required String kategoriId,
      required String nama,
      Value<int> urutan,
      Value<int> rowid,
    });
typedef $$MateriTopiksTableUpdateCompanionBuilder =
    MateriTopiksCompanion Function({
      Value<String> id,
      Value<String> kategoriId,
      Value<String> nama,
      Value<int> urutan,
      Value<int> rowid,
    });

class $$MateriTopiksTableFilterComposer
    extends Composer<_$AppDatabase, $MateriTopiksTable> {
  $$MateriTopiksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kategoriId => $composableBuilder(
    column: $table.kategoriId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get urutan => $composableBuilder(
    column: $table.urutan,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MateriTopiksTableOrderingComposer
    extends Composer<_$AppDatabase, $MateriTopiksTable> {
  $$MateriTopiksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kategoriId => $composableBuilder(
    column: $table.kategoriId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get urutan => $composableBuilder(
    column: $table.urutan,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MateriTopiksTableAnnotationComposer
    extends Composer<_$AppDatabase, $MateriTopiksTable> {
  $$MateriTopiksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kategoriId => $composableBuilder(
    column: $table.kategoriId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<int> get urutan =>
      $composableBuilder(column: $table.urutan, builder: (column) => column);
}

class $$MateriTopiksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MateriTopiksTable,
          MateriTopik,
          $$MateriTopiksTableFilterComposer,
          $$MateriTopiksTableOrderingComposer,
          $$MateriTopiksTableAnnotationComposer,
          $$MateriTopiksTableCreateCompanionBuilder,
          $$MateriTopiksTableUpdateCompanionBuilder,
          (
            MateriTopik,
            BaseReferences<_$AppDatabase, $MateriTopiksTable, MateriTopik>,
          ),
          MateriTopik,
          PrefetchHooks Function()
        > {
  $$MateriTopiksTableTableManager(_$AppDatabase db, $MateriTopiksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MateriTopiksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MateriTopiksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MateriTopiksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> kategoriId = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<int> urutan = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MateriTopiksCompanion(
                id: id,
                kategoriId: kategoriId,
                nama: nama,
                urutan: urutan,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String kategoriId,
                required String nama,
                Value<int> urutan = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MateriTopiksCompanion.insert(
                id: id,
                kategoriId: kategoriId,
                nama: nama,
                urutan: urutan,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MateriTopiksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MateriTopiksTable,
      MateriTopik,
      $$MateriTopiksTableFilterComposer,
      $$MateriTopiksTableOrderingComposer,
      $$MateriTopiksTableAnnotationComposer,
      $$MateriTopiksTableCreateCompanionBuilder,
      $$MateriTopiksTableUpdateCompanionBuilder,
      (
        MateriTopik,
        BaseReferences<_$AppDatabase, $MateriTopiksTable, MateriTopik>,
      ),
      MateriTopik,
      PrefetchHooks Function()
    >;
typedef $$MateriUnitsTableCreateCompanionBuilder =
    MateriUnitsCompanion Function({
      required String id,
      required String topikId,
      required String judul,
      required String kontenMarkdown,
      Value<String?> mediaUrlsJson,
      Value<int> versi,
      Value<int> urutan,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$MateriUnitsTableUpdateCompanionBuilder =
    MateriUnitsCompanion Function({
      Value<String> id,
      Value<String> topikId,
      Value<String> judul,
      Value<String> kontenMarkdown,
      Value<String?> mediaUrlsJson,
      Value<int> versi,
      Value<int> urutan,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MateriUnitsTableFilterComposer
    extends Composer<_$AppDatabase, $MateriUnitsTable> {
  $$MateriUnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topikId => $composableBuilder(
    column: $table.topikId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kontenMarkdown => $composableBuilder(
    column: $table.kontenMarkdown,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaUrlsJson => $composableBuilder(
    column: $table.mediaUrlsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get versi => $composableBuilder(
    column: $table.versi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get urutan => $composableBuilder(
    column: $table.urutan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MateriUnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $MateriUnitsTable> {
  $$MateriUnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topikId => $composableBuilder(
    column: $table.topikId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kontenMarkdown => $composableBuilder(
    column: $table.kontenMarkdown,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaUrlsJson => $composableBuilder(
    column: $table.mediaUrlsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get versi => $composableBuilder(
    column: $table.versi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get urutan => $composableBuilder(
    column: $table.urutan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MateriUnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MateriUnitsTable> {
  $$MateriUnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get topikId =>
      $composableBuilder(column: $table.topikId, builder: (column) => column);

  GeneratedColumn<String> get judul =>
      $composableBuilder(column: $table.judul, builder: (column) => column);

  GeneratedColumn<String> get kontenMarkdown => $composableBuilder(
    column: $table.kontenMarkdown,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mediaUrlsJson => $composableBuilder(
    column: $table.mediaUrlsJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get versi =>
      $composableBuilder(column: $table.versi, builder: (column) => column);

  GeneratedColumn<int> get urutan =>
      $composableBuilder(column: $table.urutan, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MateriUnitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MateriUnitsTable,
          MateriUnit,
          $$MateriUnitsTableFilterComposer,
          $$MateriUnitsTableOrderingComposer,
          $$MateriUnitsTableAnnotationComposer,
          $$MateriUnitsTableCreateCompanionBuilder,
          $$MateriUnitsTableUpdateCompanionBuilder,
          (
            MateriUnit,
            BaseReferences<_$AppDatabase, $MateriUnitsTable, MateriUnit>,
          ),
          MateriUnit,
          PrefetchHooks Function()
        > {
  $$MateriUnitsTableTableManager(_$AppDatabase db, $MateriUnitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MateriUnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MateriUnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MateriUnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> topikId = const Value.absent(),
                Value<String> judul = const Value.absent(),
                Value<String> kontenMarkdown = const Value.absent(),
                Value<String?> mediaUrlsJson = const Value.absent(),
                Value<int> versi = const Value.absent(),
                Value<int> urutan = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MateriUnitsCompanion(
                id: id,
                topikId: topikId,
                judul: judul,
                kontenMarkdown: kontenMarkdown,
                mediaUrlsJson: mediaUrlsJson,
                versi: versi,
                urutan: urutan,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String topikId,
                required String judul,
                required String kontenMarkdown,
                Value<String?> mediaUrlsJson = const Value.absent(),
                Value<int> versi = const Value.absent(),
                Value<int> urutan = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MateriUnitsCompanion.insert(
                id: id,
                topikId: topikId,
                judul: judul,
                kontenMarkdown: kontenMarkdown,
                mediaUrlsJson: mediaUrlsJson,
                versi: versi,
                urutan: urutan,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MateriUnitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MateriUnitsTable,
      MateriUnit,
      $$MateriUnitsTableFilterComposer,
      $$MateriUnitsTableOrderingComposer,
      $$MateriUnitsTableAnnotationComposer,
      $$MateriUnitsTableCreateCompanionBuilder,
      $$MateriUnitsTableUpdateCompanionBuilder,
      (
        MateriUnit,
        BaseReferences<_$AppDatabase, $MateriUnitsTable, MateriUnit>,
      ),
      MateriUnit,
      PrefetchHooks Function()
    >;
typedef $$MateriRelasisTableCreateCompanionBuilder =
    MateriRelasisCompanion Function({
      required String id,
      required String materiUnitId,
      Value<String?> skuItemId,
      Value<String?> skkItemId,
      Value<int> rowid,
    });
typedef $$MateriRelasisTableUpdateCompanionBuilder =
    MateriRelasisCompanion Function({
      Value<String> id,
      Value<String> materiUnitId,
      Value<String?> skuItemId,
      Value<String?> skkItemId,
      Value<int> rowid,
    });

class $$MateriRelasisTableFilterComposer
    extends Composer<_$AppDatabase, $MateriRelasisTable> {
  $$MateriRelasisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get materiUnitId => $composableBuilder(
    column: $table.materiUnitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skuItemId => $composableBuilder(
    column: $table.skuItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skkItemId => $composableBuilder(
    column: $table.skkItemId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MateriRelasisTableOrderingComposer
    extends Composer<_$AppDatabase, $MateriRelasisTable> {
  $$MateriRelasisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get materiUnitId => $composableBuilder(
    column: $table.materiUnitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skuItemId => $composableBuilder(
    column: $table.skuItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skkItemId => $composableBuilder(
    column: $table.skkItemId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MateriRelasisTableAnnotationComposer
    extends Composer<_$AppDatabase, $MateriRelasisTable> {
  $$MateriRelasisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get materiUnitId => $composableBuilder(
    column: $table.materiUnitId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get skuItemId =>
      $composableBuilder(column: $table.skuItemId, builder: (column) => column);

  GeneratedColumn<String> get skkItemId =>
      $composableBuilder(column: $table.skkItemId, builder: (column) => column);
}

class $$MateriRelasisTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MateriRelasisTable,
          MateriRelasi,
          $$MateriRelasisTableFilterComposer,
          $$MateriRelasisTableOrderingComposer,
          $$MateriRelasisTableAnnotationComposer,
          $$MateriRelasisTableCreateCompanionBuilder,
          $$MateriRelasisTableUpdateCompanionBuilder,
          (
            MateriRelasi,
            BaseReferences<_$AppDatabase, $MateriRelasisTable, MateriRelasi>,
          ),
          MateriRelasi,
          PrefetchHooks Function()
        > {
  $$MateriRelasisTableTableManager(_$AppDatabase db, $MateriRelasisTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MateriRelasisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MateriRelasisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MateriRelasisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> materiUnitId = const Value.absent(),
                Value<String?> skuItemId = const Value.absent(),
                Value<String?> skkItemId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MateriRelasisCompanion(
                id: id,
                materiUnitId: materiUnitId,
                skuItemId: skuItemId,
                skkItemId: skkItemId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String materiUnitId,
                Value<String?> skuItemId = const Value.absent(),
                Value<String?> skkItemId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MateriRelasisCompanion.insert(
                id: id,
                materiUnitId: materiUnitId,
                skuItemId: skuItemId,
                skkItemId: skkItemId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MateriRelasisTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MateriRelasisTable,
      MateriRelasi,
      $$MateriRelasisTableFilterComposer,
      $$MateriRelasisTableOrderingComposer,
      $$MateriRelasisTableAnnotationComposer,
      $$MateriRelasisTableCreateCompanionBuilder,
      $$MateriRelasisTableUpdateCompanionBuilder,
      (
        MateriRelasi,
        BaseReferences<_$AppDatabase, $MateriRelasisTable, MateriRelasi>,
      ),
      MateriRelasi,
      PrefetchHooks Function()
    >;
typedef $$MateriProgressBacasTableCreateCompanionBuilder =
    MateriProgressBacasCompanion Function({
      required String id,
      required String anggotaId,
      required String materiUnitId,
      Value<DateTime> dibacaPada,
      Value<int> rowid,
    });
typedef $$MateriProgressBacasTableUpdateCompanionBuilder =
    MateriProgressBacasCompanion Function({
      Value<String> id,
      Value<String> anggotaId,
      Value<String> materiUnitId,
      Value<DateTime> dibacaPada,
      Value<int> rowid,
    });

class $$MateriProgressBacasTableFilterComposer
    extends Composer<_$AppDatabase, $MateriProgressBacasTable> {
  $$MateriProgressBacasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get anggotaId => $composableBuilder(
    column: $table.anggotaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get materiUnitId => $composableBuilder(
    column: $table.materiUnitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dibacaPada => $composableBuilder(
    column: $table.dibacaPada,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MateriProgressBacasTableOrderingComposer
    extends Composer<_$AppDatabase, $MateriProgressBacasTable> {
  $$MateriProgressBacasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get anggotaId => $composableBuilder(
    column: $table.anggotaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get materiUnitId => $composableBuilder(
    column: $table.materiUnitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dibacaPada => $composableBuilder(
    column: $table.dibacaPada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MateriProgressBacasTableAnnotationComposer
    extends Composer<_$AppDatabase, $MateriProgressBacasTable> {
  $$MateriProgressBacasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get anggotaId =>
      $composableBuilder(column: $table.anggotaId, builder: (column) => column);

  GeneratedColumn<String> get materiUnitId => $composableBuilder(
    column: $table.materiUnitId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dibacaPada => $composableBuilder(
    column: $table.dibacaPada,
    builder: (column) => column,
  );
}

class $$MateriProgressBacasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MateriProgressBacasTable,
          MateriProgressBaca,
          $$MateriProgressBacasTableFilterComposer,
          $$MateriProgressBacasTableOrderingComposer,
          $$MateriProgressBacasTableAnnotationComposer,
          $$MateriProgressBacasTableCreateCompanionBuilder,
          $$MateriProgressBacasTableUpdateCompanionBuilder,
          (
            MateriProgressBaca,
            BaseReferences<
              _$AppDatabase,
              $MateriProgressBacasTable,
              MateriProgressBaca
            >,
          ),
          MateriProgressBaca,
          PrefetchHooks Function()
        > {
  $$MateriProgressBacasTableTableManager(
    _$AppDatabase db,
    $MateriProgressBacasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MateriProgressBacasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MateriProgressBacasTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MateriProgressBacasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> anggotaId = const Value.absent(),
                Value<String> materiUnitId = const Value.absent(),
                Value<DateTime> dibacaPada = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MateriProgressBacasCompanion(
                id: id,
                anggotaId: anggotaId,
                materiUnitId: materiUnitId,
                dibacaPada: dibacaPada,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String anggotaId,
                required String materiUnitId,
                Value<DateTime> dibacaPada = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MateriProgressBacasCompanion.insert(
                id: id,
                anggotaId: anggotaId,
                materiUnitId: materiUnitId,
                dibacaPada: dibacaPada,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MateriProgressBacasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MateriProgressBacasTable,
      MateriProgressBaca,
      $$MateriProgressBacasTableFilterComposer,
      $$MateriProgressBacasTableOrderingComposer,
      $$MateriProgressBacasTableAnnotationComposer,
      $$MateriProgressBacasTableCreateCompanionBuilder,
      $$MateriProgressBacasTableUpdateCompanionBuilder,
      (
        MateriProgressBaca,
        BaseReferences<
          _$AppDatabase,
          $MateriProgressBacasTable,
          MateriProgressBaca
        >,
      ),
      MateriProgressBaca,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueItemsTableCreateCompanionBuilder =
    SyncQueueItemsCompanion Function({
      required String id,
      required String deviceId,
      required String penggunaId,
      required String entityType,
      required String entityId,
      required String aksi,
      required String payloadJson,
      Value<DateTime> createdAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });
typedef $$SyncQueueItemsTableUpdateCompanionBuilder =
    SyncQueueItemsCompanion Function({
      Value<String> id,
      Value<String> deviceId,
      Value<String> penggunaId,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> aksi,
      Value<String> payloadJson,
      Value<DateTime> createdAt,
      Value<DateTime?> syncedAt,
      Value<int> rowid,
    });

class $$SyncQueueItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get penggunaId => $composableBuilder(
    column: $table.penggunaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aksi => $composableBuilder(
    column: $table.aksi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get penggunaId => $composableBuilder(
    column: $table.penggunaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aksi => $composableBuilder(
    column: $table.aksi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueItemsTable> {
  $$SyncQueueItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get penggunaId => $composableBuilder(
    column: $table.penggunaId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get aksi =>
      $composableBuilder(column: $table.aksi, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$SyncQueueItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueItemsTable,
          SyncQueueItem,
          $$SyncQueueItemsTableFilterComposer,
          $$SyncQueueItemsTableOrderingComposer,
          $$SyncQueueItemsTableAnnotationComposer,
          $$SyncQueueItemsTableCreateCompanionBuilder,
          $$SyncQueueItemsTableUpdateCompanionBuilder,
          (
            SyncQueueItem,
            BaseReferences<_$AppDatabase, $SyncQueueItemsTable, SyncQueueItem>,
          ),
          SyncQueueItem,
          PrefetchHooks Function()
        > {
  $$SyncQueueItemsTableTableManager(
    _$AppDatabase db,
    $SyncQueueItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String> penggunaId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> aksi = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueItemsCompanion(
                id: id,
                deviceId: deviceId,
                penggunaId: penggunaId,
                entityType: entityType,
                entityId: entityId,
                aksi: aksi,
                payloadJson: payloadJson,
                createdAt: createdAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String deviceId,
                required String penggunaId,
                required String entityType,
                required String entityId,
                required String aksi,
                required String payloadJson,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueItemsCompanion.insert(
                id: id,
                deviceId: deviceId,
                penggunaId: penggunaId,
                entityType: entityType,
                entityId: entityId,
                aksi: aksi,
                payloadJson: payloadJson,
                createdAt: createdAt,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueItemsTable,
      SyncQueueItem,
      $$SyncQueueItemsTableFilterComposer,
      $$SyncQueueItemsTableOrderingComposer,
      $$SyncQueueItemsTableAnnotationComposer,
      $$SyncQueueItemsTableCreateCompanionBuilder,
      $$SyncQueueItemsTableUpdateCompanionBuilder,
      (
        SyncQueueItem,
        BaseReferences<_$AppDatabase, $SyncQueueItemsTable, SyncQueueItem>,
      ),
      SyncQueueItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GudepsTableTableManager get gudeps =>
      $$GudepsTableTableManager(_db, _db.gudeps);
  $$PenggunasTableTableManager get penggunas =>
      $$PenggunasTableTableManager(_db, _db.penggunas);
  $$AnggotasTableTableManager get anggotas =>
      $$AnggotasTableTableManager(_db, _db.anggotas);
  $$PembinaProfilsTableTableManager get pembinaProfils =>
      $$PembinaProfilsTableTableManager(_db, _db.pembinaProfils);
  $$SkuItemsTableTableManager get skuItems =>
      $$SkuItemsTableTableManager(_db, _db.skuItems);
  $$SkuProgressesTableTableManager get skuProgresses =>
      $$SkuProgressesTableTableManager(_db, _db.skuProgresses);
  $$SkuEventsTableTableManager get skuEvents =>
      $$SkuEventsTableTableManager(_db, _db.skuEvents);
  $$SkkBidangsTableTableManager get skkBidangs =>
      $$SkkBidangsTableTableManager(_db, _db.skkBidangs);
  $$SkkItemsTableTableManager get skkItems =>
      $$SkkItemsTableTableManager(_db, _db.skkItems);
  $$SkkProgressesTableTableManager get skkProgresses =>
      $$SkkProgressesTableTableManager(_db, _db.skkProgresses);
  $$SkkEventsTableTableManager get skkEvents =>
      $$SkkEventsTableTableManager(_db, _db.skkEvents);
  $$PelantikansTableTableManager get pelantikans =>
      $$PelantikansTableTableManager(_db, _db.pelantikans);
  $$MateriKategorisTableTableManager get materiKategoris =>
      $$MateriKategorisTableTableManager(_db, _db.materiKategoris);
  $$MateriTopiksTableTableManager get materiTopiks =>
      $$MateriTopiksTableTableManager(_db, _db.materiTopiks);
  $$MateriUnitsTableTableManager get materiUnits =>
      $$MateriUnitsTableTableManager(_db, _db.materiUnits);
  $$MateriRelasisTableTableManager get materiRelasis =>
      $$MateriRelasisTableTableManager(_db, _db.materiRelasis);
  $$MateriProgressBacasTableTableManager get materiProgressBacas =>
      $$MateriProgressBacasTableTableManager(_db, _db.materiProgressBacas);
  $$SyncQueueItemsTableTableManager get syncQueueItems =>
      $$SyncQueueItemsTableTableManager(_db, _db.syncQueueItems);
}
