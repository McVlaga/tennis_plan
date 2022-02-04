import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:tennis_plan/match_detail/plan/models/plan.dart';
import 'ranking.dart';
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

  late Plan plan;

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
    required this.plan,
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
    plan = tempMatch.plan;
  }

  void setPlan(Plan plan) {
    this.plan = plan;
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

  void setCourtLocation(dynamic location) {
    courtLocation = location;
    notifyListeners();
  }

  void addOpponentShot(String name, int score) {
    plan.opponentInfo.addOpponentShot(name, score);
    notifyListeners();
  }

  void reorderOpponentShot(int from, int to, String shotName, int shotScore) {
    plan.opponentInfo.reorderOpponentShot(from, to, shotName, shotScore);
    notifyListeners();
  }

  void addOpponentStrength(String strength) {
    plan.opponentInfo.addOpponentStrength(strength);
    notifyListeners();
  }

  void reorderOpponentStrength(int from, int to, String strength) {
    plan.opponentInfo.reorderOpponentStrength(from, to, strength);
    notifyListeners();
  }

  void addOpponentWeakness(String weakness) {
    plan.opponentInfo.addOpponentWeakness(weakness);
    notifyListeners();
  }

  void reorderOpponentWeakness(int from, int to, String weakness) {
    plan.opponentInfo.reorderOpponentWeakness(from, to, weakness);
    notifyListeners();
  }

  void updateOpponentShot(String oldName, String newName, int score) {
    plan.opponentInfo.updateOpponentShot(oldName, newName, score);
    notifyListeners();
  }

  void updateOpponentStrength(String oldStrength, String newStrength) {
    plan.opponentInfo.updateOpponentStrength(oldStrength, newStrength);
    notifyListeners();
  }

  void updateOpponentWeakness(String oldWeakness, String newWeakness) {
    plan.opponentInfo.updateOpponentWeakness(oldWeakness, newWeakness);
    notifyListeners();
  }

  void deleteOpponentShot(String name) {
    plan.opponentInfo.deleteOpponentShot(name);
    notifyListeners();
  }

  void deleteOpponentStrength(String strength) {
    plan.opponentInfo.deleteOpponentStrength(strength);
    notifyListeners();
  }

  void deleteOpponentWeakness(String weakness) {
    plan.opponentInfo.deleteOpponentWeakness(weakness);
    notifyListeners();
  }
}
