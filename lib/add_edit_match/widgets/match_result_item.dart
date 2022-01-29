import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../matches/models/validation_match.dart';
import '../../widgets/radio_button.dart';
import '../../constants/constants.dart';
import '../../widgets/settings_item_widget.dart';

class MatchResultItem extends StatelessWidget {
  const MatchResultItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<ValidationMatch>(context);
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: InkWell(
        child: SettingsItemWidget(
          title: 'Result',
          label: newMatch.matchStateString,
          showError: newMatch.showError(newMatch.matchResult),
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
            children: [
              const SizedBox(height: Dimensions.paddingOne),
              RadioButton(
                label: 'I lost',
                valueType: newMatch.matchResult,
                value: MatchState.lose,
                function: () {
                  if (newMatch.matchResult != MatchState.lose) {
                    newMatch.setMatchState(MatchState.lose);
                  }
                  Navigator.pop(context);
                },
              ),
              RadioButton(
                label: 'I won',
                valueType: newMatch.matchResult,
                value: MatchState.win,
                function: () {
                  if (newMatch.matchResult != MatchState.win) {
                    newMatch.setMatchState(MatchState.win);
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
