import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../matches/models/a_match.dart';
import '../../settings/widgets/settings_item_widget.dart';
import '../../widgets/radio_button.dart';
import '../models/validation_match.dart';

class CourtSurfaceItem extends StatelessWidget {
  const CourtSurfaceItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final match = context.watch<ValidationMatch>();
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        child: SettingsItemWidget(
          title: 'Surface',
          label: match.courtSurfaceString,
          showError: match.showError(match.courtSurface),
        ),
        onTap: () {
          showDialog(context, match);
        },
      ),
    );
  }

  void showDialog(BuildContext context, ValidationMatch match) {
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
        return CourtSurfacePickerDialog(match: match);
      },
    );
  }
}

class CourtSurfacePickerDialog extends StatelessWidget {
  const CourtSurfacePickerDialog({
    Key? key,
    required this.match,
  }) : super(key: key);

  final ValidationMatch match;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Wrap(
        children: <Widget>[
          RadioButton(
            label: 'Hard Indoors',
            valueType: match.courtSurface,
            value: CourtSurface.hardIndoors,
            function: () {
              if (match.courtSurface != CourtSurface.hardIndoors) {
                match.setCourtSurface(CourtSurface.hardIndoors);
              }
              Navigator.pop(context);
            },
          ),
          RadioButton(
            label: 'Hard Outdoors',
            valueType: match.courtSurface,
            value: CourtSurface.hardOutdoors,
            function: () {
              if (match.courtSurface != CourtSurface.hardOutdoors) {
                match.setCourtSurface(CourtSurface.hardOutdoors);
              }
              Navigator.pop(context);
            },
          ),
          RadioButton(
            label: 'Clay',
            valueType: match.courtSurface,
            value: CourtSurface.clay,
            function: () {
              if (match.courtSurface != CourtSurface.clay) {
                match.setCourtSurface(CourtSurface.clay);
              }
              Navigator.pop(context);
            },
          ),
          RadioButton(
            label: 'Grass',
            valueType: match.courtSurface,
            value: CourtSurface.grass,
            function: () {
              if (match.courtSurface != CourtSurface.grass) {
                match.setCourtSurface(CourtSurface.grass);
              }
              Navigator.pop(context);
            },
          ),
          RadioButton(
            label: 'Carpet',
            valueType: match.courtSurface,
            value: CourtSurface.carpet,
            function: () {
              if (match.courtSurface != CourtSurface.carpet) {
                match.setCourtSurface(CourtSurface.carpet);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
