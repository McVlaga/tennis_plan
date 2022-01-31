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
  static const matchItemIconHeight = 30.0;
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
  static const primaryColorDarkHex = 0xff1F1D2B;
  static const MaterialColor primaryColorDark = MaterialColor(
    primaryColorDarkHex,
    <int, Color>{
      50: Color(0xff1F1D2B),
      100: Color(0xff1F1D2B),
      200: Color(0xff1F1D2B),
      300: Color(0xff1F1D2B),
      400: Color(0xff1F1D2B),
      500: Color(primaryColorDarkHex),
      600: Color(0xff1F1D2B),
      700: Color(0xff1F1D2B),
      800: Color(0xff1F1D2B),
      900: Color(0xff1F1D2B),
    },
  );
  static const primarySwatchLightHex = 0xffFBBC04;
  static const MaterialColor primarySwatchLight = MaterialColor(
    primarySwatchLightHex,
    <int, Color>{
      50: Color(0xffFBBC04),
      100: Color(0xffFBBC04),
      200: Color(0xffFBBC04),
      300: Color(0xffFBBC04),
      400: Color(0xffFBBC04),
      500: Color(primarySwatchLightHex),
      600: Color(0xffFBBC04),
      700: Color(0xffFBBC04),
      800: Color(0xffFBBC04),
      900: Color(0xffFBBC04),
    },
  );
  static const primaryColorLight = Colors.white;
  static const appBarBackgroundColorLight = Colors.white;
  static const accentColorLight = Color(0xffFBBC04);
  static const accentColorTwoLight = Color(0xff34A853);
  static const backgroundColorLight = Color(0xffF8F8F8);
  static const surfaceColorLight = Colors.white;
  static const onSecondaryColorLight = Colors.white;
  static const onPrimaryColorLight = Colors.black;
  static const textSecondaryColorLight = Color(0xff7E90A1);

  static const appBarBackgroundColorDark = primaryColorDark;
  static const accentColorDark = Colors.yellow;
  static const accentColorTwoDark = Colors.yellow;
  static const backgroundColorDark = Color(0xff222330);
  static const surfaceColorDark = Color(0xff242837);
  static const onSecondaryColorDark = Colors.black;
  static const onPrimaryColorDark = Colors.white;
  static const textSecondaryColorDark = Color(0xff7C7B89);

  static const accentColor = Colors.yellow;
  static const winColor = Colors.green;
  static const loseColor = Colors.red;
  static const notPlayedColor = Colors.yellow;
  static const tabBarItemColor = Colors.black54;

  static const buttonsColor = Colors.black87;
}

class Fonts {
  static const rubikFont = 'Rubik';

  // Match list item
  static const matchListItemFontSize = 18.0;
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
