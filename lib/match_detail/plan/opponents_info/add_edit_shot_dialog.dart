import 'package:flutter/material.dart';
import 'package:tennis_plan/constants/constants.dart';
import 'package:tennis_plan/match_detail/plan/models/shot.dart';
import 'package:tennis_plan/matches/models/a_match.dart';

class AddEditShotDialog extends StatefulWidget {
  const AddEditShotDialog({
    required this.context,
    required this.match,
    required this.shot,
    Key? key,
  }) : super(key: key);

  final BuildContext context;
  final AMatch match;
  final Shot? shot;

  @override
  State<AddEditShotDialog> createState() => _AddEditShotDialogState();
}

class _AddEditShotDialogState extends State<AddEditShotDialog> {
  TextEditingController shotController = TextEditingController();
  int selectedStar = 0;
  bool editing = false;
  late String oldShotName;

  @override
  void initState() {
    if (widget.shot != null) {
      editing = true;
      shotController.text = widget.shot!.name;
      selectedStar = widget.shot!.score;
      oldShotName = widget.shot!.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.only(left: 10, top: 6, right: 10, bottom: 10),
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
              padding: EdgeInsets.only(left: 10, top: 6, right: 10, bottom: 10),
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
              padding: EdgeInsets.only(left: 10, top: 6, right: 10, bottom: 10),
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
              if (editing)
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: const Text(
                        'DELETE',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        widget.match.deleteOpponentShot(oldShotName);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              if (!editing) const Spacer(),
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
                  if (shotController.text.isNotEmpty && selectedStar > 0) {
                    if (editing) {
                      widget.match.updateOpponentShot(
                          oldShotName, shotController.text, selectedStar);
                    } else {
                      widget.match
                          .addOpponentShot(shotController.text, selectedStar);
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
