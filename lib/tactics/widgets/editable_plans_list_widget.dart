import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import '../../opponent_info/add_header_list_button.dart';
import '../dialogs/add_edit_plan_info_dialog.dart';
import '../models/tactical_plan.dart';
import '../models/tactical_plans.dart';

import '../../constants/constants.dart';

class EditablePlansListWidget extends StatelessWidget {
  const EditablePlansListWidget({
    Key? key,
  }) : super(key: key);

  void showAddPlanInfoDialog(BuildContext ctx, TacticalPlans tempPlans) {
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
        return AddEditPlanInfoDialog(plans: tempPlans, plan: null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TacticalPlans tempPlans = context.watch<TacticalPlans>();
    List<TacticalPlan> plans = tempPlans.plans;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingOne),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(
              Radius.circular(Dimensions.borderRadius),
            ),
          ),
          child: AddHeaderListButton(
            title: 'Add a plan',
            showDialog: () {
              showAddPlanInfoDialog(context, tempPlans);
            },
          ),
        ),
        const SizedBox(height: 16),
        ReorderableColumn(
          children: [
            ...tempPlans.plans.map((plan) {
              return ChangeNotifierProvider.value(
                key: ValueKey(plan.title),
                value: plan,
                builder: (_, __) {
                  return EditablePlanItemWidget(plans: tempPlans);
                },
              );
            }).toList(),
          ],
          onReorder: (int from, int to) {
            tempPlans.reorderPlans(
                from,
                to,
                plans[from].title,
                plans[from].description,
                plans[from].color,
                plans[from].imageBytes);
          },
          buildDraggableFeedback: (context, constraints, child) =>
              ConstrainedBox(
            constraints: constraints,
            child: child,
          ),
        ),
      ],
    );
  }
}

class EditablePlanItemWidget extends StatelessWidget {
  const EditablePlanItemWidget({
    Key? key,
    required this.plans,
  }) : super(key: key);

  final TacticalPlans plans;

  @override
  Widget build(BuildContext context) {
    TacticalPlan plan = context.watch<TacticalPlan>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.borderRadius),
        ),
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: plan.imageBytes == null
                          ? Image.asset('assets/images/court_on_black.png')
                          : Image.memory(plan.imageBytes!),
                    ),
                    const VerticalDivider(
                        width: 48, thickness: 1, indent: 16, endIndent: 16),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan.title,
                              style: TextStyle(
                                fontSize: 18,
                                color: plan.color,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(plan.description),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
