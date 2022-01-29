import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../matches/models/matches.dart';
import 'plan_screen.dart';
import 'review_screen.dart';

class MatchDetailTabBarScreen extends StatefulWidget {
  static const routeName = '/match-detail-tab-bar';

  const MatchDetailTabBarScreen({Key? key}) : super(key: key);

  @override
  _MatchDetailTabBarScreenState createState() =>
      _MatchDetailTabBarScreenState();
}

class _MatchDetailTabBarScreenState extends State<MatchDetailTabBarScreen> {
  @override
  Widget build(BuildContext context) {
    final String matchId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedMatch =
        Provider.of<Matches>(context, listen: false).findById(matchId);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(text: 'PLAN'),
              Tab(text: 'REVIEW'),
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('VS ${loadedMatch.opponentLastName}'),
        ),
        body: const TabBarView(
          children: [
            PlanScreen(),
            ReviewScreen(),
          ],
        ),
      ),
    );
  }
}
