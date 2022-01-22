import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../matches/models/a_match.dart';

class SettingsTimeItem extends StatelessWidget {
  const SettingsTimeItem({Key? key}) : super(key: key);

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
                'Time',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (newMatch.matchTime != null)
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      newMatch.matchTime!.format(context),
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
          final TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: newMatch.matchTime == null
                ? TimeOfDay.now()
                : newMatch.matchTime!,
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
        },
      ),
    );
  }
}
