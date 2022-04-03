import 'package:flutter/material.dart';

import 'color_schemes.dart';
import 'type.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    colorScheme: lightColorScheme,
    useMaterial3: true,
    typography: AppTypography.typography,
  );

  static ThemeData dark = ThemeData(
    colorScheme: darkColorScheme,
    useMaterial3: true,
    typography: AppTypography.typography,
  );
}
