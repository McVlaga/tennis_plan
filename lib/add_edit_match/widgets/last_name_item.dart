import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../models/validation_match.dart';

class LastNameItem extends StatelessWidget {
  const LastNameItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<ValidationMatch>(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingTwo,
        vertical: Dimensions.paddingOne,
      ),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        onChanged: (newValue) {
          newMatch.setOpponentLastName(newValue);
        },
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: 'Last Name',
          errorText: newMatch.opponentLastNameError,
        ),
      ),
    );
  }
}
