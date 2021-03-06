import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'widgets/settings_first_name.dart';
import 'widgets/settings_last_name.dart';
import 'widgets/settings_section_widget.dart';
import 'widgets/theme_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: Dimensions.paddingTwo,
          right: Dimensions.paddingTwo,
          bottom: Dimensions.paddingTwo,
        ),
        child: Column(
          children: const [
            SettingsSectionWidget(
              title: 'USER INFO',
              children: [
                SettingsFirstName(),
                SettingsLastName(),
              ],
            ),
            SettingsSectionWidget(
              title: 'THEME',
              children: [
                ThemeItem(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
