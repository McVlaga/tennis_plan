import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_edit_match_radio_item.dart';
import 'radio_button.dart';
import '../../constants/constants.dart';
import '../../matches/models/a_match.dart';

class MatchResultItem extends StatelessWidget {
  const MatchResultItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<AMatch>(context);
    return AddEditMatchRadioItem(
      itemTitle: 'Result',
      choiceLabel: newMatch.matchState == MatchState.lose
          ? 'I lost'
          : newMatch.matchState == MatchState.win
              ? 'I won'
              : '',
      dialogBody: Wrap(
        children: [
          const SizedBox(height: Dimensions.paddingOne),
          RadioButton(
            label: 'I lost',
            valueType: newMatch.matchState,
            value: MatchState.lose,
            function: () {
              if (newMatch.matchState != MatchState.lose) {
                newMatch.setMatchState(MatchState.lose);
              }
              Navigator.pop(context);
            },
          ),
          RadioButton(
            label: 'I won',
            valueType: newMatch.matchState,
            value: MatchState.win,
            function: () {
              if (newMatch.matchState != MatchState.win) {
                newMatch.setMatchState(MatchState.win);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
