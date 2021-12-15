import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigator/navigator.dart';

import 'paths.dart';

final navigationProvider = Provider((ref) {
  final paths = ref.read(navigationPaths);

  return RouterConfiguration(paths);
});
