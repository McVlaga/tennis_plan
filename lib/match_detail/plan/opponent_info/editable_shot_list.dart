import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../../constants/constants.dart';
import '../models/shot.dart';
import '../models/shots.dart';
import 'ripple_shot_widget.dart';

class EditableShotList extends StatelessWidget {
  const EditableShotList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Shots tempShots = context.watch<Shots>();
    final List<Shot> shots = tempShots.shots;
    if (shots.isEmpty) return const SizedBox.shrink();

    return ReorderableWrap(
      scrollPhysics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingTwo,
        vertical: Dimensions.paddingOne,
      ),
      spacing: 8.0,
      runSpacing: 8.0,
      onReorder: (int from, int to) {
        tempShots.reorderOpponentShot(
            from, to, shots[from].name, shots[from].score);
      },
      children: [
        ...shots.map((shot) {
          return ChangeNotifierProvider.value(
            value: shot,
            builder: (_, __) {
              return RippleShotWidget(shots: tempShots);
            },
          );
        }).toList(),
      ],
      buildDraggableFeedback: (context, constraints, child) => ConstrainedBox(
        constraints: constraints,
        child: child,
      ),
    );
  }
}
