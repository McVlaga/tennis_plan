import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../matches/models/a_match.dart';

class FlagNameWidget extends StatelessWidget {
  const FlagNameWidget({
    Key? key,
    required this.fullName,
  }) : super(key: key);

  final bool fullName;

  @override
  Widget build(BuildContext context) {
    AMatch match = context.watch<AMatch>();
    return Row(
      children: <Widget>[
        if (match.opponentCountry != null)
          SizedBox(
            height: Dimensions.matchItemIconHeight,
            width: Dimensions.matchItemIconHeight,
            child: CircleAvatar(
              key: ValueKey(match.id),
              radius: Dimensions.circleAvatarRadius,
              foregroundImage: AssetImage(
                match.getFlagImagePath(),
                package: General.countryIconsPackage,
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        if (match.opponentCountry != null)
          const SizedBox(
            width: Dimensions.paddingOne,
          ),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  match.getNameString(fullName),
                  maxLines: 1,
                  softWrap: false,
                  style: const TextStyle(fontSize: Fonts.matchListItemFontSize),
                ),
              ),
              if (match.opponentRanking != null)
                Text(
                  match.getRankingString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).textTheme.headline6?.color,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
