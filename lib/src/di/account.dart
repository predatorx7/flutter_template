import 'package:example/src/modules/authentication/account_manager.dart';
import 'package:example/src/repo/account.dart';
import 'package:example/src/storage/account/dao/token.dart';
import 'package:example/src/storage/account/dao/user_account.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'database.dart';

final accountRepositoryRef = Provider((ref) {
  final userAccountDb = ref.watch(userAccountDatabaseRef);

  final authTokenDao = AuthenticationTokensDao(userAccountDb);
  final userAccountsDao = UserAccountsDao(userAccountDb);

  return AccountRepository(
    authTokenDao,
    userAccountsDao,
  );
});

final accountManagerRef =
    StateNotifierProvider<AccountManager, UserAccount?>((ref) {
  final repo = ref.watch(accountRepositoryRef);

  final manager = AccountManagerImpl(repo);

  ref.onDispose(manager.dispose);

  return manager;
});
