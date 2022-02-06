import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../models/a_match.dart';

class WinLoseBadgeWidget extends StatelessWidget {
  const WinLoseBadgeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AMatch match = context.watch<AMatch>();
    return Positioned(
      right: -14,
      bottom: 0,
      child: Transform.rotate(
        angle: Dimensions.badgeWinLoseAngle,
        child: Container(
          height: Dimensions.badgeWinLoseHeight,
          width: 300,
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
