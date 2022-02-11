import 'package:flutter/material.dart';

class CourtPainter extends CustomPainter {
  CourtPainter(this.context, this.courtHeight, this.paddingTop) {
    courtWidth = courtHeight / aspectRatio;
    netStart = paddingLeft - 16;
    netEnd = courtWidth - paddingRight + 16;
  }

  final double aspectRatio = 1.2;

  final BuildContext context;
  late double courtWidth;
  late double courtHeight;
  late double paddingTop;
  final double paddingLeft = 16;
  final double paddingRight = 16;
  late double netStart;
  late double netEnd;
  final double paddingSD = 20;

  @override
  void paint(Canvas canvas, Size size) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = darkMode ? Colors.white : Colors.black;

    Path path = Path();

    //  left doubles sideline
    path.moveTo(paddingLeft, paddingTop);
    path.lineTo(paddingLeft, paddingTop + courtHeight);
    //  closer baseline
    path.lineTo(courtWidth - paddingLeft, paddingTop + courtHeight);
    // right doubles sideline
    path.lineTo(courtWidth - paddingLeft, paddingTop);
    // futher baseline
    path.lineTo(paddingLeft, paddingTop);
    // left singles sideline
    path.moveTo(paddingLeft + paddingSD, paddingTop);
    path.lineTo(paddingLeft + paddingSD, courtHeight + paddingTop);
    // right singles sideline
    path.moveTo(courtWidth - paddingSD - paddingLeft, paddingTop);
    path.lineTo(courtWidth - paddingSD - paddingLeft, paddingTop + courtHeight);
    // center line
    path.moveTo(courtWidth / 2, courtHeight / 4 + paddingTop - 16);
    path.lineTo(
        courtWidth / 2, courtHeight - courtHeight / 4 + paddingTop + 16);
    // futher service line
    path.moveTo(paddingLeft + paddingSD, courtHeight / 4 + paddingTop - 16);
    path.lineTo(courtWidth - paddingSD - paddingLeft,
        courtHeight / 4 + paddingTop - 16);
    //closer service line
    path.moveTo(paddingLeft + paddingSD,
        courtHeight - courtHeight / 4 + paddingTop + 16);
    path.lineTo(courtWidth - paddingSD - paddingLeft,
        courtHeight - courtHeight / 4 + paddingTop + 16);

    canvas.drawPath(path, paint);

    // net
    path = Path();
    paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = darkMode ? Colors.white : Colors.black;
    path.moveTo(netStart, courtHeight / 2 + paddingTop);
    path.lineTo(netEnd, courtHeight / 2 + paddingTop);

    canvas.drawPath(path, paint);
  }

  // 4
  @override
  bool shouldRepaint(CourtPainter delegate) {
    return true;
  }
}
