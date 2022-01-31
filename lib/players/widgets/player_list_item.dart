import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class PlayerListItem extends StatelessWidget {
  const PlayerListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.paddingOne,
        right: Dimensions.paddingOne,
        top: Dimensions.paddingZero,
        bottom: Dimensions.paddingZero,
      ),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
        child: InkWell(
          borderRadius:
              const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
          onTap: () {},
          child: const SizedBox(
            width: double.infinity,
            child: ListTile(
              leading: SizedBox(
                height: Dimensions.playerItemIconHeight,
                width: Dimensions.playerItemIconHeight,
                child: CircleAvatar(
                  radius: Dimensions.circleAvatarRadius,
                  backgroundImage: AssetImage('icons/flags/png/ru.png',
                      package: 'country_icons'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              title: Text('A. Masin'),
              subtitle: Text('ATP 100'),
            ),
          ),
        ),
      ),
    );
  }
}
