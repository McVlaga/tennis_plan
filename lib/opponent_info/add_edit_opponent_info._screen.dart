import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../matches/models/a_match.dart';
import '../../widgets/screen_save_button.dart';
import '../../widgets/section_title_widget.dart';
import 'models/shots.dart';
import 'models/strengths.dart';
import 'models/weaknesses.dart';
import 'widgets/editable_shots_list_widget.dart';
import 'widgets/editable_strengths_list_widget.dart';
import 'widgets/editable_weaknesses_list_widget.dart';

class AddEditOpponentInfoScreen extends StatefulWidget {
  const AddEditOpponentInfoScreen({Key? key}) : super(key: key);

  @override
  State<AddEditOpponentInfoScreen> createState() =>
      _AddEditOpponentInfoScreenState();
}

class _AddEditOpponentInfoScreenState extends State<AddEditOpponentInfoScreen> {
  late AMatch match;
  late Shots tempShots;
  late Strengths tempStrengths;
  late Weaknesses tempWeaknesses;
  bool firstInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstInit) {
      match = ModalRoute.of(context)!.settings.arguments as AMatch;
      tempShots = Shots(match.opponentShots.shots);
      tempStrengths = Strengths(match.opponentStrengths.strengths);
      tempWeaknesses = Weaknesses(match.opponentWeaknesses.weaknesses);
      firstInit = false;
    }
  }

  void saveOpponentInfo() {
    match.setOpponentInfo(tempShots, tempStrengths, tempWeaknesses);
    Navigator.of(context).pop();
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
              const SectionTitleWidget(title: 'SHOTS'),
              ChangeNotifierProvider.value(
                value: tempShots,
                builder: (_, __) {
                  return const EditableShotsListWidget();
                },
              ),
              const SectionTitleWidget(title: 'STRENGTHS'),
              ChangeNotifierProvider.value(
                value: tempStrengths,
                builder: (_, __) {
                  return const EditableStrengthsListWidget();
                },
              ),
              const SectionTitleWidget(title: 'WEAKNESSES'),
              ChangeNotifierProvider.value(
                  value: tempWeaknesses,
                  builder: (_, __) {
                    return const EditableWeaknessesListWidget();
                  }),
              const OpponentInfoInstructionWidget()
            ],
          ),
          ScreenSaveButton(saveFunction: saveOpponentInfo, color: Colors.red),
        ],
      ),
    );
  }
}

class OpponentInfoInstructionWidget extends StatelessWidget {
  const OpponentInfoInstructionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '1. Tap on an item to edit or delete it.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '2. Tap and hold to drag an item and place it somewhere else.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
