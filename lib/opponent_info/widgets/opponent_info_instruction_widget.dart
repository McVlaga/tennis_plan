import 'package:flutter/material.dart';

class OpponentInfoInstructionWidget extends StatelessWidget {
  const OpponentInfoInstructionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '1. Tap on an item to edit or delete it.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '2. Tap and hold to drag an item and place it somewhere else.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
