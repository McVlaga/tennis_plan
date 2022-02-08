import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../models/validation_match.dart';

class LeftyCheckBox extends StatelessWidget {
  const LeftyCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<ValidationMatch>(context);
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: SwitchListTile(
        activeColor: Theme.of(context).colorScheme.secondary,
        contentPadding: const EdgeInsets.only(
          left: Dimensions.paddingTwo,
          right: Dimensions.paddingTwo,
        ),
        title: const Text("Lefty"),
        value: newMatch.isOpponentLefty!,
        onChanged: (newValue) {
          newMatch.setIsOpponentLefty(newValue);
        }, //  <-- leading Checkbox
      ),
    );
  }
}
