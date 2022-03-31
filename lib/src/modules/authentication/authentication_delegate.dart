import 'account_manager.dart';
import 'token.dart';

class AuthenticationResponseWithFailure<T>
    implements AuthenticationResponse<T> {
  const AuthenticationResponseWithFailure(
    this.message, {
    this.account,
    this.data,
    this.needsVerification = false,
  })  : token = null,
        isSuccess = false;

  @override
  final Account? account;

  @override
  final AuthenticationToken? token;

  @override
  final bool needsVerification;

  /// Extra payload
  @override
  final T? data;

  @override
  final String? message;

  @override
  final bool isSuccess;
}

class AuthenticationResponseWithAccount<T>
    implements AuthenticationResponse<T> {
  const AuthenticationResponseWithAccount(
    this.account, {
    this.data,
  })  : message = null,
        token = null,
        needsVerification = true,
        isSuccess = true;

  @override
  final Account account;

  @override
  final AuthenticationToken? token;

  @override
  final bool needsVerification;

  /// Extra payload
  @override
  final T? data;

  @override
  final String? message;

  @override
  final bool isSuccess;
}

class AuthenticationResponseWithVerifiedAccount<T>
    implements AuthenticationResponseWithAccount<T> {
  const AuthenticationResponseWithVerifiedAccount(
    this.account,
    this.token, {
    this.data,
  })  : message = null,
        needsVerification = false,
        isSuccess = true;

  @override
  final Account account;

  @override
  final AuthenticationToken token;

  @override
  final bool needsVerification;

  /// Extra payload
  @override
  final T? data;

  @override
  final String? message;

  @override
  final bool isSuccess;
}

abstract class AuthenticationResponse<T> {
  final Account? account;

  final AuthenticationToken? token;

  bool get needsVerification => token == null;

  /// Extra payload
  final T? data;

  final String? message;

  final bool isSuccess;

  const AuthenticationResponse(
    this.account,
    this.message,
    this.token,
    this.isSuccess,
    this.data,
  );

  const factory AuthenticationResponse.onAccount(
    Account account, {
    T? data,
  }) = AuthenticationResponseWithAccount<T>;

  const factory AuthenticationResponse.onAccountVerified(
    Account account,
    AuthenticationToken token, {
    T? data,
  }) = AuthenticationResponseWithVerifiedAccount<T>;

  const factory AuthenticationResponse.onFailure(
    String message, {
    Account? account,
    T? data,
    bool needsVerification,
  }) = AuthenticationResponseWithFailure<T>;
}

abstract class AuthenticationDelegate<T> {
  const AuthenticationDelegate();

  Future<AuthenticationResponse<T>> loginWithUsernamePassword(
    String username,
    String password,
  );

  Future<AuthenticationResponse<T>> loginWithMobileNumber(
    String dialingCode,
    String mobile,
  );

  Future<AuthenticationResponse<T>> verify(
    AuthenticationResponse<T> authentication,
    String otp,
  );

  Future<void> logout();
}
