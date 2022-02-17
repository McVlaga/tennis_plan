import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tennis_plan/tactics/add_edit_tactical_goal_dialog.dart';
import 'package:tennis_plan/tactics/models/tactical_goal.dart';
import 'package:tennis_plan/tactics/models/tactical_goals.dart';
import '../widgets/screen_save_button.dart';
import '../widgets/section_title_widget.dart';
import 'models/tactical_plans.dart';
import 'widgets/editable_plans_list_widget.dart';
import '../../../matches/models/a_match.dart';
import '../../../constants/constants.dart';
import '../widgets/add_header_list_button.dart';

class AddEditTacticsScreen extends StatefulWidget {
  const AddEditTacticsScreen({Key? key}) : super(key: key);

  @override
  State<AddEditTacticsScreen> createState() => _AddEditTacticsScreenState();
}

class _AddEditTacticsScreenState extends State<AddEditTacticsScreen> {
  bool firstInit = true;
  late AMatch match;
  late TacticalPlans tempPlans;
  late TacticalGoals tempGoals;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstInit) {
      match = ModalRoute.of(context)!.settings.arguments as AMatch;
      tempPlans = TacticalPlans(match.tacticalPlans.plans);
      tempGoals = TacticalGoals(match.tacticalGoals.goals);
      firstInit = false;
    }
  }

  void saveTactics() {
    match.setTacticalPlans(tempPlans);
    match.setTacticalGoals(tempGoals);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tactics'),
        backgroundColor: Colors.blue,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(
              left: Dimensions.paddingTwo,
              right: Dimensions.paddingTwo,
              bottom: 100,
            ),
            children: [
              const SectionTitleWidget(title: 'PLANS'),
              ChangeNotifierProvider<TacticalPlans>.value(
                value: tempPlans,
                builder: (_, __) {
                  return const EditablePlansListWidget();
                },
              ),
              const SectionTitleWidget(title: 'GOALS'),
              ChangeNotifierProvider<TacticalGoals>.value(
                value: tempGoals,
                builder: (_, __) {
                  return const EditableTacticalGoalsList();
                },
              ),
            ],
          ),
          ScreenSaveButton(saveFunction: saveTactics, color: Colors.blue),
        ],
      ),
    );
  }
}

class EditableTacticalGoalsList extends StatelessWidget {
  const EditableTacticalGoalsList({
    Key? key,
  }) : super(key: key);

  void showAddGoalDialog(BuildContext ctx, TacticalGoals tempGoals) {
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
        return AddEditTacticalGoalDialog(goals: tempGoals, goal: null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TacticalGoals tempGoals = context.watch<TacticalGoals>();
    List<TacticalGoal> goals = tempGoals.goals;
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
          child: Column(
            children: [
              AddHeaderListButton(
                title: 'Add a goal',
                icon: Icons.add,
                function: () {
                  showAddGoalDialog(context, tempGoals);
                },
              ),
              const SizedBox(height: 8),
              ReorderableColumn(
                children: [
                  for (int i = 0; i < goals.length; i++)
                    ChangeNotifierProvider<TacticalGoal>.value(
                      key: UniqueKey(),
                      value: goals[i],
                      builder: (_, __) {
                        return EditableTacticalGoalItemWidget(
                          index: i,
                          goals: tempGoals,
                        );
                      },
                    ),
                ],
                onReorder: (int from, int to) {
                  tempGoals.reorderGoal(
                      from, to, goals[from].coloredWords, goals[from].text);
                },
                buildDraggableFeedback: (context, constraints, child) =>
                    ConstrainedBox(
                  constraints: constraints,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EditableTacticalGoalItemWidget extends StatelessWidget {
  const EditableTacticalGoalItemWidget({
    Key? key,
    required this.index,
    required this.goals,
  }) : super(key: key);

  final int index;
  final TacticalGoals goals;

  void _showEditGoalDialog(BuildContext ctx, TacticalGoal goal) {
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
        return AddEditTacticalGoalDialog(goals: goals, goal: goal);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color themeTextColor = Theme.of(context).colorScheme.onPrimary;
    TacticalGoal goal = context.watch<TacticalGoal>();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _showEditGoalDialog(context, goal);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${index + 1})'),
                const SizedBox(width: 8),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(fontSize: 15),
                      children: [
                        ...goal.coloredWords.map(
                          (coloredWord) {
                            FontWeight weight;
                            if (themeTextColor == coloredWord.color) {
                              weight = FontWeight.w400;
                            } else {
                              weight = FontWeight.bold;
                            }
                            return TextSpan(
                              text: coloredWord.word + ' ',
                              style: TextStyle(
                                color: coloredWord.color,
                                fontWeight: weight,
                              ),
                            );
                          },
                        ).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
