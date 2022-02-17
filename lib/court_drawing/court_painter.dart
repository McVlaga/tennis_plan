import 'package:flutter/material.dart';

class CourtPainter extends CustomPainter {
  CourtPainter(
    this.darkMode,
    this.canvasWidth,
    this.canvasHeight,
    this.sizeRatio,
  ) {
    paddingHorizontal = canvasWidth / 10;
    courtWidth = canvasWidth - paddingHorizontal * 2;
    courtHeight = courtWidth * courtAspectRatio;
    paddingTop = (canvasHeight - courtHeight) / 2;
    paddingSD = 20 * sizeRatio;
    netStart = canvasWidth / 20 * sizeRatio;
    netEnd = canvasWidth - canvasWidth / 20 * sizeRatio;
  }

  static const double courtAspectRatio = 1.2;
  late double sizeRatio;

  final double canvasWidth;
  final double canvasHeight;
  late double courtWidth;
  late double courtHeight;
  late double centerY;
  late double paddingTop;
  late double paddingHorizontal;
  late double netStart;
  late double netEnd;
  late double paddingSD;
  late bool darkMode;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 * sizeRatio
      ..color = darkMode ? Colors.white : Colors.black;

    Path path = Path();

    //  left doubles sideline
    path.moveTo(paddingHorizontal, paddingTop);
    path.lineTo(paddingHorizontal, paddingTop + courtHeight);
    //  closer baseline
    path.lineTo(canvasWidth - paddingHorizontal, paddingTop + courtHeight);
    // right doubles sideline
    path.lineTo(canvasWidth - paddingHorizontal, paddingTop);
    // futher baseline
    path.lineTo(paddingHorizontal, paddingTop);
    // left singles sideline
    path.moveTo(paddingHorizontal + paddingSD, paddingTop);
    path.lineTo(paddingHorizontal + paddingSD, courtHeight + paddingTop);
    // right singles sideline
    path.moveTo(canvasWidth - paddingHorizontal - paddingSD, paddingTop);
    path.lineTo(
        canvasWidth - paddingHorizontal - paddingSD, paddingTop + courtHeight);
    // center line
    path.moveTo(canvasWidth / 2, courtHeight / 4 + paddingTop - 16 * sizeRatio);
    path.lineTo(canvasWidth / 2,
        courtHeight - courtHeight / 4 + paddingTop + 16 * sizeRatio);
    // futher service line
    path.moveTo(paddingHorizontal + paddingSD,
        courtHeight / 4 + paddingTop - 16 * sizeRatio);
    path.lineTo(canvasWidth - paddingHorizontal - paddingSD,
        courtHeight / 4 + paddingTop - 16 * sizeRatio);
    //closer service line
    path.moveTo(paddingHorizontal + paddingSD,
        courtHeight - courtHeight / 4 + paddingTop + 16 * sizeRatio);
    path.lineTo(canvasWidth - paddingHorizontal - paddingSD,
        courtHeight - courtHeight / 4 + paddingTop + 16 * sizeRatio);

    canvas.drawPath(path, paint);

    // net
    path = Path();
    paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 * sizeRatio
      ..color = darkMode ? Colors.white : Colors.black;
    path.moveTo(netStart, courtHeight / 2 + paddingTop);
    path.lineTo(netEnd, courtHeight / 2 + paddingTop);

    canvas.drawPath(path, paint);
  }

  // 4
  @override
  bool shouldRepaint(CourtPainter oldDelegate) {
    return true;
  }
}
