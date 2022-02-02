import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:tennis_plan/match_detail/plan/models/plan.dart';
import 'package:tennis_plan/match_detail/plan/models/shot.dart';
import 'package:tennis_plan/matches/models/ranking.dart';
import '../../add_edit_match/models/validation_match.dart';
import '../../constants/constants.dart';

class AMatch with ChangeNotifier {
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
  CourtLocation? courtLocation;

  Plan? plan = Plan();

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
    this.courtLocation,
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

  void addOpponentShot(String name, int score) {
    plan!.addOpponentShot(name, score);
    notifyListeners();
  }

  void addOpponentStrength(String strength) {
    plan!.addOpponentStrength(strength);
    notifyListeners();
  }

  void addOpponentWeakness(String weakness) {
    plan!.addOpponentWeakness(weakness);
    notifyListeners();
  }

  void updateOpponentShot(String oldName, String newName, int score) {
    plan!.updateOpponentShot(oldName, newName, score);
    notifyListeners();
  }

  void updateOpponentStrength(String oldStrength, String newStrength) {
    plan!.updateOpponentStrength(oldStrength, newStrength);
    notifyListeners();
  }

  void updateOpponentWeakness(String oldWeakness, String newWeakness) {
    plan!.updateOpponentWeakness(oldWeakness, newWeakness);
    notifyListeners();
  }

  void deleteOpponentShot(String name) {
    plan!.deleteOpponentShot(name);
    notifyListeners();
  }

  void deleteOpponentStrength(String strength) {
    plan!.deleteOpponentStrength(strength);
    notifyListeners();
  }

  void deleteOpponentWeakness(String weakness) {
    plan!.deleteOpponentWeakness(weakness);
    notifyListeners();
  }
}
