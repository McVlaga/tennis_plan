import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../constants/constants.dart';
import '../../widgets/add_header_list_button.dart';
import '../dialogs/add_edit_strength_dialog.dart';
import '../models/strengths.dart';

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
            icon: Icons.add,
            function: () {
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

class EditableStrengthItemWidget extends StatelessWidget {
  const EditableStrengthItemWidget({
    Key? key,
    required this.strengths,
    required this.strength,
  }) : super(key: key);

  final Strengths? strengths;
  final String strength;

  void showAddEditItemDialog(BuildContext ctx) {
    FocusScope.of(ctx).unfocus();
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
        return AddEditStrengthDialog(strengths: strengths!, strength: strength);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (strengths != null) showAddEditItemDialog(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingTwo,
            vertical: 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(top: 4),
              ),
              const SizedBox(width: 16),
              Flexible(child: Text(strength)),
            ],
          ),
        ),
      ),
    );
  }
}
