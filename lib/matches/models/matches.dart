import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../add_edit_match/models/validation_match.dart';
import 'a_match.dart';
import 'ranking.dart';

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
    ),
    AMatch(
      id: DateTime.now().toString(),
      opponentFirstName: 'Rafael',
      opponentLastName: 'Nadal',
      opponentCountry: Country.parse('Spain'),
      opponentRanking: Ranking(federation: 'ATP', position: 6),
      isOpponentLefty: true,
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
      courtSurface: CourtSurface.hardIndoors,
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

  void addMatch(ValidationMatch tempMatch) {
    _matches.insert(0, AMatch.fromTemporaryMatch(tempMatch));
    notifyListeners();
  }

  AMatch findById(String id) {
    return _matches.firstWhere((match) => match.id == id);
  }

  void deleteMatch(String id) {
    _matches.remove(_matches.firstWhere((match) => match.id == id));
    notifyListeners();
  }
}
