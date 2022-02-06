import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import '../models/shot.dart';
import '../models/shots.dart';
import '../models/strengths.dart';
import '../models/weaknesses.dart';
import 'add_edit_strength_dialog.dart';
import 'add_header_list_button.dart';
import 'editable_shot_list.dart';
import 'editable_strength_list.dart';
import 'opponent_info_instruction_widget.dart';
import '../ripple_weakness_widget.dart';
import '../../../constants/constants.dart';
import 'add_edit_shot_dialog.dart';
import '../ripple_strength_widget.dart';
import 'add_edit_weakness_dialog.dart';
import 'editable_weakness_list.dart';
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
  late Shots tempShots;
  late Strengths tempStrengths;
  late Weaknesses tempWeaknesses;
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
      tempShots = Shots(match.opponentShots.shots);
      tempStrengths = Strengths(match.opponentStrengths.strengths);
      tempWeaknesses = Weaknesses(match.opponentWeaknesses.weaknesses);
      firstInit = false;
    }
  }

  void showAddItemDialog(BuildContext ctx, Widget dialog) {
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
      builder: (_) {
        return dialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opponent Info'),
        backgroundColor: Colors.red,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(
              left: Dimensions.paddingTwo,
              right: Dimensions.paddingTwo,
              bottom: 80,
            ),
            children: [
              ChangeNotifierProvider.value(
                  value: tempShots,
                  builder: (_, __) {
                    return SettingsSectionWidget(
                      title: 'SHOTS',
                      children: [
                        AddHeaderListButton(
                          title: 'Add a shot',
                          showDialog: () {
                            showAddItemDialog(
                              context,
                              AddEditShotDialog(shots: tempShots, shot: null),
                            );
                          },
                        ),
                        const EditableShotList(),
                      ],
                    );
                  }),
              ChangeNotifierProvider.value(
                value: tempStrengths,
                builder: (_, __) {
                  return SettingsSectionWidget(
                    title: 'STRENGTHS',
                    children: [
                      AddHeaderListButton(
                        title: 'Add a strength',
                        showDialog: () {
                          showAddItemDialog(
                            context,
                            AddEditStrengthDialog(
                              strengths: tempStrengths,
                              strength: null,
                            ),
                          );
                        },
                      ),
                      const EditableStrengthList(),
                    ],
                  );
                },
              ),
              ChangeNotifierProvider.value(
                  value: tempWeaknesses,
                  builder: (_, __) {
                    return SettingsSectionWidget(
                      title: 'WEAKNESSES',
                      children: [
                        AddHeaderListButton(
                          title: 'Add a weakness',
                          showDialog: () {
                            showAddItemDialog(
                              context,
                              AddEditWeaknessDialog(
                                weaknesses: tempWeaknesses,
                                weakness: null,
                              ),
                            );
                          },
                        ),
                        const EditableWeaknessList(),
                      ],
                    );
                  }),
              const OpponentInfoInstructionWidget()
            ],
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
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
                      match.setOpponentInfo(
                          tempShots, tempStrengths, tempWeaknesses);
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
          ),
        ],
      ),
    );
  }
}
