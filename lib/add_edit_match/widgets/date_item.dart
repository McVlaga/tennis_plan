import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../settings/widgets/settings_item_widget.dart';
import '../models/validation_match.dart';

class DateItem extends StatelessWidget {
  const DateItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final match = context.watch<ValidationMatch>();
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        child: SettingsItemWidget(
          title: 'Date',
          label: match.matchDateString,
        ),
        onTap: () async {
          await showDateDialog(context, match);
        },
      ),
    );
  }

  Future<void> showDateDialog(
      BuildContext context, ValidationMatch match) async {
    FocusScope.of(context).unfocus();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: match.matchDate == null ? DateTime.now() : match.matchDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
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
    if (pickedDate != null && pickedDate != match.matchDate) {
      match.setMatchDate(pickedDate);
    }
  }
}
