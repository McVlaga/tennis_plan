import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../widgets/settings_section_title.dart';

class AddEditMatchSection extends StatelessWidget {
  const AddEditMatchSection({
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
        SettingsSectionTitle(title: sectionTitle),
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(Dimensions.borderRadius),
          ),
          child: Material(
            color: Colors.white,
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
