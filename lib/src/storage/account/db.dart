import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import 'dao/token.dart';
import 'dao/user_account.dart';
import 'table/token.dart';
import 'table/user_account.dart';

part 'db.g.dart';

@DriftDatabase(
  tables: [
    SavedUserAccounts,
    SavedAuthenticationTokens,
  ],
  daos: [
    UserAccountsDao,
    AuthenticationTokensDao,
  ],
)
class UserAccountDatabase extends _$UserAccountDatabase {
  UserAccountDatabase(QueryExecutor e) : super(e);

  /// Creates database connection from a custom database connection and returns a database instance.
  UserAccountDatabase.connect(DatabaseConnection c) : super.connect(c);

  @override
  int get schemaVersion => 1;

  static const bool _deleteEverythingBeforeStartupInDebug = false;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (Migrator m) {
      return m.createAll();
    }, beforeOpen: (details) async {
      if (kDebugMode && _deleteEverythingBeforeStartupInDebug) {
        final m = Migrator(this);
        for (final table in allTables) {
          await m.deleteTable(table.actualTableName);
          await m.createTable(table);
        }
      }
    });
  }
}
