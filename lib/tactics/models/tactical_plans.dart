import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tennis_plan/court_drawing/drawing.dart';
import 'tactical_plan.dart';

class TacticalPlans with ChangeNotifier {
  TacticalPlans(List<TacticalPlan> newPlans) {
    plans = List.from(newPlans);
  }

  List<TacticalPlan> plans = [];

  void addPlan(
      String title, String description, Color color, Drawing? drawing) {
    plans.add(TacticalPlan(
        title: title,
        description: description,
        color: color,
        drawing: drawing));
    notifyListeners();
  }

  void addPlanAt(String title, String description, Color color,
      Drawing? drawing, int index) {
    plans.insert(
      index,
      TacticalPlan(
        title: title,
        description: description,
        color: color,
        drawing: drawing,
      ),
    );
  }

  void updatePlan(
      String title, String description, Color color, Drawing? drawing) {
    TacticalPlan plan = TacticalPlan(
        title: title, description: description, color: color, drawing: drawing);
    int foundIndex = plans.indexWhere((indexPlan) => indexPlan.title == title);
    if (foundIndex >= 0) {
      plans[plans.indexWhere((indexPlan) => indexPlan.title == title)] = plan;
    }
    notifyListeners();
  }

  void deletePlan(String title) {
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
    Drawing? drawing,
  ) {
    deletePlanAt(from);
    addPlanAt(title, description, color, drawing, to);
    notifyListeners();
  }
}
