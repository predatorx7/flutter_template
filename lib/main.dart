import 'package:app_boot/app_boot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magnific_core/magnific_core.dart';

import 'src/commons/bootstrap.dart';
import 'src/commons/settings.dart';
import 'src/ui/main/app.dart';
import 'src/utils/logging.dart';
import 'src/services/uri.dart';

void main() {
  final bootstrap = BootstrapApp(
    onStart: () async {
      settingsManager.settings = mainAppSettings.copyWith(
        flavorName: SettingsFor.production.id,
        identifier: SettingsFor.production,
        payload: AppData(
          AppApi(
            Uri.https('example.com', ''),
          ),
        ),
      );

      await onStart();
    },
    loggingManager: () {
      return createDefaultLoggingManager(false);
    },
    onStarted: onStarted,
    onEnd: onEnd,
  );

  bootstrap.start(
    () => runApp(
      const ProviderScope(
        child: MainApp(),
      ),
    ),
  );
}
