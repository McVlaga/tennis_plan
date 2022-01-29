import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../matches/models/validation_match.dart';
import '../../constants/constants.dart';

class PracticeCheckBox extends StatelessWidget {
  const PracticeCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<ValidationMatch>(context);
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: SwitchListTile(
        contentPadding: const EdgeInsets.only(
          left: Dimensions.paddingTwo,
          right: Dimensions.paddingTwo,
        ),
        title: const Text("Practice match"),
        value: newMatch.isPractice!,
        onChanged: (newValue) {
          newMatch.setIsPractice(newValue);
        }, //  <-- leading Checkbox
      ),
    );
  }
}
