import 'package:flutter/material.dart';
import '../../court_drawing/models/drawing.dart';

class TacticalPlan with ChangeNotifier {
  TacticalPlan({
    required this.title,
    required this.description,
    required this.color,
    required this.drawing,
  });

  String title;
  String description;
  Color color;
  Drawing? drawing;

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setColor(Color color) {
    this.color = color;
  }

  void setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  void setDrawing(Drawing drawing) {
    this.drawing = drawing;
    notifyListeners();
  }
}
