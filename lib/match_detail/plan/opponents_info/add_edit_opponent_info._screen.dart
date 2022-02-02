import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/constants/constants.dart';
import 'package:tennis_plan/match_detail/plan/opponents_info/add_edit_shot_dialog.dart';
import 'package:tennis_plan/match_detail/plan/opponents_info/add_edit_strength_dialog.dart';
import 'package:tennis_plan/match_detail/plan/opponents_info/add_edit_weakness_dialog.dart';
import 'package:tennis_plan/match_detail/plan/ripple_color_text_widget.dart';
import 'package:tennis_plan/match_detail/plan/opponents_info/ripple_shot_widget.dart';
import 'package:tennis_plan/matches/models/a_match.dart';
import 'package:tennis_plan/matches/models/matches.dart';
import 'package:tennis_plan/widgets/settings_section_widget.dart';

class AddEditOpponentInfoScreen extends StatelessWidget {
  const AddEditOpponentInfoScreen({Key? key}) : super(key: key);
  static const routeName = '/add-edit-opponent-info';

  @override
  Widget build(BuildContext context) {
    final String matchId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedMatch = Provider.of<Matches>(context).findById(matchId);
    return ChangeNotifierProvider.value(
      value: loadedMatch,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Opponent Info'),
          backgroundColor: Colors.red,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
        ),
        body: Consumer<AMatch>(builder: (_, match, __) {
          return ListView(
            padding: const EdgeInsets.only(
              left: Dimensions.paddingTwo,
              right: Dimensions.paddingTwo,
              bottom: Dimensions.paddingTwo,
            ),
            children: [
              SettingsSectionWidget(
                sectionTitle: 'SHOTS',
                sectionWidgets: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dimensions.addMatchDialogInputHeight,
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingTwo),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Add a shot',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Icon(
                                  Icons.add,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            showAddShotDialog(context, loadedMatch);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: Dimensions.paddingTwo,
                          right: Dimensions.paddingTwo,
                          top: Dimensions.paddingOne,
                        ),
                        child: Wrap(
                          spacing: 8.0, // gap between adjacent chips
                          runSpacing: 8.0,
                          children: [
                            ...match.plan!.shots.map((shot) {
                              return RippleShotWidget(
                                name: shot.name,
                                starNumber: '${shot.score}',
                                match: match,
                                editable: true,
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SettingsSectionWidget(
                sectionTitle: 'STRENGTHS',
                sectionWidgets: [
                  Column(
                    children: [
                      SizedBox(
                        height: Dimensions.addMatchDialogInputHeight,
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingTwo),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Add a strength',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Icon(
                                  Icons.add,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            showAddItemDialog(
                              context,
                              loadedMatch,
                              AddEditStrengthDialog(
                                context: context,
                                match: match,
                                strength: null,
                              ),
                            );
                          },
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return RippleColorTextWidget(
                            itemColor: Colors.green,
                            item: match.plan!.strengths[index],
                            tapFunction: () {
                              showEditItemDialog(
                                context,
                                match,
                                match.plan!.strengths[index],
                                AddEditStrengthDialog(
                                  context: context,
                                  match: match,
                                  strength: match.plan!.strengths[index],
                                ),
                              );
                            },
                          );
                        },
                        itemCount: match.plan!.strengths.length,
                        separatorBuilder: (_, index) {
                          return const Divider(
                            height: 1,
                            thickness: 1,
                            indent: 40,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SettingsSectionWidget(
                sectionTitle: 'WEAKNESSES',
                sectionWidgets: [
                  Column(
                    children: [
                      SizedBox(
                        height: Dimensions.addMatchDialogInputHeight,
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingTwo),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Add a weakness',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Icon(
                                  Icons.add,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            showAddItemDialog(
                              context,
                              loadedMatch,
                              AddEditWeaknessDialog(
                                context: context,
                                match: match,
                                weakness: null,
                              ),
                            );
                          },
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return RippleColorTextWidget(
                            itemColor: Colors.red,
                            item: match.plan!.weaknesses[index],
                            tapFunction: () {
                              showEditItemDialog(
                                context,
                                match,
                                match.plan!.weaknesses[index],
                                AddEditWeaknessDialog(
                                  context: context,
                                  match: match,
                                  weakness: match.plan!.weaknesses[index],
                                ),
                              );
                            },
                          );
                        },
                        itemCount: match.plan!.weaknesses.length,
                        separatorBuilder: (_, index) {
                          return const Divider(
                            height: 1,
                            thickness: 1,
                            indent: 40,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  void showEditItemDialog(
      BuildContext ctx, AMatch match, String? item, Widget dialog) {
    FocusScope.of(ctx).unfocus();
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
      builder: (context) {
        return dialog;
      },
    );
  }

  void showAddShotDialog(BuildContext ctx, AMatch match) {
    FocusScope.of(ctx).unfocus();
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
      builder: (context) {
        return AddEditShotDialog(context: ctx, match: match, shot: null);
      },
    );
  }

  void showAddItemDialog(BuildContext ctx, AMatch match, Widget dialog) {
    FocusScope.of(ctx).unfocus();
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
      builder: (context) {
        return dialog;
      },
    );
  }
}
