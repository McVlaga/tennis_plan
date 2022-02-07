import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    AMatch match = context.watch<AMatch>();
    List<Shot> shots = match.opponentShots.shots;
    List<String> strengths = match.opponentStrengths.strengths;
    List<String> weaknesses = match.opponentWeaknesses.weaknesses;
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
                children: const [
                  Expanded(child: FlagAndNameWidget(fullName: true)),
                  Text(
                    'Righty',
                    style: TextStyle(fontSize: 20),
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
        const SizedBox(height: 16),
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
        const SizedBox(height: 16),
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
        const SizedBox(height: 110),
      ],
    );
  }
}
