import 'package:flutter/material.dart';

class Weaknesses with ChangeNotifier {
  Weaknesses(List<String> newWeaknesses) {
    weaknesses = List.from(newWeaknesses);
  }
  List<String> weaknesses = [
    'Runs so much that poeple are getting crazy',
    'Can really hit the ball really hard, so there is sparks flying all over the place',
  ];

  void addOpponentWeakness(String newWeakness) {
    weaknesses.add(newWeakness);
    notifyListeners();
  }

  void addOpponentWeaknessAt(String newWeakness, int index) {
    weaknesses.insert(index, newWeakness);
  }

  String findWeaknessByName(String name) {
    return weaknesses.firstWhere((weakness) => weakness == name);
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

  void deleteOpponentWeakness(String weakness) {
    weaknesses.remove(weaknesses[
        weaknesses.indexWhere((indexWeakness) => indexWeakness == weakness)]);
    notifyListeners();
  }

  void deleteOpponentWeaknessAt(int index) {
    weaknesses.removeAt(index);
  }

  void reorderOpponentWeakness(int from, int to, String weakness) {
    deleteOpponentWeaknessAt(from);
    addOpponentWeaknessAt(weakness, to);
    notifyListeners();
  }
}
