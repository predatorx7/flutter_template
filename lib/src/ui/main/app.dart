import 'package:app_boot/app_boot.dart';
import 'package:example/src/commons/settings.dart';
import 'package:example/src/modules/navigation/router.dart';
import 'package:example/l10n/l10n.dart';
import 'package:example/src/ui/widget/banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainApp extends ConsumerWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = currentSettings;
    final _router = ref.read(routerProviderRef);

    Widget app = MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: settings.appName,
      theme: settings.theme,
      darkTheme: settings.darkTheme ?? settings.theme,
      themeMode: settings.darkTheme != null && settings.theme != null
          ? ThemeMode.system
          : (settings.darkTheme != null ? ThemeMode.dark : ThemeMode.light),
      debugShowCheckedModeBanner: false,
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
