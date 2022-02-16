import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/screen_save_button.dart';

import '../constants/constants.dart';
import '../matches/models/a_match.dart';
import '../matches/models/matches.dart';
import '../settings/widgets/settings_section_widget.dart';
import 'models/validation_match.dart';
import 'widgets/countries_item.dart';
import 'widgets/court_surface_item.dart';
import 'widgets/date_item.dart';
import 'widgets/ranking_item.dart';
import 'widgets/time_item.dart';

class AddEditMatchScreen extends StatefulWidget {
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
      _onInit();
    }
  }

  void _onInit() {
    var argument = ModalRoute.of(context)!.settings.arguments;
    if (argument != null) {
      editing = true;
      matchId = argument as String;
      match = context.read<Matches>().findById(matchId);
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
                    const LeftyCheckBoxItem(),
                  ],
                ),
                const SettingsSectionWidget(
                  title: 'MATCH',
                  children: [
                    DateItem(),
                    TimeItem(),
                    PracticeCheckBoxItem(),
                  ],
                ),
                const SettingsSectionWidget(
                  title: 'COURT',
                  children: [
                    CourtSurfaceItem(),
                  ],
                ),
              ],
            ),
            Consumer<Matches>(builder: (_, matches, __) {
              return ScreenSaveButton(
                saveFunction: () {
                  _saveMatch(context, matches);
                },
                color: Theme.of(context).colorScheme.secondaryVariant,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class FirstNameItem extends StatelessWidget {
  FirstNameItem({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    final match = context.read<ValidationMatch>();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingTwo,
        vertical: Dimensions.paddingOne,
      ),
      child: TextField(
        controller: nameController,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: 'FirstName',
          errorText: match.opponentFirstNameError,
        ),
      ),
    );
  }
}

class LastNameItem extends StatelessWidget {
  LastNameItem({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    final match = context.read<ValidationMatch>();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingTwo,
        vertical: Dimensions.paddingOne,
      ),
      child: TextField(
        controller: nameController,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: 'Last Name',
          errorText: match.opponentLastNameError,
        ),
      ),
    );
  }
}

class LeftyCheckBoxItem extends StatelessWidget {
  const LeftyCheckBoxItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final match = context.watch<ValidationMatch>();
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: SwitchListTile(
        activeColor: Theme.of(context).colorScheme.secondary,
        contentPadding: const EdgeInsets.only(
          left: Dimensions.paddingTwo,
          right: Dimensions.paddingTwo,
        ),
        title: const Text("Lefty"),
        value: match.isOpponentLefty!,
        onChanged: (newValue) {
          match.setIsOpponentLefty(newValue);
        }, //  <-- leading Checkbox
      ),
    );
  }
}

class PracticeCheckBoxItem extends StatelessWidget {
  const PracticeCheckBoxItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final match = context.watch<ValidationMatch>();
    return SizedBox(
      height: Dimensions.addMatchDialogInputHeight,
      child: SwitchListTile(
        activeColor: Theme.of(context).colorScheme.secondary,
        contentPadding: const EdgeInsets.only(
          left: Dimensions.paddingTwo,
          right: Dimensions.paddingTwo,
        ),
        title: const Text("Practice"),
        value: match.isPractice!,
        onChanged: (newValue) {
          match.setIsPractice(newValue);
        }, //  <-- leading Checkbox
      ),
    );
  }
}
