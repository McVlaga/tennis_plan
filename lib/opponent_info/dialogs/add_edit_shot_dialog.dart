import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../models/shot.dart';
import '../models/shots.dart';

class AddEditShotDialog extends StatefulWidget {
  const AddEditShotDialog({
    Key? key,
    required this.shots,
    required this.shot,
  }) : super(key: key);

  final Shots shots;
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
            child: Text('Shot'),
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
            child: Text('Score'),
          ),
          const SizedBox(height: Dimensions.paddingZero),
          Row(children: [
            IconButton(
              iconSize: 35,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: Theme.of(context).colorScheme.secondary,
              icon: Icon(selectedStar > 0 ? Icons.star : Icons.star_outline),
              onPressed: () {
                setState(() {
                  selectedStar = 1;
                });
              },
            ),
            IconButton(
              iconSize: 35,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: Theme.of(context).colorScheme.secondary,
              icon: Icon(selectedStar > 1 ? Icons.star : Icons.star_outline),
              onPressed: () {
                setState(() {
                  selectedStar = 2;
                });
              },
            ),
            IconButton(
              iconSize: 35,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: Theme.of(context).colorScheme.secondary,
              icon: Icon(selectedStar > 2 ? Icons.star : Icons.star_outline),
              onPressed: () {
                setState(() {
                  selectedStar = 3;
                });
              },
            ),
            IconButton(
              iconSize: 35,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: Theme.of(context).colorScheme.secondary,
              icon: Icon(selectedStar > 3 ? Icons.star : Icons.star_outline),
              onPressed: () {
                setState(() {
                  selectedStar = 4;
                });
              },
            ),
            IconButton(
              iconSize: 35,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              color: Theme.of(context).colorScheme.secondary,
              icon: Icon(selectedStar > 4 ? Icons.star : Icons.star_outline),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: const Text(
                      'DELETE',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      widget.shots.deleteOpponentShot(oldShotName);
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
                  if (shotController.text.isNotEmpty && selectedStar > 0) {
                    if (editing) {
                      widget.shots.updateOpponentShot(
                          oldShotName, shotController.text, selectedStar);
                    } else {
                      widget.shots
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
