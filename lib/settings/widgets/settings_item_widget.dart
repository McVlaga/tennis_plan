import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({
    Key? key,
    required this.title,
    required this.label,
    required this.showError,
  }) : super(key: key);

  final String title;
  final String label;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    Color labelColor;
    if (showError) {
      labelColor = Theme.of(context).colorScheme.error;
    } else {
      labelColor = Theme.of(context).colorScheme.secondaryVariant;
    }
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingTwo),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: labelColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
