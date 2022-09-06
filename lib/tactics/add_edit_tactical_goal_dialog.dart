import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'models/tactical_goal.dart';
import 'models/tactical_goals.dart';
import '../widgets/color_picker_dialog.dart';

import '../../../constants/constants.dart';

class AddEditTacticalGoalDialog extends StatefulWidget {
  const AddEditTacticalGoalDialog({
    required this.goals,
    required this.goal,
    Key? key,
  }) : super(key: key);

  final TacticalGoals goals;
  final TacticalGoal? goal;

  @override
  State<AddEditTacticalGoalDialog> createState() =>
      _AddEditTacticalGoalDialogState();
}

class _AddEditTacticalGoalDialogState extends State<AddEditTacticalGoalDialog> {
  TextEditingController goalTextController = TextEditingController();
  bool editing = false;
  late String oldGoalText;

  late List<TacticalGoalWord> coloredWords = [];

  @override
  void initState() {
    if (widget.goal != null) {
      editing = true;
      coloredWords = List.from(widget.goal!.coloredWords);
      goalTextController.text = widget.goal!.text;
      oldGoalText = widget.goal!.text;
    }
    super.initState();
  }

  void _showColorPickerDialog(TacticalGoalWord coloredWord) async {
    final Color? color = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ColorPickerDialog(selectedColor: coloredWord.color);
      },
    );
    if (color != null) {
      coloredWord.setColor(color);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Color themeTextColor = Theme.of(context).colorScheme.onPrimary;
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
            child: Text('Add a goal'),
          ),
          TextField(
            autofocus: true,
            maxLines: null,
            controller: goalTextController,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (text) {
              List<String> words = text.split(' ');
              coloredWords.replaceRange(0, coloredWords.length, [
                ...words.map((word) {
                  return TacticalGoalWord(word: word, color: themeTextColor);
                }).toList(),
              ]);
              setState(() {});
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Try to be aggressive',
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 25),
                children: [
                  ...coloredWords.map((coloredWord) {
                    FontWeight weight;
                    if (themeTextColor == coloredWord.color) {
                      weight = FontWeight.normal;
                    } else {
                      weight = FontWeight.bold;
                    }
                    return TextSpan(
                      text: coloredWord.word + ' ',
                      style: TextStyle(
                        color: coloredWord.color,
                        fontWeight: weight,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _showColorPickerDialog(coloredWord);
                        },
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimensions.paddingTwo),
          Row(
            children: [
              if (editing)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: const Text(
                      'DELETE',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      widget.goals.deleteGoal(oldGoalText);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              const Spacer(),
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: Dimensions.paddingTwo),
              TextButton(
                child: const Text(
                  'SAVE',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  if (goalTextController.text.isNotEmpty) {
                    if (editing) {
                      widget.goals.updateGoal(
                        oldGoalText,
                        goalTextController.text,
                        coloredWords,
                      );
                    } else {
                      widget.goals
                          .addGoal(coloredWords, goalTextController.text);
                    }
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
  }
}
