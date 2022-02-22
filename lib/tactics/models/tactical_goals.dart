import 'package:flutter/material.dart';
import 'tactical_goal.dart';

class TacticalGoals with ChangeNotifier {
  TacticalGoals(List<TacticalGoal> newGoals) {
    goals = List.from(newGoals);
  }
  List<TacticalGoal> goals = [];

  void addGoal(List<TacticalGoalWord> coloredWords, String text) {
    goals.add(TacticalGoal(coloredWords, text));
    notifyListeners();
  }

  void addGoalAt(TacticalGoal goal, int index) {
    goals.insert(index, goal);
  }

  void deleteGoal(String text) {
    goals
        .remove(goals[goals.indexWhere((indexGoal) => indexGoal.text == text)]);
    notifyListeners();
  }

  void deleteGoalAt(int index) {
    goals.removeAt(index);
  }

  void updateGoal(
      String oldGoalText, String newGoalText, List<TacticalGoalWord> words) {
    int foundIndex =
        goals.indexWhere((indexGoal) => indexGoal.text == oldGoalText);
    if (foundIndex >= 0) {
      TacticalGoal goal = TacticalGoal(words, newGoalText);
      goals[goals.indexWhere((indexGoal) => indexGoal.text == oldGoalText)] =
          goal;
    }
    notifyListeners();
  }

  void reorderGoal(
      int from, int to, List<TacticalGoalWord> coloredWords, String text) {
    deleteGoalAt(from);
    addGoalAt(TacticalGoal(coloredWords, text), to);
    notifyListeners();
  }
}
