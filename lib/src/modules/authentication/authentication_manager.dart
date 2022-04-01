import 'account_manager.dart';
import 'authentication_delegate.dart';
import 'error.dart';

class AuthenticationAttempt {
  final String? validationMessage;

  bool get isSuccessful => validationMessage == null;

  final bool needsVerification;
  final String? reason;

  const AuthenticationAttempt.failed(
    this.validationMessage,
    this.needsVerification, [
    this.reason,
  ]);

  const AuthenticationAttempt.verifiedSuccess()
      : validationMessage = null,
        reason = null,
        needsVerification = false;

  const AuthenticationAttempt.success()
      : validationMessage = null,
        reason = null,
        needsVerification = true;
}

class _SavedLoginAttempt<T> {
  final int savedAccountId;
  final AuthenticationResponse<T> response;

  const _SavedLoginAttempt(this.savedAccountId, this.response);
}

class AuthenticationManager<T> {
  AuthenticationManager(
    this.delegate,
    this.accountManager,
  );

  final AuthenticationDelegate<T> delegate;
  final AccountManager accountManager;

  _SavedLoginAttempt<T>? _savedLoginAttempt;

  bool get hasLoginAttempt => _savedLoginAttempt != null;

  void _addSavedLoginAttempt(
    int savedAccountId,
    AuthenticationResponse<T> response,
  ) {
    if (_savedLoginAttempt != null) {
      throw const AuthenticationError(
        'A previous login attempt is in progress and needs verification',
      );
    }
    _savedLoginAttempt = _SavedLoginAttempt(savedAccountId, response);
  }

  _SavedLoginAttempt<T> _getSavedLoginAttempt() {
    final response = _savedLoginAttempt;
    if (response == null) {
      throw const AuthenticationError(
        'No previous login attempt is saved that needs verification',
      );
    }
    return response;
  }

  Future<AuthenticationAttempt> _verifyFromToken(
    int savedAccountId,
    AuthenticationResponse<T> response,
  ) async {
    if (!response.isSuccess) {
      return AuthenticationAttempt.failed(
        response.message,
        response.needsVerification,
      );
    }

    final token = response.token;

    if (token != null && token.isAuthenticated) {
      final savedTokenId = await accountManager.addAuthenticationToken(
        savedAccountId,
        token.token,
      );

      if (savedTokenId != null) {
        return const AuthenticationAttempt.verifiedSuccess();
      } else {
        return AuthenticationAttempt.failed(
          response.message,
          response.needsVerification,
          'Failed to save token ${token.token}',
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
        response.needsVerification,
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
        false,
      );
    }

    final account = response.account;
    if (account != null) {
      final savedAccountId = await accountManager.addAccount(
        account,
      );

      if (savedAccountId != null) {
        if (!response.needsVerification) {
          return _verifyFromToken(savedAccountId, response);
        } else {
          _addSavedLoginAttempt(savedAccountId, response);

          return const AuthenticationAttempt.success();
        }
      } else {
        return AuthenticationAttempt.failed(
          response.message,
          false,
          'Failed to save account',
        );
      }
    } else {
      return AuthenticationAttempt.failed(
        response.message,
        false,
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
    final previousLoginAttempt = _getSavedLoginAttempt();
    final response = await delegate.verify(
      previousLoginAttempt.response,
      verification,
    );

    return _verifyFromToken(previousLoginAttempt.savedAccountId, response);
  }

  void clearLoginAttempts() {
    _savedLoginAttempt = null;
  }

  Future<void> logout() async {
    await delegate.logout();
    await accountManager.removeAccount();
  }
}
