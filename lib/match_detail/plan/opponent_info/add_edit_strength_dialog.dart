import 'package:flutter/material.dart';
import 'package:tennis_plan/match_detail/plan/models/opponent_info.dart';
import '../../../constants/constants.dart';

class AddEditStrengthDialog extends StatefulWidget {
  const AddEditStrengthDialog({
    required this.context,
    required this.opponentInfo,
    required this.strength,
    Key? key,
  }) : super(key: key);

  final BuildContext context;
  final OpponentInfo opponentInfo;
  final String? strength;

  @override
  State<AddEditStrengthDialog> createState() => _AddEditStrengthDialogState();
}

class _AddEditStrengthDialogState extends State<AddEditStrengthDialog> {
  TextEditingController strengthController = TextEditingController();
  bool editing = false;
  late String oldStrength;

  @override
  void initState() {
    if (widget.strength != null) {
      editing = true;
      strengthController.text = widget.strength!;
      oldStrength = widget.strength!;
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
              'Add a strength',
            ),
          ),
          TextField(
            autofocus: true,
            maxLines: null,
            controller: strengthController,
            textCapitalization: TextCapitalization.sentences,
            onChanged: null,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Great serve + 1',
            ),
          ),
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
                        widget.opponentInfo.deleteOpponentStrength(oldStrength);
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
                  if (strengthController.text.isNotEmpty) {
                    if (editing) {
                      widget.opponentInfo.updateOpponentStrength(
                        oldStrength,
                        strengthController.text,
                      );
                    } else {
                      widget.opponentInfo
                          .addOpponentStrength(strengthController.text);
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
