import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import '../widgets/screen_save_button.dart';
import '../widgets/section_title_widget.dart';
import 'models/tactical_plans.dart';
import 'widgets/editable_plans_list_widget.dart';
import '../../../matches/models/a_match.dart';
import '../../../constants/constants.dart';
import '../widgets/add_header_list_button.dart';

class AddEditTacticsScreen extends StatefulWidget {
  const AddEditTacticsScreen({Key? key}) : super(key: key);

  @override
  State<AddEditTacticsScreen> createState() => _AddEditTacticsScreenState();
}

class _AddEditTacticsScreenState extends State<AddEditTacticsScreen> {
  bool firstInit = true;
  late AMatch match;
  late TacticalPlans tempPlans;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstInit) {
      match = ModalRoute.of(context)!.settings.arguments as AMatch;
      tempPlans = TacticalPlans(match.tacticalPlans.plans);
      firstInit = false;
    }
  }

  void saveTactics() {
    match.setTacticalPlans(tempPlans);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tactics'),
        backgroundColor: Colors.blue,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(
              left: Dimensions.paddingTwo,
              right: Dimensions.paddingTwo,
              bottom: 100,
            ),
            children: [
              const SectionTitleWidget(title: 'PLANS'),
              ChangeNotifierProvider<TacticalPlans>.value(
                value: tempPlans,
                builder: (_, __) {
                  return const EditablePlansListWidget();
                },
              ),
              const SectionTitleWidget(title: 'GOALS'),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingOne),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(Dimensions.borderRadius),
                      ),
                    ),
                    child: Column(
                      children: [
                        AddHeaderListButton(
                          title: 'Add a goal',
                          icon: Icons.add,
                          function: () {},
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ReorderableColumn(
                            children: [
                              Row(
                                key: ValueKey('1'),
                                children: [
                                  Text('1)'),
                                  const SizedBox(width: 8),
                                  Text(
                                      'Try to keep him away from the baseline'),
                                ],
                              ),
                              const SizedBox(key: ValueKey('huy'), height: 16),
                              Row(
                                key: ValueKey('2'),
                                children: [
                                  Text('2)'),
                                  const SizedBox(width: 8),
                                  Text(
                                      'Play aggresive tennis when it is appropriate'),
                                ],
                              ),
                              const SizedBox(key: ValueKey('pizda'), height: 8),
                            ],
                            onReorder: (int oldIndex, int newIndex) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          ScreenSaveButton(saveFunction: saveTactics, color: Colors.blue),
        ],
      ),
    );
  }
}
