import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'storage_manager.dart';

class ThemeManager with ChangeNotifier {
  final darkTheme = ThemeData(
    fontFamily: 'Rubik',
    primarySwatch: AppColors.primarySwatchDark,
    primaryColor: AppColors.primarySwatchDark,
    canvasColor: AppColors.backgroundColorDark,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.appBarBackgroundColorDark,
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
    textTheme: const TextTheme(
      headline6: TextStyle(color: AppColors.textSecondaryColorDark),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primarySwatchDark,
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
      selectionColor: AppColors.accentColorDark[900],
      selectionHandleColor: AppColors.accentColorDark[700],
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
    textTheme: const TextTheme(
      headline6: TextStyle(color: AppColors.textSecondaryColorLight),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primarySwatchLight,
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

extension ColorSchemeExtension on ColorScheme {
  Color get cardShotGoodBg => brightness == Brightness.light
      ? const Color(0xffE8F5E9)
      : const Color(0xFF292e40);

  Color get cardShotMediumBg => brightness == Brightness.light
      ? const Color(0xffFFF3E0)
      : const Color(0xFF292e40);

  Color get cardShotBadBg => brightness == Brightness.light
      ? const Color(0xffFFEBEE)
      : const Color(0xFF292e40);
}

enum ThemeType { dark, light }
