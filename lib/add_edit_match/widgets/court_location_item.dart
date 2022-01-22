import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'radio_button.dart';
import '../../constants/constants.dart';
import '../../matches/models/a_match.dart';

import 'add_edit_match_radio_item.dart';

class CourtLocationItem extends StatelessWidget {
  const CourtLocationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<AMatch>(context);
    return AddEditMatchRadioItem(
      itemTitle: 'Location',
      choiceLabel:
          newMatch.courtLocation == null ? '' : newMatch.courtLocation!.name,
      dialogBody: Wrap(
        children: <Widget>[
          const SizedBox(height: Dimensions.paddingOne),
          RadioButton(
            label: 'Indoors',
            valueType: newMatch.courtLocation,
            value: CourtLocation.indoors,
            function: () {
              if (newMatch.courtLocation != CourtLocation.indoors) {
                newMatch.setCourtLocation(CourtLocation.indoors);
              }
              Navigator.pop(context);
            },
          ),
          RadioButton(
            label: 'Outdoors',
            valueType: newMatch.courtLocation,
            value: CourtLocation.outdoors,
            function: () {
              if (newMatch.courtLocation != CourtLocation.outdoors) {
                newMatch.setCourtLocation(CourtLocation.outdoors);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
