import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/constants.dart';

class ValidationMatch with ChangeNotifier {
  String id;
  String? opponentFirstName;
  String? opponentLastName;
  Country? opponentCountry;
  bool? isPractice;
  DateTime? matchDate;
  TimeOfDay? matchTime;
  MatchState? matchResult;
  CourtSurface? courtSurface;
  CourtLocation? courtLocation;

  String? opponentFirstNameError;
  String? opponentLastNameError;
  String? opponentCountryError;
  String? matchDateError;
  String? matchTimeError;
  String? matchResultError;
  String? courtSurfaceError;
  String? courtLocationError;

  ValidationMatch({
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
    if (opponentCountry == null) {
      opponentCountryError = 'Choose a country';
      isValid = false;
    } else {
      opponentCountryError = null;
    }
    if (matchDate == null) {
      matchDateError = 'Select a date';
      isValid = false;
    } else {
      matchDateError = null;
    }
    if (matchTime == null) {
      matchTimeError = 'Select time';
      isValid = false;
    } else {
      matchTimeError = null;
    }
    if (matchDate != null && matchTime != null) {
      DateTime fullDate = DateTime(
        matchDate!.year,
        matchDate!.month,
        matchDate!.day,
        matchTime!.hour,
        matchTime!.minute,
      );
      if (fullDate.isBefore(DateTime.now())) {
        if (matchResult == null) {
          matchResultError = 'Select result';
          isValid = false;
        } else {
          matchResultError = null;
        }
      }
    }
    if (courtSurface == null) {
      courtSurfaceError = 'Choose a surface';
      isValid = false;
    } else {
      courtSurfaceError = null;
      if (courtSurface == CourtSurface.hard) {
        if (courtLocation == null) {
          courtLocationError = 'Choose a location';
          isValid = false;
        } else {
          courtLocationError = null;
        }
      }
    }
    if (!isValid) {
      notifyListeners();
    }
    return isValid;
  }

  bool showError(Object? property) {
    return property == null;
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

  String get opponentCountryString {
    if (opponentCountry != null) {
      return opponentCountry!.name;
    }
    if (opponentCountryError != null) {
      return opponentCountryError!;
    }
    return '';
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
    if (matchDateError != null) {
      return matchDateError!;
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
    if (matchTimeError != null) {
      return matchTimeError!;
    }
    return '';
  }

  void setMatchState(MatchState state) {
    matchResult = state;
    notifyListeners();
  }

  String get matchStateString {
    if (matchResult != null) {
      if (matchResult == MatchState.lose) {
        return 'I lost';
      } else if (matchResult == MatchState.win) {
        return 'I won';
      }
    }
    if (matchResultError != null) {
      return matchResultError!;
    }
    return '';
  }

  void setInvisibleMatchState(MatchState state) {
    matchResult = state;
  }

  void setCourtSurface(CourtSurface surface) {
    courtSurface = surface;
    notifyListeners();
  }

  String get courtSurfaceString {
    if (courtSurface != null) {
      return courtSurface!.name;
    }
    if (courtSurfaceError != null) {
      return courtSurfaceError!;
    }
    return '';
  }

  void setCourtLocation(dynamic location) {
    courtLocation = location;
    notifyListeners();
  }

  String get courtLocationString {
    if (courtLocation != null) {
      return courtLocation!.name;
    }
    if (courtLocationError != null) {
      return courtLocationError!;
    }
    return '';
  }

  void setInvisibleCourtLocation(CourtLocation? location) {
    courtLocation = location;
  }

  void showErrors() {
    notifyListeners();
  }
}
