import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/settings_item_widget.dart';
import '../../constants/constants.dart';
import '../../matches/models/validation_match.dart';

class TimeItem extends StatelessWidget {
  const TimeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<ValidationMatch>(context);
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        child: SettingsItemWidget(
          title: 'Time',
          label: newMatch.getMatchTimeString(context),
          showError: newMatch.showError(newMatch.matchTime),
        ),
        onTap: () async {
          await showTimeDialog(context, newMatch);
        },
      ),
    );
  }

  Future<void> showTimeDialog(
      BuildContext context, ValidationMatch newMatch) async {
    FocusScope.of(context).unfocus();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime:
          newMatch.matchTime == null ? TimeOfDay.now() : newMatch.matchTime!,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme:
                const ColorScheme.light(primary: AppColors.primaryColor),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != newMatch.matchTime) {
      newMatch.setMatchTime(pickedTime);
    }
  }
}
