import 'package:flutter/material.dart';

import '../constants/constants.dart';

class SettingsSectionTitle extends StatelessWidget {
  final String title;

  const SettingsSectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.paddingThree,
        bottom: Dimensions.paddingTwo,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: Fonts.addMatchDialogMatchFontSize,
          ),
        ),
      ),
    );
  }
}
