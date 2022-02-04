import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../models/validation_match.dart';

class FirstNameItem extends StatelessWidget {
  FirstNameItem({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    final newMatch = Provider.of<ValidationMatch>(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingTwo,
        vertical: Dimensions.paddingOne,
      ),
      child: TextField(
        controller: nameController,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: 'FirstName',
          errorText: newMatch.opponentFirstNameError,
        ),
      ),
    );
  }
}
