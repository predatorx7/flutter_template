import 'dart:async';

import 'package:example/src/repo/account.dart';
import 'package:example/src/storage/account/db.dart';
import 'package:flutter/material.dart';
import 'package:magnific_core/magnific_core.dart';
import 'package:riverpod/riverpod.dart';

import 'error.dart';
import 'token.dart';

class Account {
  final String accountId;
  final String accountType;

  const Account(this.accountId, this.accountType);
}

class UserAccount extends Account {
  UserAccount._(
    this.id,
    String accountId,
    String accountType,
    this.authenticationToken,
  ) : super(accountId, accountType);

  final int id;
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
  AuthenticationToken? get authenticationToken => state?.authenticationToken;

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
  Future<bool> addAuthenticationToken(String token) async {
    final account = state;
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
