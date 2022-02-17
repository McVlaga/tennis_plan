import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/tactics/models/tactical_goal.dart';
import 'package:tennis_plan/tactics/models/tactical_goals.dart';
import 'widgets/shots_list_widget.dart';
import '../widgets/flag_name_widget.dart';
import '../widgets/section_header_widget.dart';

import '../../constants/constants.dart';
import '../../matches/models/a_match.dart';
import '../opponent_info/models/shots.dart';
import '../opponent_info/models/strengths.dart';
import '../opponent_info/models/weaknesses.dart';
import '../tactics/models/tactical_plans.dart';
import '../widgets/section_title_widget.dart';
import 'widgets/plans_list_widget.dart';
import 'widgets/strengths_list_widget.dart';
import 'widgets/weaknesses_list_widget.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AMatch match = context.watch<AMatch>();
    Shots shots = match.opponentShots;
    Strengths strengths = match.opponentStrengths;
    Weaknesses weaknesses = match.opponentWeaknesses;
    TacticalPlans plans = match.tacticalPlans;
    TacticalGoals goals = match.tacticalGoals;
    return ListView(
      padding: const EdgeInsets.only(
        left: Dimensions.paddingTwo,
        right: Dimensions.paddingTwo,
        bottom: Dimensions.paddingTwo,
      ),
      shrinkWrap: true,
      children: [
        const SectionTitleWidget(title: 'OPPONENT INFO'),
        ChangeNotifierProvider<Shots>.value(
          value: shots,
          builder: (_, __) {
            return const OpponentHeaderWidget();
          },
        ),
        if (strengths.strengths.isNotEmpty)
          const SizedBox(height: Dimensions.paddingTwo),
        ChangeNotifierProvider<Strengths>.value(
          value: strengths,
          builder: (_, __) {
            return const StrengthsListWidget();
          },
        ),
        if (weaknesses.weaknesses.isNotEmpty)
          const SizedBox(height: Dimensions.paddingTwo),
        ChangeNotifierProvider<Weaknesses>.value(
          value: weaknesses,
          builder: (_, __) {
            return const WeaknessesListWidget();
          },
        ),
        if (plans.plans.isNotEmpty) const SectionTitleWidget(title: 'TACTICS'),
        ChangeNotifierProvider<TacticalPlans>.value(
          value: plans,
          builder: (_, __) {
            return const PlansListWidget();
          },
        ),
        if (goals.goals.isNotEmpty) const SizedBox(height: 16),
        ChangeNotifierProvider<TacticalGoals>.value(
          value: goals,
          builder: (_, __) {
            return const TacticalGoalsListWidget();
          },
        ),
        const SizedBox(height: 110),
      ],
    );
  }
}

class TacticalGoalsListWidget extends StatelessWidget {
  const TacticalGoalsListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TacticalGoal> goals = context.watch<TacticalGoals>().goals;
    if (goals.isEmpty) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.borderRadius),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const SectionHeaderWidget(
              title: 'Goals', icon: Icons.sports_football),
          const SizedBox(height: 16),
          for (int i = 0; i < goals.length; i++)
            ChangeNotifierProvider<TacticalGoal>.value(
              value: goals[i],
              builder: (_, __) {
                return Column(
                  children: [
                    TacticalGoalItemWidget(index: i),
                    if (i < goals.length - 1)
                      const Divider(indent: 16, height: 20),
                  ],
                );
              },
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class TacticalGoalItemWidget extends StatelessWidget {
  const TacticalGoalItemWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    Color themeTextColor = Theme.of(context).colorScheme.onPrimary;
    TacticalGoal goal = context.watch<TacticalGoal>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
    );
  }
}

class OpponentHeaderWidget extends StatelessWidget {
  const OpponentHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AMatch match = context.watch<AMatch>();
    Shots shots = context.watch<Shots>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingTwo),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius:
            const BorderRadius.all(Radius.circular(Dimensions.borderRadius)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Expanded(child: FlagNameWidget(fullName: true)),
                Text(
                  match.isOpponentLefty! ? 'Lefty' : 'Righty',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          if (shots.shots.isNotEmpty) const SizedBox(height: 16),
          if (shots.shots.isNotEmpty) const ShotsListWidget(),
        ],
      ),
    );
  }
}
