import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/constants/constants.dart';
import 'package:tennis_plan/court_drawing/court_painter.dart';
import 'package:tennis_plan/opponent_info/add_header_list_button.dart';
import 'package:tennis_plan/services/court_drawing_manager.dart';
import 'package:tennis_plan/settings/widgets/settings_section_widget.dart';
import 'package:tennis_plan/tactics/models/tactical_plan.dart';
import 'package:tennis_plan/tactics/models/tactical_plans.dart';
import 'package:tennis_plan/widgets/color_picker_dialog.dart';
import 'package:tennis_plan/widgets/screen_save_button.dart';

class AddEditTacticalPlanScreen extends StatefulWidget {
  const AddEditTacticalPlanScreen({Key? key}) : super(key: key);

  @override
  State<AddEditTacticalPlanScreen> createState() =>
      _AddEditTacticalPlanScreenState();
}

class _AddEditTacticalPlanScreenState extends State<AddEditTacticalPlanScreen> {
  bool firstInit = true;
  bool editing = false;
  late TacticalPlans tempPlans;
  late TacticalPlan plan;
  late CourtDrawingManager _courtManager;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late String oldTitle;
  late Color selectedColor = Colors.grey;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstInit) {
      _onInit();
    }
  }

  void _onInit() {
    final courtWidth = MediaQuery.of(context).size.width - 32;
    _courtManager = CourtDrawingManager(context, courtWidth, 1);
    Map<String, Object?> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object?>;
    tempPlans = arguments['tempPlans'] as TacticalPlans;
    String? planTitle = arguments['planTitle'] as String?;
    if (planTitle == null) {
      selectedColor = Theme.of(context).colorScheme.onPrimary;
      plan = TacticalPlan(
          title: '', description: '', color: selectedColor, drawing: null);
    } else {
      editing = true;
      plan = tempPlans.findByTitle(planTitle);
      titleController.text = plan.title;
      oldTitle = plan.title;
      descriptionController.text = plan.description;
      selectedColor = plan.color;
    }
    firstInit = false;
  }

  void _savePlan() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      if (editing) {
        tempPlans.updatePlan(
          titleController.text,
          descriptionController.text,
          selectedColor,
          plan.drawing,
        );
      } else {
        tempPlans.addPlan(
          titleController.text,
          descriptionController.text,
          selectedColor,
          plan.drawing,
        );
      }
      Navigator.of(context).pop();
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'Delete plan',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          content: const Text("Are you sure you want to delete this plan?"),
          actions: [
            TextButton(
              child: const Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "DELETE",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                tempPlans.deletePlan(oldTitle);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _openDrawPlanScreen() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamed(
      '/match-detail/add-edit-tactics/add-edit-tactical-plan/draw-plan',
      arguments: plan,
    );
  }

  void _showColorPickerDialog() async {
    FocusScope.of(context).unfocus();
    final Color? color = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ColorPickerDialog(selectedColor: selectedColor);
      },
    );
    if (color != null) {
      setState(() {
        selectedColor = color;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Edit plan' : 'Add a plan'),
        backgroundColor: Colors.blue,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        actions: [
          if (editing)
            IconButton(
              onPressed: _showDeleteDialog,
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            )
        ],
      ),
      body: ChangeNotifierProvider.value(
          value: plan,
          builder: (_, __) {
            return Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.only(
                    left: Dimensions.paddingTwo,
                    right: Dimensions.paddingTwo,
                    bottom: 100,
                  ),
                  children: [
                    SettingsSectionWidget(
                      title: 'PLAN INFO',
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            autofocus: !editing,
                            controller: titleController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Plan A',
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            maxLines: null,
                            controller: descriptionController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Try to play deeper',
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
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
                          onTap: _showColorPickerDialog,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Dimensions.borderRadius)),
                      ),
                      child: Column(
                        children: [
                          AddHeaderListButton(
                            title: 'Draw plan',
                            icon: Icons.edit,
                            function: _openDrawPlanScreen,
                          ),
                          Consumer<TacticalPlan>(builder: (_, newPlan, ___) {
                            return ClipRRect(
                              child: Container(
                                width: _courtManager.canvasWidth,
                                height: _courtManager.canvasHeight,
                                alignment: Alignment.topLeft,
                                color: Colors.transparent,
                                child: newPlan.drawing != null
                                    ? _courtManager.buildCourtDrawingWidget(
                                        newPlan.drawing!,
                                      )
                                    : _courtManager.buildCourtWidget(),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                ScreenSaveButton(saveFunction: _savePlan, color: Colors.blue),
              ],
            );
          }),
    );
  }
}
