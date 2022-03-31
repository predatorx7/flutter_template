import 'package:example/src/storage/provider.dart';
import 'package:riverpod/riverpod.dart';

final userAccountDatabaseRef = Provider.autoDispose((ref) {
  return DatabaseConstructor.userAccount();
});
