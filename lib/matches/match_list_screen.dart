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
      ),
      body: const MatchList(),
    );
  }
}
