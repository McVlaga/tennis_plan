import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../matches/models/a_match.dart';

class SettingsDateItem extends StatelessWidget {
  const SettingsDateItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<AMatch>(context);
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingTwo),
          child: Row(
            children: [
              const Text(
                'Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (newMatch.matchDate != null)
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      DateFormat('MMM d, yyyy').format(newMatch.matchDate!),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
        onTap: () async {
          FocusScope.of(context).unfocus();
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: newMatch.matchDate == null
                ? DateTime.now()
                : newMatch.matchDate!,
            firstDate: DateTime(2015, 8),
            lastDate: DateTime(2101),
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
          if (pickedDate != null && pickedDate != newMatch.matchDate) {
            newMatch.setMatchDate(pickedDate);
          }
        },
      ),
    );
  }
}
