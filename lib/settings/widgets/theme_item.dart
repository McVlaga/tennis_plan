import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../services/theme_manager.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/settings_item_widget.dart';

class ThemeItem extends StatelessWidget {
  const ThemeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(builder: (context, theme, _) {
      String themeString = theme.getTheme().name;
      return SizedBox(
        height: Dimensions.addMatchDialogInputHeight,
        child: InkWell(
          child: SettingsItemWidget(
            title: 'Theme',
            label: themeString,
            showError: false,
          ),
          onTap: () {
            showDialog(context, theme);
          },
        ),
      );
    });
  }

  void showDialog(BuildContext context, ThemeManager theme) {
    ThemeType themeType = theme.getTheme();
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.borderRadius),
          topRight: Radius.circular(Dimensions.borderRadius),
        ),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      builder: (builder) {
        return ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 300),
          child: Wrap(
            children: <Widget>[
              const SizedBox(height: Dimensions.paddingOne),
              RadioButton(
                label: 'Light',
                valueType: themeType,
                value: ThemeType.light,
                function: () {
                  theme.setLightTheme();
                  Navigator.pop(context);
                },
              ),
              RadioButton(
                label: 'Dark',
                valueType: themeType,
                value: ThemeType.dark,
                function: () {
                  theme.setDarkTheme();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
