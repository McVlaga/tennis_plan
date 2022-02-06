import 'package:flutter/material.dart';

class Shot with ChangeNotifier {
  Shot({
    required this.name,
    required this.score,
  });

  String name;
  int score;

  void setName(String name) {
    this.name = name;
  }

  void setScore(int score) {
    this.score = score;
  }
}
