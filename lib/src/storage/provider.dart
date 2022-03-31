import 'account/db.dart';
import 'provider/unsupported.dart'
    if (dart.library.ffi) 'provider/native.dart'
    if (dart.library.html) 'provider/web.dart';

class DatabaseConstructor {
  DatabaseConstructor._();

  static UserAccountDatabase userAccount() => $userAccount();
}
