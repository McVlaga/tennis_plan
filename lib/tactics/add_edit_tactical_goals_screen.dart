import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/widgets/section_title_widget.dart';
import '../court_drawing/draw_plan_screen.dart';
import 'dialogs/add_edit_plan_info_dialog.dart';
import 'models/tactical_plans.dart';
import 'widgets/editable_plans_list_widget.dart';
import '../../../matches/models/a_match.dart';
import '../../../matches/models/matches.dart';
import '../../../constants/constants.dart';
import '../opponent_info/add_header_list_button.dart';
import '../../../settings/widgets/settings_section_widget.dart';

class AddEditTacticalGoalsScreen extends StatefulWidget {
  const AddEditTacticalGoalsScreen({Key? key}) : super(key: key);
  static const routeName = '/add-edit-tactical-goals';

  @override
  State<AddEditTacticalGoalsScreen> createState() =>
      _AddEditTacticalGoalsScreenState();
}

class _AddEditTacticalGoalsScreenState
    extends State<AddEditTacticalGoalsScreen> {
  bool firstInit = true;
  late AMatch match;
  late String matchId;
  late TacticalPlans tempPlans;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstInit) {
      matchId = ModalRoute.of(context)!.settings.arguments as String;
      match = Provider.of<Matches>(context, listen: false).findById(matchId);
      tempPlans = TacticalPlans(match.tacticalPlans.plans);
      firstInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tactical Goals'),
        backgroundColor: Colors.blue,
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
              const SectionTitleWidget(title: 'PLANS'),
              ChangeNotifierProvider<TacticalPlans>.value(
                value: tempPlans,
                builder: (_, __) {
                  return const EditablePlansListWidget();
                },
              ),
              const SectionTitleWidget(title: 'GOALS'),
              AddHeaderListButton(
                title: 'Add a goal',
                showDialog: () {},
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.paddingTwo,
                right: Dimensions.paddingTwo,
                bottom: Dimensions.paddingTwo,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.borderRadius),
                ),
                child: Material(
                  color: Colors.blue,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                      height: Dimensions.addMatchDialogInputHeight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
