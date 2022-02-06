import 'package:flutter/material.dart';

class Strengths with ChangeNotifier {
  Strengths(List<String> newStrengths) {
    strengths = List.from(newStrengths);
  }
  List<String> strengths = [
    'Can really hit the ball really hard, so there is sparks flying all over the place',
    'Serves like crazy',
    'Runs so much that poeple are getting crazy',
  ];

  void addOpponentStrength(String newStrength) {
    strengths.add(newStrength);
    notifyListeners();
  }

  void addOpponentStrengthAt(String newStrength, int index) {
    strengths.insert(index, newStrength);
  }

  String findStrengthByName(String name) {
    return strengths.firstWhere((strength) => strength == name);
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

  void deleteOpponentStrength(String strength) {
    strengths.remove(strengths[
        strengths.indexWhere((indexStrength) => indexStrength == strength)]);
    notifyListeners();
  }

  void deleteOpponentStrengthAt(int index) {
    strengths.removeAt(index);
  }

  void reorderOpponentStrength(int from, int to, String strength) {
    deleteOpponentStrengthAt(from);
    addOpponentStrengthAt(strength, to);
    notifyListeners();
  }
}
