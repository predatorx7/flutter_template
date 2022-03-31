import 'package:example/src/utils/connection.dart';

import '../account/db.dart';

UserAccountDatabase $userAccount() {
  const _dbName = 'useraccount_db.sqlite';
  const _dbConnectionProvider = DatabaseConnectionProvider(_dbName);

  return UserAccountDatabase.connect(_dbConnectionProvider.fromBackground);
}
