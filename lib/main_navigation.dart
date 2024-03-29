import 'package:flutter/material.dart';
import 'add_edit_match/add_edit_match_screen.dart';
import 'court_drawing/draw_plan_screen.dart';
import 'main_screen.dart';
import 'match_detail/match_detail_tab_bar_screen.dart';
import 'mental/add_edit_mentality_sreen.dart';
import 'opponent_info/add_edit_opponent_info._screen.dart';
import 'other/add_edit_other_goals.dart';
import 'tactics/add_edit%20_tactical_plan_screen.dart';
import 'tactics/add_edit_tactics_screen.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const matchDetails = '/match_details';
  static const addEditMatch = '/add_edit_match';
  static const addEditOpponentInfo = '/match_details/add_edit_opponent_info';
  static const addEditTactics = '/match_detail/add_edit_tactics';
  static const addEditTacticalPlan =
      '/match_detail/add_edit_tactics/add_edit_tactical_plan';
  static const addEditMentality = '/match_details/add_edit_mentality';
  static const addEditOtherGoals = '/match_detail/add_edit_other_goals';
  static const drawPlan =
      '/match_detail/add_edit_tactics/add_edit_tactical_plan/draw_plan';
}

class MainNavigation {
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.mainScreen: (context) => const MainScreen(),
    MainNavigationRouteNames.addEditMatch: (context) =>
        const AddEditMatchScreen(),
    MainNavigationRouteNames.addEditOpponentInfo: (context) =>
        const AddEditOpponentInfoScreen(),
    MainNavigationRouteNames.addEditTactics: (context) =>
        const AddEditTacticsScreen(),
    MainNavigationRouteNames.addEditTacticalPlan: (context) =>
        const AddEditTacticalPlanScreen(),
    MainNavigationRouteNames.addEditMentality: (context) =>
        const AddEditMentalityScreen(),
    MainNavigationRouteNames.addEditOtherGoals: (context) =>
        const AddEditOtherGoalsScreen(),
    MainNavigationRouteNames.drawPlan: (context) => const DrawPlanScreen(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.matchDetails:
        final arguments = settings.arguments;
        final matchId = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (context) => MatchDetailTabBarScreen(matchId: matchId),
        );
      default:
        const widget = Text('Navigation error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
