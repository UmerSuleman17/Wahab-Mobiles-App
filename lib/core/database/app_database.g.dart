// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AdminEntriesTable extends AdminEntries
    with TableInfo<$AdminEntriesTable, AdminEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AdminEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pinHashMeta =
      const VerificationMeta('pinHash');
  @override
  late final GeneratedColumn<String> pinHash = GeneratedColumn<String>(
      'pin_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, pinHash, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'admin_entries';
  @override
  VerificationContext validateIntegrity(Insertable<AdminEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pin_hash')) {
      context.handle(_pinHashMeta,
          pinHash.isAcceptableOrUnknown(data['pin_hash']!, _pinHashMeta));
    } else if (isInserting) {
      context.missing(_pinHashMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AdminEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AdminEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      pinHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pin_hash'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AdminEntriesTable createAlias(String alias) {
    return $AdminEntriesTable(attachedDatabase, alias);
  }
}

class AdminEntry extends DataClass implements Insertable<AdminEntry> {
  final String id;
  final String pinHash;
  final DateTime createdAt;
  const AdminEntry(
      {required this.id, required this.pinHash, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pin_hash'] = Variable<String>(pinHash);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AdminEntriesCompanion toCompanion(bool nullToAbsent) {
    return AdminEntriesCompanion(
      id: Value(id),
      pinHash: Value(pinHash),
      createdAt: Value(createdAt),
    );
  }

  factory AdminEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AdminEntry(
      id: serializer.fromJson<String>(json['id']),
      pinHash: serializer.fromJson<String>(json['pinHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pinHash': serializer.toJson<String>(pinHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AdminEntry copyWith({String? id, String? pinHash, DateTime? createdAt}) =>
      AdminEntry(
        id: id ?? this.id,
        pinHash: pinHash ?? this.pinHash,
        createdAt: createdAt ?? this.createdAt,
      );
  AdminEntry copyWithCompanion(AdminEntriesCompanion data) {
    return AdminEntry(
      id: data.id.present ? data.id.value : this.id,
      pinHash: data.pinHash.present ? data.pinHash.value : this.pinHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AdminEntry(')
          ..write('id: $id, ')
          ..write('pinHash: $pinHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pinHash, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdminEntry &&
          other.id == this.id &&
          other.pinHash == this.pinHash &&
          other.createdAt == this.createdAt);
}

class AdminEntriesCompanion extends UpdateCompanion<AdminEntry> {
  final Value<String> id;
  final Value<String> pinHash;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AdminEntriesCompanion({
    this.id = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AdminEntriesCompanion.insert({
    required String id,
    required String pinHash,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        pinHash = Value(pinHash),
        createdAt = Value(createdAt);
  static Insertable<AdminEntry> custom({
    Expression<String>? id,
    Expression<String>? pinHash,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pinHash != null) 'pin_hash': pinHash,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AdminEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? pinHash,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return AdminEntriesCompanion(
      id: id ?? this.id,
      pinHash: pinHash ?? this.pinHash,
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
    if (pinHash.present) {
      map['pin_hash'] = Variable<String>(pinHash.value);
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
    return (StringBuffer('AdminEntriesCompanion(')
          ..write('id: $id, ')
          ..write('pinHash: $pinHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BusinessEntriesTable extends BusinessEntries
    with TableInfo<$BusinessEntriesTable, BusinessEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BusinessEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _logoPathMeta =
      const VerificationMeta('logoPath');
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
      'logo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('PKR'));
  static const VerificationMeta _openingCashMeta =
      const VerificationMeta('openingCash');
  @override
  late final GeneratedColumn<double> openingCash = GeneratedColumn<double>(
      'opening_cash', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _openingBankMeta =
      const VerificationMeta('openingBank');
  @override
  late final GeneratedColumn<double> openingBank = GeneratedColumn<double>(
      'opening_bank', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isSetupCompleteMeta =
      const VerificationMeta('isSetupComplete');
  @override
  late final GeneratedColumn<bool> isSetupComplete = GeneratedColumn<bool>(
      'is_setup_complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_setup_complete" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        logoPath,
        phone,
        email,
        address,
        currency,
        openingCash,
        openingBank,
        isSetupComplete,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'business_entries';
  @override
  VerificationContext validateIntegrity(Insertable<BusinessEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('logo_path')) {
      context.handle(_logoPathMeta,
          logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('opening_cash')) {
      context.handle(
          _openingCashMeta,
          openingCash.isAcceptableOrUnknown(
              data['opening_cash']!, _openingCashMeta));
    }
    if (data.containsKey('opening_bank')) {
      context.handle(
          _openingBankMeta,
          openingBank.isAcceptableOrUnknown(
              data['opening_bank']!, _openingBankMeta));
    }
    if (data.containsKey('is_setup_complete')) {
      context.handle(
          _isSetupCompleteMeta,
          isSetupComplete.isAcceptableOrUnknown(
              data['is_setup_complete']!, _isSetupCompleteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BusinessEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BusinessEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      logoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo_path']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      openingCash: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}opening_cash'])!,
      openingBank: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}opening_bank'])!,
      isSetupComplete: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_setup_complete'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BusinessEntriesTable createAlias(String alias) {
    return $BusinessEntriesTable(attachedDatabase, alias);
  }
}

class BusinessEntry extends DataClass implements Insertable<BusinessEntry> {
  final String id;
  final String name;
  final String? logoPath;
  final String? phone;
  final String? email;
  final String? address;
  final String currency;
  final double openingCash;
  final double openingBank;
  final bool isSetupComplete;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BusinessEntry(
      {required this.id,
      required this.name,
      this.logoPath,
      this.phone,
      this.email,
      this.address,
      required this.currency,
      required this.openingCash,
      required this.openingBank,
      required this.isSetupComplete,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['currency'] = Variable<String>(currency);
    map['opening_cash'] = Variable<double>(openingCash);
    map['opening_bank'] = Variable<double>(openingBank);
    map['is_setup_complete'] = Variable<bool>(isSetupComplete);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BusinessEntriesCompanion toCompanion(bool nullToAbsent) {
    return BusinessEntriesCompanion(
      id: Value(id),
      name: Value(name),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      currency: Value(currency),
      openingCash: Value(openingCash),
      openingBank: Value(openingBank),
      isSetupComplete: Value(isSetupComplete),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BusinessEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BusinessEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      currency: serializer.fromJson<String>(json['currency']),
      openingCash: serializer.fromJson<double>(json['openingCash']),
      openingBank: serializer.fromJson<double>(json['openingBank']),
      isSetupComplete: serializer.fromJson<bool>(json['isSetupComplete']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'logoPath': serializer.toJson<String?>(logoPath),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'currency': serializer.toJson<String>(currency),
      'openingCash': serializer.toJson<double>(openingCash),
      'openingBank': serializer.toJson<double>(openingBank),
      'isSetupComplete': serializer.toJson<bool>(isSetupComplete),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BusinessEntry copyWith(
          {String? id,
          String? name,
          Value<String?> logoPath = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> address = const Value.absent(),
          String? currency,
          double? openingCash,
          double? openingBank,
          bool? isSetupComplete,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      BusinessEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        logoPath: logoPath.present ? logoPath.value : this.logoPath,
        phone: phone.present ? phone.value : this.phone,
        email: email.present ? email.value : this.email,
        address: address.present ? address.value : this.address,
        currency: currency ?? this.currency,
        openingCash: openingCash ?? this.openingCash,
        openingBank: openingBank ?? this.openingBank,
        isSetupComplete: isSetupComplete ?? this.isSetupComplete,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  BusinessEntry copyWithCompanion(BusinessEntriesCompanion data) {
    return BusinessEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      currency: data.currency.present ? data.currency.value : this.currency,
      openingCash:
          data.openingCash.present ? data.openingCash.value : this.openingCash,
      openingBank:
          data.openingBank.present ? data.openingBank.value : this.openingBank,
      isSetupComplete: data.isSetupComplete.present
          ? data.isSetupComplete.value
          : this.isSetupComplete,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BusinessEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('logoPath: $logoPath, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('currency: $currency, ')
          ..write('openingCash: $openingCash, ')
          ..write('openingBank: $openingBank, ')
          ..write('isSetupComplete: $isSetupComplete, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      logoPath,
      phone,
      email,
      address,
      currency,
      openingCash,
      openingBank,
      isSetupComplete,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BusinessEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.logoPath == this.logoPath &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.currency == this.currency &&
          other.openingCash == this.openingCash &&
          other.openingBank == this.openingBank &&
          other.isSetupComplete == this.isSetupComplete &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BusinessEntriesCompanion extends UpdateCompanion<BusinessEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> logoPath;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String> currency;
  final Value<double> openingCash;
  final Value<double> openingBank;
  final Value<bool> isSetupComplete;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BusinessEntriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.currency = const Value.absent(),
    this.openingCash = const Value.absent(),
    this.openingBank = const Value.absent(),
    this.isSetupComplete = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BusinessEntriesCompanion.insert({
    required String id,
    required String name,
    this.logoPath = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.currency = const Value.absent(),
    this.openingCash = const Value.absent(),
    this.openingBank = const Value.absent(),
    this.isSetupComplete = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<BusinessEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? logoPath,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? currency,
    Expression<double>? openingCash,
    Expression<double>? openingBank,
    Expression<bool>? isSetupComplete,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (logoPath != null) 'logo_path': logoPath,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (currency != null) 'currency': currency,
      if (openingCash != null) 'opening_cash': openingCash,
      if (openingBank != null) 'opening_bank': openingBank,
      if (isSetupComplete != null) 'is_setup_complete': isSetupComplete,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BusinessEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? logoPath,
      Value<String?>? phone,
      Value<String?>? email,
      Value<String?>? address,
      Value<String>? currency,
      Value<double>? openingCash,
      Value<double>? openingBank,
      Value<bool>? isSetupComplete,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return BusinessEntriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      logoPath: logoPath ?? this.logoPath,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      currency: currency ?? this.currency,
      openingCash: openingCash ?? this.openingCash,
      openingBank: openingBank ?? this.openingBank,
      isSetupComplete: isSetupComplete ?? this.isSetupComplete,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (openingCash.present) {
      map['opening_cash'] = Variable<double>(openingCash.value);
    }
    if (openingBank.present) {
      map['opening_bank'] = Variable<double>(openingBank.value);
    }
    if (isSetupComplete.present) {
      map['is_setup_complete'] = Variable<bool>(isSetupComplete.value);
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
    return (StringBuffer('BusinessEntriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('logoPath: $logoPath, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('currency: $currency, ')
          ..write('openingCash: $openingCash, ')
          ..write('openingBank: $openingBank, ')
          ..write('isSetupComplete: $isSetupComplete, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  const AppSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory AppSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSetting copyWith({String? key, String? value}) => AppSetting(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String name;
  const Category({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Category copyWith({String? id, String? name}) => Category(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category && other.id == this.id && other.name == this.name);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, phone, email, address, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(Insertable<Supplier> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final String? address;
  final String? notes;
  final DateTime createdAt;
  const Supplier(
      {required this.id,
      required this.name,
      this.phone,
      this.email,
      this.address,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      name: Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Supplier.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Supplier copyWith(
          {String? id,
          String? name,
          Value<String?> phone = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      Supplier(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone.present ? phone.value : this.phone,
        email: email.present ? email.value : this.email,
        address: address.present ? address.value : this.address,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  Supplier copyWithCompanion(SuppliersCompanion data) {
    return Supplier(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, phone, email, address, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SuppliersCompanion.insert({
    required String id,
    required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt);
  static Insertable<Supplier> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SuppliersCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? phone,
      Value<String?>? email,
      Value<String?>? address,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SuppliersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      notes: notes ?? this.notes,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _barcodeMeta =
      const VerificationMeta('barcode');
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
      'barcode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'));
  static const VerificationMeta _purchasePriceMeta =
      const VerificationMeta('purchasePrice');
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
      'purchase_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _sellingPriceMeta =
      const VerificationMeta('sellingPrice');
  @override
  late final GeneratedColumn<double> sellingPrice = GeneratedColumn<double>(
      'selling_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _minStockMeta =
      const VerificationMeta('minStock');
  @override
  late final GeneratedColumn<int> minStock = GeneratedColumn<int>(
      'min_stock', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5));
  static const VerificationMeta _supplierIdMeta =
      const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
      'supplier_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES suppliers (id)'));
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        sku,
        barcode,
        categoryId,
        purchasePrice,
        sellingPrice,
        quantity,
        minStock,
        supplierId,
        imagePath,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
          _purchasePriceMeta,
          purchasePrice.isAcceptableOrUnknown(
              data['purchase_price']!, _purchasePriceMeta));
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('selling_price')) {
      context.handle(
          _sellingPriceMeta,
          sellingPrice.isAcceptableOrUnknown(
              data['selling_price']!, _sellingPriceMeta));
    } else if (isInserting) {
      context.missing(_sellingPriceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('min_stock')) {
      context.handle(_minStockMeta,
          minStock.isAcceptableOrUnknown(data['min_stock']!, _minStockMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      barcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id']),
      purchasePrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}purchase_price'])!,
      sellingPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}selling_price'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      minStock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_stock'])!,
      supplierId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_id']),
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final String name;
  final String? sku;
  final String? barcode;
  final String? categoryId;
  final double purchasePrice;
  final double sellingPrice;
  final double quantity;
  final int minStock;
  final String? supplierId;
  final String? imagePath;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Product(
      {required this.id,
      required this.name,
      this.sku,
      this.barcode,
      this.categoryId,
      required this.purchasePrice,
      required this.sellingPrice,
      required this.quantity,
      required this.minStock,
      this.supplierId,
      this.imagePath,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['selling_price'] = Variable<double>(sellingPrice);
    map['quantity'] = Variable<double>(quantity);
    map['min_stock'] = Variable<int>(minStock);
    if (!nullToAbsent || supplierId != null) {
      map['supplier_id'] = Variable<String>(supplierId);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      purchasePrice: Value(purchasePrice),
      sellingPrice: Value(sellingPrice),
      quantity: Value(quantity),
      minStock: Value(minStock),
      supplierId: supplierId == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierId),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sku: serializer.fromJson<String?>(json['sku']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      sellingPrice: serializer.fromJson<double>(json['sellingPrice']),
      quantity: serializer.fromJson<double>(json['quantity']),
      minStock: serializer.fromJson<int>(json['minStock']),
      supplierId: serializer.fromJson<String?>(json['supplierId']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'sku': serializer.toJson<String?>(sku),
      'barcode': serializer.toJson<String?>(barcode),
      'categoryId': serializer.toJson<String?>(categoryId),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'sellingPrice': serializer.toJson<double>(sellingPrice),
      'quantity': serializer.toJson<double>(quantity),
      'minStock': serializer.toJson<int>(minStock),
      'supplierId': serializer.toJson<String?>(supplierId),
      'imagePath': serializer.toJson<String?>(imagePath),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Product copyWith(
          {String? id,
          String? name,
          Value<String?> sku = const Value.absent(),
          Value<String?> barcode = const Value.absent(),
          Value<String?> categoryId = const Value.absent(),
          double? purchasePrice,
          double? sellingPrice,
          double? quantity,
          int? minStock,
          Value<String?> supplierId = const Value.absent(),
          Value<String?> imagePath = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        sku: sku.present ? sku.value : this.sku,
        barcode: barcode.present ? barcode.value : this.barcode,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        purchasePrice: purchasePrice ?? this.purchasePrice,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        quantity: quantity ?? this.quantity,
        minStock: minStock ?? this.minStock,
        supplierId: supplierId.present ? supplierId.value : this.supplierId,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sku: data.sku.present ? data.sku.value : this.sku,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      minStock: data.minStock.present ? data.minStock.value : this.minStock,
      supplierId:
          data.supplierId.present ? data.supplierId.value : this.supplierId,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('categoryId: $categoryId, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('quantity: $quantity, ')
          ..write('minStock: $minStock, ')
          ..write('supplierId: $supplierId, ')
          ..write('imagePath: $imagePath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      sku,
      barcode,
      categoryId,
      purchasePrice,
      sellingPrice,
      quantity,
      minStock,
      supplierId,
      imagePath,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.sku == this.sku &&
          other.barcode == this.barcode &&
          other.categoryId == this.categoryId &&
          other.purchasePrice == this.purchasePrice &&
          other.sellingPrice == this.sellingPrice &&
          other.quantity == this.quantity &&
          other.minStock == this.minStock &&
          other.supplierId == this.supplierId &&
          other.imagePath == this.imagePath &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> sku;
  final Value<String?> barcode;
  final Value<String?> categoryId;
  final Value<double> purchasePrice;
  final Value<double> sellingPrice;
  final Value<double> quantity;
  final Value<int> minStock;
  final Value<String?> supplierId;
  final Value<String?> imagePath;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.minStock = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    required String name,
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    this.categoryId = const Value.absent(),
    required double purchasePrice,
    required double sellingPrice,
    this.quantity = const Value.absent(),
    this.minStock = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        purchasePrice = Value(purchasePrice),
        sellingPrice = Value(sellingPrice),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? sku,
    Expression<String>? barcode,
    Expression<String>? categoryId,
    Expression<double>? purchasePrice,
    Expression<double>? sellingPrice,
    Expression<double>? quantity,
    Expression<int>? minStock,
    Expression<String>? supplierId,
    Expression<String>? imagePath,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sku != null) 'sku': sku,
      if (barcode != null) 'barcode': barcode,
      if (categoryId != null) 'category_id': categoryId,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (quantity != null) 'quantity': quantity,
      if (minStock != null) 'min_stock': minStock,
      if (supplierId != null) 'supplier_id': supplierId,
      if (imagePath != null) 'image_path': imagePath,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? sku,
      Value<String?>? barcode,
      Value<String?>? categoryId,
      Value<double>? purchasePrice,
      Value<double>? sellingPrice,
      Value<double>? quantity,
      Value<int>? minStock,
      Value<String?>? supplierId,
      Value<String?>? imagePath,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      categoryId: categoryId ?? this.categoryId,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      quantity: quantity ?? this.quantity,
      minStock: minStock ?? this.minStock,
      supplierId: supplierId ?? this.supplierId,
      imagePath: imagePath ?? this.imagePath,
      notes: notes ?? this.notes,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<double>(sellingPrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (minStock.present) {
      map['min_stock'] = Variable<int>(minStock.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('categoryId: $categoryId, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('quantity: $quantity, ')
          ..write('minStock: $minStock, ')
          ..write('supplierId: $supplierId, ')
          ..write('imagePath: $imagePath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, phone, address, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final String id;
  final String name;
  final String? phone;
  final String? address;
  final String? notes;
  final DateTime createdAt;
  const Customer(
      {required this.id,
      required this.name,
      this.phone,
      this.address,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Customer copyWith(
          {String? id,
          String? name,
          Value<String?> phone = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone.present ? phone.value : this.phone,
        address: address.present ? address.value : this.address,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone, address, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersCompanion.insert({
    required String id,
    required String name,
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt);
  static Insertable<Customer> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? phone,
      Value<String?>? address,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      notes: notes ?? this.notes,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _receiptIdMeta =
      const VerificationMeta('receiptId');
  @override
  late final GeneratedColumn<String> receiptId = GeneratedColumn<String>(
      'receipt_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _discountMeta =
      const VerificationMeta('discount');
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
      'discount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _amountReceivedMeta =
      const VerificationMeta('amountReceived');
  @override
  late final GeneratedColumn<double> amountReceived = GeneratedColumn<double>(
      'amount_received', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<int> paymentMethod = GeneratedColumn<int>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _paymentStatusMeta =
      const VerificationMeta('paymentStatus');
  @override
  late final GeneratedColumn<int> paymentStatus = GeneratedColumn<int>(
      'payment_status', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _saleTypeMeta =
      const VerificationMeta('saleType');
  @override
  late final GeneratedColumn<int> saleType = GeneratedColumn<int>(
      'sale_type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isVoidedMeta =
      const VerificationMeta('isVoided');
  @override
  late final GeneratedColumn<bool> isVoided = GeneratedColumn<bool>(
      'is_voided', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_voided" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        receiptId,
        customerId,
        total,
        discount,
        amountReceived,
        paymentMethod,
        paymentStatus,
        saleType,
        dueDate,
        notes,
        isVoided,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(Insertable<Sale> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('receipt_id')) {
      context.handle(_receiptIdMeta,
          receiptId.isAcceptableOrUnknown(data['receipt_id']!, _receiptIdMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(_discountMeta,
          discount.isAcceptableOrUnknown(data['discount']!, _discountMeta));
    }
    if (data.containsKey('amount_received')) {
      context.handle(
          _amountReceivedMeta,
          amountReceived.isAcceptableOrUnknown(
              data['amount_received']!, _amountReceivedMeta));
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('payment_status')) {
      context.handle(
          _paymentStatusMeta,
          paymentStatus.isAcceptableOrUnknown(
              data['payment_status']!, _paymentStatusMeta));
    } else if (isInserting) {
      context.missing(_paymentStatusMeta);
    }
    if (data.containsKey('sale_type')) {
      context.handle(_saleTypeMeta,
          saleType.isAcceptableOrUnknown(data['sale_type']!, _saleTypeMeta));
    } else if (isInserting) {
      context.missing(_saleTypeMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_voided')) {
      context.handle(_isVoidedMeta,
          isVoided.isAcceptableOrUnknown(data['is_voided']!, _isVoidedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      receiptId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}receipt_id']),
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id']),
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      discount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}discount'])!,
      amountReceived: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}amount_received'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_method'])!,
      paymentStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_status'])!,
      saleType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sale_type'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      isVoided: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_voided'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class Sale extends DataClass implements Insertable<Sale> {
  final String id;
  final String? receiptId;
  final String? customerId;
  final double total;
  final double discount;
  final double amountReceived;

  /// Maps to PaymentMethod enum. Conversion handled in DAO/repository layer.
  final int paymentMethod;

  /// Maps to PaymentStatus enum. Conversion handled in DAO/repository layer.
  final int paymentStatus;

  /// Maps to SaleType enum. Conversion handled in DAO/repository layer.
  final int saleType;
  final DateTime? dueDate;
  final String? notes;
  final bool isVoided;
  final DateTime createdAt;
  const Sale(
      {required this.id,
      this.receiptId,
      this.customerId,
      required this.total,
      required this.discount,
      required this.amountReceived,
      required this.paymentMethod,
      required this.paymentStatus,
      required this.saleType,
      this.dueDate,
      this.notes,
      required this.isVoided,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || receiptId != null) {
      map['receipt_id'] = Variable<String>(receiptId);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    map['total'] = Variable<double>(total);
    map['discount'] = Variable<double>(discount);
    map['amount_received'] = Variable<double>(amountReceived);
    map['payment_method'] = Variable<int>(paymentMethod);
    map['payment_status'] = Variable<int>(paymentStatus);
    map['sale_type'] = Variable<int>(saleType);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_voided'] = Variable<bool>(isVoided);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      receiptId: receiptId == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptId),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      total: Value(total),
      discount: Value(discount),
      amountReceived: Value(amountReceived),
      paymentMethod: Value(paymentMethod),
      paymentStatus: Value(paymentStatus),
      saleType: Value(saleType),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      isVoided: Value(isVoided),
      createdAt: Value(createdAt),
    );
  }

  factory Sale.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<String>(json['id']),
      receiptId: serializer.fromJson<String?>(json['receiptId']),
      customerId: serializer.fromJson<String?>(json['customerId']),
      total: serializer.fromJson<double>(json['total']),
      discount: serializer.fromJson<double>(json['discount']),
      amountReceived: serializer.fromJson<double>(json['amountReceived']),
      paymentMethod: serializer.fromJson<int>(json['paymentMethod']),
      paymentStatus: serializer.fromJson<int>(json['paymentStatus']),
      saleType: serializer.fromJson<int>(json['saleType']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      isVoided: serializer.fromJson<bool>(json['isVoided']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'receiptId': serializer.toJson<String?>(receiptId),
      'customerId': serializer.toJson<String?>(customerId),
      'total': serializer.toJson<double>(total),
      'discount': serializer.toJson<double>(discount),
      'amountReceived': serializer.toJson<double>(amountReceived),
      'paymentMethod': serializer.toJson<int>(paymentMethod),
      'paymentStatus': serializer.toJson<int>(paymentStatus),
      'saleType': serializer.toJson<int>(saleType),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'notes': serializer.toJson<String?>(notes),
      'isVoided': serializer.toJson<bool>(isVoided),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Sale copyWith(
          {String? id,
          Value<String?> receiptId = const Value.absent(),
          Value<String?> customerId = const Value.absent(),
          double? total,
          double? discount,
          double? amountReceived,
          int? paymentMethod,
          int? paymentStatus,
          int? saleType,
          Value<DateTime?> dueDate = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          bool? isVoided,
          DateTime? createdAt}) =>
      Sale(
        id: id ?? this.id,
        receiptId: receiptId.present ? receiptId.value : this.receiptId,
        customerId: customerId.present ? customerId.value : this.customerId,
        total: total ?? this.total,
        discount: discount ?? this.discount,
        amountReceived: amountReceived ?? this.amountReceived,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        saleType: saleType ?? this.saleType,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        notes: notes.present ? notes.value : this.notes,
        isVoided: isVoided ?? this.isVoided,
        createdAt: createdAt ?? this.createdAt,
      );
  Sale copyWithCompanion(SalesCompanion data) {
    return Sale(
      id: data.id.present ? data.id.value : this.id,
      receiptId: data.receiptId.present ? data.receiptId.value : this.receiptId,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      total: data.total.present ? data.total.value : this.total,
      discount: data.discount.present ? data.discount.value : this.discount,
      amountReceived: data.amountReceived.present
          ? data.amountReceived.value
          : this.amountReceived,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      paymentStatus: data.paymentStatus.present
          ? data.paymentStatus.value
          : this.paymentStatus,
      saleType: data.saleType.present ? data.saleType.value : this.saleType,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      isVoided: data.isVoided.present ? data.isVoided.value : this.isVoided,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('receiptId: $receiptId, ')
          ..write('customerId: $customerId, ')
          ..write('total: $total, ')
          ..write('discount: $discount, ')
          ..write('amountReceived: $amountReceived, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('saleType: $saleType, ')
          ..write('dueDate: $dueDate, ')
          ..write('notes: $notes, ')
          ..write('isVoided: $isVoided, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      receiptId,
      customerId,
      total,
      discount,
      amountReceived,
      paymentMethod,
      paymentStatus,
      saleType,
      dueDate,
      notes,
      isVoided,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.receiptId == this.receiptId &&
          other.customerId == this.customerId &&
          other.total == this.total &&
          other.discount == this.discount &&
          other.amountReceived == this.amountReceived &&
          other.paymentMethod == this.paymentMethod &&
          other.paymentStatus == this.paymentStatus &&
          other.saleType == this.saleType &&
          other.dueDate == this.dueDate &&
          other.notes == this.notes &&
          other.isVoided == this.isVoided &&
          other.createdAt == this.createdAt);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<String> id;
  final Value<String?> receiptId;
  final Value<String?> customerId;
  final Value<double> total;
  final Value<double> discount;
  final Value<double> amountReceived;
  final Value<int> paymentMethod;
  final Value<int> paymentStatus;
  final Value<int> saleType;
  final Value<DateTime?> dueDate;
  final Value<String?> notes;
  final Value<bool> isVoided;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.receiptId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.total = const Value.absent(),
    this.discount = const Value.absent(),
    this.amountReceived = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.saleType = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.isVoided = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesCompanion.insert({
    required String id,
    this.receiptId = const Value.absent(),
    this.customerId = const Value.absent(),
    required double total,
    this.discount = const Value.absent(),
    this.amountReceived = const Value.absent(),
    required int paymentMethod,
    required int paymentStatus,
    required int saleType,
    this.dueDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.isVoided = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        total = Value(total),
        paymentMethod = Value(paymentMethod),
        paymentStatus = Value(paymentStatus),
        saleType = Value(saleType),
        createdAt = Value(createdAt);
  static Insertable<Sale> custom({
    Expression<String>? id,
    Expression<String>? receiptId,
    Expression<String>? customerId,
    Expression<double>? total,
    Expression<double>? discount,
    Expression<double>? amountReceived,
    Expression<int>? paymentMethod,
    Expression<int>? paymentStatus,
    Expression<int>? saleType,
    Expression<DateTime>? dueDate,
    Expression<String>? notes,
    Expression<bool>? isVoided,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (receiptId != null) 'receipt_id': receiptId,
      if (customerId != null) 'customer_id': customerId,
      if (total != null) 'total': total,
      if (discount != null) 'discount': discount,
      if (amountReceived != null) 'amount_received': amountReceived,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (saleType != null) 'sale_type': saleType,
      if (dueDate != null) 'due_date': dueDate,
      if (notes != null) 'notes': notes,
      if (isVoided != null) 'is_voided': isVoided,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesCompanion copyWith(
      {Value<String>? id,
      Value<String?>? receiptId,
      Value<String?>? customerId,
      Value<double>? total,
      Value<double>? discount,
      Value<double>? amountReceived,
      Value<int>? paymentMethod,
      Value<int>? paymentStatus,
      Value<int>? saleType,
      Value<DateTime?>? dueDate,
      Value<String?>? notes,
      Value<bool>? isVoided,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SalesCompanion(
      id: id ?? this.id,
      receiptId: receiptId ?? this.receiptId,
      customerId: customerId ?? this.customerId,
      total: total ?? this.total,
      discount: discount ?? this.discount,
      amountReceived: amountReceived ?? this.amountReceived,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      saleType: saleType ?? this.saleType,
      dueDate: dueDate ?? this.dueDate,
      notes: notes ?? this.notes,
      isVoided: isVoided ?? this.isVoided,
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
    if (receiptId.present) {
      map['receipt_id'] = Variable<String>(receiptId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (amountReceived.present) {
      map['amount_received'] = Variable<double>(amountReceived.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<int>(paymentMethod.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<int>(paymentStatus.value);
    }
    if (saleType.present) {
      map['sale_type'] = Variable<int>(saleType.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isVoided.present) {
      map['is_voided'] = Variable<bool>(isVoided.value);
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
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('receiptId: $receiptId, ')
          ..write('customerId: $customerId, ')
          ..write('total: $total, ')
          ..write('discount: $discount, ')
          ..write('amountReceived: $amountReceived, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('saleType: $saleType, ')
          ..write('dueDate: $dueDate, ')
          ..write('notes: $notes, ')
          ..write('isVoided: $isVoided, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SaleItemsTable extends SaleItems
    with TableInfo<$SaleItemsTable, SaleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
      'sale_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sales (id)'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _unitPriceMeta =
      const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, saleId, productId, quantity, unitPrice, total];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_items';
  @override
  VerificationContext validateIntegrity(Insertable<SaleItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sale_id')) {
      context.handle(_saleIdMeta,
          saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta));
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      saleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sale_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      unitPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
    );
  }

  @override
  $SaleItemsTable createAlias(String alias) {
    return $SaleItemsTable(attachedDatabase, alias);
  }
}

class SaleItem extends DataClass implements Insertable<SaleItem> {
  final String id;
  final String saleId;
  final String productId;
  final double quantity;
  final double unitPrice;
  final double total;
  const SaleItem(
      {required this.id,
      required this.saleId,
      required this.productId,
      required this.quantity,
      required this.unitPrice,
      required this.total});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sale_id'] = Variable<String>(saleId);
    map['product_id'] = Variable<String>(productId);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['total'] = Variable<double>(total);
    return map;
  }

  SaleItemsCompanion toCompanion(bool nullToAbsent) {
    return SaleItemsCompanion(
      id: Value(id),
      saleId: Value(saleId),
      productId: Value(productId),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      total: Value(total),
    );
  }

  factory SaleItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleItem(
      id: serializer.fromJson<String>(json['id']),
      saleId: serializer.fromJson<String>(json['saleId']),
      productId: serializer.fromJson<String>(json['productId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      total: serializer.fromJson<double>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'saleId': serializer.toJson<String>(saleId),
      'productId': serializer.toJson<String>(productId),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'total': serializer.toJson<double>(total),
    };
  }

  SaleItem copyWith(
          {String? id,
          String? saleId,
          String? productId,
          double? quantity,
          double? unitPrice,
          double? total}) =>
      SaleItem(
        id: id ?? this.id,
        saleId: saleId ?? this.saleId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
        total: total ?? this.total,
      );
  SaleItem copyWithCompanion(SaleItemsCompanion data) {
    return SaleItem(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleItem(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, saleId, productId, quantity, unitPrice, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleItem &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.total == this.total);
}

class SaleItemsCompanion extends UpdateCompanion<SaleItem> {
  final Value<String> id;
  final Value<String> saleId;
  final Value<String> productId;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<double> total;
  final Value<int> rowid;
  const SaleItemsCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SaleItemsCompanion.insert({
    required String id,
    required String saleId,
    required String productId,
    required double quantity,
    required double unitPrice,
    required double total,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        saleId = Value(saleId),
        productId = Value(productId),
        quantity = Value(quantity),
        unitPrice = Value(unitPrice),
        total = Value(total);
  static Insertable<SaleItem> custom({
    Expression<String>? id,
    Expression<String>? saleId,
    Expression<String>? productId,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? total,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (total != null) 'total': total,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SaleItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? saleId,
      Value<String>? productId,
      Value<double>? quantity,
      Value<double>? unitPrice,
      Value<double>? total,
      Value<int>? rowid}) {
    return SaleItemsCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleItemsCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchasesTable extends Purchases
    with TableInfo<$PurchasesTable, Purchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _supplierIdMeta =
      const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
      'supplier_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES suppliers (id)'));
  static const VerificationMeta _receiptIdMeta =
      const VerificationMeta('receiptId');
  @override
  late final GeneratedColumn<String> receiptId = GeneratedColumn<String>(
      'receipt_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _discountMeta =
      const VerificationMeta('discount');
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
      'discount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _amountPaidMeta =
      const VerificationMeta('amountPaid');
  @override
  late final GeneratedColumn<double> amountPaid = GeneratedColumn<double>(
      'amount_paid', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<int> paymentMethod = GeneratedColumn<int>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _paymentStatusMeta =
      const VerificationMeta('paymentStatus');
  @override
  late final GeneratedColumn<int> paymentStatus = GeneratedColumn<int>(
      'payment_status', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isVoidedMeta =
      const VerificationMeta('isVoided');
  @override
  late final GeneratedColumn<bool> isVoided = GeneratedColumn<bool>(
      'is_voided', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_voided" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        supplierId,
        receiptId,
        total,
        discount,
        amountPaid,
        paymentMethod,
        paymentStatus,
        notes,
        isVoided,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchases';
  @override
  VerificationContext validateIntegrity(Insertable<Purchase> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('receipt_id')) {
      context.handle(_receiptIdMeta,
          receiptId.isAcceptableOrUnknown(data['receipt_id']!, _receiptIdMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(_discountMeta,
          discount.isAcceptableOrUnknown(data['discount']!, _discountMeta));
    }
    if (data.containsKey('amount_paid')) {
      context.handle(
          _amountPaidMeta,
          amountPaid.isAcceptableOrUnknown(
              data['amount_paid']!, _amountPaidMeta));
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('payment_status')) {
      context.handle(
          _paymentStatusMeta,
          paymentStatus.isAcceptableOrUnknown(
              data['payment_status']!, _paymentStatusMeta));
    } else if (isInserting) {
      context.missing(_paymentStatusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_voided')) {
      context.handle(_isVoidedMeta,
          isVoided.isAcceptableOrUnknown(data['is_voided']!, _isVoidedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Purchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Purchase(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      supplierId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_id'])!,
      receiptId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}receipt_id']),
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      discount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}discount'])!,
      amountPaid: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount_paid'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_method'])!,
      paymentStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_status'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      isVoided: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_voided'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PurchasesTable createAlias(String alias) {
    return $PurchasesTable(attachedDatabase, alias);
  }
}

class Purchase extends DataClass implements Insertable<Purchase> {
  final String id;
  final String supplierId;
  final String? receiptId;
  final double total;
  final double discount;

  /// Amount paid to the supplier at the time of purchase.
  /// Supplier payable for this purchase = total − amountPaid.
  final double amountPaid;

  /// Maps to PaymentMethod enum. Conversion handled in DAO/repository layer.
  final int paymentMethod;

  /// Maps to PaymentStatus enum. Conversion handled in DAO/repository layer.
  final int paymentStatus;
  final String? notes;
  final bool isVoided;
  final DateTime createdAt;
  const Purchase(
      {required this.id,
      required this.supplierId,
      this.receiptId,
      required this.total,
      required this.discount,
      required this.amountPaid,
      required this.paymentMethod,
      required this.paymentStatus,
      this.notes,
      required this.isVoided,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['supplier_id'] = Variable<String>(supplierId);
    if (!nullToAbsent || receiptId != null) {
      map['receipt_id'] = Variable<String>(receiptId);
    }
    map['total'] = Variable<double>(total);
    map['discount'] = Variable<double>(discount);
    map['amount_paid'] = Variable<double>(amountPaid);
    map['payment_method'] = Variable<int>(paymentMethod);
    map['payment_status'] = Variable<int>(paymentStatus);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_voided'] = Variable<bool>(isVoided);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PurchasesCompanion toCompanion(bool nullToAbsent) {
    return PurchasesCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      receiptId: receiptId == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptId),
      total: Value(total),
      discount: Value(discount),
      amountPaid: Value(amountPaid),
      paymentMethod: Value(paymentMethod),
      paymentStatus: Value(paymentStatus),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      isVoided: Value(isVoided),
      createdAt: Value(createdAt),
    );
  }

  factory Purchase.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Purchase(
      id: serializer.fromJson<String>(json['id']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      receiptId: serializer.fromJson<String?>(json['receiptId']),
      total: serializer.fromJson<double>(json['total']),
      discount: serializer.fromJson<double>(json['discount']),
      amountPaid: serializer.fromJson<double>(json['amountPaid']),
      paymentMethod: serializer.fromJson<int>(json['paymentMethod']),
      paymentStatus: serializer.fromJson<int>(json['paymentStatus']),
      notes: serializer.fromJson<String?>(json['notes']),
      isVoided: serializer.fromJson<bool>(json['isVoided']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'supplierId': serializer.toJson<String>(supplierId),
      'receiptId': serializer.toJson<String?>(receiptId),
      'total': serializer.toJson<double>(total),
      'discount': serializer.toJson<double>(discount),
      'amountPaid': serializer.toJson<double>(amountPaid),
      'paymentMethod': serializer.toJson<int>(paymentMethod),
      'paymentStatus': serializer.toJson<int>(paymentStatus),
      'notes': serializer.toJson<String?>(notes),
      'isVoided': serializer.toJson<bool>(isVoided),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Purchase copyWith(
          {String? id,
          String? supplierId,
          Value<String?> receiptId = const Value.absent(),
          double? total,
          double? discount,
          double? amountPaid,
          int? paymentMethod,
          int? paymentStatus,
          Value<String?> notes = const Value.absent(),
          bool? isVoided,
          DateTime? createdAt}) =>
      Purchase(
        id: id ?? this.id,
        supplierId: supplierId ?? this.supplierId,
        receiptId: receiptId.present ? receiptId.value : this.receiptId,
        total: total ?? this.total,
        discount: discount ?? this.discount,
        amountPaid: amountPaid ?? this.amountPaid,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        notes: notes.present ? notes.value : this.notes,
        isVoided: isVoided ?? this.isVoided,
        createdAt: createdAt ?? this.createdAt,
      );
  Purchase copyWithCompanion(PurchasesCompanion data) {
    return Purchase(
      id: data.id.present ? data.id.value : this.id,
      supplierId:
          data.supplierId.present ? data.supplierId.value : this.supplierId,
      receiptId: data.receiptId.present ? data.receiptId.value : this.receiptId,
      total: data.total.present ? data.total.value : this.total,
      discount: data.discount.present ? data.discount.value : this.discount,
      amountPaid:
          data.amountPaid.present ? data.amountPaid.value : this.amountPaid,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      paymentStatus: data.paymentStatus.present
          ? data.paymentStatus.value
          : this.paymentStatus,
      notes: data.notes.present ? data.notes.value : this.notes,
      isVoided: data.isVoided.present ? data.isVoided.value : this.isVoided,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Purchase(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('receiptId: $receiptId, ')
          ..write('total: $total, ')
          ..write('discount: $discount, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('notes: $notes, ')
          ..write('isVoided: $isVoided, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, supplierId, receiptId, total, discount,
      amountPaid, paymentMethod, paymentStatus, notes, isVoided, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Purchase &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.receiptId == this.receiptId &&
          other.total == this.total &&
          other.discount == this.discount &&
          other.amountPaid == this.amountPaid &&
          other.paymentMethod == this.paymentMethod &&
          other.paymentStatus == this.paymentStatus &&
          other.notes == this.notes &&
          other.isVoided == this.isVoided &&
          other.createdAt == this.createdAt);
}

class PurchasesCompanion extends UpdateCompanion<Purchase> {
  final Value<String> id;
  final Value<String> supplierId;
  final Value<String?> receiptId;
  final Value<double> total;
  final Value<double> discount;
  final Value<double> amountPaid;
  final Value<int> paymentMethod;
  final Value<int> paymentStatus;
  final Value<String?> notes;
  final Value<bool> isVoided;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PurchasesCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.receiptId = const Value.absent(),
    this.total = const Value.absent(),
    this.discount = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.isVoided = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchasesCompanion.insert({
    required String id,
    required String supplierId,
    this.receiptId = const Value.absent(),
    required double total,
    this.discount = const Value.absent(),
    this.amountPaid = const Value.absent(),
    required int paymentMethod,
    required int paymentStatus,
    this.notes = const Value.absent(),
    this.isVoided = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        supplierId = Value(supplierId),
        total = Value(total),
        paymentMethod = Value(paymentMethod),
        paymentStatus = Value(paymentStatus),
        createdAt = Value(createdAt);
  static Insertable<Purchase> custom({
    Expression<String>? id,
    Expression<String>? supplierId,
    Expression<String>? receiptId,
    Expression<double>? total,
    Expression<double>? discount,
    Expression<double>? amountPaid,
    Expression<int>? paymentMethod,
    Expression<int>? paymentStatus,
    Expression<String>? notes,
    Expression<bool>? isVoided,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (receiptId != null) 'receipt_id': receiptId,
      if (total != null) 'total': total,
      if (discount != null) 'discount': discount,
      if (amountPaid != null) 'amount_paid': amountPaid,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (notes != null) 'notes': notes,
      if (isVoided != null) 'is_voided': isVoided,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchasesCompanion copyWith(
      {Value<String>? id,
      Value<String>? supplierId,
      Value<String?>? receiptId,
      Value<double>? total,
      Value<double>? discount,
      Value<double>? amountPaid,
      Value<int>? paymentMethod,
      Value<int>? paymentStatus,
      Value<String?>? notes,
      Value<bool>? isVoided,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return PurchasesCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      receiptId: receiptId ?? this.receiptId,
      total: total ?? this.total,
      discount: discount ?? this.discount,
      amountPaid: amountPaid ?? this.amountPaid,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      notes: notes ?? this.notes,
      isVoided: isVoided ?? this.isVoided,
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
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (receiptId.present) {
      map['receipt_id'] = Variable<String>(receiptId.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (amountPaid.present) {
      map['amount_paid'] = Variable<double>(amountPaid.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<int>(paymentMethod.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<int>(paymentStatus.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isVoided.present) {
      map['is_voided'] = Variable<bool>(isVoided.value);
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
    return (StringBuffer('PurchasesCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('receiptId: $receiptId, ')
          ..write('total: $total, ')
          ..write('discount: $discount, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('notes: $notes, ')
          ..write('isVoided: $isVoided, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseItemsTable extends PurchaseItems
    with TableInfo<$PurchaseItemsTable, PurchaseItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _purchaseIdMeta =
      const VerificationMeta('purchaseId');
  @override
  late final GeneratedColumn<String> purchaseId = GeneratedColumn<String>(
      'purchase_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES purchases (id)'));
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _unitPriceMeta =
      const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, purchaseId, productId, quantity, unitPrice, total];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_items';
  @override
  VerificationContext validateIntegrity(Insertable<PurchaseItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
          _purchaseIdMeta,
          purchaseId.isAcceptableOrUnknown(
              data['purchase_id']!, _purchaseIdMeta));
    } else if (isInserting) {
      context.missing(_purchaseIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      purchaseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}purchase_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      unitPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
    );
  }

  @override
  $PurchaseItemsTable createAlias(String alias) {
    return $PurchaseItemsTable(attachedDatabase, alias);
  }
}

class PurchaseItem extends DataClass implements Insertable<PurchaseItem> {
  final String id;
  final String purchaseId;
  final String productId;
  final double quantity;
  final double unitPrice;
  final double total;
  const PurchaseItem(
      {required this.id,
      required this.purchaseId,
      required this.productId,
      required this.quantity,
      required this.unitPrice,
      required this.total});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['purchase_id'] = Variable<String>(purchaseId);
    map['product_id'] = Variable<String>(productId);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['total'] = Variable<double>(total);
    return map;
  }

  PurchaseItemsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseItemsCompanion(
      id: Value(id),
      purchaseId: Value(purchaseId),
      productId: Value(productId),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      total: Value(total),
    );
  }

  factory PurchaseItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseItem(
      id: serializer.fromJson<String>(json['id']),
      purchaseId: serializer.fromJson<String>(json['purchaseId']),
      productId: serializer.fromJson<String>(json['productId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      total: serializer.fromJson<double>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'purchaseId': serializer.toJson<String>(purchaseId),
      'productId': serializer.toJson<String>(productId),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'total': serializer.toJson<double>(total),
    };
  }

  PurchaseItem copyWith(
          {String? id,
          String? purchaseId,
          String? productId,
          double? quantity,
          double? unitPrice,
          double? total}) =>
      PurchaseItem(
        id: id ?? this.id,
        purchaseId: purchaseId ?? this.purchaseId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
        total: total ?? this.total,
      );
  PurchaseItem copyWithCompanion(PurchaseItemsCompanion data) {
    return PurchaseItem(
      id: data.id.present ? data.id.value : this.id,
      purchaseId:
          data.purchaseId.present ? data.purchaseId.value : this.purchaseId,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItem(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, purchaseId, productId, quantity, unitPrice, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseItem &&
          other.id == this.id &&
          other.purchaseId == this.purchaseId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.total == this.total);
}

class PurchaseItemsCompanion extends UpdateCompanion<PurchaseItem> {
  final Value<String> id;
  final Value<String> purchaseId;
  final Value<String> productId;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<double> total;
  final Value<int> rowid;
  const PurchaseItemsCompanion({
    this.id = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseItemsCompanion.insert({
    required String id,
    required String purchaseId,
    required String productId,
    required double quantity,
    required double unitPrice,
    required double total,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        purchaseId = Value(purchaseId),
        productId = Value(productId),
        quantity = Value(quantity),
        unitPrice = Value(unitPrice),
        total = Value(total);
  static Insertable<PurchaseItem> custom({
    Expression<String>? id,
    Expression<String>? purchaseId,
    Expression<String>? productId,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? total,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (total != null) 'total': total,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? purchaseId,
      Value<String>? productId,
      Value<double>? quantity,
      Value<double>? unitPrice,
      Value<double>? total,
      Value<int>? rowid}) {
    return PurchaseItemsCompanion(
      id: id ?? this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<String>(purchaseId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItemsCompanion(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SupplierPaymentsTable extends SupplierPayments
    with TableInfo<$SupplierPaymentsTable, SupplierPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _supplierIdMeta =
      const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
      'supplier_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES suppliers (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<int> paymentMethod = GeneratedColumn<int>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isVoidedMeta =
      const VerificationMeta('isVoided');
  @override
  late final GeneratedColumn<bool> isVoided = GeneratedColumn<bool>(
      'is_voided', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_voided" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        supplierId,
        amount,
        paymentMethod,
        reference,
        notes,
        isVoided,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_payments';
  @override
  VerificationContext validateIntegrity(Insertable<SupplierPayment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_voided')) {
      context.handle(_isVoidedMeta,
          isVoided.isAcceptableOrUnknown(data['is_voided']!, _isVoidedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierPayment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      supplierId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_method'])!,
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      isVoided: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_voided'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SupplierPaymentsTable createAlias(String alias) {
    return $SupplierPaymentsTable(attachedDatabase, alias);
  }
}

class SupplierPayment extends DataClass implements Insertable<SupplierPayment> {
  final String id;
  final String supplierId;
  final double amount;

  /// Maps to PaymentMethod enum. Conversion handled in DAO/repository layer.
  final int paymentMethod;
  final String? reference;
  final String? notes;
  final bool isVoided;
  final DateTime createdAt;
  const SupplierPayment(
      {required this.id,
      required this.supplierId,
      required this.amount,
      required this.paymentMethod,
      this.reference,
      this.notes,
      required this.isVoided,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['supplier_id'] = Variable<String>(supplierId);
    map['amount'] = Variable<double>(amount);
    map['payment_method'] = Variable<int>(paymentMethod);
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_voided'] = Variable<bool>(isVoided);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SupplierPaymentsCompanion toCompanion(bool nullToAbsent) {
    return SupplierPaymentsCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      amount: Value(amount),
      paymentMethod: Value(paymentMethod),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      isVoided: Value(isVoided),
      createdAt: Value(createdAt),
    );
  }

  factory SupplierPayment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierPayment(
      id: serializer.fromJson<String>(json['id']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentMethod: serializer.fromJson<int>(json['paymentMethod']),
      reference: serializer.fromJson<String?>(json['reference']),
      notes: serializer.fromJson<String?>(json['notes']),
      isVoided: serializer.fromJson<bool>(json['isVoided']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'supplierId': serializer.toJson<String>(supplierId),
      'amount': serializer.toJson<double>(amount),
      'paymentMethod': serializer.toJson<int>(paymentMethod),
      'reference': serializer.toJson<String?>(reference),
      'notes': serializer.toJson<String?>(notes),
      'isVoided': serializer.toJson<bool>(isVoided),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SupplierPayment copyWith(
          {String? id,
          String? supplierId,
          double? amount,
          int? paymentMethod,
          Value<String?> reference = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          bool? isVoided,
          DateTime? createdAt}) =>
      SupplierPayment(
        id: id ?? this.id,
        supplierId: supplierId ?? this.supplierId,
        amount: amount ?? this.amount,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        reference: reference.present ? reference.value : this.reference,
        notes: notes.present ? notes.value : this.notes,
        isVoided: isVoided ?? this.isVoided,
        createdAt: createdAt ?? this.createdAt,
      );
  SupplierPayment copyWithCompanion(SupplierPaymentsCompanion data) {
    return SupplierPayment(
      id: data.id.present ? data.id.value : this.id,
      supplierId:
          data.supplierId.present ? data.supplierId.value : this.supplierId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      reference: data.reference.present ? data.reference.value : this.reference,
      notes: data.notes.present ? data.notes.value : this.notes,
      isVoided: data.isVoided.present ? data.isVoided.value : this.isVoided,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierPayment(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('reference: $reference, ')
          ..write('notes: $notes, ')
          ..write('isVoided: $isVoided, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, supplierId, amount, paymentMethod,
      reference, notes, isVoided, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierPayment &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.amount == this.amount &&
          other.paymentMethod == this.paymentMethod &&
          other.reference == this.reference &&
          other.notes == this.notes &&
          other.isVoided == this.isVoided &&
          other.createdAt == this.createdAt);
}

class SupplierPaymentsCompanion extends UpdateCompanion<SupplierPayment> {
  final Value<String> id;
  final Value<String> supplierId;
  final Value<double> amount;
  final Value<int> paymentMethod;
  final Value<String?> reference;
  final Value<String?> notes;
  final Value<bool> isVoided;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SupplierPaymentsCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.reference = const Value.absent(),
    this.notes = const Value.absent(),
    this.isVoided = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SupplierPaymentsCompanion.insert({
    required String id,
    required String supplierId,
    required double amount,
    required int paymentMethod,
    this.reference = const Value.absent(),
    this.notes = const Value.absent(),
    this.isVoided = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        supplierId = Value(supplierId),
        amount = Value(amount),
        paymentMethod = Value(paymentMethod),
        createdAt = Value(createdAt);
  static Insertable<SupplierPayment> custom({
    Expression<String>? id,
    Expression<String>? supplierId,
    Expression<double>? amount,
    Expression<int>? paymentMethod,
    Expression<String>? reference,
    Expression<String>? notes,
    Expression<bool>? isVoided,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (amount != null) 'amount': amount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (reference != null) 'reference': reference,
      if (notes != null) 'notes': notes,
      if (isVoided != null) 'is_voided': isVoided,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SupplierPaymentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? supplierId,
      Value<double>? amount,
      Value<int>? paymentMethod,
      Value<String?>? reference,
      Value<String?>? notes,
      Value<bool>? isVoided,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SupplierPaymentsCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      reference: reference ?? this.reference,
      notes: notes ?? this.notes,
      isVoided: isVoided ?? this.isVoided,
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
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<int>(paymentMethod.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isVoided.present) {
      map['is_voided'] = Variable<bool>(isVoided.value);
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
    return (StringBuffer('SupplierPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('reference: $reference, ')
          ..write('notes: $notes, ')
          ..write('isVoided: $isVoided, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomerPaymentsTable extends CustomerPayments
    with TableInfo<$CustomerPaymentsTable, CustomerPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
      'sale_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sales (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<int> paymentMethod = GeneratedColumn<int>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        customerId,
        saleId,
        amount,
        paymentMethod,
        reference,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_payments';
  @override
  VerificationContext validateIntegrity(Insertable<CustomerPayment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('sale_id')) {
      context.handle(_saleIdMeta,
          saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerPayment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id'])!,
      saleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sale_id']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_method'])!,
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CustomerPaymentsTable createAlias(String alias) {
    return $CustomerPaymentsTable(attachedDatabase, alias);
  }
}

class CustomerPayment extends DataClass implements Insertable<CustomerPayment> {
  final String id;
  final String customerId;
  final String? saleId;
  final double amount;

  /// Maps to PaymentMethod enum. Conversion handled in DAO/repository layer.
  final int paymentMethod;
  final String? reference;
  final String? notes;
  final DateTime createdAt;
  const CustomerPayment(
      {required this.id,
      required this.customerId,
      this.saleId,
      required this.amount,
      required this.paymentMethod,
      this.reference,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['customer_id'] = Variable<String>(customerId);
    if (!nullToAbsent || saleId != null) {
      map['sale_id'] = Variable<String>(saleId);
    }
    map['amount'] = Variable<double>(amount);
    map['payment_method'] = Variable<int>(paymentMethod);
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomerPaymentsCompanion toCompanion(bool nullToAbsent) {
    return CustomerPaymentsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      saleId:
          saleId == null && nullToAbsent ? const Value.absent() : Value(saleId),
      amount: Value(amount),
      paymentMethod: Value(paymentMethod),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory CustomerPayment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerPayment(
      id: serializer.fromJson<String>(json['id']),
      customerId: serializer.fromJson<String>(json['customerId']),
      saleId: serializer.fromJson<String?>(json['saleId']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentMethod: serializer.fromJson<int>(json['paymentMethod']),
      reference: serializer.fromJson<String?>(json['reference']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'customerId': serializer.toJson<String>(customerId),
      'saleId': serializer.toJson<String?>(saleId),
      'amount': serializer.toJson<double>(amount),
      'paymentMethod': serializer.toJson<int>(paymentMethod),
      'reference': serializer.toJson<String?>(reference),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CustomerPayment copyWith(
          {String? id,
          String? customerId,
          Value<String?> saleId = const Value.absent(),
          double? amount,
          int? paymentMethod,
          Value<String?> reference = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      CustomerPayment(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        saleId: saleId.present ? saleId.value : this.saleId,
        amount: amount ?? this.amount,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        reference: reference.present ? reference.value : this.reference,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  CustomerPayment copyWithCompanion(CustomerPaymentsCompanion data) {
    return CustomerPayment(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      reference: data.reference.present ? data.reference.value : this.reference,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerPayment(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('saleId: $saleId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('reference: $reference, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, customerId, saleId, amount, paymentMethod,
      reference, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerPayment &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.saleId == this.saleId &&
          other.amount == this.amount &&
          other.paymentMethod == this.paymentMethod &&
          other.reference == this.reference &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class CustomerPaymentsCompanion extends UpdateCompanion<CustomerPayment> {
  final Value<String> id;
  final Value<String> customerId;
  final Value<String?> saleId;
  final Value<double> amount;
  final Value<int> paymentMethod;
  final Value<String?> reference;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CustomerPaymentsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.saleId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.reference = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomerPaymentsCompanion.insert({
    required String id,
    required String customerId,
    this.saleId = const Value.absent(),
    required double amount,
    required int paymentMethod,
    this.reference = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        customerId = Value(customerId),
        amount = Value(amount),
        paymentMethod = Value(paymentMethod),
        createdAt = Value(createdAt);
  static Insertable<CustomerPayment> custom({
    Expression<String>? id,
    Expression<String>? customerId,
    Expression<String>? saleId,
    Expression<double>? amount,
    Expression<int>? paymentMethod,
    Expression<String>? reference,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (saleId != null) 'sale_id': saleId,
      if (amount != null) 'amount': amount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (reference != null) 'reference': reference,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomerPaymentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? customerId,
      Value<String?>? saleId,
      Value<double>? amount,
      Value<int>? paymentMethod,
      Value<String?>? reference,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return CustomerPaymentsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      saleId: saleId ?? this.saleId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      reference: reference ?? this.reference,
      notes: notes ?? this.notes,
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
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<int>(paymentMethod.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('CustomerPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('saleId: $saleId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('reference: $reference, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
      'category', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<int> paymentMethod = GeneratedColumn<int>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isVoidedMeta =
      const VerificationMeta('isVoided');
  @override
  late final GeneratedColumn<bool> isVoided = GeneratedColumn<bool>(
      'is_voided', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_voided" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        category,
        amount,
        description,
        paymentMethod,
        reference,
        isVoided,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(Insertable<Expense> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    }
    if (data.containsKey('is_voided')) {
      context.handle(_isVoidedMeta,
          isVoided.isAcceptableOrUnknown(data['is_voided']!, _isVoidedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_method'])!,
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference']),
      isVoided: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_voided'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;

  /// Maps to ExpenseCategory enum. Conversion handled in DAO/repository layer.
  final int category;
  final double amount;
  final String description;

  /// Maps to PaymentMethod enum. Conversion handled in DAO/repository layer.
  final int paymentMethod;
  final String? reference;
  final bool isVoided;
  final DateTime createdAt;
  const Expense(
      {required this.id,
      required this.category,
      required this.amount,
      required this.description,
      required this.paymentMethod,
      this.reference,
      required this.isVoided,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category'] = Variable<int>(category);
    map['amount'] = Variable<double>(amount);
    map['description'] = Variable<String>(description);
    map['payment_method'] = Variable<int>(paymentMethod);
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    map['is_voided'] = Variable<bool>(isVoided);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      category: Value(category),
      amount: Value(amount),
      description: Value(description),
      paymentMethod: Value(paymentMethod),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      isVoided: Value(isVoided),
      createdAt: Value(createdAt),
    );
  }

  factory Expense.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      category: serializer.fromJson<int>(json['category']),
      amount: serializer.fromJson<double>(json['amount']),
      description: serializer.fromJson<String>(json['description']),
      paymentMethod: serializer.fromJson<int>(json['paymentMethod']),
      reference: serializer.fromJson<String?>(json['reference']),
      isVoided: serializer.fromJson<bool>(json['isVoided']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'category': serializer.toJson<int>(category),
      'amount': serializer.toJson<double>(amount),
      'description': serializer.toJson<String>(description),
      'paymentMethod': serializer.toJson<int>(paymentMethod),
      'reference': serializer.toJson<String?>(reference),
      'isVoided': serializer.toJson<bool>(isVoided),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Expense copyWith(
          {String? id,
          int? category,
          double? amount,
          String? description,
          int? paymentMethod,
          Value<String?> reference = const Value.absent(),
          bool? isVoided,
          DateTime? createdAt}) =>
      Expense(
        id: id ?? this.id,
        category: category ?? this.category,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        reference: reference.present ? reference.value : this.reference,
        isVoided: isVoided ?? this.isVoided,
        createdAt: createdAt ?? this.createdAt,
      );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      description:
          data.description.present ? data.description.value : this.description,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      reference: data.reference.present ? data.reference.value : this.reference,
      isVoided: data.isVoided.present ? data.isVoided.value : this.isVoided,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('reference: $reference, ')
          ..write('isVoided: $isVoided, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, amount, description,
      paymentMethod, reference, isVoided, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.description == this.description &&
          other.paymentMethod == this.paymentMethod &&
          other.reference == this.reference &&
          other.isVoided == this.isVoided &&
          other.createdAt == this.createdAt);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<int> category;
  final Value<double> amount;
  final Value<String> description;
  final Value<int> paymentMethod;
  final Value<String?> reference;
  final Value<bool> isVoided;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.reference = const Value.absent(),
    this.isVoided = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    required int category,
    required double amount,
    required String description,
    required int paymentMethod,
    this.reference = const Value.absent(),
    this.isVoided = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        category = Value(category),
        amount = Value(amount),
        description = Value(description),
        paymentMethod = Value(paymentMethod),
        createdAt = Value(createdAt);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<int>? category,
    Expression<double>? amount,
    Expression<String>? description,
    Expression<int>? paymentMethod,
    Expression<String>? reference,
    Expression<bool>? isVoided,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (reference != null) 'reference': reference,
      if (isVoided != null) 'is_voided': isVoided,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith(
      {Value<String>? id,
      Value<int>? category,
      Value<double>? amount,
      Value<String>? description,
      Value<int>? paymentMethod,
      Value<String?>? reference,
      Value<bool>? isVoided,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return ExpensesCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      reference: reference ?? this.reference,
      isVoided: isVoided ?? this.isVoided,
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
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<int>(paymentMethod.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (isVoided.present) {
      map['is_voided'] = Variable<bool>(isVoided.value);
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
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('reference: $reference, ')
          ..write('isVoided: $isVoided, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockTransactionsTable extends StockTransactions
    with TableInfo<$StockTransactionsTable, StockTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES products (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _unitPriceMeta =
      const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _referenceIdMeta =
      const VerificationMeta('referenceId');
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
      'reference_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        productId,
        type,
        quantity,
        unitPrice,
        total,
        referenceId,
        reason,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_transactions';
  @override
  VerificationContext validateIntegrity(Insertable<StockTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('reference_id')) {
      context.handle(
          _referenceIdMeta,
          referenceId.isAcceptableOrUnknown(
              data['reference_id']!, _referenceIdMeta));
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockTransaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      unitPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      referenceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_id']),
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $StockTransactionsTable createAlias(String alias) {
    return $StockTransactionsTable(attachedDatabase, alias);
  }
}

class StockTransaction extends DataClass
    implements Insertable<StockTransaction> {
  final String id;
  final String productId;

  /// Maps to StockTransactionType enum. Conversion handled in DAO/repository layer.
  final int type;
  final double quantity;
  final double unitPrice;
  final double total;
  final String? referenceId;
  final String? reason;
  final DateTime createdAt;
  const StockTransaction(
      {required this.id,
      required this.productId,
      required this.type,
      required this.quantity,
      required this.unitPrice,
      required this.total,
      this.referenceId,
      this.reason,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    map['type'] = Variable<int>(type);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['total'] = Variable<double>(total);
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StockTransactionsCompanion toCompanion(bool nullToAbsent) {
    return StockTransactionsCompanion(
      id: Value(id),
      productId: Value(productId),
      type: Value(type),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      total: Value(total),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      reason:
          reason == null && nullToAbsent ? const Value.absent() : Value(reason),
      createdAt: Value(createdAt),
    );
  }

  factory StockTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockTransaction(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      type: serializer.fromJson<int>(json['type']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      total: serializer.fromJson<double>(json['total']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      reason: serializer.fromJson<String?>(json['reason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'type': serializer.toJson<int>(type),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'total': serializer.toJson<double>(total),
      'referenceId': serializer.toJson<String?>(referenceId),
      'reason': serializer.toJson<String?>(reason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StockTransaction copyWith(
          {String? id,
          String? productId,
          int? type,
          double? quantity,
          double? unitPrice,
          double? total,
          Value<String?> referenceId = const Value.absent(),
          Value<String?> reason = const Value.absent(),
          DateTime? createdAt}) =>
      StockTransaction(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        type: type ?? this.type,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
        total: total ?? this.total,
        referenceId: referenceId.present ? referenceId.value : this.referenceId,
        reason: reason.present ? reason.value : this.reason,
        createdAt: createdAt ?? this.createdAt,
      );
  StockTransaction copyWithCompanion(StockTransactionsCompanion data) {
    return StockTransaction(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      type: data.type.present ? data.type.value : this.type,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      total: data.total.present ? data.total.value : this.total,
      referenceId:
          data.referenceId.present ? data.referenceId.value : this.referenceId,
      reason: data.reason.present ? data.reason.value : this.reason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockTransaction(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('type: $type, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total, ')
          ..write('referenceId: $referenceId, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, type, quantity, unitPrice,
      total, referenceId, reason, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockTransaction &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.type == this.type &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.total == this.total &&
          other.referenceId == this.referenceId &&
          other.reason == this.reason &&
          other.createdAt == this.createdAt);
}

class StockTransactionsCompanion extends UpdateCompanion<StockTransaction> {
  final Value<String> id;
  final Value<String> productId;
  final Value<int> type;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<double> total;
  final Value<String?> referenceId;
  final Value<String?> reason;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const StockTransactionsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.type = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.total = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.reason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockTransactionsCompanion.insert({
    required String id,
    required String productId,
    required int type,
    required double quantity,
    required double unitPrice,
    required double total,
    this.referenceId = const Value.absent(),
    this.reason = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        productId = Value(productId),
        type = Value(type),
        quantity = Value(quantity),
        unitPrice = Value(unitPrice),
        total = Value(total),
        createdAt = Value(createdAt);
  static Insertable<StockTransaction> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<int>? type,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? total,
    Expression<String>? referenceId,
    Expression<String>? reason,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (type != null) 'type': type,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (total != null) 'total': total,
      if (referenceId != null) 'reference_id': referenceId,
      if (reason != null) 'reason': reason,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockTransactionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? productId,
      Value<int>? type,
      Value<double>? quantity,
      Value<double>? unitPrice,
      Value<double>? total,
      Value<String?>? referenceId,
      Value<String?>? reason,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return StockTransactionsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
      referenceId: referenceId ?? this.referenceId,
      reason: reason ?? this.reason,
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
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
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
    return (StringBuffer('StockTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('type: $type, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total, ')
          ..write('referenceId: $referenceId, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CashEntriesTable extends CashEntries
    with TableInfo<$CashEntriesTable, CashEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _referenceIdMeta =
      const VerificationMeta('referenceId');
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
      'reference_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, amount, description, referenceId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_entries';
  @override
  VerificationContext validateIntegrity(Insertable<CashEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('reference_id')) {
      context.handle(
          _referenceIdMeta,
          referenceId.isAcceptableOrUnknown(
              data['reference_id']!, _referenceIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      referenceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CashEntriesTable createAlias(String alias) {
    return $CashEntriesTable(attachedDatabase, alias);
  }
}

class CashEntry extends DataClass implements Insertable<CashEntry> {
  final String id;

  /// Maps to CashEntryType enum. Conversion handled in DAO/repository layer.
  final int type;
  final double amount;
  final String description;
  final String? referenceId;
  final DateTime createdAt;
  const CashEntry(
      {required this.id,
      required this.type,
      required this.amount,
      required this.description,
      this.referenceId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<int>(type);
    map['amount'] = Variable<double>(amount);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CashEntriesCompanion toCompanion(bool nullToAbsent) {
    return CashEntriesCompanion(
      id: Value(id),
      type: Value(type),
      amount: Value(amount),
      description: Value(description),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      createdAt: Value(createdAt),
    );
  }

  factory CashEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashEntry(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<int>(json['type']),
      amount: serializer.fromJson<double>(json['amount']),
      description: serializer.fromJson<String>(json['description']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<int>(type),
      'amount': serializer.toJson<double>(amount),
      'description': serializer.toJson<String>(description),
      'referenceId': serializer.toJson<String?>(referenceId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CashEntry copyWith(
          {String? id,
          int? type,
          double? amount,
          String? description,
          Value<String?> referenceId = const Value.absent(),
          DateTime? createdAt}) =>
      CashEntry(
        id: id ?? this.id,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        referenceId: referenceId.present ? referenceId.value : this.referenceId,
        createdAt: createdAt ?? this.createdAt,
      );
  CashEntry copyWithCompanion(CashEntriesCompanion data) {
    return CashEntry(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      description:
          data.description.present ? data.description.value : this.description,
      referenceId:
          data.referenceId.present ? data.referenceId.value : this.referenceId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashEntry(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('referenceId: $referenceId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, amount, description, referenceId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashEntry &&
          other.id == this.id &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.description == this.description &&
          other.referenceId == this.referenceId &&
          other.createdAt == this.createdAt);
}

class CashEntriesCompanion extends UpdateCompanion<CashEntry> {
  final Value<String> id;
  final Value<int> type;
  final Value<double> amount;
  final Value<String> description;
  final Value<String?> referenceId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CashEntriesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CashEntriesCompanion.insert({
    required String id,
    required int type,
    required double amount,
    required String description,
    this.referenceId = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        amount = Value(amount),
        description = Value(description),
        createdAt = Value(createdAt);
  static Insertable<CashEntry> custom({
    Expression<String>? id,
    Expression<int>? type,
    Expression<double>? amount,
    Expression<String>? description,
    Expression<String>? referenceId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (referenceId != null) 'reference_id': referenceId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CashEntriesCompanion copyWith(
      {Value<String>? id,
      Value<int>? type,
      Value<double>? amount,
      Value<String>? description,
      Value<String?>? referenceId,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return CashEntriesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      referenceId: referenceId ?? this.referenceId,
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
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
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
    return (StringBuffer('CashEntriesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('referenceId: $referenceId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CashClosingsTable extends CashClosings
    with TableInfo<$CashClosingsTable, CashClosing> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashClosingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _businessDateMeta =
      const VerificationMeta('businessDate');
  @override
  late final GeneratedColumn<DateTime> businessDate = GeneratedColumn<DateTime>(
      'business_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _openingBalanceMeta =
      const VerificationMeta('openingBalance');
  @override
  late final GeneratedColumn<double> openingBalance = GeneratedColumn<double>(
      'opening_balance', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _expectedClosingMeta =
      const VerificationMeta('expectedClosing');
  @override
  late final GeneratedColumn<double> expectedClosing = GeneratedColumn<double>(
      'expected_closing', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _actualClosingMeta =
      const VerificationMeta('actualClosing');
  @override
  late final GeneratedColumn<double> actualClosing = GeneratedColumn<double>(
      'actual_closing', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _differenceMeta =
      const VerificationMeta('difference');
  @override
  late final GeneratedColumn<double> difference = GeneratedColumn<double>(
      'difference', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        businessDate,
        openingBalance,
        expectedClosing,
        actualClosing,
        difference,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_closings';
  @override
  VerificationContext validateIntegrity(Insertable<CashClosing> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('business_date')) {
      context.handle(
          _businessDateMeta,
          businessDate.isAcceptableOrUnknown(
              data['business_date']!, _businessDateMeta));
    } else if (isInserting) {
      context.missing(_businessDateMeta);
    }
    if (data.containsKey('opening_balance')) {
      context.handle(
          _openingBalanceMeta,
          openingBalance.isAcceptableOrUnknown(
              data['opening_balance']!, _openingBalanceMeta));
    } else if (isInserting) {
      context.missing(_openingBalanceMeta);
    }
    if (data.containsKey('expected_closing')) {
      context.handle(
          _expectedClosingMeta,
          expectedClosing.isAcceptableOrUnknown(
              data['expected_closing']!, _expectedClosingMeta));
    } else if (isInserting) {
      context.missing(_expectedClosingMeta);
    }
    if (data.containsKey('actual_closing')) {
      context.handle(
          _actualClosingMeta,
          actualClosing.isAcceptableOrUnknown(
              data['actual_closing']!, _actualClosingMeta));
    } else if (isInserting) {
      context.missing(_actualClosingMeta);
    }
    if (data.containsKey('difference')) {
      context.handle(
          _differenceMeta,
          difference.isAcceptableOrUnknown(
              data['difference']!, _differenceMeta));
    } else if (isInserting) {
      context.missing(_differenceMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashClosing map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashClosing(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      businessDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}business_date'])!,
      openingBalance: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}opening_balance'])!,
      expectedClosing: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}expected_closing'])!,
      actualClosing: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}actual_closing'])!,
      difference: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}difference'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CashClosingsTable createAlias(String alias) {
    return $CashClosingsTable(attachedDatabase, alias);
  }
}

class CashClosing extends DataClass implements Insertable<CashClosing> {
  final String id;

  /// Start of the business day that was closed (00:00 local time).
  final DateTime businessDate;
  final double openingBalance;
  final double expectedClosing;
  final double actualClosing;
  final double difference;
  final String? notes;
  final DateTime createdAt;
  const CashClosing(
      {required this.id,
      required this.businessDate,
      required this.openingBalance,
      required this.expectedClosing,
      required this.actualClosing,
      required this.difference,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['business_date'] = Variable<DateTime>(businessDate);
    map['opening_balance'] = Variable<double>(openingBalance);
    map['expected_closing'] = Variable<double>(expectedClosing);
    map['actual_closing'] = Variable<double>(actualClosing);
    map['difference'] = Variable<double>(difference);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CashClosingsCompanion toCompanion(bool nullToAbsent) {
    return CashClosingsCompanion(
      id: Value(id),
      businessDate: Value(businessDate),
      openingBalance: Value(openingBalance),
      expectedClosing: Value(expectedClosing),
      actualClosing: Value(actualClosing),
      difference: Value(difference),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory CashClosing.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashClosing(
      id: serializer.fromJson<String>(json['id']),
      businessDate: serializer.fromJson<DateTime>(json['businessDate']),
      openingBalance: serializer.fromJson<double>(json['openingBalance']),
      expectedClosing: serializer.fromJson<double>(json['expectedClosing']),
      actualClosing: serializer.fromJson<double>(json['actualClosing']),
      difference: serializer.fromJson<double>(json['difference']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'businessDate': serializer.toJson<DateTime>(businessDate),
      'openingBalance': serializer.toJson<double>(openingBalance),
      'expectedClosing': serializer.toJson<double>(expectedClosing),
      'actualClosing': serializer.toJson<double>(actualClosing),
      'difference': serializer.toJson<double>(difference),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CashClosing copyWith(
          {String? id,
          DateTime? businessDate,
          double? openingBalance,
          double? expectedClosing,
          double? actualClosing,
          double? difference,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      CashClosing(
        id: id ?? this.id,
        businessDate: businessDate ?? this.businessDate,
        openingBalance: openingBalance ?? this.openingBalance,
        expectedClosing: expectedClosing ?? this.expectedClosing,
        actualClosing: actualClosing ?? this.actualClosing,
        difference: difference ?? this.difference,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  CashClosing copyWithCompanion(CashClosingsCompanion data) {
    return CashClosing(
      id: data.id.present ? data.id.value : this.id,
      businessDate: data.businessDate.present
          ? data.businessDate.value
          : this.businessDate,
      openingBalance: data.openingBalance.present
          ? data.openingBalance.value
          : this.openingBalance,
      expectedClosing: data.expectedClosing.present
          ? data.expectedClosing.value
          : this.expectedClosing,
      actualClosing: data.actualClosing.present
          ? data.actualClosing.value
          : this.actualClosing,
      difference:
          data.difference.present ? data.difference.value : this.difference,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashClosing(')
          ..write('id: $id, ')
          ..write('businessDate: $businessDate, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('expectedClosing: $expectedClosing, ')
          ..write('actualClosing: $actualClosing, ')
          ..write('difference: $difference, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, businessDate, openingBalance,
      expectedClosing, actualClosing, difference, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashClosing &&
          other.id == this.id &&
          other.businessDate == this.businessDate &&
          other.openingBalance == this.openingBalance &&
          other.expectedClosing == this.expectedClosing &&
          other.actualClosing == this.actualClosing &&
          other.difference == this.difference &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class CashClosingsCompanion extends UpdateCompanion<CashClosing> {
  final Value<String> id;
  final Value<DateTime> businessDate;
  final Value<double> openingBalance;
  final Value<double> expectedClosing;
  final Value<double> actualClosing;
  final Value<double> difference;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CashClosingsCompanion({
    this.id = const Value.absent(),
    this.businessDate = const Value.absent(),
    this.openingBalance = const Value.absent(),
    this.expectedClosing = const Value.absent(),
    this.actualClosing = const Value.absent(),
    this.difference = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CashClosingsCompanion.insert({
    required String id,
    required DateTime businessDate,
    required double openingBalance,
    required double expectedClosing,
    required double actualClosing,
    required double difference,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        businessDate = Value(businessDate),
        openingBalance = Value(openingBalance),
        expectedClosing = Value(expectedClosing),
        actualClosing = Value(actualClosing),
        difference = Value(difference),
        createdAt = Value(createdAt);
  static Insertable<CashClosing> custom({
    Expression<String>? id,
    Expression<DateTime>? businessDate,
    Expression<double>? openingBalance,
    Expression<double>? expectedClosing,
    Expression<double>? actualClosing,
    Expression<double>? difference,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (businessDate != null) 'business_date': businessDate,
      if (openingBalance != null) 'opening_balance': openingBalance,
      if (expectedClosing != null) 'expected_closing': expectedClosing,
      if (actualClosing != null) 'actual_closing': actualClosing,
      if (difference != null) 'difference': difference,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CashClosingsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? businessDate,
      Value<double>? openingBalance,
      Value<double>? expectedClosing,
      Value<double>? actualClosing,
      Value<double>? difference,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return CashClosingsCompanion(
      id: id ?? this.id,
      businessDate: businessDate ?? this.businessDate,
      openingBalance: openingBalance ?? this.openingBalance,
      expectedClosing: expectedClosing ?? this.expectedClosing,
      actualClosing: actualClosing ?? this.actualClosing,
      difference: difference ?? this.difference,
      notes: notes ?? this.notes,
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
    if (businessDate.present) {
      map['business_date'] = Variable<DateTime>(businessDate.value);
    }
    if (openingBalance.present) {
      map['opening_balance'] = Variable<double>(openingBalance.value);
    }
    if (expectedClosing.present) {
      map['expected_closing'] = Variable<double>(expectedClosing.value);
    }
    if (actualClosing.present) {
      map['actual_closing'] = Variable<double>(actualClosing.value);
    }
    if (difference.present) {
      map['difference'] = Variable<double>(difference.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('CashClosingsCompanion(')
          ..write('id: $id, ')
          ..write('businessDate: $businessDate, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('expectedClosing: $expectedClosing, ')
          ..write('actualClosing: $actualClosing, ')
          ..write('difference: $difference, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReceiptsTable extends Receipts with TableInfo<$ReceiptsTable, Receipt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _receiptNumberMeta =
      const VerificationMeta('receiptNumber');
  @override
  late final GeneratedColumn<String> receiptNumber = GeneratedColumn<String>(
      'receipt_number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
      'transaction_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, receiptNumber, transactionId, type, total, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipts';
  @override
  VerificationContext validateIntegrity(Insertable<Receipt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('receipt_number')) {
      context.handle(
          _receiptNumberMeta,
          receiptNumber.isAcceptableOrUnknown(
              data['receipt_number']!, _receiptNumberMeta));
    } else if (isInserting) {
      context.missing(_receiptNumberMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Receipt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Receipt(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      receiptNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}receipt_number'])!,
      transactionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transaction_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      total: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(attachedDatabase, alias);
  }
}

class Receipt extends DataClass implements Insertable<Receipt> {
  final String id;
  final String receiptNumber;
  final String transactionId;

  /// Maps to ReceiptType enum. Conversion handled in DAO/repository layer.
  final int type;
  final double total;
  final DateTime createdAt;
  const Receipt(
      {required this.id,
      required this.receiptNumber,
      required this.transactionId,
      required this.type,
      required this.total,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['receipt_number'] = Variable<String>(receiptNumber);
    map['transaction_id'] = Variable<String>(transactionId);
    map['type'] = Variable<int>(type);
    map['total'] = Variable<double>(total);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      receiptNumber: Value(receiptNumber),
      transactionId: Value(transactionId),
      type: Value(type),
      total: Value(total),
      createdAt: Value(createdAt),
    );
  }

  factory Receipt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<String>(json['id']),
      receiptNumber: serializer.fromJson<String>(json['receiptNumber']),
      transactionId: serializer.fromJson<String>(json['transactionId']),
      type: serializer.fromJson<int>(json['type']),
      total: serializer.fromJson<double>(json['total']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'receiptNumber': serializer.toJson<String>(receiptNumber),
      'transactionId': serializer.toJson<String>(transactionId),
      'type': serializer.toJson<int>(type),
      'total': serializer.toJson<double>(total),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Receipt copyWith(
          {String? id,
          String? receiptNumber,
          String? transactionId,
          int? type,
          double? total,
          DateTime? createdAt}) =>
      Receipt(
        id: id ?? this.id,
        receiptNumber: receiptNumber ?? this.receiptNumber,
        transactionId: transactionId ?? this.transactionId,
        type: type ?? this.type,
        total: total ?? this.total,
        createdAt: createdAt ?? this.createdAt,
      );
  Receipt copyWithCompanion(ReceiptsCompanion data) {
    return Receipt(
      id: data.id.present ? data.id.value : this.id,
      receiptNumber: data.receiptNumber.present
          ? data.receiptNumber.value
          : this.receiptNumber,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      type: data.type.present ? data.type.value : this.type,
      total: data.total.present ? data.total.value : this.total,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Receipt(')
          ..write('id: $id, ')
          ..write('receiptNumber: $receiptNumber, ')
          ..write('transactionId: $transactionId, ')
          ..write('type: $type, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, receiptNumber, transactionId, type, total, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == this.id &&
          other.receiptNumber == this.receiptNumber &&
          other.transactionId == this.transactionId &&
          other.type == this.type &&
          other.total == this.total &&
          other.createdAt == this.createdAt);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<String> id;
  final Value<String> receiptNumber;
  final Value<String> transactionId;
  final Value<int> type;
  final Value<double> total;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.receiptNumber = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.type = const Value.absent(),
    this.total = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    required String id,
    required String receiptNumber,
    required String transactionId,
    required int type,
    required double total,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        receiptNumber = Value(receiptNumber),
        transactionId = Value(transactionId),
        type = Value(type),
        total = Value(total),
        createdAt = Value(createdAt);
  static Insertable<Receipt> custom({
    Expression<String>? id,
    Expression<String>? receiptNumber,
    Expression<String>? transactionId,
    Expression<int>? type,
    Expression<double>? total,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (receiptNumber != null) 'receipt_number': receiptNumber,
      if (transactionId != null) 'transaction_id': transactionId,
      if (type != null) 'type': type,
      if (total != null) 'total': total,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReceiptsCompanion copyWith(
      {Value<String>? id,
      Value<String>? receiptNumber,
      Value<String>? transactionId,
      Value<int>? type,
      Value<double>? total,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      transactionId: transactionId ?? this.transactionId,
      type: type ?? this.type,
      total: total ?? this.total,
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
    if (receiptNumber.present) {
      map['receipt_number'] = Variable<String>(receiptNumber.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
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
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('receiptNumber: $receiptNumber, ')
          ..write('transactionId: $transactionId, ')
          ..write('type: $type, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReceiptSettingsTable extends ReceiptSettings
    with TableInfo<$ReceiptSettingsTable, ReceiptSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _headerMeta = const VerificationMeta('header');
  @override
  late final GeneratedColumn<String> header = GeneratedColumn<String>(
      'header', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _footerMeta = const VerificationMeta('footer');
  @override
  late final GeneratedColumn<String> footer = GeneratedColumn<String>(
      'footer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _showLogoMeta =
      const VerificationMeta('showLogo');
  @override
  late final GeneratedColumn<bool> showLogo = GeneratedColumn<bool>(
      'show_logo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("show_logo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _showBusinessInfoMeta =
      const VerificationMeta('showBusinessInfo');
  @override
  late final GeneratedColumn<bool> showBusinessInfo = GeneratedColumn<bool>(
      'show_business_info', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_business_info" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _taxLabelMeta =
      const VerificationMeta('taxLabel');
  @override
  late final GeneratedColumn<String> taxLabel = GeneratedColumn<String>(
      'tax_label', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _taxPercentageMeta =
      const VerificationMeta('taxPercentage');
  @override
  late final GeneratedColumn<double> taxPercentage = GeneratedColumn<double>(
      'tax_percentage', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, header, footer, showLogo, showBusinessInfo, taxLabel, taxPercentage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipt_settings';
  @override
  VerificationContext validateIntegrity(Insertable<ReceiptSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('header')) {
      context.handle(_headerMeta,
          header.isAcceptableOrUnknown(data['header']!, _headerMeta));
    }
    if (data.containsKey('footer')) {
      context.handle(_footerMeta,
          footer.isAcceptableOrUnknown(data['footer']!, _footerMeta));
    }
    if (data.containsKey('show_logo')) {
      context.handle(_showLogoMeta,
          showLogo.isAcceptableOrUnknown(data['show_logo']!, _showLogoMeta));
    }
    if (data.containsKey('show_business_info')) {
      context.handle(
          _showBusinessInfoMeta,
          showBusinessInfo.isAcceptableOrUnknown(
              data['show_business_info']!, _showBusinessInfoMeta));
    }
    if (data.containsKey('tax_label')) {
      context.handle(_taxLabelMeta,
          taxLabel.isAcceptableOrUnknown(data['tax_label']!, _taxLabelMeta));
    }
    if (data.containsKey('tax_percentage')) {
      context.handle(
          _taxPercentageMeta,
          taxPercentage.isAcceptableOrUnknown(
              data['tax_percentage']!, _taxPercentageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReceiptSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReceiptSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      header: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}header']),
      footer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}footer']),
      showLogo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}show_logo'])!,
      showBusinessInfo: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}show_business_info'])!,
      taxLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tax_label']),
      taxPercentage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tax_percentage']),
    );
  }

  @override
  $ReceiptSettingsTable createAlias(String alias) {
    return $ReceiptSettingsTable(attachedDatabase, alias);
  }
}

class ReceiptSetting extends DataClass implements Insertable<ReceiptSetting> {
  final String id;
  final String? header;
  final String? footer;
  final bool showLogo;
  final bool showBusinessInfo;
  final String? taxLabel;
  final double? taxPercentage;
  const ReceiptSetting(
      {required this.id,
      this.header,
      this.footer,
      required this.showLogo,
      required this.showBusinessInfo,
      this.taxLabel,
      this.taxPercentage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || header != null) {
      map['header'] = Variable<String>(header);
    }
    if (!nullToAbsent || footer != null) {
      map['footer'] = Variable<String>(footer);
    }
    map['show_logo'] = Variable<bool>(showLogo);
    map['show_business_info'] = Variable<bool>(showBusinessInfo);
    if (!nullToAbsent || taxLabel != null) {
      map['tax_label'] = Variable<String>(taxLabel);
    }
    if (!nullToAbsent || taxPercentage != null) {
      map['tax_percentage'] = Variable<double>(taxPercentage);
    }
    return map;
  }

  ReceiptSettingsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptSettingsCompanion(
      id: Value(id),
      header:
          header == null && nullToAbsent ? const Value.absent() : Value(header),
      footer:
          footer == null && nullToAbsent ? const Value.absent() : Value(footer),
      showLogo: Value(showLogo),
      showBusinessInfo: Value(showBusinessInfo),
      taxLabel: taxLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(taxLabel),
      taxPercentage: taxPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(taxPercentage),
    );
  }

  factory ReceiptSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReceiptSetting(
      id: serializer.fromJson<String>(json['id']),
      header: serializer.fromJson<String?>(json['header']),
      footer: serializer.fromJson<String?>(json['footer']),
      showLogo: serializer.fromJson<bool>(json['showLogo']),
      showBusinessInfo: serializer.fromJson<bool>(json['showBusinessInfo']),
      taxLabel: serializer.fromJson<String?>(json['taxLabel']),
      taxPercentage: serializer.fromJson<double?>(json['taxPercentage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'header': serializer.toJson<String?>(header),
      'footer': serializer.toJson<String?>(footer),
      'showLogo': serializer.toJson<bool>(showLogo),
      'showBusinessInfo': serializer.toJson<bool>(showBusinessInfo),
      'taxLabel': serializer.toJson<String?>(taxLabel),
      'taxPercentage': serializer.toJson<double?>(taxPercentage),
    };
  }

  ReceiptSetting copyWith(
          {String? id,
          Value<String?> header = const Value.absent(),
          Value<String?> footer = const Value.absent(),
          bool? showLogo,
          bool? showBusinessInfo,
          Value<String?> taxLabel = const Value.absent(),
          Value<double?> taxPercentage = const Value.absent()}) =>
      ReceiptSetting(
        id: id ?? this.id,
        header: header.present ? header.value : this.header,
        footer: footer.present ? footer.value : this.footer,
        showLogo: showLogo ?? this.showLogo,
        showBusinessInfo: showBusinessInfo ?? this.showBusinessInfo,
        taxLabel: taxLabel.present ? taxLabel.value : this.taxLabel,
        taxPercentage:
            taxPercentage.present ? taxPercentage.value : this.taxPercentage,
      );
  ReceiptSetting copyWithCompanion(ReceiptSettingsCompanion data) {
    return ReceiptSetting(
      id: data.id.present ? data.id.value : this.id,
      header: data.header.present ? data.header.value : this.header,
      footer: data.footer.present ? data.footer.value : this.footer,
      showLogo: data.showLogo.present ? data.showLogo.value : this.showLogo,
      showBusinessInfo: data.showBusinessInfo.present
          ? data.showBusinessInfo.value
          : this.showBusinessInfo,
      taxLabel: data.taxLabel.present ? data.taxLabel.value : this.taxLabel,
      taxPercentage: data.taxPercentage.present
          ? data.taxPercentage.value
          : this.taxPercentage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptSetting(')
          ..write('id: $id, ')
          ..write('header: $header, ')
          ..write('footer: $footer, ')
          ..write('showLogo: $showLogo, ')
          ..write('showBusinessInfo: $showBusinessInfo, ')
          ..write('taxLabel: $taxLabel, ')
          ..write('taxPercentage: $taxPercentage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, header, footer, showLogo, showBusinessInfo, taxLabel, taxPercentage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReceiptSetting &&
          other.id == this.id &&
          other.header == this.header &&
          other.footer == this.footer &&
          other.showLogo == this.showLogo &&
          other.showBusinessInfo == this.showBusinessInfo &&
          other.taxLabel == this.taxLabel &&
          other.taxPercentage == this.taxPercentage);
}

class ReceiptSettingsCompanion extends UpdateCompanion<ReceiptSetting> {
  final Value<String> id;
  final Value<String?> header;
  final Value<String?> footer;
  final Value<bool> showLogo;
  final Value<bool> showBusinessInfo;
  final Value<String?> taxLabel;
  final Value<double?> taxPercentage;
  final Value<int> rowid;
  const ReceiptSettingsCompanion({
    this.id = const Value.absent(),
    this.header = const Value.absent(),
    this.footer = const Value.absent(),
    this.showLogo = const Value.absent(),
    this.showBusinessInfo = const Value.absent(),
    this.taxLabel = const Value.absent(),
    this.taxPercentage = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReceiptSettingsCompanion.insert({
    required String id,
    this.header = const Value.absent(),
    this.footer = const Value.absent(),
    this.showLogo = const Value.absent(),
    this.showBusinessInfo = const Value.absent(),
    this.taxLabel = const Value.absent(),
    this.taxPercentage = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<ReceiptSetting> custom({
    Expression<String>? id,
    Expression<String>? header,
    Expression<String>? footer,
    Expression<bool>? showLogo,
    Expression<bool>? showBusinessInfo,
    Expression<String>? taxLabel,
    Expression<double>? taxPercentage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (header != null) 'header': header,
      if (footer != null) 'footer': footer,
      if (showLogo != null) 'show_logo': showLogo,
      if (showBusinessInfo != null) 'show_business_info': showBusinessInfo,
      if (taxLabel != null) 'tax_label': taxLabel,
      if (taxPercentage != null) 'tax_percentage': taxPercentage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReceiptSettingsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? header,
      Value<String?>? footer,
      Value<bool>? showLogo,
      Value<bool>? showBusinessInfo,
      Value<String?>? taxLabel,
      Value<double?>? taxPercentage,
      Value<int>? rowid}) {
    return ReceiptSettingsCompanion(
      id: id ?? this.id,
      header: header ?? this.header,
      footer: footer ?? this.footer,
      showLogo: showLogo ?? this.showLogo,
      showBusinessInfo: showBusinessInfo ?? this.showBusinessInfo,
      taxLabel: taxLabel ?? this.taxLabel,
      taxPercentage: taxPercentage ?? this.taxPercentage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (header.present) {
      map['header'] = Variable<String>(header.value);
    }
    if (footer.present) {
      map['footer'] = Variable<String>(footer.value);
    }
    if (showLogo.present) {
      map['show_logo'] = Variable<bool>(showLogo.value);
    }
    if (showBusinessInfo.present) {
      map['show_business_info'] = Variable<bool>(showBusinessInfo.value);
    }
    if (taxLabel.present) {
      map['tax_label'] = Variable<String>(taxLabel.value);
    }
    if (taxPercentage.present) {
      map['tax_percentage'] = Variable<double>(taxPercentage.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptSettingsCompanion(')
          ..write('id: $id, ')
          ..write('header: $header, ')
          ..write('footer: $footer, ')
          ..write('showLogo: $showLogo, ')
          ..write('showBusinessInfo: $showBusinessInfo, ')
          ..write('taxLabel: $taxLabel, ')
          ..write('taxPercentage: $taxPercentage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditEntriesTable extends AuditEntries
    with TableInfo<$AuditEntriesTable, AuditEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<int> action = GeneratedColumn<int>(
      'action', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<int> entityType = GeneratedColumn<int>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _previousValueMeta =
      const VerificationMeta('previousValue');
  @override
  late final GeneratedColumn<String> previousValue = GeneratedColumn<String>(
      'previous_value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _newValueMeta =
      const VerificationMeta('newValue');
  @override
  late final GeneratedColumn<String> newValue = GeneratedColumn<String>(
      'new_value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, action, entityType, entityId, previousValue, newValue, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_entries';
  @override
  VerificationContext validateIntegrity(Insertable<AuditEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta,
          action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('previous_value')) {
      context.handle(
          _previousValueMeta,
          previousValue.isAcceptableOrUnknown(
              data['previous_value']!, _previousValueMeta));
    }
    if (data.containsKey('new_value')) {
      context.handle(_newValueMeta,
          newValue.isAcceptableOrUnknown(data['new_value']!, _newValueMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      action: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}action'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      previousValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}previous_value']),
      newValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}new_value']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AuditEntriesTable createAlias(String alias) {
    return $AuditEntriesTable(attachedDatabase, alias);
  }
}

class AuditEntry extends DataClass implements Insertable<AuditEntry> {
  final String id;

  /// Maps to AuditAction enum. Conversion handled in DAO/repository layer.
  final int action;

  /// Maps to AuditEntityType enum. Conversion handled in DAO/repository layer.
  final int entityType;
  final String entityId;
  final String? previousValue;
  final String? newValue;
  final DateTime createdAt;
  const AuditEntry(
      {required this.id,
      required this.action,
      required this.entityType,
      required this.entityId,
      this.previousValue,
      this.newValue,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['action'] = Variable<int>(action);
    map['entity_type'] = Variable<int>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    if (!nullToAbsent || previousValue != null) {
      map['previous_value'] = Variable<String>(previousValue);
    }
    if (!nullToAbsent || newValue != null) {
      map['new_value'] = Variable<String>(newValue);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditEntriesCompanion toCompanion(bool nullToAbsent) {
    return AuditEntriesCompanion(
      id: Value(id),
      action: Value(action),
      entityType: Value(entityType),
      entityId: Value(entityId),
      previousValue: previousValue == null && nullToAbsent
          ? const Value.absent()
          : Value(previousValue),
      newValue: newValue == null && nullToAbsent
          ? const Value.absent()
          : Value(newValue),
      createdAt: Value(createdAt),
    );
  }

  factory AuditEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditEntry(
      id: serializer.fromJson<String>(json['id']),
      action: serializer.fromJson<int>(json['action']),
      entityType: serializer.fromJson<int>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      previousValue: serializer.fromJson<String?>(json['previousValue']),
      newValue: serializer.fromJson<String?>(json['newValue']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'action': serializer.toJson<int>(action),
      'entityType': serializer.toJson<int>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'previousValue': serializer.toJson<String?>(previousValue),
      'newValue': serializer.toJson<String?>(newValue),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AuditEntry copyWith(
          {String? id,
          int? action,
          int? entityType,
          String? entityId,
          Value<String?> previousValue = const Value.absent(),
          Value<String?> newValue = const Value.absent(),
          DateTime? createdAt}) =>
      AuditEntry(
        id: id ?? this.id,
        action: action ?? this.action,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        previousValue:
            previousValue.present ? previousValue.value : this.previousValue,
        newValue: newValue.present ? newValue.value : this.newValue,
        createdAt: createdAt ?? this.createdAt,
      );
  AuditEntry copyWithCompanion(AuditEntriesCompanion data) {
    return AuditEntry(
      id: data.id.present ? data.id.value : this.id,
      action: data.action.present ? data.action.value : this.action,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      previousValue: data.previousValue.present
          ? data.previousValue.value
          : this.previousValue,
      newValue: data.newValue.present ? data.newValue.value : this.newValue,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditEntry(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('previousValue: $previousValue, ')
          ..write('newValue: $newValue, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, action, entityType, entityId, previousValue, newValue, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditEntry &&
          other.id == this.id &&
          other.action == this.action &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.previousValue == this.previousValue &&
          other.newValue == this.newValue &&
          other.createdAt == this.createdAt);
}

class AuditEntriesCompanion extends UpdateCompanion<AuditEntry> {
  final Value<String> id;
  final Value<int> action;
  final Value<int> entityType;
  final Value<String> entityId;
  final Value<String?> previousValue;
  final Value<String?> newValue;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AuditEntriesCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.previousValue = const Value.absent(),
    this.newValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditEntriesCompanion.insert({
    required String id,
    required int action,
    required int entityType,
    required String entityId,
    this.previousValue = const Value.absent(),
    this.newValue = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        action = Value(action),
        entityType = Value(entityType),
        entityId = Value(entityId),
        createdAt = Value(createdAt);
  static Insertable<AuditEntry> custom({
    Expression<String>? id,
    Expression<int>? action,
    Expression<int>? entityType,
    Expression<String>? entityId,
    Expression<String>? previousValue,
    Expression<String>? newValue,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (previousValue != null) 'previous_value': previousValue,
      if (newValue != null) 'new_value': newValue,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditEntriesCompanion copyWith(
      {Value<String>? id,
      Value<int>? action,
      Value<int>? entityType,
      Value<String>? entityId,
      Value<String?>? previousValue,
      Value<String?>? newValue,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return AuditEntriesCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      previousValue: previousValue ?? this.previousValue,
      newValue: newValue ?? this.newValue,
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
    if (action.present) {
      map['action'] = Variable<int>(action.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<int>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (previousValue.present) {
      map['previous_value'] = Variable<String>(previousValue.value);
    }
    if (newValue.present) {
      map['new_value'] = Variable<String>(newValue.value);
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
    return (StringBuffer('AuditEntriesCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('previousValue: $previousValue, ')
          ..write('newValue: $newValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
      'sale_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sales (id)'));
  static const VerificationMeta _outstandingAmountMeta =
      const VerificationMeta('outstandingAmount');
  @override
  late final GeneratedColumn<double> outstandingAmount =
      GeneratedColumn<double>('outstanding_amount', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _scheduledAtMeta =
      const VerificationMeta('scheduledAt');
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
      'scheduled_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
      'sent_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        customerId,
        saleId,
        outstandingAmount,
        scheduledAt,
        sentAt,
        status,
        message,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(Insertable<Reminder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('sale_id')) {
      context.handle(_saleIdMeta,
          saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta));
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('outstanding_amount')) {
      context.handle(
          _outstandingAmountMeta,
          outstandingAmount.isAcceptableOrUnknown(
              data['outstanding_amount']!, _outstandingAmountMeta));
    } else if (isInserting) {
      context.missing(_outstandingAmountMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
          _scheduledAtMeta,
          scheduledAt.isAcceptableOrUnknown(
              data['scheduled_at']!, _scheduledAtMeta));
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('sent_at')) {
      context.handle(_sentAtMeta,
          sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id'])!,
      saleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sale_id'])!,
      outstandingAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}outstanding_amount'])!,
      scheduledAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}scheduled_at'])!,
      sentAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}sent_at']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final String id;
  final String customerId;
  final String saleId;
  final double outstandingAmount;
  final DateTime scheduledAt;
  final DateTime? sentAt;

  /// Maps to ReminderStatus enum. Conversion handled in DAO/repository layer.
  final int status;
  final String? message;
  final DateTime createdAt;
  const Reminder(
      {required this.id,
      required this.customerId,
      required this.saleId,
      required this.outstandingAmount,
      required this.scheduledAt,
      this.sentAt,
      required this.status,
      this.message,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['customer_id'] = Variable<String>(customerId);
    map['sale_id'] = Variable<String>(saleId);
    map['outstanding_amount'] = Variable<double>(outstandingAmount);
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    if (!nullToAbsent || sentAt != null) {
      map['sent_at'] = Variable<DateTime>(sentAt);
    }
    map['status'] = Variable<int>(status);
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String>(message);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      customerId: Value(customerId),
      saleId: Value(saleId),
      outstandingAmount: Value(outstandingAmount),
      scheduledAt: Value(scheduledAt),
      sentAt:
          sentAt == null && nullToAbsent ? const Value.absent() : Value(sentAt),
      status: Value(status),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      createdAt: Value(createdAt),
    );
  }

  factory Reminder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<String>(json['id']),
      customerId: serializer.fromJson<String>(json['customerId']),
      saleId: serializer.fromJson<String>(json['saleId']),
      outstandingAmount: serializer.fromJson<double>(json['outstandingAmount']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      sentAt: serializer.fromJson<DateTime?>(json['sentAt']),
      status: serializer.fromJson<int>(json['status']),
      message: serializer.fromJson<String?>(json['message']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'customerId': serializer.toJson<String>(customerId),
      'saleId': serializer.toJson<String>(saleId),
      'outstandingAmount': serializer.toJson<double>(outstandingAmount),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'sentAt': serializer.toJson<DateTime?>(sentAt),
      'status': serializer.toJson<int>(status),
      'message': serializer.toJson<String?>(message),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Reminder copyWith(
          {String? id,
          String? customerId,
          String? saleId,
          double? outstandingAmount,
          DateTime? scheduledAt,
          Value<DateTime?> sentAt = const Value.absent(),
          int? status,
          Value<String?> message = const Value.absent(),
          DateTime? createdAt}) =>
      Reminder(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        saleId: saleId ?? this.saleId,
        outstandingAmount: outstandingAmount ?? this.outstandingAmount,
        scheduledAt: scheduledAt ?? this.scheduledAt,
        sentAt: sentAt.present ? sentAt.value : this.sentAt,
        status: status ?? this.status,
        message: message.present ? message.value : this.message,
        createdAt: createdAt ?? this.createdAt,
      );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      outstandingAmount: data.outstandingAmount.present
          ? data.outstandingAmount.value
          : this.outstandingAmount,
      scheduledAt:
          data.scheduledAt.present ? data.scheduledAt.value : this.scheduledAt,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      status: data.status.present ? data.status.value : this.status,
      message: data.message.present ? data.message.value : this.message,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('saleId: $saleId, ')
          ..write('outstandingAmount: $outstandingAmount, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('sentAt: $sentAt, ')
          ..write('status: $status, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, customerId, saleId, outstandingAmount,
      scheduledAt, sentAt, status, message, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.saleId == this.saleId &&
          other.outstandingAmount == this.outstandingAmount &&
          other.scheduledAt == this.scheduledAt &&
          other.sentAt == this.sentAt &&
          other.status == this.status &&
          other.message == this.message &&
          other.createdAt == this.createdAt);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<String> id;
  final Value<String> customerId;
  final Value<String> saleId;
  final Value<double> outstandingAmount;
  final Value<DateTime> scheduledAt;
  final Value<DateTime?> sentAt;
  final Value<int> status;
  final Value<String?> message;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.saleId = const Value.absent(),
    this.outstandingAmount = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.status = const Value.absent(),
    this.message = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    required String id,
    required String customerId,
    required String saleId,
    required double outstandingAmount,
    required DateTime scheduledAt,
    this.sentAt = const Value.absent(),
    required int status,
    this.message = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        customerId = Value(customerId),
        saleId = Value(saleId),
        outstandingAmount = Value(outstandingAmount),
        scheduledAt = Value(scheduledAt),
        status = Value(status),
        createdAt = Value(createdAt);
  static Insertable<Reminder> custom({
    Expression<String>? id,
    Expression<String>? customerId,
    Expression<String>? saleId,
    Expression<double>? outstandingAmount,
    Expression<DateTime>? scheduledAt,
    Expression<DateTime>? sentAt,
    Expression<int>? status,
    Expression<String>? message,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (saleId != null) 'sale_id': saleId,
      if (outstandingAmount != null) 'outstanding_amount': outstandingAmount,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (sentAt != null) 'sent_at': sentAt,
      if (status != null) 'status': status,
      if (message != null) 'message': message,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith(
      {Value<String>? id,
      Value<String>? customerId,
      Value<String>? saleId,
      Value<double>? outstandingAmount,
      Value<DateTime>? scheduledAt,
      Value<DateTime?>? sentAt,
      Value<int>? status,
      Value<String?>? message,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return RemindersCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      saleId: saleId ?? this.saleId,
      outstandingAmount: outstandingAmount ?? this.outstandingAmount,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      sentAt: sentAt ?? this.sentAt,
      status: status ?? this.status,
      message: message ?? this.message,
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
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (outstandingAmount.present) {
      map['outstanding_amount'] = Variable<double>(outstandingAmount.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
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
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('saleId: $saleId, ')
          ..write('outstandingAmount: $outstandingAmount, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('sentAt: $sentAt, ')
          ..write('status: $status, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AdminEntriesTable adminEntries = $AdminEntriesTable(this);
  late final $BusinessEntriesTable businessEntries =
      $BusinessEntriesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $SaleItemsTable saleItems = $SaleItemsTable(this);
  late final $PurchasesTable purchases = $PurchasesTable(this);
  late final $PurchaseItemsTable purchaseItems = $PurchaseItemsTable(this);
  late final $SupplierPaymentsTable supplierPayments =
      $SupplierPaymentsTable(this);
  late final $CustomerPaymentsTable customerPayments =
      $CustomerPaymentsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $StockTransactionsTable stockTransactions =
      $StockTransactionsTable(this);
  late final $CashEntriesTable cashEntries = $CashEntriesTable(this);
  late final $CashClosingsTable cashClosings = $CashClosingsTable(this);
  late final $ReceiptsTable receipts = $ReceiptsTable(this);
  late final $ReceiptSettingsTable receiptSettings =
      $ReceiptSettingsTable(this);
  late final $AuditEntriesTable auditEntries = $AuditEntriesTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        adminEntries,
        businessEntries,
        appSettings,
        categories,
        suppliers,
        products,
        customers,
        sales,
        saleItems,
        purchases,
        purchaseItems,
        supplierPayments,
        customerPayments,
        expenses,
        stockTransactions,
        cashEntries,
        cashClosings,
        receipts,
        receiptSettings,
        auditEntries,
        reminders
      ];
}

typedef $$AdminEntriesTableCreateCompanionBuilder = AdminEntriesCompanion
    Function({
  required String id,
  required String pinHash,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$AdminEntriesTableUpdateCompanionBuilder = AdminEntriesCompanion
    Function({
  Value<String> id,
  Value<String> pinHash,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$AdminEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AdminEntriesTable,
    AdminEntry,
    $$AdminEntriesTableFilterComposer,
    $$AdminEntriesTableOrderingComposer,
    $$AdminEntriesTableCreateCompanionBuilder,
    $$AdminEntriesTableUpdateCompanionBuilder> {
  $$AdminEntriesTableTableManager(_$AppDatabase db, $AdminEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AdminEntriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AdminEntriesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> pinHash = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AdminEntriesCompanion(
            id: id,
            pinHash: pinHash,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String pinHash,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AdminEntriesCompanion.insert(
            id: id,
            pinHash: pinHash,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$AdminEntriesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AdminEntriesTable> {
  $$AdminEntriesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get pinHash => $state.composableBuilder(
      column: $state.table.pinHash,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AdminEntriesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AdminEntriesTable> {
  $$AdminEntriesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get pinHash => $state.composableBuilder(
      column: $state.table.pinHash,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$BusinessEntriesTableCreateCompanionBuilder = BusinessEntriesCompanion
    Function({
  required String id,
  required String name,
  Value<String?> logoPath,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<String> currency,
  Value<double> openingCash,
  Value<double> openingBank,
  Value<bool> isSetupComplete,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$BusinessEntriesTableUpdateCompanionBuilder = BusinessEntriesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> logoPath,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<String> currency,
  Value<double> openingCash,
  Value<double> openingBank,
  Value<bool> isSetupComplete,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$BusinessEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BusinessEntriesTable,
    BusinessEntry,
    $$BusinessEntriesTableFilterComposer,
    $$BusinessEntriesTableOrderingComposer,
    $$BusinessEntriesTableCreateCompanionBuilder,
    $$BusinessEntriesTableUpdateCompanionBuilder> {
  $$BusinessEntriesTableTableManager(
      _$AppDatabase db, $BusinessEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BusinessEntriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$BusinessEntriesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> logoPath = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<double> openingCash = const Value.absent(),
            Value<double> openingBank = const Value.absent(),
            Value<bool> isSetupComplete = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BusinessEntriesCompanion(
            id: id,
            name: name,
            logoPath: logoPath,
            phone: phone,
            email: email,
            address: address,
            currency: currency,
            openingCash: openingCash,
            openingBank: openingBank,
            isSetupComplete: isSetupComplete,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> logoPath = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<double> openingCash = const Value.absent(),
            Value<double> openingBank = const Value.absent(),
            Value<bool> isSetupComplete = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              BusinessEntriesCompanion.insert(
            id: id,
            name: name,
            logoPath: logoPath,
            phone: phone,
            email: email,
            address: address,
            currency: currency,
            openingCash: openingCash,
            openingBank: openingBank,
            isSetupComplete: isSetupComplete,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$BusinessEntriesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $BusinessEntriesTable> {
  $$BusinessEntriesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get logoPath => $state.composableBuilder(
      column: $state.table.logoPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get email => $state.composableBuilder(
      column: $state.table.email,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get currency => $state.composableBuilder(
      column: $state.table.currency,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get openingCash => $state.composableBuilder(
      column: $state.table.openingCash,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get openingBank => $state.composableBuilder(
      column: $state.table.openingBank,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isSetupComplete => $state.composableBuilder(
      column: $state.table.isSetupComplete,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$BusinessEntriesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $BusinessEntriesTable> {
  $$BusinessEntriesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get logoPath => $state.composableBuilder(
      column: $state.table.logoPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get email => $state.composableBuilder(
      column: $state.table.email,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get currency => $state.composableBuilder(
      column: $state.table.currency,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get openingCash => $state.composableBuilder(
      column: $state.table.openingCash,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get openingBank => $state.composableBuilder(
      column: $state.table.openingBank,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isSetupComplete => $state.composableBuilder(
      column: $state.table.isSetupComplete,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$AppSettingsTableCreateCompanionBuilder = AppSettingsCompanion
    Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$AppSettingsTableUpdateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$AppSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder> {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AppSettingsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AppSettingsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
        ));
}

class $$AppSettingsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer(super.$state);
  ColumnFilters<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AppSettingsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CategoriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CategoriesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
        ));
}

class $$CategoriesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter productsRefs(
      ComposableFilter Function($$ProductsTableFilterComposer f) f) {
    final $$ProductsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableFilterComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SuppliersTableCreateCompanionBuilder = SuppliersCompanion Function({
  required String id,
  required String name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<String?> notes,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SuppliersTableUpdateCompanionBuilder = SuppliersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SuppliersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SuppliersTable,
    Supplier,
    $$SuppliersTableFilterComposer,
    $$SuppliersTableOrderingComposer,
    $$SuppliersTableCreateCompanionBuilder,
    $$SuppliersTableUpdateCompanionBuilder> {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SuppliersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SuppliersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SuppliersCompanion(
            id: id,
            name: name,
            phone: phone,
            email: email,
            address: address,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SuppliersCompanion.insert(
            id: id,
            name: name,
            phone: phone,
            email: email,
            address: address,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$SuppliersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get email => $state.composableBuilder(
      column: $state.table.email,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter productsRefs(
      ComposableFilter Function($$ProductsTableFilterComposer f) f) {
    final $$ProductsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.supplierId,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableFilterComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter purchasesRefs(
      ComposableFilter Function($$PurchasesTableFilterComposer f) f) {
    final $$PurchasesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.purchases,
        getReferencedColumn: (t) => t.supplierId,
        builder: (joinBuilder, parentComposers) =>
            $$PurchasesTableFilterComposer(ComposerState(
                $state.db, $state.db.purchases, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter supplierPaymentsRefs(
      ComposableFilter Function($$SupplierPaymentsTableFilterComposer f) f) {
    final $$SupplierPaymentsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.supplierPayments,
            getReferencedColumn: (t) => t.supplierId,
            builder: (joinBuilder, parentComposers) =>
                $$SupplierPaymentsTableFilterComposer(ComposerState($state.db,
                    $state.db.supplierPayments, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$SuppliersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get email => $state.composableBuilder(
      column: $state.table.email,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  required String id,
  required String name,
  Value<String?> sku,
  Value<String?> barcode,
  Value<String?> categoryId,
  required double purchasePrice,
  required double sellingPrice,
  Value<double> quantity,
  Value<int> minStock,
  Value<String?> supplierId,
  Value<String?> imagePath,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> sku,
  Value<String?> barcode,
  Value<String?> categoryId,
  Value<double> purchasePrice,
  Value<double> sellingPrice,
  Value<double> quantity,
  Value<int> minStock,
  Value<String?> supplierId,
  Value<String?> imagePath,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ProductsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder> {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ProductsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ProductsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<String?> barcode = const Value.absent(),
            Value<String?> categoryId = const Value.absent(),
            Value<double> purchasePrice = const Value.absent(),
            Value<double> sellingPrice = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<int> minStock = const Value.absent(),
            Value<String?> supplierId = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsCompanion(
            id: id,
            name: name,
            sku: sku,
            barcode: barcode,
            categoryId: categoryId,
            purchasePrice: purchasePrice,
            sellingPrice: sellingPrice,
            quantity: quantity,
            minStock: minStock,
            supplierId: supplierId,
            imagePath: imagePath,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> sku = const Value.absent(),
            Value<String?> barcode = const Value.absent(),
            Value<String?> categoryId = const Value.absent(),
            required double purchasePrice,
            required double sellingPrice,
            Value<double> quantity = const Value.absent(),
            Value<int> minStock = const Value.absent(),
            Value<String?> supplierId = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsCompanion.insert(
            id: id,
            name: name,
            sku: sku,
            barcode: barcode,
            categoryId: categoryId,
            purchasePrice: purchasePrice,
            sellingPrice: sellingPrice,
            quantity: quantity,
            minStock: minStock,
            supplierId: supplierId,
            imagePath: imagePath,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$ProductsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sku => $state.composableBuilder(
      column: $state.table.sku,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get barcode => $state.composableBuilder(
      column: $state.table.barcode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get purchasePrice => $state.composableBuilder(
      column: $state.table.purchasePrice,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get sellingPrice => $state.composableBuilder(
      column: $state.table.sellingPrice,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get minStock => $state.composableBuilder(
      column: $state.table.minStock,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get imagePath => $state.composableBuilder(
      column: $state.table.imagePath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $state.db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CategoriesTableFilterComposer(ComposerState($state.db,
                $state.db.categories, joinBuilder, parentComposers)));
    return composer;
  }

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $state.db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SuppliersTableFilterComposer(ComposerState(
                $state.db, $state.db.suppliers, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter saleItemsRefs(
      ComposableFilter Function($$SaleItemsTableFilterComposer f) f) {
    final $$SaleItemsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.saleItems,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, parentComposers) =>
            $$SaleItemsTableFilterComposer(ComposerState(
                $state.db, $state.db.saleItems, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter purchaseItemsRefs(
      ComposableFilter Function($$PurchaseItemsTableFilterComposer f) f) {
    final $$PurchaseItemsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.purchaseItems,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder, parentComposers) =>
            $$PurchaseItemsTableFilterComposer(ComposerState($state.db,
                $state.db.purchaseItems, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter stockTransactionsRefs(
      ComposableFilter Function($$StockTransactionsTableFilterComposer f) f) {
    final $$StockTransactionsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.stockTransactions,
            getReferencedColumn: (t) => t.productId,
            builder: (joinBuilder, parentComposers) =>
                $$StockTransactionsTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.stockTransactions,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sku => $state.composableBuilder(
      column: $state.table.sku,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get barcode => $state.composableBuilder(
      column: $state.table.barcode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get purchasePrice => $state.composableBuilder(
      column: $state.table.purchasePrice,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get sellingPrice => $state.composableBuilder(
      column: $state.table.sellingPrice,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get minStock => $state.composableBuilder(
      column: $state.table.minStock,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get imagePath => $state.composableBuilder(
      column: $state.table.imagePath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $state.db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CategoriesTableOrderingComposer(ComposerState($state.db,
                $state.db.categories, joinBuilder, parentComposers)));
    return composer;
  }

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $state.db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SuppliersTableOrderingComposer(ComposerState(
                $state.db, $state.db.suppliers, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$CustomersTableCreateCompanionBuilder = CustomersCompanion Function({
  required String id,
  required String name,
  Value<String?> phone,
  Value<String?> address,
  Value<String?> notes,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> phone,
  Value<String?> address,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$CustomersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder> {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CustomersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CustomersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomersCompanion(
            id: id,
            name: name,
            phone: phone,
            address: address,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomersCompanion.insert(
            id: id,
            name: name,
            phone: phone,
            address: address,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$CustomersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter salesRefs(
      ComposableFilter Function($$SalesTableFilterComposer f) f) {
    final $$SalesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.sales,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder, parentComposers) => $$SalesTableFilterComposer(
            ComposerState(
                $state.db, $state.db.sales, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter customerPaymentsRefs(
      ComposableFilter Function($$CustomerPaymentsTableFilterComposer f) f) {
    final $$CustomerPaymentsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.customerPayments,
            getReferencedColumn: (t) => t.customerId,
            builder: (joinBuilder, parentComposers) =>
                $$CustomerPaymentsTableFilterComposer(ComposerState($state.db,
                    $state.db.customerPayments, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter remindersRefs(
      ComposableFilter Function($$RemindersTableFilterComposer f) f) {
    final $$RemindersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.reminders,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder, parentComposers) =>
            $$RemindersTableFilterComposer(ComposerState(
                $state.db, $state.db.reminders, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SalesTableCreateCompanionBuilder = SalesCompanion Function({
  required String id,
  Value<String?> receiptId,
  Value<String?> customerId,
  required double total,
  Value<double> discount,
  Value<double> amountReceived,
  required int paymentMethod,
  required int paymentStatus,
  required int saleType,
  Value<DateTime?> dueDate,
  Value<String?> notes,
  Value<bool> isVoided,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SalesTableUpdateCompanionBuilder = SalesCompanion Function({
  Value<String> id,
  Value<String?> receiptId,
  Value<String?> customerId,
  Value<double> total,
  Value<double> discount,
  Value<double> amountReceived,
  Value<int> paymentMethod,
  Value<int> paymentStatus,
  Value<int> saleType,
  Value<DateTime?> dueDate,
  Value<String?> notes,
  Value<bool> isVoided,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SalesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SalesTable,
    Sale,
    $$SalesTableFilterComposer,
    $$SalesTableOrderingComposer,
    $$SalesTableCreateCompanionBuilder,
    $$SalesTableUpdateCompanionBuilder> {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SalesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SalesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> receiptId = const Value.absent(),
            Value<String?> customerId = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<double> discount = const Value.absent(),
            Value<double> amountReceived = const Value.absent(),
            Value<int> paymentMethod = const Value.absent(),
            Value<int> paymentStatus = const Value.absent(),
            Value<int> saleType = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isVoided = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SalesCompanion(
            id: id,
            receiptId: receiptId,
            customerId: customerId,
            total: total,
            discount: discount,
            amountReceived: amountReceived,
            paymentMethod: paymentMethod,
            paymentStatus: paymentStatus,
            saleType: saleType,
            dueDate: dueDate,
            notes: notes,
            isVoided: isVoided,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> receiptId = const Value.absent(),
            Value<String?> customerId = const Value.absent(),
            required double total,
            Value<double> discount = const Value.absent(),
            Value<double> amountReceived = const Value.absent(),
            required int paymentMethod,
            required int paymentStatus,
            required int saleType,
            Value<DateTime?> dueDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isVoided = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SalesCompanion.insert(
            id: id,
            receiptId: receiptId,
            customerId: customerId,
            total: total,
            discount: discount,
            amountReceived: amountReceived,
            paymentMethod: paymentMethod,
            paymentStatus: paymentStatus,
            saleType: saleType,
            dueDate: dueDate,
            notes: notes,
            isVoided: isVoided,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$SalesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get receiptId => $state.composableBuilder(
      column: $state.table.receiptId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get discount => $state.composableBuilder(
      column: $state.table.discount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amountReceived => $state.composableBuilder(
      column: $state.table.amountReceived,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get paymentStatus => $state.composableBuilder(
      column: $state.table.paymentStatus,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get saleType => $state.composableBuilder(
      column: $state.table.saleType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dueDate => $state.composableBuilder(
      column: $state.table.dueDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isVoided => $state.composableBuilder(
      column: $state.table.isVoided,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableFilterComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter saleItemsRefs(
      ComposableFilter Function($$SaleItemsTableFilterComposer f) f) {
    final $$SaleItemsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.saleItems,
        getReferencedColumn: (t) => t.saleId,
        builder: (joinBuilder, parentComposers) =>
            $$SaleItemsTableFilterComposer(ComposerState(
                $state.db, $state.db.saleItems, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter customerPaymentsRefs(
      ComposableFilter Function($$CustomerPaymentsTableFilterComposer f) f) {
    final $$CustomerPaymentsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.customerPayments,
            getReferencedColumn: (t) => t.saleId,
            builder: (joinBuilder, parentComposers) =>
                $$CustomerPaymentsTableFilterComposer(ComposerState($state.db,
                    $state.db.customerPayments, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter remindersRefs(
      ComposableFilter Function($$RemindersTableFilterComposer f) f) {
    final $$RemindersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.reminders,
        getReferencedColumn: (t) => t.saleId,
        builder: (joinBuilder, parentComposers) =>
            $$RemindersTableFilterComposer(ComposerState(
                $state.db, $state.db.reminders, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$SalesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get receiptId => $state.composableBuilder(
      column: $state.table.receiptId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get discount => $state.composableBuilder(
      column: $state.table.discount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amountReceived => $state.composableBuilder(
      column: $state.table.amountReceived,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get paymentStatus => $state.composableBuilder(
      column: $state.table.paymentStatus,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get saleType => $state.composableBuilder(
      column: $state.table.saleType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dueDate => $state.composableBuilder(
      column: $state.table.dueDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isVoided => $state.composableBuilder(
      column: $state.table.isVoided,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableOrderingComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$SaleItemsTableCreateCompanionBuilder = SaleItemsCompanion Function({
  required String id,
  required String saleId,
  required String productId,
  required double quantity,
  required double unitPrice,
  required double total,
  Value<int> rowid,
});
typedef $$SaleItemsTableUpdateCompanionBuilder = SaleItemsCompanion Function({
  Value<String> id,
  Value<String> saleId,
  Value<String> productId,
  Value<double> quantity,
  Value<double> unitPrice,
  Value<double> total,
  Value<int> rowid,
});

class $$SaleItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SaleItemsTable,
    SaleItem,
    $$SaleItemsTableFilterComposer,
    $$SaleItemsTableOrderingComposer,
    $$SaleItemsTableCreateCompanionBuilder,
    $$SaleItemsTableUpdateCompanionBuilder> {
  $$SaleItemsTableTableManager(_$AppDatabase db, $SaleItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SaleItemsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SaleItemsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> saleId = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<double> unitPrice = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SaleItemsCompanion(
            id: id,
            saleId: saleId,
            productId: productId,
            quantity: quantity,
            unitPrice: unitPrice,
            total: total,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String saleId,
            required String productId,
            required double quantity,
            required double unitPrice,
            required double total,
            Value<int> rowid = const Value.absent(),
          }) =>
              SaleItemsCompanion.insert(
            id: id,
            saleId: saleId,
            productId: productId,
            quantity: quantity,
            unitPrice: unitPrice,
            total: total,
            rowid: rowid,
          ),
        ));
}

class $$SaleItemsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get unitPrice => $state.composableBuilder(
      column: $state.table.unitPrice,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$SalesTableFilterComposer get saleId {
    final $$SalesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.saleId,
        referencedTable: $state.db.sales,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$SalesTableFilterComposer(
            ComposerState(
                $state.db, $state.db.sales, joinBuilder, parentComposers)));
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableFilterComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$SaleItemsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get unitPrice => $state.composableBuilder(
      column: $state.table.unitPrice,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$SalesTableOrderingComposer get saleId {
    final $$SalesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.saleId,
        referencedTable: $state.db.sales,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$SalesTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.sales, joinBuilder, parentComposers)));
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableOrderingComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$PurchasesTableCreateCompanionBuilder = PurchasesCompanion Function({
  required String id,
  required String supplierId,
  Value<String?> receiptId,
  required double total,
  Value<double> discount,
  Value<double> amountPaid,
  required int paymentMethod,
  required int paymentStatus,
  Value<String?> notes,
  Value<bool> isVoided,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$PurchasesTableUpdateCompanionBuilder = PurchasesCompanion Function({
  Value<String> id,
  Value<String> supplierId,
  Value<String?> receiptId,
  Value<double> total,
  Value<double> discount,
  Value<double> amountPaid,
  Value<int> paymentMethod,
  Value<int> paymentStatus,
  Value<String?> notes,
  Value<bool> isVoided,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$PurchasesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PurchasesTable,
    Purchase,
    $$PurchasesTableFilterComposer,
    $$PurchasesTableOrderingComposer,
    $$PurchasesTableCreateCompanionBuilder,
    $$PurchasesTableUpdateCompanionBuilder> {
  $$PurchasesTableTableManager(_$AppDatabase db, $PurchasesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PurchasesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PurchasesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> supplierId = const Value.absent(),
            Value<String?> receiptId = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<double> discount = const Value.absent(),
            Value<double> amountPaid = const Value.absent(),
            Value<int> paymentMethod = const Value.absent(),
            Value<int> paymentStatus = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isVoided = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PurchasesCompanion(
            id: id,
            supplierId: supplierId,
            receiptId: receiptId,
            total: total,
            discount: discount,
            amountPaid: amountPaid,
            paymentMethod: paymentMethod,
            paymentStatus: paymentStatus,
            notes: notes,
            isVoided: isVoided,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String supplierId,
            Value<String?> receiptId = const Value.absent(),
            required double total,
            Value<double> discount = const Value.absent(),
            Value<double> amountPaid = const Value.absent(),
            required int paymentMethod,
            required int paymentStatus,
            Value<String?> notes = const Value.absent(),
            Value<bool> isVoided = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PurchasesCompanion.insert(
            id: id,
            supplierId: supplierId,
            receiptId: receiptId,
            total: total,
            discount: discount,
            amountPaid: amountPaid,
            paymentMethod: paymentMethod,
            paymentStatus: paymentStatus,
            notes: notes,
            isVoided: isVoided,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$PurchasesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get receiptId => $state.composableBuilder(
      column: $state.table.receiptId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get discount => $state.composableBuilder(
      column: $state.table.discount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amountPaid => $state.composableBuilder(
      column: $state.table.amountPaid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get paymentStatus => $state.composableBuilder(
      column: $state.table.paymentStatus,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isVoided => $state.composableBuilder(
      column: $state.table.isVoided,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $state.db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SuppliersTableFilterComposer(ComposerState(
                $state.db, $state.db.suppliers, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter purchaseItemsRefs(
      ComposableFilter Function($$PurchaseItemsTableFilterComposer f) f) {
    final $$PurchaseItemsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.purchaseItems,
        getReferencedColumn: (t) => t.purchaseId,
        builder: (joinBuilder, parentComposers) =>
            $$PurchaseItemsTableFilterComposer(ComposerState($state.db,
                $state.db.purchaseItems, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$PurchasesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get receiptId => $state.composableBuilder(
      column: $state.table.receiptId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get discount => $state.composableBuilder(
      column: $state.table.discount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amountPaid => $state.composableBuilder(
      column: $state.table.amountPaid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get paymentStatus => $state.composableBuilder(
      column: $state.table.paymentStatus,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isVoided => $state.composableBuilder(
      column: $state.table.isVoided,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $state.db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SuppliersTableOrderingComposer(ComposerState(
                $state.db, $state.db.suppliers, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$PurchaseItemsTableCreateCompanionBuilder = PurchaseItemsCompanion
    Function({
  required String id,
  required String purchaseId,
  required String productId,
  required double quantity,
  required double unitPrice,
  required double total,
  Value<int> rowid,
});
typedef $$PurchaseItemsTableUpdateCompanionBuilder = PurchaseItemsCompanion
    Function({
  Value<String> id,
  Value<String> purchaseId,
  Value<String> productId,
  Value<double> quantity,
  Value<double> unitPrice,
  Value<double> total,
  Value<int> rowid,
});

class $$PurchaseItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PurchaseItemsTable,
    PurchaseItem,
    $$PurchaseItemsTableFilterComposer,
    $$PurchaseItemsTableOrderingComposer,
    $$PurchaseItemsTableCreateCompanionBuilder,
    $$PurchaseItemsTableUpdateCompanionBuilder> {
  $$PurchaseItemsTableTableManager(_$AppDatabase db, $PurchaseItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PurchaseItemsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PurchaseItemsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> purchaseId = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<double> unitPrice = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PurchaseItemsCompanion(
            id: id,
            purchaseId: purchaseId,
            productId: productId,
            quantity: quantity,
            unitPrice: unitPrice,
            total: total,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String purchaseId,
            required String productId,
            required double quantity,
            required double unitPrice,
            required double total,
            Value<int> rowid = const Value.absent(),
          }) =>
              PurchaseItemsCompanion.insert(
            id: id,
            purchaseId: purchaseId,
            productId: productId,
            quantity: quantity,
            unitPrice: unitPrice,
            total: total,
            rowid: rowid,
          ),
        ));
}

class $$PurchaseItemsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get unitPrice => $state.composableBuilder(
      column: $state.table.unitPrice,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$PurchasesTableFilterComposer get purchaseId {
    final $$PurchasesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.purchaseId,
        referencedTable: $state.db.purchases,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PurchasesTableFilterComposer(ComposerState(
                $state.db, $state.db.purchases, joinBuilder, parentComposers)));
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableFilterComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PurchaseItemsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get unitPrice => $state.composableBuilder(
      column: $state.table.unitPrice,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$PurchasesTableOrderingComposer get purchaseId {
    final $$PurchasesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.purchaseId,
        referencedTable: $state.db.purchases,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PurchasesTableOrderingComposer(ComposerState(
                $state.db, $state.db.purchases, joinBuilder, parentComposers)));
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableOrderingComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$SupplierPaymentsTableCreateCompanionBuilder
    = SupplierPaymentsCompanion Function({
  required String id,
  required String supplierId,
  required double amount,
  required int paymentMethod,
  Value<String?> reference,
  Value<String?> notes,
  Value<bool> isVoided,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SupplierPaymentsTableUpdateCompanionBuilder
    = SupplierPaymentsCompanion Function({
  Value<String> id,
  Value<String> supplierId,
  Value<double> amount,
  Value<int> paymentMethod,
  Value<String?> reference,
  Value<String?> notes,
  Value<bool> isVoided,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SupplierPaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SupplierPaymentsTable,
    SupplierPayment,
    $$SupplierPaymentsTableFilterComposer,
    $$SupplierPaymentsTableOrderingComposer,
    $$SupplierPaymentsTableCreateCompanionBuilder,
    $$SupplierPaymentsTableUpdateCompanionBuilder> {
  $$SupplierPaymentsTableTableManager(
      _$AppDatabase db, $SupplierPaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SupplierPaymentsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SupplierPaymentsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> supplierId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<int> paymentMethod = const Value.absent(),
            Value<String?> reference = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isVoided = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SupplierPaymentsCompanion(
            id: id,
            supplierId: supplierId,
            amount: amount,
            paymentMethod: paymentMethod,
            reference: reference,
            notes: notes,
            isVoided: isVoided,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String supplierId,
            required double amount,
            required int paymentMethod,
            Value<String?> reference = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isVoided = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SupplierPaymentsCompanion.insert(
            id: id,
            supplierId: supplierId,
            amount: amount,
            paymentMethod: paymentMethod,
            reference: reference,
            notes: notes,
            isVoided: isVoided,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$SupplierPaymentsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SupplierPaymentsTable> {
  $$SupplierPaymentsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get reference => $state.composableBuilder(
      column: $state.table.reference,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isVoided => $state.composableBuilder(
      column: $state.table.isVoided,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $state.db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SuppliersTableFilterComposer(ComposerState(
                $state.db, $state.db.suppliers, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$SupplierPaymentsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SupplierPaymentsTable> {
  $$SupplierPaymentsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get reference => $state.composableBuilder(
      column: $state.table.reference,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isVoided => $state.composableBuilder(
      column: $state.table.isVoided,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.supplierId,
        referencedTable: $state.db.suppliers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SuppliersTableOrderingComposer(ComposerState(
                $state.db, $state.db.suppliers, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$CustomerPaymentsTableCreateCompanionBuilder
    = CustomerPaymentsCompanion Function({
  required String id,
  required String customerId,
  Value<String?> saleId,
  required double amount,
  required int paymentMethod,
  Value<String?> reference,
  Value<String?> notes,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$CustomerPaymentsTableUpdateCompanionBuilder
    = CustomerPaymentsCompanion Function({
  Value<String> id,
  Value<String> customerId,
  Value<String?> saleId,
  Value<double> amount,
  Value<int> paymentMethod,
  Value<String?> reference,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$CustomerPaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomerPaymentsTable,
    CustomerPayment,
    $$CustomerPaymentsTableFilterComposer,
    $$CustomerPaymentsTableOrderingComposer,
    $$CustomerPaymentsTableCreateCompanionBuilder,
    $$CustomerPaymentsTableUpdateCompanionBuilder> {
  $$CustomerPaymentsTableTableManager(
      _$AppDatabase db, $CustomerPaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CustomerPaymentsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CustomerPaymentsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> customerId = const Value.absent(),
            Value<String?> saleId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<int> paymentMethod = const Value.absent(),
            Value<String?> reference = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomerPaymentsCompanion(
            id: id,
            customerId: customerId,
            saleId: saleId,
            amount: amount,
            paymentMethod: paymentMethod,
            reference: reference,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String customerId,
            Value<String?> saleId = const Value.absent(),
            required double amount,
            required int paymentMethod,
            Value<String?> reference = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomerPaymentsCompanion.insert(
            id: id,
            customerId: customerId,
            saleId: saleId,
            amount: amount,
            paymentMethod: paymentMethod,
            reference: reference,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$CustomerPaymentsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CustomerPaymentsTable> {
  $$CustomerPaymentsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get reference => $state.composableBuilder(
      column: $state.table.reference,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableFilterComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }

  $$SalesTableFilterComposer get saleId {
    final $$SalesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.saleId,
        referencedTable: $state.db.sales,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$SalesTableFilterComposer(
            ComposerState(
                $state.db, $state.db.sales, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$CustomerPaymentsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CustomerPaymentsTable> {
  $$CustomerPaymentsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get reference => $state.composableBuilder(
      column: $state.table.reference,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableOrderingComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }

  $$SalesTableOrderingComposer get saleId {
    final $$SalesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.saleId,
        referencedTable: $state.db.sales,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$SalesTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.sales, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  required String id,
  required int category,
  required double amount,
  required String description,
  required int paymentMethod,
  Value<String?> reference,
  Value<bool> isVoided,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<String> id,
  Value<int> category,
  Value<double> amount,
  Value<String> description,
  Value<int> paymentMethod,
  Value<String?> reference,
  Value<bool> isVoided,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$ExpensesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder> {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ExpensesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ExpensesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> category = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<int> paymentMethod = const Value.absent(),
            Value<String?> reference = const Value.absent(),
            Value<bool> isVoided = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesCompanion(
            id: id,
            category: category,
            amount: amount,
            description: description,
            paymentMethod: paymentMethod,
            reference: reference,
            isVoided: isVoided,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int category,
            required double amount,
            required String description,
            required int paymentMethod,
            Value<String?> reference = const Value.absent(),
            Value<bool> isVoided = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesCompanion.insert(
            id: id,
            category: category,
            amount: amount,
            description: description,
            paymentMethod: paymentMethod,
            reference: reference,
            isVoided: isVoided,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$ExpensesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get reference => $state.composableBuilder(
      column: $state.table.reference,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isVoided => $state.composableBuilder(
      column: $state.table.isVoided,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ExpensesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get paymentMethod => $state.composableBuilder(
      column: $state.table.paymentMethod,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get reference => $state.composableBuilder(
      column: $state.table.reference,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isVoided => $state.composableBuilder(
      column: $state.table.isVoided,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$StockTransactionsTableCreateCompanionBuilder
    = StockTransactionsCompanion Function({
  required String id,
  required String productId,
  required int type,
  required double quantity,
  required double unitPrice,
  required double total,
  Value<String?> referenceId,
  Value<String?> reason,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$StockTransactionsTableUpdateCompanionBuilder
    = StockTransactionsCompanion Function({
  Value<String> id,
  Value<String> productId,
  Value<int> type,
  Value<double> quantity,
  Value<double> unitPrice,
  Value<double> total,
  Value<String?> referenceId,
  Value<String?> reason,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$StockTransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StockTransactionsTable,
    StockTransaction,
    $$StockTransactionsTableFilterComposer,
    $$StockTransactionsTableOrderingComposer,
    $$StockTransactionsTableCreateCompanionBuilder,
    $$StockTransactionsTableUpdateCompanionBuilder> {
  $$StockTransactionsTableTableManager(
      _$AppDatabase db, $StockTransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$StockTransactionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$StockTransactionsTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> productId = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<double> unitPrice = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<String?> referenceId = const Value.absent(),
            Value<String?> reason = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StockTransactionsCompanion(
            id: id,
            productId: productId,
            type: type,
            quantity: quantity,
            unitPrice: unitPrice,
            total: total,
            referenceId: referenceId,
            reason: reason,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String productId,
            required int type,
            required double quantity,
            required double unitPrice,
            required double total,
            Value<String?> referenceId = const Value.absent(),
            Value<String?> reason = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              StockTransactionsCompanion.insert(
            id: id,
            productId: productId,
            type: type,
            quantity: quantity,
            unitPrice: unitPrice,
            total: total,
            referenceId: referenceId,
            reason: reason,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$StockTransactionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $StockTransactionsTable> {
  $$StockTransactionsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get unitPrice => $state.composableBuilder(
      column: $state.table.unitPrice,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get referenceId => $state.composableBuilder(
      column: $state.table.referenceId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get reason => $state.composableBuilder(
      column: $state.table.reason,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableFilterComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$StockTransactionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $StockTransactionsTable> {
  $$StockTransactionsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get quantity => $state.composableBuilder(
      column: $state.table.quantity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get unitPrice => $state.composableBuilder(
      column: $state.table.unitPrice,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get referenceId => $state.composableBuilder(
      column: $state.table.referenceId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get reason => $state.composableBuilder(
      column: $state.table.reason,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $state.db.products,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProductsTableOrderingComposer(ComposerState(
                $state.db, $state.db.products, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$CashEntriesTableCreateCompanionBuilder = CashEntriesCompanion
    Function({
  required String id,
  required int type,
  required double amount,
  required String description,
  Value<String?> referenceId,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$CashEntriesTableUpdateCompanionBuilder = CashEntriesCompanion
    Function({
  Value<String> id,
  Value<int> type,
  Value<double> amount,
  Value<String> description,
  Value<String?> referenceId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$CashEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CashEntriesTable,
    CashEntry,
    $$CashEntriesTableFilterComposer,
    $$CashEntriesTableOrderingComposer,
    $$CashEntriesTableCreateCompanionBuilder,
    $$CashEntriesTableUpdateCompanionBuilder> {
  $$CashEntriesTableTableManager(_$AppDatabase db, $CashEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CashEntriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CashEntriesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String?> referenceId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CashEntriesCompanion(
            id: id,
            type: type,
            amount: amount,
            description: description,
            referenceId: referenceId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int type,
            required double amount,
            required String description,
            Value<String?> referenceId = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CashEntriesCompanion.insert(
            id: id,
            type: type,
            amount: amount,
            description: description,
            referenceId: referenceId,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$CashEntriesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CashEntriesTable> {
  $$CashEntriesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get referenceId => $state.composableBuilder(
      column: $state.table.referenceId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CashEntriesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CashEntriesTable> {
  $$CashEntriesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get referenceId => $state.composableBuilder(
      column: $state.table.referenceId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CashClosingsTableCreateCompanionBuilder = CashClosingsCompanion
    Function({
  required String id,
  required DateTime businessDate,
  required double openingBalance,
  required double expectedClosing,
  required double actualClosing,
  required double difference,
  Value<String?> notes,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$CashClosingsTableUpdateCompanionBuilder = CashClosingsCompanion
    Function({
  Value<String> id,
  Value<DateTime> businessDate,
  Value<double> openingBalance,
  Value<double> expectedClosing,
  Value<double> actualClosing,
  Value<double> difference,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$CashClosingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CashClosingsTable,
    CashClosing,
    $$CashClosingsTableFilterComposer,
    $$CashClosingsTableOrderingComposer,
    $$CashClosingsTableCreateCompanionBuilder,
    $$CashClosingsTableUpdateCompanionBuilder> {
  $$CashClosingsTableTableManager(_$AppDatabase db, $CashClosingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CashClosingsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CashClosingsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> businessDate = const Value.absent(),
            Value<double> openingBalance = const Value.absent(),
            Value<double> expectedClosing = const Value.absent(),
            Value<double> actualClosing = const Value.absent(),
            Value<double> difference = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CashClosingsCompanion(
            id: id,
            businessDate: businessDate,
            openingBalance: openingBalance,
            expectedClosing: expectedClosing,
            actualClosing: actualClosing,
            difference: difference,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime businessDate,
            required double openingBalance,
            required double expectedClosing,
            required double actualClosing,
            required double difference,
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CashClosingsCompanion.insert(
            id: id,
            businessDate: businessDate,
            openingBalance: openingBalance,
            expectedClosing: expectedClosing,
            actualClosing: actualClosing,
            difference: difference,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$CashClosingsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CashClosingsTable> {
  $$CashClosingsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get businessDate => $state.composableBuilder(
      column: $state.table.businessDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get openingBalance => $state.composableBuilder(
      column: $state.table.openingBalance,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get expectedClosing => $state.composableBuilder(
      column: $state.table.expectedClosing,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get actualClosing => $state.composableBuilder(
      column: $state.table.actualClosing,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get difference => $state.composableBuilder(
      column: $state.table.difference,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CashClosingsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CashClosingsTable> {
  $$CashClosingsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get businessDate => $state.composableBuilder(
      column: $state.table.businessDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get openingBalance => $state.composableBuilder(
      column: $state.table.openingBalance,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get expectedClosing => $state.composableBuilder(
      column: $state.table.expectedClosing,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get actualClosing => $state.composableBuilder(
      column: $state.table.actualClosing,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get difference => $state.composableBuilder(
      column: $state.table.difference,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ReceiptsTableCreateCompanionBuilder = ReceiptsCompanion Function({
  required String id,
  required String receiptNumber,
  required String transactionId,
  required int type,
  required double total,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$ReceiptsTableUpdateCompanionBuilder = ReceiptsCompanion Function({
  Value<String> id,
  Value<String> receiptNumber,
  Value<String> transactionId,
  Value<int> type,
  Value<double> total,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$ReceiptsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReceiptsTable,
    Receipt,
    $$ReceiptsTableFilterComposer,
    $$ReceiptsTableOrderingComposer,
    $$ReceiptsTableCreateCompanionBuilder,
    $$ReceiptsTableUpdateCompanionBuilder> {
  $$ReceiptsTableTableManager(_$AppDatabase db, $ReceiptsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ReceiptsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ReceiptsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> receiptNumber = const Value.absent(),
            Value<String> transactionId = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<double> total = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReceiptsCompanion(
            id: id,
            receiptNumber: receiptNumber,
            transactionId: transactionId,
            type: type,
            total: total,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String receiptNumber,
            required String transactionId,
            required int type,
            required double total,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ReceiptsCompanion.insert(
            id: id,
            receiptNumber: receiptNumber,
            transactionId: transactionId,
            type: type,
            total: total,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$ReceiptsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get receiptNumber => $state.composableBuilder(
      column: $state.table.receiptNumber,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get transactionId => $state.composableBuilder(
      column: $state.table.transactionId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ReceiptsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get receiptNumber => $state.composableBuilder(
      column: $state.table.receiptNumber,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get transactionId => $state.composableBuilder(
      column: $state.table.transactionId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get total => $state.composableBuilder(
      column: $state.table.total,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ReceiptSettingsTableCreateCompanionBuilder = ReceiptSettingsCompanion
    Function({
  required String id,
  Value<String?> header,
  Value<String?> footer,
  Value<bool> showLogo,
  Value<bool> showBusinessInfo,
  Value<String?> taxLabel,
  Value<double?> taxPercentage,
  Value<int> rowid,
});
typedef $$ReceiptSettingsTableUpdateCompanionBuilder = ReceiptSettingsCompanion
    Function({
  Value<String> id,
  Value<String?> header,
  Value<String?> footer,
  Value<bool> showLogo,
  Value<bool> showBusinessInfo,
  Value<String?> taxLabel,
  Value<double?> taxPercentage,
  Value<int> rowid,
});

class $$ReceiptSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReceiptSettingsTable,
    ReceiptSetting,
    $$ReceiptSettingsTableFilterComposer,
    $$ReceiptSettingsTableOrderingComposer,
    $$ReceiptSettingsTableCreateCompanionBuilder,
    $$ReceiptSettingsTableUpdateCompanionBuilder> {
  $$ReceiptSettingsTableTableManager(
      _$AppDatabase db, $ReceiptSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ReceiptSettingsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ReceiptSettingsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> header = const Value.absent(),
            Value<String?> footer = const Value.absent(),
            Value<bool> showLogo = const Value.absent(),
            Value<bool> showBusinessInfo = const Value.absent(),
            Value<String?> taxLabel = const Value.absent(),
            Value<double?> taxPercentage = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReceiptSettingsCompanion(
            id: id,
            header: header,
            footer: footer,
            showLogo: showLogo,
            showBusinessInfo: showBusinessInfo,
            taxLabel: taxLabel,
            taxPercentage: taxPercentage,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> header = const Value.absent(),
            Value<String?> footer = const Value.absent(),
            Value<bool> showLogo = const Value.absent(),
            Value<bool> showBusinessInfo = const Value.absent(),
            Value<String?> taxLabel = const Value.absent(),
            Value<double?> taxPercentage = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReceiptSettingsCompanion.insert(
            id: id,
            header: header,
            footer: footer,
            showLogo: showLogo,
            showBusinessInfo: showBusinessInfo,
            taxLabel: taxLabel,
            taxPercentage: taxPercentage,
            rowid: rowid,
          ),
        ));
}

class $$ReceiptSettingsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ReceiptSettingsTable> {
  $$ReceiptSettingsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get header => $state.composableBuilder(
      column: $state.table.header,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get footer => $state.composableBuilder(
      column: $state.table.footer,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get showLogo => $state.composableBuilder(
      column: $state.table.showLogo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get showBusinessInfo => $state.composableBuilder(
      column: $state.table.showBusinessInfo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get taxLabel => $state.composableBuilder(
      column: $state.table.taxLabel,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get taxPercentage => $state.composableBuilder(
      column: $state.table.taxPercentage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ReceiptSettingsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ReceiptSettingsTable> {
  $$ReceiptSettingsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get header => $state.composableBuilder(
      column: $state.table.header,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get footer => $state.composableBuilder(
      column: $state.table.footer,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get showLogo => $state.composableBuilder(
      column: $state.table.showLogo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get showBusinessInfo => $state.composableBuilder(
      column: $state.table.showBusinessInfo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get taxLabel => $state.composableBuilder(
      column: $state.table.taxLabel,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get taxPercentage => $state.composableBuilder(
      column: $state.table.taxPercentage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$AuditEntriesTableCreateCompanionBuilder = AuditEntriesCompanion
    Function({
  required String id,
  required int action,
  required int entityType,
  required String entityId,
  Value<String?> previousValue,
  Value<String?> newValue,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$AuditEntriesTableUpdateCompanionBuilder = AuditEntriesCompanion
    Function({
  Value<String> id,
  Value<int> action,
  Value<int> entityType,
  Value<String> entityId,
  Value<String?> previousValue,
  Value<String?> newValue,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$AuditEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AuditEntriesTable,
    AuditEntry,
    $$AuditEntriesTableFilterComposer,
    $$AuditEntriesTableOrderingComposer,
    $$AuditEntriesTableCreateCompanionBuilder,
    $$AuditEntriesTableUpdateCompanionBuilder> {
  $$AuditEntriesTableTableManager(_$AppDatabase db, $AuditEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AuditEntriesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AuditEntriesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> action = const Value.absent(),
            Value<int> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String?> previousValue = const Value.absent(),
            Value<String?> newValue = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AuditEntriesCompanion(
            id: id,
            action: action,
            entityType: entityType,
            entityId: entityId,
            previousValue: previousValue,
            newValue: newValue,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int action,
            required int entityType,
            required String entityId,
            Value<String?> previousValue = const Value.absent(),
            Value<String?> newValue = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AuditEntriesCompanion.insert(
            id: id,
            action: action,
            entityType: entityType,
            entityId: entityId,
            previousValue: previousValue,
            newValue: newValue,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$AuditEntriesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AuditEntriesTable> {
  $$AuditEntriesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get action => $state.composableBuilder(
      column: $state.table.action,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get entityType => $state.composableBuilder(
      column: $state.table.entityType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get entityId => $state.composableBuilder(
      column: $state.table.entityId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get previousValue => $state.composableBuilder(
      column: $state.table.previousValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get newValue => $state.composableBuilder(
      column: $state.table.newValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AuditEntriesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AuditEntriesTable> {
  $$AuditEntriesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get action => $state.composableBuilder(
      column: $state.table.action,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get entityType => $state.composableBuilder(
      column: $state.table.entityType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get entityId => $state.composableBuilder(
      column: $state.table.entityId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get previousValue => $state.composableBuilder(
      column: $state.table.previousValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get newValue => $state.composableBuilder(
      column: $state.table.newValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  required String id,
  required String customerId,
  required String saleId,
  required double outstandingAmount,
  required DateTime scheduledAt,
  Value<DateTime?> sentAt,
  required int status,
  Value<String?> message,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<String> id,
  Value<String> customerId,
  Value<String> saleId,
  Value<double> outstandingAmount,
  Value<DateTime> scheduledAt,
  Value<DateTime?> sentAt,
  Value<int> status,
  Value<String?> message,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$RemindersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RemindersTable,
    Reminder,
    $$RemindersTableFilterComposer,
    $$RemindersTableOrderingComposer,
    $$RemindersTableCreateCompanionBuilder,
    $$RemindersTableUpdateCompanionBuilder> {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RemindersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RemindersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> customerId = const Value.absent(),
            Value<String> saleId = const Value.absent(),
            Value<double> outstandingAmount = const Value.absent(),
            Value<DateTime> scheduledAt = const Value.absent(),
            Value<DateTime?> sentAt = const Value.absent(),
            Value<int> status = const Value.absent(),
            Value<String?> message = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RemindersCompanion(
            id: id,
            customerId: customerId,
            saleId: saleId,
            outstandingAmount: outstandingAmount,
            scheduledAt: scheduledAt,
            sentAt: sentAt,
            status: status,
            message: message,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String customerId,
            required String saleId,
            required double outstandingAmount,
            required DateTime scheduledAt,
            Value<DateTime?> sentAt = const Value.absent(),
            required int status,
            Value<String?> message = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              RemindersCompanion.insert(
            id: id,
            customerId: customerId,
            saleId: saleId,
            outstandingAmount: outstandingAmount,
            scheduledAt: scheduledAt,
            sentAt: sentAt,
            status: status,
            message: message,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$RemindersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get outstandingAmount => $state.composableBuilder(
      column: $state.table.outstandingAmount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get scheduledAt => $state.composableBuilder(
      column: $state.table.scheduledAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get sentAt => $state.composableBuilder(
      column: $state.table.sentAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get message => $state.composableBuilder(
      column: $state.table.message,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableFilterComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }

  $$SalesTableFilterComposer get saleId {
    final $$SalesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.saleId,
        referencedTable: $state.db.sales,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$SalesTableFilterComposer(
            ComposerState(
                $state.db, $state.db.sales, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$RemindersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get outstandingAmount => $state.composableBuilder(
      column: $state.table.outstandingAmount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get scheduledAt => $state.composableBuilder(
      column: $state.table.scheduledAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get sentAt => $state.composableBuilder(
      column: $state.table.sentAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get message => $state.composableBuilder(
      column: $state.table.message,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $state.db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CustomersTableOrderingComposer(ComposerState(
                $state.db, $state.db.customers, joinBuilder, parentComposers)));
    return composer;
  }

  $$SalesTableOrderingComposer get saleId {
    final $$SalesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.saleId,
        referencedTable: $state.db.sales,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$SalesTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.sales, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AdminEntriesTableTableManager get adminEntries =>
      $$AdminEntriesTableTableManager(_db, _db.adminEntries);
  $$BusinessEntriesTableTableManager get businessEntries =>
      $$BusinessEntriesTableTableManager(_db, _db.businessEntries);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$SalesTableTableManager get sales =>
      $$SalesTableTableManager(_db, _db.sales);
  $$SaleItemsTableTableManager get saleItems =>
      $$SaleItemsTableTableManager(_db, _db.saleItems);
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db, _db.purchases);
  $$PurchaseItemsTableTableManager get purchaseItems =>
      $$PurchaseItemsTableTableManager(_db, _db.purchaseItems);
  $$SupplierPaymentsTableTableManager get supplierPayments =>
      $$SupplierPaymentsTableTableManager(_db, _db.supplierPayments);
  $$CustomerPaymentsTableTableManager get customerPayments =>
      $$CustomerPaymentsTableTableManager(_db, _db.customerPayments);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$StockTransactionsTableTableManager get stockTransactions =>
      $$StockTransactionsTableTableManager(_db, _db.stockTransactions);
  $$CashEntriesTableTableManager get cashEntries =>
      $$CashEntriesTableTableManager(_db, _db.cashEntries);
  $$CashClosingsTableTableManager get cashClosings =>
      $$CashClosingsTableTableManager(_db, _db.cashClosings);
  $$ReceiptsTableTableManager get receipts =>
      $$ReceiptsTableTableManager(_db, _db.receipts);
  $$ReceiptSettingsTableTableManager get receiptSettings =>
      $$ReceiptSettingsTableTableManager(_db, _db.receiptSettings);
  $$AuditEntriesTableTableManager get auditEntries =>
      $$AuditEntriesTableTableManager(_db, _db.auditEntries);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
}
