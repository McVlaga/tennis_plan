import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class WeaknessItemWidget extends StatelessWidget {
  const WeaknessItemWidget({
    Key? key,
    required this.weakness,
  }) : super(key: key);
  final String weakness;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingTwo,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10.0,
            height: 10.0,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(top: 4),
          ),
          const SizedBox(width: 16),
          Flexible(child: Text(weakness)),
        ],
      ),
    );
  }
}
