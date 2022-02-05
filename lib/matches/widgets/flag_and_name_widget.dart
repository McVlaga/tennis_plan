import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class FlagAndNameWidget extends StatelessWidget {
  final Country? country;
  final String name;
  final String? ranking;

  const FlagAndNameWidget({
    Key? key,
    required this.name,
    required this.country,
    required this.ranking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (country != null)
          SizedBox(
            height: Dimensions.matchItemIconHeight,
            width: Dimensions.matchItemIconHeight,
            child: CircleAvatar(
              radius: Dimensions.circleAvatarRadius,
              backgroundImage: AssetImage(
                  'icons/flags/png/${country!.countryCode.toLowerCase()}.png',
                  package: General.countryIconsPackage),
              backgroundColor: Colors.transparent,
            ),
          ),
        if (country != null)
          const SizedBox(
            width: Dimensions.paddingOne,
          ),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(fontSize: Fonts.matchListItemFontSize),
              ),
              if (ranking != null)
                Text(
                  ranking!,
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
