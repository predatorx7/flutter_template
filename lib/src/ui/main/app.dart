import 'package:app_boot/app_boot.dart';
import 'package:example/src/commons/settings.dart';
import 'package:example/src/navigation/config.dart';
import 'package:example/l10n/l10n.dart';
import 'package:example/src/ui/widget/banner.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magnific_core/magnific_core.dart';

class MainApp extends ConsumerWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = currentSettings;
    final _nav = ref.read(navigationProvider);

    Widget app = MaterialApp(
      title: settings.appName,
      theme: settings.theme,
      darkTheme: settings.theme,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      navigatorKey: _nav.navigatorKey,
      onGenerateRoute: _nav.onGenerateRoute,
      onUnknownRoute: _nav.onUnknownRoute,
      navigatorObservers: [
        FirebaseAnalyticsObserver(
          analytics: FirebaseAnalytics.instance,
          onError: (e) {
            logger.warning(
              'Failed to send navigation analytics to firebase',
              e,
            );
          },
        ),
      ],
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );

    if (!settingsManager.isFor(SettingsFor.production)) {
      app = CustomModeBanner(
        label: currentSettings.flavorName,
        child: app,
      );
    }

    return app;
  }
}
