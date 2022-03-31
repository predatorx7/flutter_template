import '../account/db.dart';
import 'package:drift/web.dart';

UserAccountDatabase $userAccount() {
  const _dbName = 'useraccount_db.sqlite';

  return UserAccountDatabase(WebDatabase(_dbName));
}
