import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../matches/models/a_match.dart';

class SettingsLastNameItem extends StatelessWidget {
  const SettingsLastNameItem({
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
          newMatch.setOpponentLastName(newValue);
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Last Name',
        ),
      ),
    );
  }
}
