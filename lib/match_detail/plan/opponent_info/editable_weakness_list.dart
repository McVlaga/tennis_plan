import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../models/weaknesses.dart';
import '../ripple_weakness_widget.dart';

class EditableWeaknessList extends StatelessWidget {
  const EditableWeaknessList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Weaknesses tempWeaknesses = context.watch<Weaknesses>();
    List<String> weaknesses = tempWeaknesses.weaknesses;
    return ReorderableColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...weaknesses.map((weakness) {
          return RippleWeaknessWidget(
            key: ValueKey(weakness),
            weaknesses: tempWeaknesses,
            weakness: weakness,
          );
        }).toList(),
      ],
      onReorder: (int from, int to) {
        tempWeaknesses.reorderOpponentWeakness(
          from,
          to,
          weaknesses[from],
        );
      },
      buildDraggableFeedback: (context, constraints, child) => ConstrainedBox(
        constraints: constraints,
        child: child,
      ),
    );
  }
}
