import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/ranking_item.dart';

import '../constants/constants.dart';
import '../matches/models/a_match.dart';
import '../matches/models/matches.dart';
import '../widgets/settings_section_widget.dart';
import 'models/validation_match.dart';
import 'widgets/countries_item.dart';
import 'widgets/court_location_item.dart';
import 'widgets/court_surface_item.dart';
import 'widgets/date_item.dart';
import 'widgets/first_name_item.dart';
import 'widgets/last_name_item.dart';
import 'widgets/practice_check_box.dart';
import 'widgets/time_item.dart';

class AddEditMatchScreen extends StatefulWidget {
  static const routeName = '/add-edit-match-screen';

  const AddEditMatchScreen({Key? key}) : super(key: key);

  @override
  _AddEditMatchScreenState createState() => _AddEditMatchScreenState();
}

class _AddEditMatchScreenState extends State<AddEditMatchScreen> {
  late ValidationMatch tempMatch;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tempMatch = ValidationMatch(id: DateTime.now().toString());
  }

  void _saveMatch(BuildContext ctx, Matches matches) {
    tempMatch.setOpponentFirstName(firstNameController.text);
    tempMatch.setOpponentLastName(lastNameController.text);
    if (tempMatch.isValid()) {
      matches.addMatch(AMatch.fromTemporaryMatch(tempMatch));
      Navigator.of(ctx).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: tempMatch,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.addMatchDialogTitle),
          backgroundColor: Theme.of(context).colorScheme.secondaryVariant,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: Dimensions.paddingTwo,
                  right: Dimensions.paddingTwo,
                  bottom: Dimensions.paddingTwo,
                ),
                child: Column(
                  children: <Widget>[
                    SettingsSectionWidget(
                      sectionTitle: 'OPPONENT',
                      sectionWidgets: [
                        FirstNameItem(nameController: firstNameController),
                        LastNameItem(nameController: lastNameController),
                        const CountriesItem(),
                        const RankingItem(),
                      ],
                    ),
                    const SettingsSectionWidget(
                      sectionTitle: 'MATCH',
                      sectionWidgets: [
                        PracticeCheckBox(),
                        DateItem(),
                        TimeItem(),
                      ],
                    ),
                    SettingsSectionWidget(
                      sectionTitle: 'COURT',
                      sectionWidgets: [
                        const CourtSurfaceItem(),
                        Consumer<ValidationMatch>(
                          builder: (ctx, match, child) {
                            if (match.courtSurface != null) {
                              if (match.courtSurface == CourtSurface.hard) {
                                return const CourtLocationItem();
                              } else {
                                tempMatch.setInvisibleCourtLocation(null);
                              }
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
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
          ],
        ),
      ),
    );
  }
}
