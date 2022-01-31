import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:tennis_plan/constants/constants.dart';
import 'package:tennis_plan/matches/models/ranking.dart';

import 'a_match.dart';

class Matches with ChangeNotifier {
  final List<AMatch> _matches = [
    AMatch(
      id: DateTime.now().toString(),
      opponentFirstName: 'Andy',
      opponentLastName: 'Murray',
      opponentCountry: Country.parse('United Kingdom'),
      opponentRanking: Ranking(federation: 'ATP', position: 135),
      isPractice: true,
      matchDate: DateTime.now(),
      matchTime: TimeOfDay.now(),
      matchResult: MatchState.notPlayed,
      courtSurface: CourtSurface.grass,
    ),
    AMatch(
      id: DateTime.now().toString(),
      opponentFirstName: 'Rafael',
      opponentLastName: 'Nadal',
      opponentCountry: Country.parse('Spain'),
      opponentRanking: Ranking(federation: 'ATP', position: 6),
      isPractice: false,
      matchDate: DateTime.now(),
      matchTime: TimeOfDay.now(),
      matchResult: MatchState.win,
      courtSurface: CourtSurface.clay,
    ),
    AMatch(
      id: DateTime.now().toString(),
      opponentFirstName: 'Roger',
      opponentLastName: 'Federer',
      opponentCountry: Country.parse('Switzerland'),
      opponentRanking: Ranking(federation: 'ATP', position: 17),
      isPractice: false,
      matchDate: DateTime.now(),
      matchTime: TimeOfDay.now(),
      matchResult: MatchState.lose,
      courtSurface: CourtSurface.hard,
      courtLocation: CourtLocation.indoors,
    ),
    AMatch(
      id: DateTime.now().toString(),
      opponentFirstName: 'Novak',
      opponentLastName: 'Djokovic',
      opponentCountry: Country.parse('Serbia'),
      opponentRanking: Ranking(federation: 'ATP', position: 1),
      isPractice: false,
      matchDate: DateTime.now(),
      matchTime: TimeOfDay.now(),
      matchResult: MatchState.win,
      courtSurface: CourtSurface.grass,
    ),
  ];

  Matches();

  List<AMatch> get matches {
    return [..._matches];
  }

  void addMatch(AMatch newMatch) {
    _matches.insert(0, newMatch);
    notifyListeners();
  }

  AMatch findById(String id) {
    return _matches.firstWhere((match) => match.id == id);
  }
}
