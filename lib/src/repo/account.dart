import 'package:example/src/modules/authentication/token.dart';
import 'package:example/src/storage/account/dao/token.dart';
import 'package:example/src/storage/account/dao/user_account.dart';
import 'package:example/src/storage/account/db.dart';
import 'package:magnific_core/magnific_core.dart';

class AccountRepository {
  final AuthenticationTokensDao authenticationTokensDao;
  final UserAccountsDao userAccountsDao;

  const AccountRepository(
    this.authenticationTokensDao,
    this.userAccountsDao,
  );

  Stream<List<SavedUserAccount>> watchAccounts() {
    return userAccountsDao.watchAccounts();
  }

  Future<SavedUserAccount> addAccount(
    String accountId,
    String accountName,
    String accountType,
  ) {
    return userAccountsDao.addAccount(SavedUserAccountsCompanion.insert(
      accountId: accountId,
      accountName: accountName,
      accountType: accountType,
    ));
  }

  Future<int> updateAccount(
    String accountId,
    SavedUserAccountsCompanion companion,
  ) {
    return userAccountsDao.updateAccount(accountId, companion);
  }

  Future<void> deleteAll() {
    return userAccountsDao.deleteAll();
  }

  Future<void> deleteById(String accountId) {
    return userAccountsDao.deleteById(accountId);
  }

  Stream<Iterable<AuthenticationToken>> watchTokensBy(
    int userId,
    String tokenType,
  ) {
    return authenticationTokensDao
        .watchTokensBy(userId, tokenType)
        .map(_mapToTokens);
  }

  List<AuthenticationToken> _mapToTokens(
    List<SavedAuthenticationToken> event,
  ) {
    return <AuthenticationToken>[
      for (final it in event.map(_createToken))
        if (it != null) it,
    ];
  }

  AuthenticationToken? _createToken(
    SavedAuthenticationToken token,
  ) {
    try {
      return AuthenticationToken(
        token.tokenType,
        token.token,
      );
    } catch (e, s) {
      logger.warning('Unsupported token type', e, s);
      return null;
    }
  }

  Future<SavedAuthenticationToken> addToken(
    int userId,
    String token,
    String tokenType,
  ) {
    return authenticationTokensDao
        .addToken(SavedAuthenticationTokensCompanion.insert(
      userId: userId,
      token: token,
      tokenType: tokenType,
    ));
  }

  Future<int> updateToken(
    int userId,
    String tokenType,
    SavedAuthenticationTokensCompanion companion,
  ) {
    return authenticationTokensDao.updateTokenByIdAndType(
      userId,
      tokenType,
      companion,
    );
  }

  Future<void> deleteAllTokensBy(int userId, String tokenType) {
    return authenticationTokensDao.deleteByIdAndType(userId, tokenType);
  }

  Future<void> deleteAllTokensById(int userId) {
    return authenticationTokensDao.deleteById(userId);
  }

  Future<void> deleteAllTokens() {
    return authenticationTokensDao.deleteAll();
  }
}
