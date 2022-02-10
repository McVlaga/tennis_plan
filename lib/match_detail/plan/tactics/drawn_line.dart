import 'dart:ui';

class CanvasPath {
  final Path path = Path();
  final List<Offset> points;
  final Color color;
  final double width;

  CanvasPath(this.points, this.color, this.width);
}
