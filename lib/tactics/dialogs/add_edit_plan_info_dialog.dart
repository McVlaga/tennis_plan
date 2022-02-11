import 'package:flutter/material.dart';
import '../models/tactical_plan.dart';
import '../models/tactical_plans.dart';

import '../../../constants/constants.dart';

class AddEditPlanInfoDialog extends StatefulWidget {
  const AddEditPlanInfoDialog({
    required this.plans,
    required this.plan,
    Key? key,
  }) : super(key: key);
  final TacticalPlans plans;
  final TacticalPlan? plan;

  @override
  State<AddEditPlanInfoDialog> createState() => _AddEditPlanInfoDialogState();
}

class _AddEditPlanInfoDialogState extends State<AddEditPlanInfoDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool editing = false;
  late String oldTitle;
  late String oldDescription;

  @override
  void initState() {
    if (widget.plan != null) {
      editing = true;
      titleController.text = widget.plan!.title;
      oldTitle = widget.plan!.title;
      descriptionController.text = widget.plan!.description;
      oldDescription = widget.plan!.description;
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
            child: Text('Add a plan'),
          ),
          TextField(
            autofocus: true,
            controller: titleController,
            textCapitalization: TextCapitalization.sentences,
            onChanged: null,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Plan A',
            ),
          ),
          TextField(
            autofocus: true,
            maxLines: null,
            controller: descriptionController,
            textCapitalization: TextCapitalization.sentences,
            onChanged: null,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Try to play deeper',
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
                        widget.plans.deleteOpponentPlan(oldTitle);
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
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    if (editing) {
                      // widget.plans.updateOpponentWeakness(
                      //   oldWeakness,
                      //   weaknessController.text,
                      // );
                    } else {
                      widget.plans.addPlan(titleController.text,
                          descriptionController.text, null);
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
