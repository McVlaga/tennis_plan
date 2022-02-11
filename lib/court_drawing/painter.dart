import 'dart:ui';

import 'package:flutter/material.dart';
import 'canvas_path.dart';
import 'drawing.dart';

class Painter extends CustomPainter {
  final Drawing drawing;

  Painter({required this.drawing});

  @override
  void paint(Canvas canvas, Size size) {
    final List<CanvasPath?> canvasPaths = drawing.paths;

    if (canvasPaths.isNotEmpty) {
      for (var canvasPath in canvasPaths) {
        if (canvasPath!.points.isNotEmpty) {
          if (canvasPath.points.length == 1) {
            canvas.drawPoints(
                PointMode.points, canvasPath.points, canvasPath.paint);
          } else {
            canvas.drawPath(canvasPath.path, canvasPath.paint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(Painter oldDelegate) {
    return true;
  }
}
