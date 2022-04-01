import 'package:drift/drift.dart';

class SavedUserAccounts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get accountId => text().withLength(min: 1, max: 12)();

  TextColumn get accountName => text()();

  TextColumn get accountType => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
