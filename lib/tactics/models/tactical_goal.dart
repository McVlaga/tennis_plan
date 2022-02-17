import 'package:flutter/material.dart';

class TacticalGoal with ChangeNotifier {
  TacticalGoal(List<TacticalGoalWord> newWords, String newText) {
    coloredWords = List.from(newWords);
    text = newText;
  }
  List<TacticalGoalWord> coloredWords = [];
  String text = '';
}

class TacticalGoalWord with ChangeNotifier {
  TacticalGoalWord({required this.word, required this.color});

  String word;
  Color color;

  void setColor(Color newColor) {
    color = newColor;
  }
}
