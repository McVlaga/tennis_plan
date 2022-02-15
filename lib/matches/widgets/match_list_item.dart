import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../models/a_match.dart';
import 'flag_and_name_widget.dart';
import 'surface_practice_badge_widget.dart';
import 'win_lose_badge_widget.dart';

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
                          child: FlagAndNameWidget(fullName: false),
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
