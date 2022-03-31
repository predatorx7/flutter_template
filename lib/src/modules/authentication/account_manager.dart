import 'dart:async';

import 'package:example/src/repo/account.dart';
import 'package:example/src/storage/account/db.dart';
import 'package:flutter/material.dart';
import 'package:magnific_core/magnific_core.dart';

class AuthenticationError {
  final String message;

  const AuthenticationError(this.message);

  @override
  String toString() {
    return 'AuthenticationError($message)';
  }
}

abstract class AuthenticationMiddleware {
  @protected
  AccountManager get am;

  const AuthenticationMiddleware();

  Future<String> getAuthorizationToken() async {
    final token = am.authenticationToken;
    if (token != null && am.isAuthenticated) return token.token;

    throw const AuthenticationError('You are not authorized');
  }
}

class UserAccount {
  const UserAccount._(
    this.id,
    this.accountId,
    this.accountType,
    this.authenticationToken,
  );

  final int id;
  final String accountId;
  final String accountType;
  final AuthenticationToken? authenticationToken;

  bool get isAuthenticated {
    final token = authenticationToken;
    return token != null && token.isAuthenticated;
  }

  UserAccount? copyWith({
    AuthenticationToken? token,
  }) {
    return UserAccount._(
      id,
      accountId,
      accountType,
      token ?? authenticationToken,
    );
  }

  UserAccount? removeToken() {
    return UserAccount._(
      id,
      accountId,
      accountType,
      null,
    );
  }
}

class TokenTypes {
  static const String jwt = 'JWT';
}

abstract class AuthenticationToken {
  const AuthenticationToken._(this.tokenType, this.token);

  factory AuthenticationToken(String tokenType, String token) {
    switch (tokenType) {
      case TokenTypes.jwt:
        return JwtAuthenticationToken(token);
      default:
        throw const AuthenticationError('Invalid authentication token');
    }
  }

  final String tokenType;
  final String token;

  DateTime get expiresAt;
  bool get hasExpired;
  bool get isAuthenticated => !hasExpired;
  Duration get expiresIn;
}

class JwtAuthenticationToken extends AuthenticationToken {
  JwtAuthenticationToken(String token) : super._('JWT', token);

  @override
  DateTime get expiresAt {
    try {
      return JwtDecoder.getExpirationDateTime(token);
    } on FormatException {
      logger.severe('Invalid authorization token: $token');
      return DateTime.now().subtract(const Duration(seconds: 1));
    }
  }

  @override
  Duration get expiresIn {
    try {
      return JwtDecoder.getRemainingTime(token);
    } on FormatException {
      logger.severe('Invalid authorization token: $token');
      return Duration.zero;
    }
  }

  @override
  bool get hasExpired {
    try {
      return JwtDecoder.isExpired(token);
    } on FormatException {
      logger.severe('Invalid authorization token: $token');
      return true;
    }
  }
}

class _AccountValueModifier extends ValueNotifier<UserAccount?> {
  @protected
  final AccountRepository _accountRepository;

  _AccountValueModifier(this._accountRepository) : super(null) {
    _initialize();
  }

  StreamSubscription<List<SavedUserAccount>>? _accountStreamSubscription;

  StreamSubscription<Iterable<AuthenticationToken>>? _tokenSubscription;

  void _initialize() {
    final accountStream = _accountRepository.watchAccounts();
    _accountStreamSubscription = accountStream.listen(
      _onAccountUpdate,
      onError: _onError,
      cancelOnError: false,
    );
  }

  void _onError(e, s) {
    logger.severe('Account fetch error', e, s);
  }

  void _onAccountChange(UserAccount? oldValue, UserAccount? newValue) {
    _tokenSubscription?.cancel();
    if (newValue != null) {
      final tokenStream =
          _accountRepository.watchTokensBy(newValue.id, TokenTypes.jwt);
      _tokenSubscription = tokenStream.listen(
        _onTokenUpdate,
        onError: _onError,
        cancelOnError: false,
      );
    }
  }

  void _onTokenUpdate(Iterable<AuthenticationToken> event) {
    if (event.isEmpty) {
      _removeAuthenticationTokenState();
    } else {
      final primaryToken = event.first;
      _addAuthenticationTokenState(primaryToken);
    }
  }

  void _onAccountUpdate(List<SavedUserAccount> accounts) {
    final oldValue = value;
    if (accounts.isEmpty) {
      _removeAccountState();
    } else {
      final primaryAccount = accounts.first;
      _addAccountState(UserAccount._(
        primaryAccount.id,
        primaryAccount.accountId,
        primaryAccount.accountType,
        null,
      ));
    }
    if (oldValue?.accountId != value?.accountId || oldValue?.id != value?.id) {
      _onAccountChange(oldValue, value);
    }
  }

  void _addAccountState(UserAccount account) {
    value = account;
  }

  void _removeAccountState() {
    value = null;
  }

  void _addAuthenticationTokenState(AuthenticationToken token) {
    final _state = value;
    if (_state == null) return;

    value = _state.copyWith(token: token);
  }

  void _removeAuthenticationTokenState() {
    final _state = value;
    if (_state == null) return;

    value = _state.removeToken();
  }

  @override
  void dispose() {
    _accountStreamSubscription?.cancel();
    _tokenSubscription?.cancel();
    super.dispose();
  }
}

mixin AccountManager implements Listenable {
  AuthenticationToken? get authenticationToken;

  bool get isAuthenticated => authenticationToken?.isAuthenticated == true;

  Future<bool> addAccount(String accountId, String accountType);

  Future<bool> removeAccount();

  Future<bool> addAuthenticationToken(String token);

  Future<bool> removeAuthenticationToken();
}

class AccountManagerImpl extends _AccountValueModifier with AccountManager {
  AccountManagerImpl(
    AccountRepository _accountRepository,
  ) : super(_accountRepository);

  @override
  AuthenticationToken? get authenticationToken => value?.authenticationToken;

  @override
  Future<bool> addAccount(String accountId, String accountType) async {
    try {
      await _accountRepository.addAccount(accountId, accountType);
      return true;
    } catch (e, s) {
      _onError(e, s);
    }
    return false;
  }

  @override
  Future<bool> removeAccount() async {
    final account = value;
    if (account == null) return true;
    try {
      await _accountRepository.deleteById(account.accountId);
      return true;
    } catch (e, s) {
      _onError(e, s);
    }
    return false;
  }

  @override
  Future<bool> addAuthenticationToken(String token) async {
    final account = value;
    if (account == null) return false;

    try {
      await _accountRepository.addToken(account.id, token, TokenTypes.jwt);
      return true;
    } catch (e, s) {
      _onError(e, s);
    }
    return false;
  }

  @override
  Future<bool> removeAuthenticationToken() async {
    final account = value;
    if (account == null) return true;

    try {
      await _accountRepository.deleteAllTokensBy(account.id, TokenTypes.jwt);
      return true;
    } catch (e, s) {
      _onError(e, s);
    }
    return false;
  }
}

abstract class AuthenticationManager {
  AuthenticationManager();

  Future<String?> loginWithUsernamePassword(
    String username,
    String password,
  );

  Future<String?> loginWithMobileNumber(
    String dialingCode,
    String mobile,
  );

  Future<String?> verify(String otp);

  Future<void> logout();
}
