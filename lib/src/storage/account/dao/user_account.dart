import 'package:drift/drift.dart';
import 'package:example/src/storage/account/db.dart';
import 'package:example/src/storage/account/table/user_account.dart';

part 'user_account.g.dart';

@DriftAccessor(tables: [SavedUserAccounts])
class UserAccountsDao extends DatabaseAccessor<UserAccountDatabase>
    with _$UserAccountsDaoMixin {
  UserAccountsDao(UserAccountDatabase db) : super(db);

  Future<List<SavedUserAccount>> getAccounts() {
    return select(savedUserAccounts).get();
  }

  Stream<List<SavedUserAccount>> watchAccounts() {
    return select(savedUserAccounts).watch();
  }

  Future<SavedUserAccount> addAccount(SavedUserAccountsCompanion companion) {
    return into(savedUserAccounts).insertReturning(companion);
  }

  Future<int> updateAccount(
    String accountId,
    SavedUserAccountsCompanion companion,
  ) {
    final q = update(savedUserAccounts);
    q.where((tbl) => tbl.accountId.equals(accountId));
    return q.write(companion);
  }

  Future<void> deleteAll() {
    return delete(savedUserAccounts).go();
  }

  Future<void> deleteById(String accountId) {
    final q = delete(savedUserAccounts);
    q.where((tbl) => tbl.accountId.equals(accountId));
    return q.go();
  }
}
