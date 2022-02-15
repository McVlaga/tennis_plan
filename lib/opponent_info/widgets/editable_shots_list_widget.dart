import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../../constants/constants.dart';
import '../add_header_list_button.dart';
import '../dialogs/add_edit_shot_dialog.dart';
import '../models/shot.dart';
import '../models/shots.dart';
import 'editable_shot_item_widget.dart';

class EditableShotsListWidget extends StatelessWidget {
  const EditableShotsListWidget({
    Key? key,
  }) : super(key: key);

  void showAddItemDialog(BuildContext ctx, Shots tempShots) {
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
        return AddEditShotDialog(shots: tempShots, shot: null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Shots tempShots = context.watch<Shots>();
    final List<Shot> shots = tempShots.shots;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingOne),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddHeaderListButton(
            title: 'Add a shot',
            icon: Icons.add,
            function: () {
              showAddItemDialog(context, tempShots);
            },
          ),
          if (shots.isNotEmpty)
            ReorderableWrap(
              scrollPhysics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingTwo,
                vertical: Dimensions.paddingOne,
              ),
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ...shots.map((shot) {
                  return ChangeNotifierProvider.value(
                    value: shot,
                    builder: (_, __) {
                      return EditableShotItemWidget(shots: tempShots);
                    },
                  );
                }).toList(),
              ],
              onReorder: (int from, int to) {
                tempShots.reorderOpponentShot(
                    from, to, shots[from].name, shots[from].score);
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
