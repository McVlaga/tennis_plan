import 'package:flutter/material.dart';
import 'package:tennis_plan/match_detail/plan/models/shot.dart';

class Plan with ChangeNotifier {
  Plan();
  final List<Shot> _shots = [
    Shot(name: 'Forehand Cross', score: 5),
    Shot(name: 'Forehand Line', score: 4),
    Shot(name: 'Backhand', score: 3),
    Shot(name: 'Serve', score: 2),
    Shot(name: 'Volleys', score: 4),
  ];
  final List<String> _strengths = [
    'Play to the opponents backhand as much as you can. Try no to let him play his forehand ever in his life.',
    'Try to put every return in',
    'Dont ever play volleys. If the guy tries to make me play a volley, then.',
  ];
  final List<String> _weaknesses = [
    'Make him run as much as you can',
    'Dont ever play volleys. If the guy tries to make me play a volley, then.',
  ];

  List<Shot> get shots {
    return [..._shots];
  }

  List<String> get strengths {
    return [..._strengths];
  }

  List<String> get weaknesses {
    return [..._weaknesses];
  }

  void addShot(Shot newShot) {
    _shots.add(newShot);
    notifyListeners();
  }

  void addStrength(String newStrength) {
    _strengths.add(newStrength);
    notifyListeners();
  }

  void addWeakness(String newWeakness) {
    _weaknesses.add(newWeakness);
    notifyListeners();
  }
}
