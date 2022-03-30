import 'package:app_boot/app_settings_manager.dart';
import 'package:example/src/commons/settings.dart';
import 'package:example/src/utils/package_support/package_support.dart';
import 'package:flutter/foundation.dart';

class DevelopmentError {
  const DevelopmentError(this.moduleName);

  final String moduleName;

  @override
  String toString() {
    return 'DevelopmentError: $moduleName was enabled but it cannot be used in production. It is marked as "IN DEVELOPMENT".\n\nHint: To fix this issue, assign `false` to the constant `InDevelopment.$moduleName` in the under_construction.dart file.';
  }
}


final packageSupportInfo = PackageSupportInfo();

class BuildConfigurations {
  // Warning: Setting this false will disable asserts even in production release mode.
  // ignore: unused_field
  final _assertsEnabled = true;

  bool get developmentFeature => kDebugMode;

  // Example of a feature that is not in development but can be enabled/disabled later.
  bool get someotherNonDevelopmentFeature => true;

  /// All development only features must be asserted here to
  /// prevent releases in production.
  ///
  /// This will be run in release mode when `settingsManager.isFor(SettingsFor.production)` is true.
  void _asserts() {
    // An example of an assert statement of a feature that is still in
    // development mode.
    _assert(developmentFeature, 'development-feature');
  }

  void assertDevelopmentFlags() {
    final shouldAssert = _assertsEnabled &&
        kReleaseMode &&
        settingsManager.isFor(SettingsFor.production);

    if (shouldAssert) {
      _asserts();
    }
  }

  void _assert(bool flag, String moduleName) {
    if (flag) throw DevelopmentError(moduleName);
  }
}

final buildConfigurations = BuildConfigurations();
