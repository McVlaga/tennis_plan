import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../matches/models/a_match.dart';
import '../opponent_info/models/shots.dart';
import '../opponent_info/models/strengths.dart';
import '../opponent_info/models/weaknesses.dart';
import '../tactics/models/tactical_goals.dart';
import '../tactics/models/tactical_plans.dart';
import '../widgets/section_title_widget.dart';
import 'widgets/opponent_header_widget.dart';
import 'widgets/strengths_list_widget.dart';
import 'widgets/tactical_goals_list_widget.dart';
import 'widgets/tactical_plans_list_widget.dart';
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
            return const TacticalPlansListWidget();
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
