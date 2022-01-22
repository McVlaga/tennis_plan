import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../matches/models/a_match.dart';

class SettingsFirstNameItem extends StatelessWidget {
  const SettingsFirstNameItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<AMatch>(context);
    return Container(
      height: Dimensions.addMatchDialogInputHeight,
      padding: const EdgeInsets.only(
        left: Dimensions.paddingTwo,
        right: Dimensions.paddingTwo,
      ),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        onChanged: (newValue) {
          newMatch.setOpponentFirstName(newValue);
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'FirstName',
        ),
      ),
    );
  }
}
