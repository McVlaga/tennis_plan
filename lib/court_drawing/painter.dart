import 'dart:ui';

import 'package:flutter/material.dart';

import 'drawing.dart';

class Painter extends CustomPainter {
  Painter({
    required this.drawing,
    required this.pathsRatio,
    required this.darkMode,
  });

  final Drawing drawing;
  final bool darkMode;
  late double pathsRatio;

  @override
  void paint(Canvas canvas, Size size) {
    if (drawing.paths.isNotEmpty) {
      for (var canvasPath in drawing.paths) {
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
            ..strokeWidth = canvasPath.paint.strokeWidth * pathsRatio
            ..blendMode = canvasPath.paint.blendMode
            ..style = PaintingStyle.stroke;
          if (canvasPath.points.length == 1) {
            canvas.drawPoints(
                PointMode.points,
                [
                  Offset(canvasPath.points[0].dx * pathsRatio,
                      canvasPath.points[0].dy * pathsRatio)
                ],
                paint);
          } else {
            final Matrix4 matrix4 = Matrix4.identity();
            matrix4.scale(pathsRatio, pathsRatio);
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
