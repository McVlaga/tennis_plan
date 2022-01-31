import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/validation_match.dart';
import '../../widgets/radio_button.dart';
import '../../constants/constants.dart';
import '../../widgets/settings_item_widget.dart';

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
        return ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 300),
          child: Wrap(
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
      },
    );
  }
}
