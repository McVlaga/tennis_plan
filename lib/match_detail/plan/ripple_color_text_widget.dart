import 'package:flutter/material.dart';
import 'package:tennis_plan/constants/constants.dart';
import 'package:tennis_plan/matches/models/a_match.dart';

class RippleColorTextWidget extends StatelessWidget {
  const RippleColorTextWidget({
    Key? key,
    required this.itemColor,
    required this.item,
    required this.tapFunction,
  }) : super(key: key);

  final Color itemColor;
  final String item;
  final void Function()? tapFunction;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: tapFunction,
        child: Padding(
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
                decoration: BoxDecoration(
                  color: itemColor,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(top: 4),
              ),
              const SizedBox(width: 16),
              Flexible(child: Text(item)),
            ],
          ),
        ),
      ),
    );
  }
}
