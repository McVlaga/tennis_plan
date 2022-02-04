import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tennis_plan/match_detail/plan/models/opponent_info.dart';
import 'package:tennis_plan/match_detail/plan/models/plan.dart';
import 'package:tennis_plan/match_detail/plan/models/shot.dart';
import 'package:tennis_plan/match_detail/plan/opponent_info/add_header_list_button.dart';
import 'package:tennis_plan/match_detail/plan/opponent_info/opponent_info_instruction_widget.dart';
import '../../../constants/constants.dart';
import 'add_edit_shot_dialog.dart';
import 'add_edit_strength_dialog.dart';
import 'add_edit_weakness_dialog.dart';
import '../ripple_color_text_widget.dart';
import 'ripple_shot_widget.dart';
import '../../../matches/models/a_match.dart';
import '../../../matches/models/matches.dart';
import '../../../widgets/settings_section_widget.dart';

class AddEditOpponentInfoScreen extends StatefulWidget {
  const AddEditOpponentInfoScreen({Key? key}) : super(key: key);
  static const routeName = '/add-edit-opponent-info';

  @override
  State<AddEditOpponentInfoScreen> createState() =>
      _AddEditOpponentInfoScreenState();
}

class _AddEditOpponentInfoScreenState extends State<AddEditOpponentInfoScreen> {
  late AMatch match;
  late OpponentInfo tempOpponentInfo;
  late Plan tempPlan;
  bool reordering = false;
  bool firstInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstInit) {
      String matchId = ModalRoute.of(context)!.settings.arguments as String;
      match = Provider.of<Matches>(
        context,
        listen: false,
      ).findById(matchId);
      Plan loadedPlan = match.plan;
      tempOpponentInfo = OpponentInfo(
        shots: loadedPlan.opponentInfo.shots,
        strengths: loadedPlan.opponentInfo.strengths,
        weaknesses: loadedPlan.opponentInfo.weaknesses,
      );
      tempPlan = Plan(opponentInfo: tempOpponentInfo);
      // plan.setOpponentInfo(
      //   OpponentInfo(
      //     shots: loadedOpponentInfo.shots,
      //     strengths: loadedOpponentInfo.strengths,
      //     weaknesses: loadedOpponentInfo.weaknesses,
      //   ),
      // );
      firstInit = false;
    }
  }

  void showAddShotDialog(BuildContext ctx, OpponentInfo opponentInfo) {
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
        return AddEditShotDialog(
            context: ctx, opponentInfo: opponentInfo, shot: null);
      },
    );
  }

  void showAddEditItemDialog(BuildContext ctx, Widget dialog) {
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: tempOpponentInfo,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Opponent Info'),
          backgroundColor: Colors.red,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
        ),
        body: Consumer<OpponentInfo>(builder: (_, opponentInfo, __) {
          final List<Shot> shots = opponentInfo.shots;
          final List<String> strengthes = opponentInfo.strengths;
          final List<String> weaknesses = opponentInfo.weaknesses;
          return Column(
            children: [
              Expanded(
                child: ListView(
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
                            AddHeaderListButton(
                              title: 'Add a shot',
                              showDialog: () {
                                showAddShotDialog(context, opponentInfo);
                              },
                            ),
                            if (shots.isNotEmpty)
                              ReorderableWrap(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingTwo,
                                  vertical: Dimensions.paddingOne,
                                ),
                                spacing: 8.0, // gap between adjacent chips
                                runSpacing: 8.0,
                                onReorder: (int from, int to) {
                                  opponentInfo.reorderOpponentShot(from, to,
                                      shots[from].name, shots[from].score);
                                },
                                children: [
                                  ...shots.map((shot) {
                                    return RippleShotWidget(
                                      name: shot.name,
                                      starNumber: '${shot.score}',
                                      opponentInfo: opponentInfo,
                                      editable: true,
                                    );
                                  }).toList(),
                                ],
                                buildDraggableFeedback:
                                    (context, constraints, child) =>
                                        ConstrainedBox(
                                  constraints: constraints,
                                  child: child,
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
                            AddHeaderListButton(
                              title: 'Add a strength',
                              showDialog: () {
                                showAddEditItemDialog(
                                  context,
                                  AddEditStrengthDialog(
                                    context: context,
                                    opponentInfo: opponentInfo,
                                    strength: null,
                                  ),
                                );
                              },
                            ),
                            ReorderableColumn(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...strengthes.map((strength) {
                                  return RippleColorTextWidget(
                                    key: ValueKey(strength),
                                    itemColor: Colors.green,
                                    item: strength,
                                    tapFunction: () {
                                      showAddEditItemDialog(
                                        context,
                                        AddEditStrengthDialog(
                                          context: context,
                                          opponentInfo: opponentInfo,
                                          strength: strength,
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ],
                              onReorder: (int from, int to) {
                                opponentInfo.reorderOpponentStrength(
                                  from,
                                  to,
                                  strengthes[from],
                                );
                              },
                              buildDraggableFeedback:
                                  (context, constraints, child) =>
                                      ConstrainedBox(
                                constraints: constraints,
                                child: child,
                              ),
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
                            AddHeaderListButton(
                              title: 'Add a weakness',
                              showDialog: () {
                                showAddEditItemDialog(
                                  context,
                                  AddEditWeaknessDialog(
                                    context: context,
                                    opponentInfo: opponentInfo,
                                    weakness: null,
                                  ),
                                );
                              },
                            ),
                            ReorderableColumn(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...weaknesses.map((weakness) {
                                  return RippleColorTextWidget(
                                    key: ValueKey(weakness),
                                    itemColor: Colors.red,
                                    item: weakness,
                                    tapFunction: () {
                                      showAddEditItemDialog(
                                        context,
                                        AddEditWeaknessDialog(
                                          context: context,
                                          opponentInfo: opponentInfo,
                                          weakness: weakness,
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ],
                              onReorder: (int from, int to) {
                                opponentInfo.reorderOpponentWeakness(
                                  from,
                                  to,
                                  weaknesses[from],
                                );
                              },
                              buildDraggableFeedback:
                                  (context, constraints, child) =>
                                      ConstrainedBox(
                                constraints: constraints,
                                child: child,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const OpponentInfoInstructionWidget()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.paddingTwo,
                  right: Dimensions.paddingTwo,
                  bottom: Dimensions.paddingTwo,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Dimensions.borderRadius),
                  ),
                  child: Material(
                    color: Colors.red,
                    child: InkWell(
                      onTap: () {
                        match.setPlan(tempPlan);
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        height: Dimensions.addMatchDialogInputHeight,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
