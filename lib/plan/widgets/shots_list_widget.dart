import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../opponent_info/models/shot.dart';
import '../../opponent_info/models/shots.dart';
import 'shot_item_widget.dart';

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
