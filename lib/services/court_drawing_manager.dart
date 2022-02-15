import 'package:flutter/material.dart';
import 'package:tennis_plan/court_drawing/court_painter.dart';
import 'package:tennis_plan/court_drawing/drawing.dart';
import 'package:tennis_plan/court_drawing/painter.dart';

class CourtDrawingManager {
  CourtDrawingManager(this.context, this.canvasWidth, this.sizeRatio) {
    final totalWidth = MediaQuery.of(context).size.width - 32;
    pathsWidthRatio = canvasWidth / totalWidth;
    final totalHeight = totalWidth * courtAspectRatio + totalWidth / 10 * 2;
    paddingTop = canvasWidth / 10;
    canvasHeight = canvasWidth * courtAspectRatio + paddingTop * 2;
    pathsHeightRatio = canvasHeight / totalHeight;
    darkMode = Theme.of(context).brightness == Brightness.dark;
  }
  late BuildContext context;
  late bool darkMode;
  late double sizeRatio;
  late double pathsWidthRatio;
  late double pathsHeightRatio;
  late double canvasPaddingTop;
  late double canvasHeight;
  late double canvasWidth;
  late double paddingTop;
  static const courtAspectRatio = 1.2;

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
            widthRatio: pathsWidthRatio,
            heightRatio: pathsHeightRatio,
            darkMode: darkMode,
          ),
        ),
      ],
    );
  }
}
