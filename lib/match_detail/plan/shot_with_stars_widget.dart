import 'package:flutter/material.dart';
import 'package:tennis_plan/constants/constants.dart';
import 'package:tennis_plan/services/theme_manager.dart';

class ShotWithStarsWidget extends StatelessWidget {
  const ShotWithStarsWidget({
    required this.title,
    required this.starNumber,
    Key? key,
  }) : super(key: key);

  final String title;
  final String starNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.borderRadius),
        ),
        color: Theme.of(context).colorScheme.cardShotGoodBg,
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                starNumber,
                style: TextStyle(fontSize: 20),
              ),
              Icon(
                Icons.star,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
