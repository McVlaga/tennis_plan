import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../models/weaknesses.dart';

class AddEditWeaknessDialog extends StatefulWidget {
  const AddEditWeaknessDialog({
    required this.weaknesses,
    required this.weakness,
    Key? key,
  }) : super(key: key);
  final Weaknesses weaknesses;
  final String? weakness;

  @override
  State<AddEditWeaknessDialog> createState() => _AddEditWeaknessDialogState();
}

class _AddEditWeaknessDialogState extends State<AddEditWeaknessDialog> {
  TextEditingController weaknessController = TextEditingController();
  bool editing = false;
  late String oldWeakness;

  @override
  void initState() {
    if (widget.weakness != null) {
      editing = true;
      weaknessController.text = widget.weakness!;
      oldWeakness = widget.weakness!;
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
              'Add a weakness',
            ),
          ),
          TextField(
            autofocus: true,
            maxLines: null,
            controller: weaknessController,
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: const Text(
                      'DELETE',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      widget.weaknesses.deleteOpponentWeakness(oldWeakness);
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
                  if (weaknessController.text.isNotEmpty) {
                    if (editing) {
                      widget.weaknesses.updateOpponentWeakness(
                        oldWeakness,
                        weaknessController.text,
                      );
                    } else {
                      widget.weaknesses
                          .addOpponentWeakness(weaknessController.text);
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
