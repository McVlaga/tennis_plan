import 'package:flutter/material.dart';
import 'package:tennis_plan/match_detail/plan/models/shot.dart';

class Plan with ChangeNotifier {
  Plan();
  final List<Shot> _shots = [
    Shot(name: 'Forehand Cross', score: 5),
    Shot(name: 'Forehand Line', score: 4),
    Shot(name: 'Backhand', score: 3),
    Shot(name: 'Serve', score: 2),
    Shot(name: 'Volleys', score: 4),
  ];
  final List<String> _strengths = [
    'Play to the opponents backhand as much as you can. Try no to let him play his forehand ever in his life.',
    'Try to put every return in',
    'Dont ever play volleys. If the guy tries to make me play a volley, then.',
  ];
  final List<String> _weaknesses = [
    'Make him run as much as you can',
    'Dont ever play volleys. If the guy tries to make me play a volley, then.',
  ];

  List<Shot> get shots {
    return [..._shots];
  }

  List<String> get strengths {
    return [..._strengths];
  }

  List<String> get weaknesses {
    return [..._weaknesses];
  }

  void addOpponentShot(String name, int score) {
    _shots.add(Shot(name: name, score: score));
    notifyListeners();
  }

  void addOpponentStrength(String newStrength) {
    _strengths.add(newStrength);
    notifyListeners();
  }

  void addOpponentWeakness(String newWeakness) {
    _weaknesses.add(newWeakness);
    notifyListeners();
  }

  Shot findShotByName(String name) {
    return _shots.firstWhere((shot) => shot.name == name);
  }

  String findStrengthByName(String name) {
    return _strengths.firstWhere((strength) => strength == name);
  }

  String findWeaknessByName(String name) {
    return _weaknesses.firstWhere((weakness) => weakness == name);
  }

  void updateOpponentShot(String oldName, String newName, int score) {
    Shot shot = Shot(name: newName, score: score);
    int foundIndex =
        _shots.indexWhere((indexShot) => indexShot.name == oldName);
    if (foundIndex >= 0) {
      _shots[_shots.indexWhere((indexShot) => indexShot.name == oldName)] =
          shot;
    }
  }

  void updateOpponentStrength(String oldStrength, String newStrength) {
    int foundIndex =
        _strengths.indexWhere((indexStrength) => indexStrength == oldStrength);
    if (foundIndex >= 0) {
      _strengths[_strengths.indexWhere(
          (indexStrength) => indexStrength == oldStrength)] = newStrength;
    }
  }

  void updateOpponentWeakness(String oldWeakness, String newWeakness) {
    int foundIndex =
        _weaknesses.indexWhere((indexWeakness) => indexWeakness == oldWeakness);
    if (foundIndex >= 0) {
      _weaknesses[_weaknesses.indexWhere(
          (indexWeakness) => indexWeakness == oldWeakness)] = newWeakness;
    }
  }

  void deleteOpponentShot(String name) {
    _shots.remove(
        _shots[_shots.indexWhere((indexShot) => indexShot.name == name)]);
  }

  void deleteOpponentStrength(String strength) {
    _strengths.remove(_strengths[
        _strengths.indexWhere((indexStrength) => indexStrength == strength)]);
  }

  void deleteOpponentWeakness(String weakness) {
    _weaknesses.remove(_weaknesses[
        _weaknesses.indexWhere((indexWeakness) => indexWeakness == weakness)]);
  }
}
