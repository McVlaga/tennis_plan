import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import '../../add_edit_match/models/validation_match.dart';
import '../../constants/constants.dart';

class AMatch with ChangeNotifier {
  late String id;
  String? opponentFirstName;
  String? opponentLastName;
  Country? opponentCountry;
  bool? isPractice;
  DateTime? matchDate;
  TimeOfDay? matchTime;
  MatchState? matchResult;
  CourtSurface? courtSurface;
  CourtLocation? courtLocation;

  AMatch({
    required this.id,
    this.opponentFirstName,
    this.opponentLastName,
    this.opponentCountry,
    this.isPractice = false,
    this.matchDate,
    this.matchTime,
    this.matchResult,
    this.courtSurface,
    this.courtLocation,
  });

  AMatch.fromTemporaryMatch(ValidationMatch tempMatch) {
    id = tempMatch.id;
    opponentFirstName = tempMatch.opponentFirstName;
    opponentLastName = tempMatch.opponentLastName;
    opponentCountry = tempMatch.opponentCountry;
    isPractice = tempMatch.isPractice;
    matchDate = tempMatch.matchDate;
    matchTime = tempMatch.matchTime;
    matchResult = tempMatch.matchResult;
    courtSurface = tempMatch.courtSurface;
    courtLocation = tempMatch.courtLocation;
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

  void setCourtLocation(dynamic location) {
    courtLocation = location;
    notifyListeners();
  }
}
