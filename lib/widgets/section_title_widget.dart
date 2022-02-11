import 'package:flutter/material.dart';

import '../constants/constants.dart';

class SectionTitleWidget extends StatelessWidget {
  const SectionTitleWidget({required this.title, Key? key}) : super(key: key);

  final String title;

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
