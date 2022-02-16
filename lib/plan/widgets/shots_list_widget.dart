import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../opponent_info/models/shot.dart';
import '../../opponent_info/models/shots.dart';

class ShotsListWidget extends StatelessWidget {
  const ShotsListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Shot> shots = context.watch<Shots>().shots;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingTwo,
      ),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          ...shots.map((shot) {
            return ChangeNotifierProvider.value(
              value: shot,
              builder: (_, __) {
                return const ShotItemWidget();
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}

class ShotItemWidget extends StatelessWidget {
  const ShotItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Shot shot = context.watch<Shot>();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: shot.getShotColor(context),
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              shot.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  shot.score.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
