import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/constants/constants.dart';
import 'package:tennis_plan/match_detail/plan/shot_with_stars_widget.dart';
import 'package:tennis_plan/matches/models/a_match.dart';
import 'package:tennis_plan/matches/models/matches.dart';
import 'package:tennis_plan/widgets/settings_section_widget.dart';

import 'models/shot.dart';

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
          title: Text('Opponent Info'),
          backgroundColor: Colors.red,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
        ),
        body: ListView(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingTwo),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Add a shot',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Icon(
                                Icons.add,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          showAddShotDialog(context, loadedMatch, null);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Consumer<AMatch>(
                      builder: (_, match, __) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingTwo),
                          child: Wrap(
                            spacing: 8.0, // gap between adjacent chips
                            runSpacing: 8.0,
                            children: [
                              ...match.plan!.shots.map((shot) {
                                return ShotWithStarsWidget(
                                  title: shot.name,
                                  starNumber: '${shot.score}',
                                );
                              }).toList(),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingTwo),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Add a strength',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Icon(
                                Icons.add,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    )
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
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingTwo),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Add a weakness',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Icon(
                                Icons.add,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAddShotDialog(BuildContext ctx, AMatch match, Shot? shot) {
    TextEditingController shotController = TextEditingController();
    int selectedStar = 0;

    if (shot != null) {
      shotController.text = shot.name;
      selectedStar = shot.score;
    }

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
        return StatefulBuilder(builder: (context, setState) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              left: Dimensions.paddingFour,
              right: Dimensions.paddingFour,
              top: Dimensions.paddingFour,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Shot',
                  ),
                ),
                TextField(
                  autofocus: true,
                  controller: shotController,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: null,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Forehand cross',
                  ),
                ),
                const SizedBox(height: Dimensions.paddingThree),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Score',
                  ),
                ),
                const SizedBox(height: Dimensions.paddingZero),
                Row(children: [
                  IconButton(
                    padding: EdgeInsets.only(top: 6, right: 10, bottom: 10),
                    constraints: BoxConstraints(),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      selectedStar > 0 ? Icons.star : Icons.star_outline,
                      size: 35,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedStar = 1;
                      });
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.only(
                        left: 10, top: 6, right: 10, bottom: 10),
                    constraints: BoxConstraints(),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      selectedStar > 1 ? Icons.star : Icons.star_outline,
                      size: 35,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedStar = 2;
                      });
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.only(
                        left: 10, top: 6, right: 10, bottom: 10),
                    constraints: BoxConstraints(),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      selectedStar > 2 ? Icons.star : Icons.star_outline,
                      size: 35,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedStar = 3;
                      });
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.only(
                        left: 10, top: 6, right: 10, bottom: 10),
                    constraints: BoxConstraints(),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      selectedStar > 3 ? Icons.star : Icons.star_outline,
                      size: 35,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedStar = 4;
                      });
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.only(left: 10, top: 6, bottom: 10),
                    constraints: BoxConstraints(),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      selectedStar > 4 ? Icons.star : Icons.star_outline,
                      size: 35,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedStar = 5;
                      });
                    },
                  ),
                ]),
                const SizedBox(height: Dimensions.paddingTwo),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      child: const Text('CANCEL'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: Dimensions.paddingTwo),
                    TextButton(
                      child: const Text('SAVE'),
                      onPressed: () {
                        if (shotController.text.isNotEmpty &&
                            selectedStar > 0) {
                          match.addShot(shotController.text, selectedStar);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingTwo),
              ],
            ),
          );
        });
      },
    );
  }
}
