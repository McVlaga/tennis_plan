import 'package:flutter/material.dart';
import '../../../services/theme_manager.dart';

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

  Color getShotColor(BuildContext context) {
    if (score == 5) {
      return Theme.of(context).colorScheme.cardShotGoodBg;
    } else if (score == 3 || score == 4) {
      return Theme.of(context).colorScheme.cardShotMediumBg;
    } else {
      return Theme.of(context).colorScheme.cardShotBadBg;
    }
  }
}
