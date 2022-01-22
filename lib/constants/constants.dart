import 'dart:math' as math;

import 'package:flutter/material.dart';

class General {
  static const countryIconsPackage = 'country_icons';
}

class Animations {
  static const animationDuration = 300;
}

class Dimensions {
  // General
  static const paddingZero = 4.0;
  static const paddingOne = 8.0;
  static const paddingTwo = 16.0;
  static const paddingThree = 24.0;
  static const paddingFour = 32.0;
  static const paddingFive = 48.0;
  static const paddingSix = 64.0;
  static const matchesListPaddingBottom = 80.0;
  static const borderRadius = 8.0;

  // Bottom navigation bar dimensions
  static const navBarHeight = 60.0;
  static const navBarItemIconHeight = 30.0;

  // Match list dimensions
  static const matchListItemHeight = 80.0;
  static const matchItemIconHeight = 16.0;
  static const badgeWinLoseHeight = 30.0;
  static const badgeWinLoseWidth = 600.0;
  static const circleAvatarRadius = 30.0;
  static const badgeWinLoseAngle = -math.pi / 4;

  // Player list item dimensions
  static const playerListItemHeight = 80.0;
  static const playerItemIconHeight = 50.0;

  // Add a match dimensions
  static const addMatchDialogInputHeight = 60.0;
  static const addMatchDialogIconHeight = 20.0;
}

class AppColors {
  static const primaryColor = Colors.green;
  static const accentColor = Colors.yellow;
  static const backgroundColor = Color(0xffF8F8F8);
  static const winColor = Colors.green;
  static const loseColor = Colors.red;
  static const notPlayedColor = Colors.yellow;
  static const tabBarItemColor = Colors.black54;

  static const buttonsColor = Colors.black87;
}

class Fonts {
  static const rubikFont = 'Rubik';

  // Match list item
  static const matchListItemFontSize = 16.0;
  static const matchListItemVSFontSize = 55.0;

  // Add a match dialog
  static const addMatchDialogMatchFontSize = 16.0;
}

class Strings {
  // Match list item
  static const matchListItemVSString = 'VS';

  // Add a match dialog
  static const addMatchDialogTitle = 'Add a match';
  static const addMatchDialogFirstName = 'First name';
  static const addMatchDialogLastName = 'Last name';
  static const addMatchDialogCountryTitle = 'Select a country';
  static const addMatchDialogMatchTitle = 'Match played?';
}

enum MatchState { win, lose, notPlayed }

enum CourtSurface { grass, hard, clay, carpet }

enum CourtLocation { indoors, outdoors }
