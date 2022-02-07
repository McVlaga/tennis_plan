import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../matches/models/a_match.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/settings_item_widget.dart';
import '../models/validation_match.dart';

class CourtSurfaceItem extends StatelessWidget {
  const CourtSurfaceItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<ValidationMatch>(context);
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        child: SettingsItemWidget(
          title: 'Surface',
          label: newMatch.courtSurfaceString,
          showError: newMatch.showError(newMatch.courtSurface),
        ),
        onTap: () {
          showDialog(context, newMatch);
        },
      ),
    );
  }

  void showDialog(BuildContext context, ValidationMatch newMatch) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.borderRadius),
          topRight: Radius.circular(Dimensions.borderRadius),
        ),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Wrap(
            children: <Widget>[
              RadioButton(
                label: 'Hard Indoors',
                valueType: newMatch.courtSurface,
                value: CourtSurface.hardIndoors,
                function: () {
                  if (newMatch.courtSurface != CourtSurface.hardIndoors) {
                    newMatch.setCourtSurface(CourtSurface.hardIndoors);
                  }
                  Navigator.pop(context);
                },
              ),
              RadioButton(
                label: 'Hard Outdoors',
                valueType: newMatch.courtSurface,
                value: CourtSurface.hardOutdoors,
                function: () {
                  if (newMatch.courtSurface != CourtSurface.hardOutdoors) {
                    newMatch.setCourtSurface(CourtSurface.hardOutdoors);
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
      },
    );
  }
}
