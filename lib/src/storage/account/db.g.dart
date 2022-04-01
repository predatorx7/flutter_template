// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class SavedUserAccount extends DataClass
    implements Insertable<SavedUserAccount> {
  final int id;
  final String accountId;
  final String accountName;
  final String accountType;
  final DateTime createdAt;
  final DateTime updatedAt;
  SavedUserAccount(
      {required this.id,
      required this.accountId,
      required this.accountName,
      required this.accountType,
      required this.createdAt,
      required this.updatedAt});
  factory SavedUserAccount.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SavedUserAccount(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      accountId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}account_id'])!,
      accountName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}account_name'])!,
      accountType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}account_type'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<String>(accountId);
    map['account_name'] = Variable<String>(accountName);
    map['account_type'] = Variable<String>(accountType);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SavedUserAccountsCompanion toCompanion(bool nullToAbsent) {
    return SavedUserAccountsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      accountName: Value(accountName),
      accountType: Value(accountType),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SavedUserAccount.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedUserAccount(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      accountName: serializer.fromJson<String>(json['accountName']),
      accountType: serializer.fromJson<String>(json['accountType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<String>(accountId),
      'accountName': serializer.toJson<String>(accountName),
      'accountType': serializer.toJson<String>(accountType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SavedUserAccount copyWith(
          {int? id,
          String? accountId,
          String? accountName,
          String? accountType,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      SavedUserAccount(
        id: id ?? this.id,
        accountId: accountId ?? this.accountId,
        accountName: accountName ?? this.accountName,
        accountType: accountType ?? this.accountType,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('SavedUserAccount(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('accountName: $accountName, ')
          ..write('accountType: $accountType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, accountId, accountName, accountType, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedUserAccount &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.accountName == this.accountName &&
          other.accountType == this.accountType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SavedUserAccountsCompanion extends UpdateCompanion<SavedUserAccount> {
  final Value<int> id;
  final Value<String> accountId;
  final Value<String> accountName;
  final Value<String> accountType;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SavedUserAccountsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.accountName = const Value.absent(),
    this.accountType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SavedUserAccountsCompanion.insert({
    this.id = const Value.absent(),
    required String accountId,
    required String accountName,
    required String accountType,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : accountId = Value(accountId),
        accountName = Value(accountName),
        accountType = Value(accountType);
  static Insertable<SavedUserAccount> custom({
    Expression<int>? id,
    Expression<String>? accountId,
    Expression<String>? accountName,
    Expression<String>? accountType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (accountName != null) 'account_name': accountName,
      if (accountType != null) 'account_type': accountType,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SavedUserAccountsCompanion copyWith(
      {Value<int>? id,
      Value<String>? accountId,
      Value<String>? accountName,
      Value<String>? accountType,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return SavedUserAccountsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      accountName: accountName ?? this.accountName,
      accountType: accountType ?? this.accountType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (accountName.present) {
      map['account_name'] = Variable<String>(accountName.value);
    }
    if (accountType.present) {
      map['account_type'] = Variable<String>(accountType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedUserAccountsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('accountName: $accountName, ')
          ..write('accountType: $accountType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SavedUserAccountsTable extends SavedUserAccounts
    with TableInfo<$SavedUserAccountsTable, SavedUserAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedUserAccountsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _accountIdMeta = const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String?> accountId = GeneratedColumn<String?>(
      'account_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 12),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _accountNameMeta =
      const VerificationMeta('accountName');
  @override
  late final GeneratedColumn<String?> accountName = GeneratedColumn<String?>(
      'account_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _accountTypeMeta =
      const VerificationMeta('accountType');
  @override
  late final GeneratedColumn<String?> accountType = GeneratedColumn<String?>(
      'account_type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, accountId, accountName, accountType, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'saved_user_accounts';
  @override
  String get actualTableName => 'saved_user_accounts';
  @override
  VerificationContext validateIntegrity(Insertable<SavedUserAccount> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('account_name')) {
      context.handle(
          _accountNameMeta,
          accountName.isAcceptableOrUnknown(
              data['account_name']!, _accountNameMeta));
    } else if (isInserting) {
      context.missing(_accountNameMeta);
    }
    if (data.containsKey('account_type')) {
      context.handle(
          _accountTypeMeta,
          accountType.isAcceptableOrUnknown(
              data['account_type']!, _accountTypeMeta));
    } else if (isInserting) {
      context.missing(_accountTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedUserAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SavedUserAccount.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SavedUserAccountsTable createAlias(String alias) {
    return $SavedUserAccountsTable(attachedDatabase, alias);
  }
}

class SavedAuthenticationToken extends DataClass
    implements Insertable<SavedAuthenticationToken> {
  final int id;
  final int userId;
  final String token;
  final String tokenType;
  final DateTime createdAt;
  final DateTime updatedAt;
  SavedAuthenticationToken(
      {required this.id,
      required this.userId,
      required this.token,
      required this.tokenType,
      required this.createdAt,
      required this.updatedAt});
  factory SavedAuthenticationToken.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SavedAuthenticationToken(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      userId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id'])!,
      token: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}token'])!,
      tokenType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}token_type'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['token'] = Variable<String>(token);
    map['token_type'] = Variable<String>(tokenType);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SavedAuthenticationTokensCompanion toCompanion(bool nullToAbsent) {
    return SavedAuthenticationTokensCompanion(
      id: Value(id),
      userId: Value(userId),
      token: Value(token),
      tokenType: Value(tokenType),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SavedAuthenticationToken.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedAuthenticationToken(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      token: serializer.fromJson<String>(json['token']),
      tokenType: serializer.fromJson<String>(json['tokenType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'token': serializer.toJson<String>(token),
      'tokenType': serializer.toJson<String>(tokenType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SavedAuthenticationToken copyWith(
          {int? id,
          int? userId,
          String? token,
          String? tokenType,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      SavedAuthenticationToken(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        token: token ?? this.token,
        tokenType: tokenType ?? this.tokenType,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('SavedAuthenticationToken(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('token: $token, ')
          ..write('tokenType: $tokenType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, token, tokenType, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedAuthenticationToken &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.token == this.token &&
          other.tokenType == this.tokenType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SavedAuthenticationTokensCompanion
    extends UpdateCompanion<SavedAuthenticationToken> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> token;
  final Value<String> tokenType;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SavedAuthenticationTokensCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.token = const Value.absent(),
    this.tokenType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SavedAuthenticationTokensCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String token,
    required String tokenType,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : userId = Value(userId),
        token = Value(token),
        tokenType = Value(tokenType);
  static Insertable<SavedAuthenticationToken> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? token,
    Expression<String>? tokenType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (token != null) 'token': token,
      if (tokenType != null) 'token_type': tokenType,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SavedAuthenticationTokensCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String>? token,
      Value<String>? tokenType,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return SavedAuthenticationTokensCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      token: token ?? this.token,
      tokenType: tokenType ?? this.tokenType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (tokenType.present) {
      map['token_type'] = Variable<String>(tokenType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedAuthenticationTokensCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('token: $token, ')
          ..write('tokenType: $tokenType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SavedAuthenticationTokensTable extends SavedAuthenticationTokens
    with TableInfo<$SavedAuthenticationTokensTable, SavedAuthenticationToken> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedAuthenticationTokensTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int?> userId = GeneratedColumn<int?>(
      'user_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES saved_user_accounts (id)');
  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String?> token = GeneratedColumn<String?>(
      'token', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _tokenTypeMeta = const VerificationMeta('tokenType');
  @override
  late final GeneratedColumn<String?> tokenType = GeneratedColumn<String?>(
      'token_type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, token, tokenType, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'saved_authentication_tokens';
  @override
  String get actualTableName => 'saved_authentication_tokens';
  @override
  VerificationContext validateIntegrity(
      Insertable<SavedAuthenticationToken> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('token')) {
      context.handle(
          _tokenMeta, token.isAcceptableOrUnknown(data['token']!, _tokenMeta));
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (data.containsKey('token_type')) {
      context.handle(_tokenTypeMeta,
          tokenType.isAcceptableOrUnknown(data['token_type']!, _tokenTypeMeta));
    } else if (isInserting) {
      context.missing(_tokenTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedAuthenticationToken map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return SavedAuthenticationToken.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SavedAuthenticationTokensTable createAlias(String alias) {
    return $SavedAuthenticationTokensTable(attachedDatabase, alias);
  }
}

abstract class _$UserAccountDatabase extends GeneratedDatabase {
  _$UserAccountDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  _$UserAccountDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final $SavedUserAccountsTable savedUserAccounts =
      $SavedUserAccountsTable(this);
  late final $SavedAuthenticationTokensTable savedAuthenticationTokens =
      $SavedAuthenticationTokensTable(this);
  late final UserAccountsDao userAccountsDao =
      UserAccountsDao(this as UserAccountDatabase);
  late final AuthenticationTokensDao authenticationTokensDao =
      AuthenticationTokensDao(this as UserAccountDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [savedUserAccounts, savedAuthenticationTokens];
}
