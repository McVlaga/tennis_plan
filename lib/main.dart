import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_navigation.dart';
import 'matches/models/matches.dart';
import 'services/theme_manager.dart';
import 'settings/models/user_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
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

  static final mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(builder: (context, theme, _) {
      return MaterialApp(
        title: 'Match Planner',
        debugShowCheckedModeBanner: false,
        theme: theme.getThemeData(),
        initialRoute: MainNavigationRouteNames.mainScreen,
        routes: mainNavigation.routes,
      );
    });
  }
}
