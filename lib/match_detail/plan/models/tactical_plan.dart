import 'dart:typed_data';

import 'package:flutter/material.dart';

class TacticalPlan with ChangeNotifier {
  TacticalPlan({
    required this.title,
    required this.description,
    required this.imageBytes,
  });

  String title;
  String description;
  Uint8List? imageBytes;

  void setTitle(String title) {
    this.title = title;
  }

  void setDescription(String description) {
    this.description = description;
  }

  void setImage(Uint8List imageBytes) {
    this.imageBytes = imageBytes;
  }
}
