import 'package:flutter/material.dart';
import 'package:tennis_plan/match_detail/plan/models/opponent_info.dart';

class Plan with ChangeNotifier {
  Plan({required this.opponentInfo});

  OpponentInfo opponentInfo;

  void setOpponentInfo(OpponentInfo opponentInfo) {
    this.opponentInfo = opponentInfo;
    notifyListeners();
  }
}
