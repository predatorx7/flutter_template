import 'package:app_boot/app_boot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magnific_core/magnific_core.dart';

import 'src/commons/bootstrap.dart';
import 'src/commons/settings.dart';
import 'src/ui/app.dart';
import 'src/utils/logging.dart';

void main() {
  final bootstrap = BootstrapApp(
    onStart: () async {
      await initFirebase();

      settingsManager.settings = mainAppSettings;
    },
    loggingManager: () {
      return createDefaultLoggingManager();
    },
    onStarted: bootstrapFutures,
  );

  bootstrap.start(
    () => runApp(
      const ProviderScope(
        child: MainApp(),
      ),
    ),
  );
}
