import 'package:meta/meta.dart';

import 'account_manager.dart';
import 'error.dart';

abstract class AuthenticationMiddleware {
  @protected
  AccountManager get am;

  const AuthenticationMiddleware();

  Future<String> getAuthorizationToken() async {
    final token = am.authenticationToken;
    if (token != null && am.isAuthenticated) return token.token;

    // This is a good place to renew token if expired by using a Completer-lock mechanism.

    throw const AuthenticationError('You are not authorized');
  }
}
