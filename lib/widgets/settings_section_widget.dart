import 'package:flutter/material.dart';

import '../constants/constants.dart';

class SettingsSectionWidget extends StatelessWidget {
  const SettingsSectionWidget({
    required this.title,
    required this.children,
    Key? key,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (title.isNotEmpty)
          Padding(
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
          ),
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(Dimensions.borderRadius),
          ),
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: Dimensions.paddingOne),
                ...children,
                const SizedBox(height: Dimensions.paddingOne),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
