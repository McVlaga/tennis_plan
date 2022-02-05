import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:tennis_plan/match_detail/plan/models/opponent_info.dart';
import 'package:tennis_plan/match_detail/plan/models/plan.dart';
import '../../constants/constants.dart';
import 'ranking.dart';

import 'a_match.dart';

class Matches with ChangeNotifier {
  Matches();

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
      plan: Plan(
        opponentInfo: OpponentInfo(
          shots: [],
          strengths: [],
          weaknesses: [],
        ),
      ),
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
      plan: Plan(
        opponentInfo: OpponentInfo(
          shots: [],
          strengths: [],
          weaknesses: [],
        ),
      ),
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
      plan: Plan(
        opponentInfo: OpponentInfo(
          shots: [],
          strengths: [],
          weaknesses: [],
        ),
      ),
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
      plan: Plan(
        opponentInfo: OpponentInfo(
          shots: [],
          strengths: [],
          weaknesses: [],
        ),
      ),
    ),
  ];

  List<AMatch> get matches {
    return [..._matches];
  }

  List<AMatch> getMatchesWithQuery(String query) {
    if (query.isEmpty) {
      return matches;
    } else {
      return _matches.where((match) {
        return match.opponentLastName!
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }
  }

  void addMatch(AMatch newMatch) {
    _matches.insert(0, newMatch);
    notifyListeners();
  }

  AMatch findById(String id) {
    return _matches.firstWhere((match) => match.id == id);
  }
}
