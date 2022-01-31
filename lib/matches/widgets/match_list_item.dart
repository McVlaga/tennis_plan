import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../match_detail/match_detail_tab_bar_screen.dart';
import '../models/a_match.dart';
import 'flag_and_name_widget.dart';
import 'surface_practice_badge_widget.dart';
import 'win_lose_badge_widget.dart';

class MatchListItem extends StatelessWidget {
  const MatchListItem({
    Key? key,
    required this.match,
  }) : super(key: key);

  final AMatch match;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          MatchDetailTabBarScreen.routeName,
          arguments: match.id,
        );
      },
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            WinLoseBadgeWidget(match: match),
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.paddingTwo,
                      right: Dimensions.paddingFive,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: FlagAndNameWidget(
                            country: match.opponentCountry,
                            name:
                                '${match.opponentFirstName?[0]}. ${match.opponentLastName}',
                          ),
                        ),
                        const Text(
                          Strings.matchListItemVSString,
                          style: TextStyle(
                              fontSize: Fonts.matchListItemVSFontSize,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                SurfacePracticeBadgeWidget(match: match),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
