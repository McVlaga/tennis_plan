import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingTwo),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
