import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../widgets/settings_item_widget.dart';
import '../models/validation_match.dart';

class DateItem extends StatelessWidget {
  const DateItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<ValidationMatch>(context);
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        child: SettingsItemWidget(
          title: 'Date',
          label: newMatch.matchDateString,
          showError: newMatch.showError(newMatch.matchDate),
        ),
        onTap: () async {
          await showDateDialog(context, newMatch);
        },
      ),
    );
  }

  Future<void> showDateDialog(
      BuildContext context, ValidationMatch newMatch) async {
    FocusScope.of(context).unfocus();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          newMatch.matchDate == null ? DateTime.now() : newMatch.matchDate!,
      firstDate: DateTime(2015, 8),
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
    if (pickedDate != null && pickedDate != newMatch.matchDate) {
      newMatch.setMatchDate(pickedDate);
    }
  }
}
