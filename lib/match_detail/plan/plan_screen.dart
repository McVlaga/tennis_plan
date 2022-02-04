import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/match_detail/plan/models/opponent_info.dart';
import 'package:tennis_plan/match_detail/plan/models/shot.dart';
import '../../constants/constants.dart';
import 'ripple_color_text_widget.dart';
import 'opponent_info/ripple_shot_widget.dart';
import '../../matches/models/a_match.dart';
import '../../matches/widgets/flag_and_name_widget.dart';
import '../../widgets/settings_section_widget.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AMatch match = Provider.of<AMatch>(context);
    OpponentInfo opponentInfo = match.plan.opponentInfo;
    List<Shot> shots = match.plan.opponentInfo.shots;
    List<String> strengths = match.plan.opponentInfo.strengths;
    List<String> weaknesses = match.plan.opponentInfo.weaknesses;
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
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingTwo,
              ),
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
                  if (shots.isNotEmpty) const SizedBox(height: 16),
                  if (shots.isNotEmpty)
                    Wrap(
                      spacing: 8.0, // gap between adjacent chips
                      runSpacing: 8.0,
                      children: [
                        ...shots.map((shot) {
                          return RippleShotWidget(
                            name: shot.name,
                            starNumber: '${shot.score}',
                            opponentInfo: opponentInfo,
                            editable: false,
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
        const SizedBox(height: 16),
        if (strengths.isNotEmpty)
          SettingsSectionWidget(
            sectionTitle: '',
            sectionWidgets: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingTwo),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shield,
                          size: 18,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Strengths',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return RippleColorTextWidget(
                        itemColor: Colors.green,
                        item: strengths[index],
                        tapFunction: null,
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
            ],
          ),
        if (strengths.isNotEmpty) const SizedBox(height: 16),
        if (weaknesses.isNotEmpty)
          SettingsSectionWidget(
            sectionTitle: '',
            sectionWidgets: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingTwo),
                    child: Row(
                      children: [
                        Icon(
                          Icons.broken_image,
                          size: 18,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Weaknesses',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return RippleColorTextWidget(
                        itemColor: Colors.red,
                        item: weaknesses[index],
                        tapFunction: null,
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
            ],
          ),
        const SizedBox(height: 110),
      ],
    );
  }
}
