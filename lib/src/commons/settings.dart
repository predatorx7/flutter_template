import 'package:app_boot/app_boot.dart';
import 'package:example/src/services/uri.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dependencies.dart';
import 'theme.dart';

class SettingsFor {
  static const production = SettingsIdentifier('production');
  static const staging = SettingsIdentifier('staging');
  static const development = SettingsIdentifier('devel');
}

class AppDependency with DependencyObject {
  final BuildContext context;
  final WidgetRef ref;

  const AppDependency(this.context, this.ref);
}

final mainAppSettings = AppSettings<AppData, DependencyObject>(
  appName: 'Example',
  dependencies: (input) async {
    if (input is AppDependency) {
      // Because our app needs riverpod's ref and flutter's context to
      // find its dependencies
      return resolveAppDependencies(input.context, input.ref);
    }
  },
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  flavorName: SettingsFor.production.id,
  identifier: SettingsFor.production,
);

class AppData {
  final AppApi mainApi;

  const AppData(this.mainApi);
}

AppApi get currentAppApi => (currentSettings.payload as AppData).mainApi;
