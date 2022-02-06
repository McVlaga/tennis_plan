import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/a_match.dart';

import '../../constants/constants.dart';

class FlagAndNameWidget extends StatelessWidget {
  const FlagAndNameWidget({
    Key? key,
  }) : super(key: key);

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
              Text(
                match.getFullNameString(),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(fontSize: Fonts.matchListItemFontSize),
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
