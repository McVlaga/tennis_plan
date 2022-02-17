import 'package:flutter/material.dart';

import '../court_drawing/court_painter.dart';
import '../court_drawing/models/drawing.dart';
import '../court_drawing/painter.dart';

class CourtDrawingManager {
  CourtDrawingManager(this.context, this.canvasWidth) {
    final totalWidth = MediaQuery.of(context).size.width - 32;
    canvasPaddingTop = canvasWidth / 10;
    canvasHeight = canvasWidth * courtAspectRatio + canvasPaddingTop * 2;
    sizeRatio = canvasWidth / totalWidth;
    darkMode = Theme.of(context).brightness == Brightness.dark;
    courtPaddingTop = getCourtPaddingTop();
  }
  static const courtAspectRatio = 1.2;
  late BuildContext context;
  late bool darkMode;
  late double sizeRatio;
  late double canvasPaddingTop;
  late double canvasHeight;
  late double canvasWidth;
  late double courtPaddingTop;

  double getCourtPaddingTop() {
    final paddingHorizontal = canvasWidth / 10;
    final courtWidth = canvasWidth - paddingHorizontal * 2;
    final courtHeight = courtWidth * courtAspectRatio;
    return (canvasHeight - courtHeight) / 2;
  }

  CustomPaint buildCourtWidget() {
    return CustomPaint(
      size: Size(canvasWidth, canvasHeight),
      painter: CourtPainter(darkMode, canvasWidth, canvasHeight, sizeRatio),
    );
  }

  Stack buildCourtDrawingWidget(Drawing drawing) {
    return Stack(
      children: [
        buildCourtWidget(),
        CustomPaint(
          size: Size(canvasWidth, canvasHeight),
          painter: Painter(
            drawing: drawing,
            pathsRatio: sizeRatio,
            darkMode: darkMode,
          ),
        ),
      ],
    );
  }
}
