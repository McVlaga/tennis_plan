import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../tactics/models/tactical_goal.dart';
import '../../tactics/models/tactical_goals.dart';
import '../../widgets/section_header_widget.dart';

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
