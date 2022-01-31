import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'storage_manager.dart';

class ThemeManager with ChangeNotifier {
  final darkTheme = ThemeData(
    fontFamily: 'Rubik',
    canvasColor: AppColors.backgroundColorDark,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColorDark,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.accentColorDark,
    ),
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.0,
          color: AppColors.accentColorDark,
        ),
      ),
    ),
    colorScheme: const ColorScheme.dark(
      secondary: AppColors.accentColorDark,
      secondaryVariant: AppColors.accentColorTwoDark,
      surface: AppColors.surfaceColorDark,
      error: Colors.red,
      onSecondary: AppColors.onSecondaryColorDark,
      onPrimary: AppColors.onPrimaryColorDark,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.accentColorDark),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.accentColorDark),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.accentColorDark[700],
      selectionColor: AppColors.primaryColorDark,
      selectionHandleColor: AppColors.primaryColorDark,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accentColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.grey),
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
  );

  final lightTheme = ThemeData(
    fontFamily: 'Rubik',
    primarySwatch: AppColors.primarySwatchLight,
    canvasColor: AppColors.backgroundColorLight,
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.accentColorLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.appBarBackgroundColorLight,
      foregroundColor: Colors.black87,
      elevation: 0,
    ),
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2.0,
          color: AppColors.accentColorLight,
        ),
      ),
    ),
    colorScheme: const ColorScheme.light(
      secondary: AppColors.accentColorLight,
      secondaryVariant: AppColors.accentColorTwoLight,
      surface: AppColors.surfaceColorLight,
      error: Colors.red,
      onSecondary: AppColors.onSecondaryColorLight,
      onPrimary: AppColors.onPrimaryColorLight,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.accentColorLight),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.accentColorLight),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.accentColorLight,
      selectionColor: AppColors.primaryColorLight,
      selectionHandleColor: AppColors.primaryColorLight,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accentColorLight,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.grey[700]),
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );

  late ThemeData _themeData;
  late ThemeType _theme;
  ThemeData getThemeData() => _themeData;
  ThemeType getTheme() => _theme;

  ThemeManager() {
    _themeData = lightTheme;
    _theme = ThemeType.light;
  }

  Future<void> loadTheme() async {
    var value = await StorageManager.readData('themeMode');

    var themeMode = value ?? 'light';
    if (themeMode == 'dark') {
      _themeData = darkTheme;
      _theme = ThemeType.dark;
    } else if (themeMode == 'light') {
      _themeData = lightTheme;
      _theme = ThemeType.light;
    }
    notifyListeners();
  }

  void setDarkTheme() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    _theme = ThemeType.dark;
    notifyListeners();
  }

  void setLightTheme() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    _theme = ThemeType.light;
    notifyListeners();
  }
}

enum ThemeType { dark, light }
