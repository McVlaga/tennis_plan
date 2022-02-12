import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_edit_match/add_edit_match_screen.dart';
import 'bottom_tab_bar_screen.dart';
import 'court_drawing/draw_plan_screen.dart';
import 'match_detail/match_detail_tab_bar_screen.dart';
import 'matches/models/matches.dart';
import 'mental/add_edit_mental_goals_sreen.dart';
import 'opponent_info/add_edit_opponent_info._screen.dart';
import 'other/add_edit_other_goals.dart';
import 'services/theme_manager.dart';
import 'settings/models/user_info.dart';
import 'tactics/add_edit_tactical_goals_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance?.resamplingEnabled = true;
  UserInfo userInfo = UserInfo();
  await userInfo.loadUserInfo();
  ThemeManager themeManager = ThemeManager();
  await themeManager.loadTheme();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeManager),
        ChangeNotifierProvider.value(value: userInfo),
        ChangeNotifierProvider(create: (_) => Matches()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(builder: (context, theme, _) {
      return MaterialApp(
        title: 'Match Planner',
        debugShowCheckedModeBanner: false,
        theme: theme.getThemeData(),
        initialRoute: '/',
        routes: {
          '/': (context) => const BottomTabBarScreen(),
          MatchDetailTabBarScreen.routeName: (context) =>
              const MatchDetailTabBarScreen(),
          AddEditMatchScreen.routeName: (context) => const AddEditMatchScreen(),
          AddEditOpponentInfoScreen.routeName: (context) =>
              const AddEditOpponentInfoScreen(),
          AddEditTacticalGoalsScreen.routeName: (context) =>
              const AddEditTacticalGoalsScreen(),
          AddEditMentalGoalsScreen.routeName: (context) =>
              const AddEditMentalGoalsScreen(),
          AddEditOtherGoalsScreen.routeName: (context) =>
              const AddEditOtherGoalsScreen(),
          DrawPlanScreen.routeName: (context) => const DrawPlanScreen(),
        },
      );
    });
  }
}
