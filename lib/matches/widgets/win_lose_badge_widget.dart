import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../models/a_match.dart';

class WinLoseBadgeWidget extends StatelessWidget {
  const WinLoseBadgeWidget({
    Key? key,
    required this.match,
  }) : super(key: key);

  final AMatch match;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Transform.rotate(
        angle: Dimensions.badgeWinLoseAngle,
        child: Container(
          height: Dimensions.badgeWinLoseHeight,
          width: 270,
          color: match.matchResult == MatchState.win
              ? AppColors.winColor
              : match.matchResult == MatchState.lose
                  ? AppColors.loseColor
                  : AppColors.notPlayedColor,
        ),
      ),
    );
  }
}
