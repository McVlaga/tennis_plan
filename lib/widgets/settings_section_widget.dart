import 'package:flutter/material.dart';
import '../constants/constants.dart';

class SettingsSectionWidget extends StatelessWidget {
  const SettingsSectionWidget({
    required this.sectionTitle,
    required this.sectionWidgets,
    Key? key,
  }) : super(key: key);

  final String sectionTitle;
  final List<Widget> sectionWidgets;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (sectionTitle.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.paddingThree,
              bottom: Dimensions.paddingTwo,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                sectionTitle,
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
              children: <Widget>[
                const SizedBox(height: Dimensions.paddingOne),
                ...sectionWidgets,
                const SizedBox(height: Dimensions.paddingOne),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
