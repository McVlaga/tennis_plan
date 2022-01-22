import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_edit_match/add_edit_match_screen.dart';
import 'constants/constants.dart';
import 'match_detail/match_detail_tab_bar_screen.dart';
import 'matches/models/matches.dart';
import 'screens/bottom_tab_bar_screen.dart';

void main() {
  GestureBinding.instance?.resamplingEnabled = true;
  runApp(
    ChangeNotifierProvider(
      create: (context) => Matches(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.primaryColor,
        canvasColor: AppColors.backgroundColor,
        fontFamily: Fonts.rubikFont,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.accentColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.black,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: TextButton.styleFrom(
            primary: AppColors.primaryColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            primary: AppColors.primaryColor,
            backgroundColor: AppColors.primaryColor,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: AppColors.primaryColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.accentColor[700],
          selectionColor: AppColors.primaryColor,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const BottomTabBarScreen(),
        MatchDetailTabBarScreen.routeName: (context) =>
            const MatchDetailTabBarScreen(),
        AddEditMatchScreen.routeName: (context) => const AddEditMatchScreen(),
      },
    );
  }
}
