import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../settings/widgets/settings_item_widget.dart';
import '../models/validation_match.dart';

class TimeItem extends StatelessWidget {
  const TimeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final match = context.watch<ValidationMatch>();
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        child: SettingsItemWidget(
          title: 'Time',
          label: match.getMatchTimeString(context),
          showError: match.showError(match.matchTime),
        ),
        onTap: () async {
          await showTimeDialog(context, match);
        },
      ),
    );
  }

  Future<void> showTimeDialog(
      BuildContext context, ValidationMatch match) async {
    FocusScope.of(context).unfocus();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: match.matchTime == null
          ? TimeOfDay.now().replacing(minute: 0)
          : match.matchTime!,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme:
                ColorScheme.light(primary: Theme.of(context).primaryColor),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != match.matchTime) {
      match.setMatchTime(pickedTime);
    }
  }
}
