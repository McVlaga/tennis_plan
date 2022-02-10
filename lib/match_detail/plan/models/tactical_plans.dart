import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tennis_plan/match_detail/plan/models/tactical_plan.dart';

class TacticalPlans with ChangeNotifier {
  TacticalPlans(List<TacticalPlan> newPlans) {
    tacticalPlans = List.from(newPlans);
  }

  List<TacticalPlan> tacticalPlans = [];

  void addPlan(String title, String description, Uint8List? imageBytes) {
    tacticalPlans.add(TacticalPlan(
        title: title, description: description, imageBytes: imageBytes));
    notifyListeners();
  }

  void deleteOpponentShot(String title) {
    tacticalPlans.remove(tacticalPlans[
        tacticalPlans.indexWhere((indexPlan) => indexPlan.title == title)]);
    notifyListeners();
  }
}
