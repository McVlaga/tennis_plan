import 'package:flutter/material.dart';

import 'shot.dart';

class Shots with ChangeNotifier {
  Shots(List<Shot> newShots) {
    shots = List.from(newShots);
  }

  List<Shot> shots = [
    Shot(name: 'Forehand', score: 5),
    Shot(name: 'Backhand', score: 4),
    Shot(name: 'Serve', score: 5),
    Shot(name: 'Volleys', score: 3),
  ];

  void addOpponentShot(String name, int score) {
    shots.add(Shot(name: name, score: score));
    notifyListeners();
  }

  void addOpponentShotAt(String shotName, int _shotscore, int index) {
    shots.insert(index, Shot(name: shotName, score: _shotscore));
  }

  Shot findShotByName(String name) {
    return shots.firstWhere((shot) => shot.name == name);
  }

  void updateOpponentShot(String oldName, String newName, int score) {
    Shot shot = Shot(name: newName, score: score);
    int foundIndex = shots.indexWhere((indexShot) => indexShot.name == oldName);
    if (foundIndex >= 0) {
      shots[shots.indexWhere((indexShot) => indexShot.name == oldName)] = shot;
    }
    notifyListeners();
  }

  void deleteOpponentShot(String name) {
    shots
        .remove(shots[shots.indexWhere((indexShot) => indexShot.name == name)]);
    notifyListeners();
  }

  void deleteOpponentShotAt(int index) {
    shots.removeAt(index);
  }

  void reorderOpponentShot(int from, int to, String shotName, int _shotscore) {
    deleteOpponentShotAt(from);
    addOpponentShotAt(shotName, _shotscore, to);
    notifyListeners();
  }
}
