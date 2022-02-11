import 'dart:ui';

class CanvasPath {
  final Path path = Path();
  final List<Offset> points;
  final Paint paint;

  CanvasPath(this.points, this.paint);

  void movePathTo(double x, double y) {
    path.moveTo(x, y);
  }

  void makeLineTo(double x, double y) {
    path.lineTo(x, y);
    path.moveTo(x, y);
  }
}
