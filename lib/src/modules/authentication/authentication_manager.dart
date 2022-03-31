import 'account_manager.dart';
import 'authentication_delegate.dart';
import 'error.dart';

class AuthenticationAttempt {
  final String? validationMessage;

  bool get isSuccessful => validationMessage == null;

  final bool needsVerification;
  final String? reason;

  const AuthenticationAttempt.failed(this.validationMessage, [this.reason])
      : needsVerification = true;

  const AuthenticationAttempt.verifiedSuccess()
      : validationMessage = null,
        reason = null,
        needsVerification = false;

  const AuthenticationAttempt.success()
      : validationMessage = null,
        reason = null,
        needsVerification = true;
}

class AuthenticationManager<T> {
  AuthenticationManager(
    this.delegate,
    this.accountManager,
  );

  final AuthenticationDelegate<T> delegate;
  final AccountManager accountManager;

  AuthenticationResponse<T>? _savedLoginAttempt;

  bool get hasLoginAttempt => _savedLoginAttempt != null;

  void _addSavedLoginAttempt(AuthenticationResponse<T> response) {
    if (_savedLoginAttempt != null) {
      throw const AuthenticationError(
        'A previous login attempt is in progress and needs verification',
      );
    }
    _savedLoginAttempt = response;
  }

  AuthenticationResponse<T> _getSavedLoginAttempt() {
    final response = _savedLoginAttempt;
    if (response == null) {
      throw const AuthenticationError(
        'No previous login attempt is saved that needs verification',
      );
    }
    return response;
  }

  Future<AuthenticationAttempt> _verifyFromToken(
    AuthenticationResponse<T> response,
  ) async {
    if (!response.isSuccess) {
      return AuthenticationAttempt.failed(
        response.message,
      );
    }

    final token = response.token;

    if (token != null && token.isAuthenticated) {
      final hasUpdated = await accountManager.addAuthenticationToken(
        token.token,
      );

      if (hasUpdated) {
        return const AuthenticationAttempt.verifiedSuccess();
      } else {
        return AuthenticationAttempt.failed(
          response.message,
          'Failed to update token',
        );
      }
    } else {
      final String _reason;
      if (token == null) {
        _reason = 'Token is null';
      } else {
        _reason = 'Token is expired or invalid: ${token.token}';
      }
      return AuthenticationAttempt.failed(
        response.message,
        _reason,
      );
    }
  }

  Future<AuthenticationAttempt> _loginFromResponse(
    AuthenticationResponse<T> response,
  ) async {
    if (!response.isSuccess) {
      return AuthenticationAttempt.failed(
        response.message,
      );
    }

    final account = response.account;
    if (account != null) {
      final hasAccountUpdated = await accountManager.addAccount(
        account.accountId,
        account.accountType,
      );

      if (hasAccountUpdated) {
        if (!response.needsVerification) {
          return _verifyFromToken(response);
        } else {
          _addSavedLoginAttempt(response);

          return const AuthenticationAttempt.success();
        }
      } else {
        return AuthenticationAttempt.failed(
          response.message,
          'Failed to update account',
        );
      }
    } else {
      return AuthenticationAttempt.failed(
        response.message,
        'Account is null',
      );
    }
  }

  Future<AuthenticationAttempt> loginWithUsernamePassword(
    String username,
    String password,
  ) async {
    final response = await delegate.loginWithUsernamePassword(
      username,
      password,
    );

    return _loginFromResponse(response);
  }

  Future<AuthenticationAttempt> loginWithMobileNumber(
    String dialingCode,
    String mobile,
  ) async {
    final response = await delegate.loginWithMobileNumber(
      dialingCode,
      mobile,
    );

    return _loginFromResponse(response);
  }

  /// [verification] can be a token, otp, pin, password for verifying a login attempt.
  Future<AuthenticationAttempt> verify(String verification) async {
    final previousResponse = _getSavedLoginAttempt();
    final response = await delegate.verify(
      previousResponse,
      verification,
    );

    return _verifyFromToken(response);
  }

  void clearLoginAttempts() {
    _savedLoginAttempt = null;
  }

  Future<void> logout() async {
    await delegate.logout();
    await accountManager.removeAccount();
  }
}
