import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/settings_item_widget.dart';
import '../../matches/models/validation_match.dart';
import '../../widgets/radio_button.dart';
import '../../constants/constants.dart';

class CourtLocationItem extends StatelessWidget {
  const CourtLocationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<ValidationMatch>(context);
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        child: SettingsItemWidget(
          title: 'Location',
          label: newMatch.courtLocationString,
          showError: newMatch.showError(newMatch.courtLocation),
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
      backgroundColor: Colors.white,
      builder: (builder) {
        return ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 300),
          child: Wrap(
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
      },
    );
  }
}
