import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../constants/constants.dart';
import '../add_header_list_button.dart';
import '../dialogs/add_edit_strength_dialog.dart';
import '../models/strengths.dart';
import 'editable_strength_item_widget.dart';

class EditableStrengthsListWidget extends StatelessWidget {
  const EditableStrengthsListWidget({
    Key? key,
  }) : super(key: key);

  void showAddItemDialog(BuildContext ctx, Strengths tempStrengths) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.borderRadius),
          topRight: Radius.circular(Dimensions.borderRadius),
        ),
      ),
      backgroundColor: Theme.of(ctx).canvasColor,
      builder: (_) {
        return AddEditStrengthDialog(strengths: tempStrengths, strength: null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Strengths tempStrengths = context.watch<Strengths>();
    List<String> strengths = tempStrengths.strengths;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingOne),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
      ),
      child: Column(
        children: [
          AddHeaderListButton(
            title: 'Add a strength',
            showDialog: () {
              showAddItemDialog(context, tempStrengths);
            },
          ),
          ReorderableColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...strengths.map((strength) {
                return EditableStrengthItemWidget(
                  key: ValueKey(strength),
                  strengths: tempStrengths,
                  strength: strength,
                );
              }).toList(),
            ],
            onReorder: (int from, int to) {
              tempStrengths.reorderOpponentStrength(from, to, strengths[from]);
            },
            buildDraggableFeedback: (context, constraints, child) =>
                ConstrainedBox(
              constraints: constraints,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
