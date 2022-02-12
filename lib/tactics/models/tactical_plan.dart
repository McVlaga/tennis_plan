import 'dart:typed_data';

import 'package:flutter/material.dart';

class TacticalPlan with ChangeNotifier {
  TacticalPlan({
    required this.title,
    required this.description,
    required this.color,
    required this.imageBytes,
  });

  String title;
  String description;
  Color color;
  Uint8List? imageBytes;

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  void setImage(Uint8List imageBytes) {
    this.imageBytes = imageBytes;
    notifyListeners();
  }
}
