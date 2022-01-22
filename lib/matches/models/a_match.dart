import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class AMatch with ChangeNotifier {
  String id;
  String? playerFirstName;
  String? playerLastName;
  Country? playerCountry;
  String? opponentFirstName;
  String? opponentLastName;
  Country? opponentCountry;
  bool? isPractice;
  DateTime? matchDate;
  TimeOfDay? matchTime;
  MatchState? matchState;
  CourtSurface? courtSurface;
  CourtLocation? courtLocation;

  AMatch({
    required this.id,
    this.playerFirstName,
    this.playerLastName,
    this.playerCountry,
    this.opponentFirstName,
    this.opponentLastName,
    this.opponentCountry,
    this.isPractice = false,
    this.matchDate,
    this.matchTime,
    this.matchState,
    this.courtSurface,
    this.courtLocation,
  });

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
    matchState = state;
    notifyListeners();
  }

  void setInvisibleMatchState(MatchState state) {
    matchState = state;
  }

  void setCourtSurface(CourtSurface surface) {
    courtSurface = surface;
    notifyListeners();
  }

  void setCourtLocation(dynamic location) {
    courtLocation = location;
    notifyListeners();
  }

  void setInvisibleCourtLocation(CourtLocation? location) {
    courtLocation = location;
  }
}
