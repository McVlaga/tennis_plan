import 'package:flutter/material.dart';

import 'a_match.dart';

class Matches with ChangeNotifier {
  final List<AMatch> _matches = [];

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
