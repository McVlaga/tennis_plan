import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'tactical_plan.dart';

class TacticalPlans with ChangeNotifier {
  TacticalPlans(List<TacticalPlan> newPlans) {
    plans = List.from(newPlans);
  }

  List<TacticalPlan> plans = [];

  void addPlan(
      String title, String description, Color color, Uint8List? imageBytes) {
    plans.add(TacticalPlan(
        title: title,
        description: description,
        color: color,
        imageBytes: imageBytes));
    notifyListeners();
  }

  void addPlanAt(String title, String description, Color color,
      Uint8List? imageBytes, int index) {
    plans.insert(
      index,
      TacticalPlan(
        title: title,
        description: description,
        color: color,
        imageBytes: imageBytes,
      ),
    );
  }

  void deleteOpponentPlan(String title) {
    plans.remove(
        plans[plans.indexWhere((indexPlan) => indexPlan.title == title)]);
    notifyListeners();
  }

  void deletePlanAt(int index) {
    plans.removeAt(index);
  }

  TacticalPlan findByTitle(String title) {
    return plans.firstWhere((plan) => plan.title == title);
  }

  void reorderPlans(
    int from,
    int to,
    String title,
    String description,
    Color color,
    Uint8List? imageBytes,
  ) {
    deletePlanAt(from);
    addPlanAt(title, description, color, imageBytes, to);
    notifyListeners();
  }
}
