import 'package:flutter/material.dart';

import 'type.dart';

class AppTheme {
  static const backgroundColor = Color(0xFFE5E5E5);
  static const mainColor = Color(0xFF1A1A1A);

  static ThemeData regular = ThemeData(
    primaryColor: Colors.grey,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(
      secondary: mainColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    backgroundColor: backgroundColor,
    scaffoldBackgroundColor: backgroundColor,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: mainColor,
      // ignore: deprecated_member_use
      backwardsCompatibility: false,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 21,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: const Color(0xFF1A1A1A),
        onPrimary: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    ),
    buttonBarTheme: const ButtonBarThemeData(
      buttonPadding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      alignment: MainAxisAlignment.end,
      buttonTextTheme: ButtonTextTheme.normal,
      layoutBehavior: ButtonBarLayoutBehavior.padded,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedLabelStyle: TextStyle(
        color: Colors.white,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: UnderlineInputBorder(),
      fillColor: Colors.transparent,
      filled: true,
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: AppTextTheme.textTheme.bodyText1!.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
    primaryTextTheme: AppTextTheme.textTheme,
    textTheme: AppTextTheme.textTheme,
    bottomSheetTheme: const BottomSheetThemeData(
      modalBackgroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
    ),
    cardTheme: const CardTheme(
      color: Color(0xFFFBFCFF),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
    ),
  );
}
