import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../constants/constants.dart';
import '../add_header_list_button.dart';
import '../dialogs/add_edit_weakness_dialog.dart';
import '../models/weaknesses.dart';
import 'editable_weakness_item_widget.dart';

class EditableWeaknessesListWidget extends StatelessWidget {
  const EditableWeaknessesListWidget({
    Key? key,
  }) : super(key: key);

  void showAddItemDialog(BuildContext ctx, Weaknesses tempWeaknesses) {
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
        return AddEditWeaknessDialog(
            weaknesses: tempWeaknesses, weakness: null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Weaknesses tempWeaknesses = context.watch<Weaknesses>();
    List<String> weaknesses = tempWeaknesses.weaknesses;
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
            title: 'Add a weakness',
            icon: Icons.add,
            function: () {
              showAddItemDialog(context, tempWeaknesses);
            },
          ),
          ReorderableColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...weaknesses.map((weakness) {
                return EditableWeaknessItemWidget(
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
