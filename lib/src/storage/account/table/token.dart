import 'package:drift/drift.dart';

import 'user_account.dart';

class SavedAuthenticationTokens extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer().references(SavedUserAccounts, #id)();

  TextColumn get token => text()();

  TextColumn get tokenType => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
