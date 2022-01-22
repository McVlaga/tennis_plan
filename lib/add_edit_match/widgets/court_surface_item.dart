import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'radio_button.dart';
import '../../constants/constants.dart';
import '../../matches/models/a_match.dart';

import 'add_edit_match_radio_item.dart';

class CourtSurfaceItem extends StatelessWidget {
  const CourtSurfaceItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<AMatch>(context);
    return AddEditMatchRadioItem(
      itemTitle: 'Surface',
      choiceLabel:
          newMatch.courtSurface == null ? '' : newMatch.courtSurface!.name,
      dialogBody: Wrap(
        children: <Widget>[
          const SizedBox(height: Dimensions.paddingOne),
          RadioButton(
            label: 'Hard',
            valueType: newMatch.courtSurface,
            value: CourtSurface.hard,
            function: () {
              if (newMatch.courtSurface != CourtSurface.hard) {
                newMatch.setCourtSurface(CourtSurface.hard);
              }
              Navigator.pop(context);
            },
          ),
          RadioButton(
            label: 'Clay',
            valueType: newMatch.courtSurface,
            value: CourtSurface.clay,
            function: () {
              if (newMatch.courtSurface != CourtSurface.clay) {
                newMatch.setCourtSurface(CourtSurface.clay);
              }
              Navigator.pop(context);
            },
          ),
          RadioButton(
            label: 'Grass',
            valueType: newMatch.courtSurface,
            value: CourtSurface.grass,
            function: () {
              if (newMatch.courtSurface != CourtSurface.grass) {
                newMatch.setCourtSurface(CourtSurface.grass);
              }
              Navigator.pop(context);
            },
          ),
          RadioButton(
            label: 'Carpet',
            valueType: newMatch.courtSurface,
            value: CourtSurface.carpet,
            function: () {
              if (newMatch.courtSurface != CourtSurface.carpet) {
                newMatch.setCourtSurface(CourtSurface.carpet);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
