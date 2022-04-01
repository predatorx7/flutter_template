import 'dart:async';

import 'package:example/src/repo/account.dart';
import 'package:example/src/storage/account/db.dart';
import 'package:flutter/material.dart';
import 'package:magnific_core/magnific_core.dart';
import 'package:riverpod/riverpod.dart';

import 'token.dart';

class Account {
  final String accountId;
  final String accountName;
  final String accountType;

  const Account(
    this.accountId,
    this.accountName,
    this.accountType,
  );
}

class UserAccount extends Account {
  UserAccount._(
    this.id,
    String accountId,
    String accountName,
    String accountType,
    this.authenticationToken,
  ) : super(accountId, accountName, accountType);

  final int id;
  final AuthenticationToken? authenticationToken;

  bool get isAuthenticated {
    final token = authenticationToken;
    return token != null && token.isAuthenticated;
  }

  UserAccount? copyWith({
    AuthenticationToken? token,
    String? accountName,
    String? accountType,
  }) {
    return UserAccount._(
      id,
      accountId,
      accountName ?? this.accountName,
      accountType ?? this.accountType,
      token ?? authenticationToken,
    );
  }

  UserAccount? removeToken() {
    return UserAccount._(
      id,
      accountId,
      accountName,
      accountType,
      null,
    );
  }
}

class _AccountValueModifier extends StateNotifier<UserAccount?> {
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
    final oldValue = state;
    if (accounts.isEmpty) {
      _removeAccountState();
    } else {
      final primaryAccount = accounts.first;
      _addAccountState(UserAccount._(
        primaryAccount.id,
        primaryAccount.accountId,
        primaryAccount.accountName,
        primaryAccount.accountType,
        null,
      ));
    }
    if (oldValue?.accountId != state?.accountId || oldValue?.id != state?.id) {
      _onAccountChange(oldValue, state);
    }
  }

  void _addAccountState(UserAccount account) {
    state = account;
  }

  void _removeAccountState() {
    state = null;
  }

  void _addAuthenticationTokenState(AuthenticationToken token) {
    final _state = state;
    if (_state == null) return;

    state = _state.copyWith(token: token);
  }

  void _removeAuthenticationTokenState() {
    final _state = state;
    if (_state == null) return;

    state = _state.removeToken();
  }

  @override
  void dispose() {
    _accountStreamSubscription?.cancel();
    _tokenSubscription?.cancel();
    super.dispose();
  }
}

mixin AccountManager implements StateNotifier<UserAccount?> {
  AuthenticationToken? get authenticationToken;

  bool get isAuthenticated => authenticationToken?.isAuthenticated == true;

  /// Saves account and returns the local Id of the saved account (savedAccountId).
  ///
  /// Note: This AccountManager's state won't immediately reflect account after this future completes.
  Future<int?> addAccount(Account account);

  Future<bool> removeAccount();

  /// Adds authentication token to an accound with account local ID [savedAccountId] and
  /// returns local Id of the saved token (savedTokenId).
  ///
  /// Note: This AccountManager's state won't immediately reflect token after this future completes.
  Future<int?> addAuthenticationToken(int savedAccountId, String token);

  Future<bool> removeAuthenticationToken();
}

class AccountManagerImpl extends _AccountValueModifier with AccountManager {
  AccountManagerImpl(
    AccountRepository _accountRepository,
  ) : super(_accountRepository);

  @override
  AuthenticationToken? get authenticationToken => state?.authenticationToken;

  @override
  Future<int?> addAccount(Account account) async {
    try {
      final savedAccount = await _accountRepository.addAccount(
        account.accountId,
        account.accountName,
        account.accountType,
      );
      return savedAccount.id;
    } catch (e, s) {
      _onError(e, s);
    }
    return null;
  }

  @override
  Future<bool> removeAccount() async {
    final account = state;
    if (account == null) return true;
    try {
      await _accountRepository.deleteAllTokensById(account.id);
      await _accountRepository.deleteById(account.accountId);
      return true;
    } catch (e, s) {
      _onError(e, s);
    }
    return false;
  }

  @override
  Future<int?> addAuthenticationToken(
    int savedAccountId,
    String token,
  ) async {
    try {
      final savedToken = await _accountRepository.addToken(
        savedAccountId,
        token,
        TokenTypes.jwt,
      );
      return savedToken.id;
    } catch (e, s) {
      logger.info('Failed to save token', e, s);
      _onError(e, s);
    }
    return null;
  }

  @override
  Future<bool> removeAuthenticationToken() async {
    final account = state;
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
