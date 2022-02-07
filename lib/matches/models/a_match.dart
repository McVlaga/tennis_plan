import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../match_detail/plan/models/shots.dart';
import '../../match_detail/plan/models/strengths.dart';
import '../../match_detail/plan/models/weaknesses.dart';
import 'ranking.dart';
import '../../add_edit_match/models/validation_match.dart';

enum MatchState { win, lose, notPlayed }

enum CourtSurface { hardIndoors, hardOutdoors, grass, clay, carpet }

class AMatch with ChangeNotifier {
  final DateFormat _dateFormat = DateFormat('MMM d, yyyy');

  late String id;
  String? opponentFirstName;
  String? opponentLastName;
  Country? opponentCountry;
  Ranking? opponentRanking;
  bool? isPractice;
  DateTime? matchDate;
  TimeOfDay? matchTime;
  MatchState? matchResult;
  CourtSurface? courtSurface;

  Shots opponentShots = Shots([]);
  Strengths opponentStrengths = Strengths([]);
  Weaknesses opponentWeaknesses = Weaknesses([]);

  AMatch({
    required this.id,
    this.opponentFirstName,
    this.opponentLastName,
    this.opponentCountry,
    this.opponentRanking,
    this.isPractice = false,
    this.matchDate,
    this.matchTime,
    this.matchResult = MatchState.notPlayed,
    this.courtSurface,
  });

  AMatch.fromTemporaryMatch(ValidationMatch tempMatch) {
    id = tempMatch.id;
    opponentFirstName = tempMatch.opponentFirstName;
    opponentLastName = tempMatch.opponentLastName;
    opponentCountry = tempMatch.opponentCountry;
    opponentRanking = tempMatch.opponentRanking;
    isPractice = tempMatch.isPractice;
    matchDate = tempMatch.matchDate;
    matchTime = tempMatch.matchTime;
    courtSurface = tempMatch.courtSurface;
  }

  void setOpponentInfo(
    Shots newOpponentShots,
    Strengths newOpponentStrengths,
    Weaknesses newOpponentWeaknesses,
  ) {
    opponentShots = newOpponentShots;
    opponentStrengths = newOpponentStrengths;
    opponentWeaknesses = newOpponentWeaknesses;
    notifyListeners();
  }

  void setOpponentFirstName(String firstName) {
    opponentFirstName = firstName;
    notifyListeners();
  }

  void setOpponentLastName(String lastName) {
    opponentLastName = lastName;
    notifyListeners();
  }

  void setOpponentCountry(Country country) {
    opponentCountry = country;
    notifyListeners();
  }

  void setIsPractice(bool practice) {
    isPractice = practice;
    notifyListeners();
  }

  void setMatchDate(DateTime date) {
    matchDate = date;
    notifyListeners();
  }

  void setMatchTime(TimeOfDay time) {
    matchTime = time;
    notifyListeners();
  }

  void setMatchState(MatchState state) {
    matchResult = state;
    notifyListeners();
  }

  void setCourtSurface(CourtSurface surface) {
    courtSurface = surface;
    notifyListeners();
  }

  void updateMatch(ValidationMatch tempMatch) {
    opponentFirstName = tempMatch.opponentFirstName!;
    opponentLastName = tempMatch.opponentLastName!;
    opponentCountry = tempMatch.opponentCountry;
    opponentRanking = tempMatch.opponentRanking;
    isPractice = tempMatch.isPractice;
    matchDate = tempMatch.matchDate;
    matchTime = tempMatch.matchTime;
    courtSurface = tempMatch.courtSurface;
    notifyListeners();
  }

  String getNameString(bool fullName) {
    if (fullName) {
      return getFullNameString();
    } else {
      return getShortNameString();
    }
  }

  String getShortNameString() {
    return '${opponentFirstName?[0]}. $opponentLastName';
  }

  String getFullNameString() {
    return '$opponentFirstName $opponentLastName';
  }

  String getRankingString() {
    if (opponentRanking != null) {
      return '${opponentRanking?.federation} ${opponentRanking?.position}';
    } else {
      return '';
    }
  }

  String getFlagImagePath() {
    return 'icons/flags/png/${opponentCountry!.countryCode.toLowerCase()}.png';
  }

  String buildSurfaceLocationString() {
    if (courtSurface != null) {
      String surface = courtSurface!.name.toUpperCase();
      if (courtSurface == CourtSurface.hardIndoors) {
        return 'HARD, INDOORS';
      } else if (courtSurface == CourtSurface.hardOutdoors) {
        return 'HARD, OUTDOORS';
      } else {
        return surface;
      }
    }
    return '';
  }

  Color getSurfaceColor() {
    switch (courtSurface) {
      case CourtSurface.hardIndoors:
        return Colors.blue;
      case CourtSurface.hardOutdoors:
        return Colors.blue;
      case CourtSurface.clay:
        return Colors.orange;
      case CourtSurface.grass:
        return Colors.green;
      case CourtSurface.carpet:
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  String getDateString(BuildContext context) {
    String time = '';
    String date = '';
    if (matchTime != null) {
      time = matchTime!.format(context);
    }
    if (matchDate != null) {
      date = _dateFormat.format(matchDate!);
    }
    return '$time $date';
  }
}
