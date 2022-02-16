import 'canvas_path.dart';

class Drawing {
  late List<CanvasPath?> paths;

  Drawing({required paths}) {
    this.paths = List.from(paths);
  }
}
