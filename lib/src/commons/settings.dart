import 'package:app_boot/app_boot.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme.dart';

class SettingsFor {
  static const production = SettingsIdentifier('production');
  static const staging = SettingsIdentifier('staging');
  static const development = SettingsIdentifier('development');
}

class AppDependency with DependencyObject {
  final BuildContext context;
  final WidgetRef ref;

  const AppDependency(this.context, this.ref);
}

final mainAppSettings = AppSettings<Object, DependencyObject>(
  flavorName: 'production',
  appName: 'Example',
  dependencies: (input) async {
    await Future.delayed(const Duration(milliseconds: 1000));
  },
  theme: AppTheme.regular,
  identifier: SettingsFor.production,
);
