import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tennis_plan/main_navigation.dart';

import '../../constants/constants.dart';
import '../../widgets/add_header_list_button.dart';
import '../models/tactical_plan.dart';
import '../models/tactical_plans.dart';
import 'editable_plan_item_widget.dart';

class EditablePlansListWidget extends StatelessWidget {
  const EditablePlansListWidget({
    Key? key,
  }) : super(key: key);

  void openAddEditTacticalPlanScreen(
      BuildContext context, TacticalPlans tempPlans, String? planTitle) {
    Map<String, Object?> arguments = {
      'tempPlans': tempPlans,
      'planTitle': planTitle,
    };
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.addEditTacticalPlan,
      arguments: arguments,
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
            icon: Icons.add,
            function: () {
              openAddEditTacticalPlanScreen(context, tempPlans, null);
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
                  return EditablePlanItemWidget(
                    openEditScreenFunction: () {
                      openAddEditTacticalPlanScreen(
                          context, tempPlans, plan.title);
                    },
                  );
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
                plans[from].drawing);
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
