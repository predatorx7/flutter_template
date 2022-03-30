import 'dart:io';

class $PackageSupportInfo {
  $PackageSupportInfo._();

  static bool isFirebaseSupported =
      Platform.isAndroid || Platform.isIOS || Platform.isMacOS;
}
