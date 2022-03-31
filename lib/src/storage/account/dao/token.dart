import 'package:drift/drift.dart';
import 'package:example/src/storage/account/db.dart';

import '../table/token.dart';

part 'token.g.dart';

@DriftAccessor(tables: [SavedAuthenticationTokens])
class AuthenticationTokensDao extends DatabaseAccessor<UserAccountDatabase>
    with _$AuthenticationTokensDaoMixin {
  AuthenticationTokensDao(UserAccountDatabase db) : super(db);

  Future<List<SavedAuthenticationToken>> getTokensOf(int userId) {
    final q = select(savedAuthenticationTokens);
    q.where((tbl) => tbl.userId.equals(userId));
    q.orderBy([
      (u) => OrderingTerm(expression: u.updatedAt, mode: OrderingMode.desc),
    ]);
    return q.get();
  }

  Future<List<SavedAuthenticationToken>> getTokensBy(
      int userId, String tokenType) {
    final q = select(savedAuthenticationTokens);
    q.where((tbl) => tbl.userId.equals(userId));
    q.where((tbl) => tbl.tokenType.equals(tokenType));
    q.orderBy([
      (u) => OrderingTerm(expression: u.updatedAt, mode: OrderingMode.desc),
    ]);
    return q.get();
  }

  Stream<List<SavedAuthenticationToken>> watchTokensOf(int userId) {
    final q = select(savedAuthenticationTokens);
    q.where((tbl) => tbl.userId.equals(userId));
    q.orderBy([
      (u) => OrderingTerm(expression: u.updatedAt, mode: OrderingMode.desc),
    ]);
    return q.watch();
  }

  Stream<List<SavedAuthenticationToken>> watchTokensBy(
      int userId, String tokenType) {
    final q = select(savedAuthenticationTokens);
    q.where((tbl) => tbl.userId.equals(userId));
    q.where((tbl) => tbl.tokenType.equals(tokenType));
    q.orderBy([
      (u) => OrderingTerm(expression: u.updatedAt, mode: OrderingMode.desc),
    ]);
    return q.watch();
  }

  Future<SavedAuthenticationToken> addToken(
    SavedAuthenticationTokensCompanion companion,
  ) {
    return into(savedAuthenticationTokens).insertReturning(companion);
  }

  Future<int> updateTokenByIdAndType(
    int userId,
    String tokenType,
    SavedAuthenticationTokensCompanion companion,
  ) {
    final q = update(savedAuthenticationTokens);
    q.where((tbl) => tbl.userId.equals(userId));
    q.where((tbl) => tbl.tokenType.equals(tokenType));
    return q.write(companion);
  }

  Future<void> deleteAll() {
    return delete(savedAuthenticationTokens).go();
  }

  Future<void> deleteById(int userId) {
    final q = delete(savedAuthenticationTokens);
    q.where((tbl) => tbl.userId.equals(userId));
    return q.go();
  }

  Future<void> deleteByIdAndType(
    int userId,
    String tokenType,
  ) {
    final q = delete(savedAuthenticationTokens);
    q.where((tbl) => tbl.userId.equals(userId));
    q.where((tbl) => tbl.tokenType.equals(tokenType));
    return q.go();
  }
}
