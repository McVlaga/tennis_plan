import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/add_edit_match_section.dart';
import 'widgets/court_location_item.dart';
import 'widgets/court_surface_item.dart';
import 'widgets/match_result_item.dart';
import 'widgets/practice_check_box.dart';
import '../matches/models/a_match.dart';
import '../widgets/settings_countries_item.dart';
import '../widgets/settings_date_item.dart';
import '../widgets/settings_last_name_item.dart';
import '../widgets/settings_first_name_item.dart';
import '../widgets/settings_time_item.dart';
import '../matches/models/matches.dart';
import '../constants/constants.dart';

class AddEditMatchScreen extends StatefulWidget {
  static const routeName = '/add-edit-match-screen';

  const AddEditMatchScreen({Key? key}) : super(key: key);

  @override
  _AddEditMatchScreenState createState() => _AddEditMatchScreenState();
}

class _AddEditMatchScreenState extends State<AddEditMatchScreen> {
  late AMatch newMatch;

  @override
  void initState() {
    newMatch = AMatch(id: DateTime.now().toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: newMatch,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.addMatchDialogTitle),
          backgroundColor: Theme.of(context).primaryColor,
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
                    const AddEditMatchSection(
                      sectionTitle: 'OPPONENT',
                      sectionWidgets: [
                        SizedBox(height: Dimensions.paddingOne),
                        SettingsFirstNameItem(),
                        SettingsLastNameItem(),
                        SettingsCountriesItem(),
                        SizedBox(height: Dimensions.paddingOne),
                      ],
                    ),
                    AddEditMatchSection(
                      sectionTitle: 'MATCH',
                      sectionWidgets: [
                        const PracticeCheckBox(),
                        const SettingsDateItem(),
                        const SettingsTimeItem(),
                        Consumer<AMatch>(
                          builder: (ctx, match, child) {
                            if (match.matchDate != null &&
                                match.matchTime != null) {
                              DateTime fullDate = DateTime(
                                match.matchDate!.year,
                                match.matchDate!.month,
                                match.matchDate!.day,
                                match.matchTime!.hour,
                                match.matchTime!.minute,
                              );
                              if (fullDate.isBefore(DateTime.now())) {
                                return const MatchResultItem();
                              } else if (newMatch.matchState !=
                                  MatchState.notPlayed) {
                                newMatch.setInvisibleMatchState(
                                    MatchState.notPlayed);
                              }
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                    AddEditMatchSection(
                      sectionTitle: 'COURT',
                      sectionWidgets: [
                        const CourtSurfaceItem(),
                        Consumer<AMatch>(
                          builder: (ctx, match, child) {
                            if (match.courtSurface != null) {
                              if (match.courtSurface == CourtSurface.hard) {
                                return const CourtLocationItem();
                              } else {
                                newMatch.setInvisibleCourtLocation(null);
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
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.borderRadius),
                ),
                child: Material(
                  color: AppColors.winColor,
                  child: Consumer<Matches>(
                    builder: (ctx, matches, child) {
                      return InkWell(
                        onTap: () {
                          if (newMatch.opponentFirstName != null &&
                              newMatch.opponentLastName != null &&
                              newMatch.opponentCountry != null) {
                            matches.addMatch(newMatch);
                            Navigator.of(ctx).pop();
                          }
                        },
                        child: child,
                      );
                    },
                    child: const SizedBox(
                      height: Dimensions.addMatchDialogInputHeight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'ADD',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
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
