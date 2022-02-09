import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../matches/models/a_match.dart';
import '../../matches/models/ranking.dart';

class ValidationMatch with ChangeNotifier {
  String id;
  String? opponentFirstName;
  String? opponentLastName;
  Country? opponentCountry;
  Ranking? opponentRanking;
  bool? isOpponentLefty;
  bool? isPractice;
  DateTime? matchDate;
  TimeOfDay? matchTime;
  CourtSurface? courtSurface;

  String? opponentFirstNameError;
  String? opponentLastNameError;

  ValidationMatch({
    required this.id,
    this.opponentFirstName,
    this.opponentLastName,
    this.opponentCountry,
    this.opponentRanking,
    this.isOpponentLefty = false,
    this.isPractice = false,
    this.matchDate,
    this.matchTime,
    this.courtSurface,
  });

  bool isValid() {
    bool isValid = true;
    if (opponentFirstName == null) {
      opponentFirstNameError = 'Enter first name';
      isValid = false;
    } else {
      opponentFirstNameError = null;
    }
    if (opponentLastName == null) {
      opponentLastNameError = 'Enter last name';
      isValid = false;
    } else {
      opponentLastNameError = null;
    }
    if (!isValid) {
      notifyListeners();
    }
    return isValid;
  }

  bool showError(Object? property) {
    return property == null;
  }

  void setOpponentFirstName(String? firstName) {
    opponentFirstName = firstName;
    notifyListeners();
  }

  void setOpponentLastName(String? lastName) {
    opponentLastName = lastName;
    notifyListeners();
  }

  void setOpponentCountry(Country country) {
    opponentCountry = country;
    notifyListeners();
  }

  void setOpponentRanking(String fed, String posString) {
    if (fed.isEmpty || posString.isEmpty) {
      opponentRanking = null;
    } else {
      int posInt = int.parse(posString);
      opponentRanking = Ranking(federation: fed, position: posInt);
    }
    notifyListeners();
  }

  String get opponentCountryString {
    if (opponentCountry != null) {
      return opponentCountry!.name;
    }
    return '';
  }

  String get opponentRankingString {
    if (opponentRanking != null) {
      return '${opponentRanking!.federation} ${opponentRanking!.position}';
    }
    return '';
  }

  void setIsOpponentLefty(bool lefty) {
    isOpponentLefty = lefty;
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

  String get matchDateString {
    if (matchDate != null) {
      return DateFormat('MMM d, yyyy').format(matchDate!);
    }
    return '';
  }

  void setMatchTime(TimeOfDay time) {
    matchTime = time;
    notifyListeners();
  }

  String getMatchTimeString(BuildContext context) {
    if (matchTime != null) {
      return matchTime!.format(context);
    }
    return '';
  }

  void setCourtSurface(CourtSurface surface) {
    courtSurface = surface;
    notifyListeners();
  }

  String get courtSurfaceString {
    if (courtSurface != null) {
      if (courtSurface == CourtSurface.hardIndoors) {
        return 'hard indoors';
      } else if (courtSurface == CourtSurface.hardOutdoors) {
        return 'hard outdoors';
      } else {
        return courtSurface!.name;
      }
    }
    return '';
  }

  void showErrors() {
    notifyListeners();
  }
}
