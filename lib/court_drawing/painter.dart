import 'dart:ui';

import 'package:flutter/material.dart';

import 'canvas_path.dart';
import 'drawing.dart';

class Painter extends CustomPainter {
  Painter({
    required this.drawing,
    required this.widthRatio,
    required this.heightRatio,
    required this.darkMode,
  });

  final Drawing drawing;
  final bool darkMode;
  late double widthRatio;
  late double heightRatio;

  @override
  void paint(Canvas canvas, Size size) {
    final List<CanvasPath?> canvasPaths = drawing.paths;

    if (canvasPaths.isNotEmpty) {
      for (var canvasPath in canvasPaths) {
        if (canvasPath!.points.isNotEmpty) {
          if (canvasPath.paint.color.value == Colors.black.value && darkMode) {
            canvasPath.paint.color = Colors.white;
          } else if (canvasPath.paint.color.value == Colors.white.value &&
              !darkMode) {
            canvasPath.paint.color = Colors.black;
          }
          Paint paint = Paint()
            ..color = canvasPath.paint.color
            ..strokeCap = canvasPath.paint.strokeCap
            ..strokeWidth = canvasPath.paint.strokeWidth * widthRatio
            ..blendMode = canvasPath.paint.blendMode
            ..style = PaintingStyle.stroke;
          List<Offset> scaledPoints = [];
          for (var point in canvasPath.points) {
            scaledPoints.add(
              Offset(point.dx * widthRatio, point.dy * heightRatio),
            );
          }
          if (scaledPoints.length == 1) {
            canvas.drawPoints(PointMode.points, scaledPoints, paint);
          } else {
            final Matrix4 matrix4 = Matrix4.identity();
            matrix4.scale(widthRatio, heightRatio);
            Path path = canvasPath.path.transform(matrix4.storage);
            canvas.drawPath(path, paint);
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
