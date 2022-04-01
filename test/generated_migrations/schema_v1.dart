// GENERATED CODE, DO NOT EDIT BY HAND.
//@dart=2.12
import 'package:drift/drift.dart';

class SavedUserAccounts extends Table with TableInfo {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SavedUserAccounts(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  late final GeneratedColumn<String?> accountId = GeneratedColumn<String?>(
      'account_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 12),
      type: const StringType(),
      requiredDuringInsert: true);
  late final GeneratedColumn<String?> accountName = GeneratedColumn<String?>(
      'account_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  late final GeneratedColumn<String?> accountType = GeneratedColumn<String?>(
      'account_type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Never map(Map<String, dynamic> data, {String? tablePrefix}) {
    throw UnsupportedError('TableInfo.map in schema verification code');
  }

  @override
  SavedUserAccounts createAlias(String alias) {
    return SavedUserAccounts(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => false;
}

class SavedAuthenticationTokens extends Table with TableInfo {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SavedAuthenticationTokens(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  late final GeneratedColumn<int?> userId = GeneratedColumn<int?>(
      'user_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  late final GeneratedColumn<String?> token = GeneratedColumn<String?>(
      'token', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  late final GeneratedColumn<String?> tokenType = GeneratedColumn<String?>(
      'token_type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Never map(Map<String, dynamic> data, {String? tablePrefix}) {
    throw UnsupportedError('TableInfo.map in schema verification code');
  }

  @override
  SavedAuthenticationTokens createAlias(String alias) {
    return SavedAuthenticationTokens(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => false;
}

class DatabaseAtV1 extends GeneratedDatabase {
  DatabaseAtV1(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  DatabaseAtV1.connect(DatabaseConnection c) : super.connect(c);
  late final SavedUserAccounts savedUserAccounts = SavedUserAccounts(this);
  late final SavedAuthenticationTokens savedAuthenticationTokens =
      SavedAuthenticationTokens(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [savedUserAccounts, savedAuthenticationTokens];
  @override
  int get schemaVersion => 1;
}
