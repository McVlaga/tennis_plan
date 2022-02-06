import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import '../models/strengths.dart';
import '../ripple_strength_widget.dart';

class EditableStrengthList extends StatelessWidget {
  const EditableStrengthList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Strengths tempStrengths = context.watch<Strengths>();
    List<String> strengths = tempStrengths.strengths;
    return ReorderableColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...strengths.map((strength) {
          return RippleStrengthWidget(
            key: ValueKey(strength),
            strengths: tempStrengths,
            strength: strength,
          );
        }).toList(),
      ],
      onReorder: (int from, int to) {
        tempStrengths.reorderOpponentStrength(from, to, strengths[from]);
      },
      buildDraggableFeedback: (context, constraints, child) => ConstrainedBox(
        constraints: constraints,
        child: child,
      ),
    );
  }
}
