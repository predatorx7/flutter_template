import 'io.dart' if (dart.library.html) 'html.dart';

import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class PackageSupportInfo {
  final isFirebaseSupported = $PackageSupportInfo.isFirebaseSupported;
  final useConfigForFirebase = kIsWeb || defaultTargetPlatform != TargetPlatform.android;
}
