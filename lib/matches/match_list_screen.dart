import 'package:flutter/material.dart';

import '../add_edit_match/add_edit_match_screen.dart';
import '../constants/constants.dart';
import 'widgets/match_list.dart';

class MatchListScreen extends StatelessWidget {
  const MatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Matches'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const MatchList(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: Dimensions.navBarHeight),
        child: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: Dimensions.navBarItemIconHeight,
            color: AppColors.tabBarItemColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AddEditMatchScreen.routeName);
          },
        ),
      ),
    );
  }
}
