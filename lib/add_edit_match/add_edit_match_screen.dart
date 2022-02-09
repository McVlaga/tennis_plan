import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../matches/models/a_match.dart';
import '../matches/models/matches.dart';
import '../widgets/settings_section_widget.dart';
import 'models/validation_match.dart';
import 'widgets/countries_item.dart';
import 'widgets/court_surface_item.dart';
import 'widgets/date_item.dart';
import 'widgets/first_name_item.dart';
import 'widgets/last_name_item.dart';
import 'widgets/lefty_check_box.dart';
import 'widgets/practice_check_box.dart';
import 'widgets/ranking_item.dart';
import 'widgets/time_item.dart';

class AddEditMatchScreen extends StatefulWidget {
  static const routeName = '/add-edit-match-screen';

  const AddEditMatchScreen({Key? key}) : super(key: key);

  @override
  _AddEditMatchScreenState createState() => _AddEditMatchScreenState();
}

class _AddEditMatchScreenState extends State<AddEditMatchScreen> {
  late AMatch match;
  late String matchId;
  late ValidationMatch tempMatch;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool firstInit = true;
  bool editing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstInit) {
      var argument = ModalRoute.of(context)!.settings.arguments;
      if (argument != null) {
        editing = true;
        matchId = argument as String;
        match = Provider.of<Matches>(context, listen: false).findById(matchId);
        tempMatch = ValidationMatch(
          id: match.id,
          opponentFirstName: match.opponentFirstName,
          opponentLastName: match.opponentLastName,
          opponentCountry: match.opponentCountry,
          opponentRanking: match.opponentRanking,
          isPractice: match.isPractice,
          matchDate: match.matchDate,
          matchTime: match.matchTime,
          courtSurface: match.courtSurface,
        );
        firstNameController.text = match.opponentFirstName!;
        lastNameController.text = match.opponentLastName!;
      } else {
        tempMatch = ValidationMatch(id: DateTime.now().toString());
      }
      firstInit = false;
    }
  }

  void _saveMatch(BuildContext ctx, Matches matches) {
    tempMatch.setOpponentFirstName(
        firstNameController.text.isEmpty ? null : firstNameController.text);
    tempMatch.setOpponentLastName(
        lastNameController.text.isEmpty ? null : lastNameController.text);
    if (tempMatch.isValid()) {
      if (editing) {
        match.updateMatch(tempMatch);
      } else {
        matches.addMatch(tempMatch);
      }
      Navigator.of(ctx).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: tempMatch,
      child: Scaffold(
        appBar: AppBar(
          title: Text(editing ? 'Edit match' : 'Add a match'),
          backgroundColor: Theme.of(context).colorScheme.secondaryVariant,
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
              children: <Widget>[
                SettingsSectionWidget(
                  title: 'OPPONENT',
                  children: [
                    FirstNameItem(nameController: firstNameController),
                    LastNameItem(nameController: lastNameController),
                    const CountriesItem(),
                    const RankingItem(),
                    const LeftyCheckBox(),
                  ],
                ),
                const SettingsSectionWidget(
                  title: 'MATCH',
                  children: [
                    DateItem(),
                    TimeItem(),
                    PracticeCheckBox(),
                  ],
                ),
                const SettingsSectionWidget(
                  title: 'COURT',
                  children: [
                    CourtSurfaceItem(),
                  ],
                )
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
                    color: Theme.of(context).colorScheme.secondaryVariant,
                    child: Consumer<Matches>(
                      builder: (_, matches, child) {
                        return InkWell(
                          onTap: () {
                            _saveMatch(context, matches);
                          },
                          child: child,
                        );
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
      ),
    );
  }
}
