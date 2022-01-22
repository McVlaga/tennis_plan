import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class FlagAndNameWidget extends StatelessWidget {
  final Country? country;
  final String name;

  const FlagAndNameWidget({Key? key, required this.name, required this.country})
      : super(key: key);

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
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: Fonts.matchListItemFontSize),
          ),
        ),
      ],
    );
  }
}
