import 'package:flutter/material.dart';
import '../../court_drawing/draw_plan_screen.dart';
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
  late TacticalPlan tempPlan;
  bool editing = false;
  late String oldTitle;

  bool firstInit = true;

  late Color selectedColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    if (widget.plan != null) {
      editing = true;
      titleController.text = widget.plan!.title;
      oldTitle = widget.plan!.title;
      descriptionController.text = widget.plan!.description;
      selectedColor = widget.plan!.color;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstInit) {
      firstInit = false;
      selectedColor = Theme.of(context).colorScheme.onPrimary;
      if (editing) {
        tempPlan = widget.plan!;
      } else {
        tempPlan = TacticalPlan(
            title: '', description: '', color: selectedColor, imageBytes: null);
      }
    }
  }

  void showColorPickerDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Select color",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 50,
                    icon: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      selectedColor = Theme.of(context).colorScheme.onPrimary;
                      Navigator.of(context).pop();
                    },
                  ),
                  IconButton(
                    iconSize: 50,
                    icon: CircleAvatar(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      selectedColor = Colors.blue;
                      Navigator.of(context).pop();
                    },
                  ),
                  IconButton(
                    iconSize: 50,
                    icon: CircleAvatar(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      selectedColor = Colors.green;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 50,
                    icon: CircleAvatar(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () {
                      selectedColor = Colors.orange;
                      Navigator.of(context).pop();
                    },
                  ),
                  IconButton(
                    iconSize: 50,
                    icon: CircleAvatar(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      selectedColor = Colors.red;
                      Navigator.of(context).pop();
                    },
                  ),
                  IconButton(
                    iconSize: 50,
                    icon: CircleAvatar(
                      backgroundColor: Colors.purpleAccent,
                    ),
                    onPressed: () {
                      selectedColor = Colors.purpleAccent;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
        );
      },
    );
    setState(() {});
  }

  void openDrawPlanScreen() {
    Navigator.of(context).pushNamed(
      DrawPlanScreen.routeName,
      arguments: tempPlan,
    );
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Add a plan'),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (tempPlan.imageBytes == null)
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    child: InkWell(
                      onTap: openDrawPlanScreen,
                      child: const Center(child: Text('DRAW PLAN')),
                    ),
                  ),
                ),
              if (tempPlan.imageBytes != null)
                Expanded(child: Image.memory(tempPlan.imageBytes!)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      controller: titleController,
                      textCapitalization: TextCapitalization.sentences,
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
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Try to play deeper',
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            const Text(
                              'Plan color',
                              style: TextStyle(fontSize: 16),
                            ),
                            const Spacer(),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: selectedColor,
                              child: const Icon(null),
                            ),
                          ],
                        ),
                      ),
                      onTap: showColorPickerDialog,
                    ),
                  ],
                ),
              ),
            ],
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
                      widget.plans.deleteOpponentPlan(oldTitle);
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
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    if (editing) {
                      // widget.plans.updateOpponentWeakness(
                      //   oldWeakness,
                      //   weaknessController.text,
                      // );
                    } else {
                      widget.plans.addPlan(
                        titleController.text,
                        descriptionController.text,
                        selectedColor,
                        tempPlan.imageBytes,
                      );
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
