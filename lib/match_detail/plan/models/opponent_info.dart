import 'package:flutter/material.dart';
import 'package:tennis_plan/match_detail/plan/models/shot.dart';

class OpponentInfo with ChangeNotifier {
  OpponentInfo({required shots, required strengths, required weaknesses}) {
    this.shots = List.from(shots);
    this.strengths = List.from(strengths);
    this.weaknesses = List.from(weaknesses);
  }

  late List<Shot> shots;
  late List<String> strengths;
  late List<String> weaknesses;

  void addOpponentShot(String name, int score) {
    shots.add(Shot(name: name, score: score));
    notifyListeners();
  }

  void addOpponentShotAt(String shotName, int shotScore, int index) {
    shots.insert(index, Shot(name: shotName, score: shotScore));
  }

  void addOpponentStrength(String newStrength) {
    strengths.add(newStrength);
    notifyListeners();
  }

  void addOpponentStrengthAt(String newStrength, int index) {
    strengths.insert(index, newStrength);
  }

  void addOpponentWeakness(String newWeakness) {
    weaknesses.add(newWeakness);
    notifyListeners();
  }

  void addOpponentWeaknessAt(String newWeakness, int index) {
    weaknesses.insert(index, newWeakness);
  }

  Shot findShotByName(String name) {
    return shots.firstWhere((shot) => shot.name == name);
  }

  String findStrengthByName(String name) {
    return strengths.firstWhere((strength) => strength == name);
  }

  String findWeaknessByName(String name) {
    return weaknesses.firstWhere((weakness) => weakness == name);
  }

  void updateOpponentShot(String oldName, String newName, int score) {
    Shot shot = Shot(name: newName, score: score);
    int foundIndex = shots.indexWhere((indexShot) => indexShot.name == oldName);
    if (foundIndex >= 0) {
      shots[shots.indexWhere((indexShot) => indexShot.name == oldName)] = shot;
    }
    notifyListeners();
  }

  void updateOpponentStrength(String oldStrength, String newStrength) {
    int foundIndex =
        strengths.indexWhere((indexStrength) => indexStrength == oldStrength);
    if (foundIndex >= 0) {
      strengths[strengths.indexWhere(
          (indexStrength) => indexStrength == oldStrength)] = newStrength;
    }
    notifyListeners();
  }

  void updateOpponentWeakness(String oldWeakness, String newWeakness) {
    int foundIndex =
        weaknesses.indexWhere((indexWeakness) => indexWeakness == oldWeakness);
    if (foundIndex >= 0) {
      weaknesses[weaknesses.indexWhere(
          (indexWeakness) => indexWeakness == oldWeakness)] = newWeakness;
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

  void deleteOpponentStrength(String strength) {
    strengths.remove(strengths[
        strengths.indexWhere((indexStrength) => indexStrength == strength)]);
    notifyListeners();
  }

  void deleteOpponentStrengthAt(int index) {
    strengths.removeAt(index);
  }

  void deleteOpponentWeakness(String weakness) {
    weaknesses.remove(weaknesses[
        weaknesses.indexWhere((indexWeakness) => indexWeakness == weakness)]);
    notifyListeners();
  }

  void deleteOpponentWeaknessAt(int index) {
    weaknesses.removeAt(index);
  }

  void reorderOpponentShot(int from, int to, String shotName, int shotScore) {
    deleteOpponentShotAt(from);
    addOpponentShotAt(shotName, shotScore, to);
    notifyListeners();
  }

  void reorderOpponentStrength(int from, int to, String strength) {
    deleteOpponentStrengthAt(from);
    addOpponentStrengthAt(strength, to);
    notifyListeners();
  }

  void reorderOpponentWeakness(int from, int to, String weakness) {
    deleteOpponentWeaknessAt(from);
    addOpponentWeaknessAt(weakness, to);
    notifyListeners();
  }
}
