import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/match_detail/plan/models/tactical_plan.dart';

import '../../constants/constants.dart';
import '../../matches/models/a_match.dart';
import '../../matches/widgets/flag_and_name_widget.dart';
import '../../widgets/settings_section_widget.dart';
import 'models/shot.dart';
import 'opponent_info/ripple_shot_widget.dart';
import 'ripple_strength_widget.dart';
import 'ripple_weakness_widget.dart';
import 'section_header_widget.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    AMatch match = context.watch<AMatch>();
    List<Shot> shots = match.opponentShots.shots;
    List<String> strengths = match.opponentStrengths.strengths;
    List<String> weaknesses = match.opponentWeaknesses.weaknesses;
    List<TacticalPlan> plans = match.tacticalPlans.tacticalPlans;
    return ListView(
      padding: const EdgeInsets.only(
        left: Dimensions.paddingTwo,
        right: Dimensions.paddingTwo,
        bottom: Dimensions.paddingTwo,
      ),
      shrinkWrap: true,
      children: [
        SettingsSectionWidget(
          title: 'OPPONENT INFO',
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Expanded(child: FlagAndNameWidget(fullName: true)),
                  Text(
                    match.isOpponentLefty! ? 'Lefty' : 'Righty',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            if (shots.isNotEmpty) const SizedBox(height: 16),
            if (shots.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.paddingTwo,
                  right: Dimensions.paddingTwo,
                  top: Dimensions.paddingOne,
                ),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    ...shots.map((shot) {
                      return ChangeNotifierProvider.value(
                        value: shot,
                        builder: (_, __) {
                          return const RippleShotWidget(shots: null);
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
            const SizedBox(height: 8),
          ],
        ),
        if (strengths.isNotEmpty) const SizedBox(height: 16),
        if (strengths.isNotEmpty)
          SettingsSectionWidget(
            title: '',
            children: [
              const SizedBox(height: 8),
              const SectionHeaderWidget(
                title: 'Strengths',
                icon: Icons.shield,
              ),
              const SizedBox(height: 8),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return RippleStrengthWidget(
                    strengths: null,
                    strength: strengths[index],
                  );
                },
                itemCount: strengths.length,
                separatorBuilder: (_, index) {
                  return const Divider(
                    height: 1,
                    thickness: 1,
                    indent: 41,
                  );
                },
              ),
            ],
          ),
        if (weaknesses.isNotEmpty) const SizedBox(height: 16),
        if (weaknesses.isNotEmpty)
          SettingsSectionWidget(
            title: '',
            children: [
              const SizedBox(height: 8),
              const SectionHeaderWidget(
                title: 'Weaknesses',
                icon: Icons.broken_image,
              ),
              const SizedBox(height: 8),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return RippleWeaknessWidget(
                    weaknesses: null,
                    weakness: weaknesses[index],
                  );
                },
                itemCount: weaknesses.length,
                separatorBuilder: (_, index) {
                  return const Divider(
                    height: 1,
                    thickness: 1,
                    indent: 41,
                  );
                },
              ),
            ],
          ),
        if (plans.isNotEmpty)
          const Padding(
            padding: EdgeInsets.only(
              top: Dimensions.paddingFour,
              bottom: Dimensions.paddingTwo,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'TACTICS',
                style: TextStyle(
                  fontSize: Fonts.addMatchDialogMatchFontSize,
                ),
              ),
            ),
          ),
        if (plans.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: plans.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SettingsSectionWidget(
                  title: '',
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.memory(
                              Uint8List.view(plans[index].imageBytes!.buffer),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plans[index].title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    plans[index].description,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        const SizedBox(height: 16),
        // SettingsSectionWidget(
        //   title: '',
        //   children: [
        //     const SizedBox(height: 8),
        //     const SectionHeaderWidget(
        //       title: 'Goals',
        //       icon: Icons.next_plan,
        //     ),
        //     const SizedBox(height: 8),
        //   ],
        // ),
        const SizedBox(height: 110),
      ],
    );
  }
}
