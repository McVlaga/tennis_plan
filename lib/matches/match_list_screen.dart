import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/matches/widgets/filter_widget.dart';
import 'package:tennis_plan/matches/widgets/match_list_item.dart';
import 'package:tennis_plan/widgets/ripple_list_item.dart';
import '../constants/constants.dart';
import 'models/matches.dart';

class MatchListScreen extends StatelessWidget {
  const MatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final matches = Provider.of<Matches>(context).matches;

    if (matches.isEmpty) {
      return const Center(child: Text('No Matches :('));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Matches'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(
            left: Dimensions.paddingTwo,
            right: Dimensions.paddingTwo,
            top: Dimensions.paddingTwo,
            bottom: Dimensions.matchesListPaddingBottom,
          ),
          itemCount: matches.isEmpty ? 1 : matches.length + 1,
          itemBuilder: (_, index) {
            if (index == 0) {
              return const FilterWidget();
            }
            index--;

            return RippleListItem(
              child: MatchListItem(
                match: matches[index],
              ),
            );
          },
        ),
      );
    }
  }
}
