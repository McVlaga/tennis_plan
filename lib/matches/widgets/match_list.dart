import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'match_list_item.dart';
import '../../widgets/ripple_list_item.dart';
import '../models/matches.dart';
import 'filter_widget.dart';

import '../../constants/constants.dart';

class MatchList extends StatelessWidget {
  const MatchList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final matches = Provider.of<Matches>(context).matches;

    if (matches.isEmpty) {
      return const Center(child: Text('No Matches :('));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.only(
          left: Dimensions.paddingTwo,
          right: Dimensions.paddingTwo,
          top: Dimensions.paddingTwo,
          bottom: Dimensions.matchesListPaddingBottom,
        ),
        itemCount: matches.isEmpty ? 1 : matches.length + 1,
        itemBuilder: (_, index) {
          if (index == 0) {
            return FilterWidget();
          }
          index--;

          return RippleListItem(
            child: MatchListItem(
              match: matches[index],
            ),
          );
        },
      );
    }
  }
}
