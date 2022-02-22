import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/main_navigation.dart';

import '../constants/constants.dart';
import '../matches/models/a_match.dart';
import '../matches/models/matches.dart';
import '../plan/plan_screen.dart';
import '../review/review_screen.dart';

class MatchDetailTabBarScreen extends StatefulWidget {
  const MatchDetailTabBarScreen({Key? key}) : super(key: key);

  @override
  _MatchDetailTabBarScreenState createState() =>
      _MatchDetailTabBarScreenState();
}

class _MatchDetailTabBarScreenState extends State<MatchDetailTabBarScreen> {
  bool firstInit = true;

  late AMatch match;
  late Matches matches;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstInit) {
      _onInit();
    }
  }

  void _onInit() {
    String matchId = ModalRoute.of(context)!.settings.arguments as String;
    matches = Provider.of<Matches>(context, listen: false);
    match = matches.findById(matchId);
    firstInit = false;
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'Match VS ${match.opponentLastName}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          content: const Text("Are you sure you want to delete this match?"),
          actions: [
            TextButton(
              child: const Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "DELETE",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                matches.deleteMatch(match.id);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: match,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              labelColor: Theme.of(context).colorScheme.onPrimary,
              tabs: const [
                Tab(text: 'PLAN'),
                Tab(text: 'REVIEW'),
              ],
            ),
            title: Text(
              'VS ${match.opponentLastName}',
              overflow: TextOverflow.fade,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    MainNavigationRouteNames.addEditMatch,
                    arguments: match.id,
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: _showDeleteDialog,
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: const TabBarView(
            children: [
              PlanScreen(),
              ReviewScreen(),
            ],
          ),
          floatingActionButton: SpeedDial(
            icon: Icons.menu,
            activeIcon: Icons.close,
            spacing: Dimensions.paddingOne,
            visible: true,
            curve: Curves.bounceIn,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            heroTag: 'speed-dial-hero-tag',
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.onSecondary,
            elevation: 8.0,
            children: [
              SpeedDialChild(
                child: Icon(
                  Icons.accessibility,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                backgroundColor: Colors.red,
                label: 'Opponent info',
                labelStyle: const TextStyle(fontSize: 18.0),
                labelBackgroundColor:
                    Theme.of(context).appBarTheme.backgroundColor,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    MainNavigationRouteNames.addEditOpponentInfo,
                    arguments: match,
                  );
                },
              ),
              SpeedDialChild(
                child: Icon(
                  Icons.gamepad,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                backgroundColor: Colors.blue,
                label: 'Tactics',
                labelStyle: const TextStyle(fontSize: 18.0),
                labelBackgroundColor:
                    Theme.of(context).appBarTheme.backgroundColor,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    MainNavigationRouteNames.addEditTactics,
                    arguments: match,
                  );
                },
              ),
              SpeedDialChild(
                child: Icon(
                  Icons.health_and_safety,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                backgroundColor: Colors.green,
                label: 'Mental',
                labelStyle: const TextStyle(fontSize: 18.0),
                labelBackgroundColor:
                    Theme.of(context).appBarTheme.backgroundColor,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    MainNavigationRouteNames.addEditMentality,
                    arguments: match,
                  );
                },
              ),
              SpeedDialChild(
                child: Icon(
                  Icons.legend_toggle,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                backgroundColor: Colors.orange,
                label: 'Other',
                labelStyle: const TextStyle(fontSize: 18.0),
                labelBackgroundColor:
                    Theme.of(context).appBarTheme.backgroundColor,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    MainNavigationRouteNames.addEditOtherGoals,
                    arguments: match,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
