import 'package:flutter/material.dart';
import 'package:tennis_plan/match_detail/plan/tactics/drawn_line.dart';

class Painter extends CustomPainter {
  final List<CanvasPath?> lines;

  Painter({required this.lines});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < lines.length; ++i) {
      if (lines[i] == null) continue;
      paint.color = lines[i]!.color;
      paint.strokeWidth = lines[i]!.width;

      // draw single point
      if (lines[i]!.points.length == 1) {
        canvas.drawLine(lines[i]!.points[0], lines[i]!.points[0], paint);
      }

      // draw line
      for (int j = 0; j < lines[i]!.points.length - 1; ++j) {
        canvas.drawLine(lines[i]!.points[j], lines[i]!.points[j + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Painter oldDelegate) {
    return true;
  }
}
