import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/constants/constants.dart';
import 'package:tennis_plan/match_detail/plan/models/plan.dart';
import 'package:tennis_plan/match_detail/plan/section_with_list_widget.dart';
import 'package:tennis_plan/match_detail/plan/shot_with_stars_widget.dart';
import 'package:tennis_plan/matches/models/a_match.dart';
import 'package:tennis_plan/matches/widgets/flag_and_name_widget.dart';
import 'package:tennis_plan/widgets/settings_section_widget.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AMatch match = Provider.of<AMatch>(context);
    Plan? plan = match.plan;
    return ListView(
      padding: const EdgeInsets.only(
        left: Dimensions.paddingTwo,
        right: Dimensions.paddingTwo,
        bottom: Dimensions.paddingTwo,
      ),
      children: [
        SettingsSectionWidget(
          sectionTitle: 'OPPONENT INFO',
          sectionWidgets: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingTwo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: FlagAndNameWidget(
                          name:
                              '${match.opponentFirstName} ${match.opponentLastName}',
                          country: match.opponentCountry,
                          ranking:
                              '${match.opponentRanking!.federation} ${match.opponentRanking!.position}',
                        ),
                      ),
                      Text(
                        'Righty',
                        style: TextStyle(
                            fontSize: 20,
                            color:
                                Theme.of(context).textTheme.headline6!.color),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 8.0,
                    children: [
                      ...plan!.shots.map((shot) {
                        return ShotWithStarsWidget(
                          title: shot.name,
                          starNumber: '${shot.score}',
                        );
                      }).toList(),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 16),
        SettingsSectionWidget(
          sectionTitle: '',
          sectionWidgets: [
            SectionWithListWidget(
              title: 'Strengths',
              titleIcon: Icons.shield,
              items: plan.strengths,
            ),
          ],
        ),
        SizedBox(height: 16),
        SettingsSectionWidget(
          sectionTitle: '',
          sectionWidgets: [
            SectionWithListWidget(
              title: 'Weaknesses',
              titleIcon: Icons.broken_image,
              items: plan.weaknesses,
            ),
          ],
        ),
        SizedBox(height: 110),
      ],
    );
  }
}
