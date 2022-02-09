import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../opponent_info/add_header_list_button.dart';
import 'add_edit_plan_screen.dart';
import '../../../widgets/settings_section_widget.dart';

class AddEditTacticalGoalsScreen extends StatelessWidget {
  const AddEditTacticalGoalsScreen({Key? key}) : super(key: key);
  static const routeName = '/add-edit-tactical-goals';

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
              SettingsSectionWidget(
                title: 'PLANS',
                children: [
                  AddHeaderListButton(
                    title: 'Add a plan',
                    showDialog: () {
                      Navigator.of(context)
                          .pushNamed(AddEditPlanScreen.routeName);
                    },
                  ),
                ],
              ),
              SettingsSectionWidget(
                title: 'GOALS',
                children: [
                  AddHeaderListButton(
                    title: 'Add a goal',
                    showDialog: () {},
                  ),
                ],
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
