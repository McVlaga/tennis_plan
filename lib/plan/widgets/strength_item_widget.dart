import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class StrengthItemWidget extends StatelessWidget {
  const StrengthItemWidget({
    Key? key,
    required this.strength,
  }) : super(key: key);

  final String strength;

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
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(top: 4),
          ),
          const SizedBox(width: 16),
          Flexible(child: Text(strength)),
        ],
      ),
    );
  }
}
