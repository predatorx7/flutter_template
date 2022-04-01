import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:magnific_core/magnific_core.dart';

class AppLocale {
  AppLocale._();

  static List<Locale> deviceLocales() {
    final _platformDispatcher = WidgetsBinding.instance?.platformDispatcher;
    if (_platformDispatcher != null) {
      return _platformDispatcher.locales;
    }
    return ui.window.locales;
  }

  static Locale deviceLocale() {
    final _platformDispatcher = WidgetsBinding.instance?.platformDispatcher;
    if (_platformDispatcher != null) {
      return _platformDispatcher.locale;
    }
    return ui.window.locale;
  }

  static Future<Locale> deviceCurrentLocale() async {
    try {
      final locale = await Devicelocale.currentAsLocale;
      if (locale != null) {
        return locale;
      }
    } catch (e, s) {
      logger.warning('Failed to get locale', e, s);
    }
    return deviceLocale();
  }

  static Future<List<Locale>> devicePreferredLocales() async {
    try {
      final locale = await Devicelocale.preferredLanguagesAsLocales;
      return locale;
    } catch (e, s) {
      logger.warning('Failed to get locale', e, s);
    }
    final current = await deviceCurrentLocale();
    return <Locale>[current];
  }
}
