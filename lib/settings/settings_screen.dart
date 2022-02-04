import 'package:flutter/material.dart';
import '../add_edit_match/widgets/first_name_item.dart';
import '../add_edit_match/widgets/last_name_item.dart';
import 'widgets/settings_first_name.dart';
import 'widgets/settings_last_name.dart';
import 'widgets/theme_item.dart';
import '../constants/constants.dart';
import '../widgets/settings_section_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: Dimensions.paddingTwo,
          right: Dimensions.paddingTwo,
          bottom: Dimensions.paddingTwo,
        ),
        child: Column(
          children: const [
            SettingsSectionWidget(
              sectionTitle: 'USER INFO',
              sectionWidgets: [
                SettingsFirstName(),
                SettingsLastName(),
              ],
            ),
            SettingsSectionWidget(
              sectionTitle: 'THEME',
              sectionWidgets: [
                ThemeItem(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
