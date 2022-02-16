import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/widgets/flag_name_widget.dart';

import '../../constants/constants.dart';
import '../models/a_match.dart';

class MatchListItem extends StatelessWidget {
  const MatchListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AMatch match = context.watch<AMatch>();
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/match-detail',
          arguments: match.id,
        );
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SizedBox(
        height: 110,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            const WinLoseBadgeWidget(),
            Positioned(
              height: 20,
              left: 16,
              top: 10,
              child: Text(
                match.isOpponentLefty! ? 'LEFTY' : '',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Theme.of(context).textTheme.headline6?.color,
                ),
              ),
            ),
            Positioned(
              height: 20,
              right: 16,
              bottom: 20,
              child: Text(
                match.isPractice! ? 'PRACTICE' : '',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Theme.of(context).textTheme.headline6?.color,
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.paddingTwo,
                      right: Dimensions.paddingFive,
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: FlagNameWidget(fullName: false),
                        ),
                        SizedBox(width: 10),
                        Text(
                          Strings.matchListItemVSString,
                          style: TextStyle(
                              fontSize: Fonts.matchListItemVSFontSize,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                const SurfacePracticeBadgeWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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

class SurfacePracticeBadgeWidget extends StatelessWidget {
  const SurfacePracticeBadgeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AMatch match = context.watch<AMatch>();
    return Container(
      height: 20,
      width: double.infinity,
      decoration: BoxDecoration(
        color: match.getSurfaceColor(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingTwo),
        child: Row(
          children: [
            if (match.courtSurface != null)
              Text(
                match.buildSurfaceLocationString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 12,
                ),
              ),
            const Spacer(),
            Text(
              match.getDateString(context),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
