import 'package:example/src/storage/provider.dart';
import 'package:riverpod/riverpod.dart';

final userAccountDatabaseRef = Provider((ref) {
  final db = DatabaseConstructor.userAccount();

  ref.onDispose(db.close);

  return db;
});
