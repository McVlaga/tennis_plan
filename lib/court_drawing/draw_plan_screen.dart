import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'widgets/cancel_save_bar_widget.dart';
import '../services/court_drawing_manager.dart';
import '../widgets/color_picker_dialog.dart';
import '../widgets/screen_save_button.dart';
import '../tactics/models/tactical_plan.dart';
import '../../../constants/constants.dart';
import 'court_painter.dart';
import 'models/drawing.dart';
import 'models/canvas_path.dart';
import 'painter.dart';

class DrawPlanScreen extends StatefulWidget {
  const DrawPlanScreen({Key? key}) : super(key: key);

  @override
  State<DrawPlanScreen> createState() => _DrawPlanScreenState();
}

class _DrawPlanScreenState extends State<DrawPlanScreen> {
  bool firstInit = true;
  late TacticalPlan plan;
  late bool editing;

  final GlobalKey _globalKey = GlobalKey();
  late Drawing _drawing;
  CanvasPath? _newPath;
  late Paint _currentPaintSettings;
  bool erasing = false;

  final StreamController<Drawing> _drawingStreamController =
      StreamController<Drawing>.broadcast();

  late CourtDrawingManager _courtManager;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstInit) {
      _onInit();
    }
  }

  void _onInit() {
    final double canvasWidth = MediaQuery.of(context).size.width - 32;
    _courtManager = CourtDrawingManager(context, canvasWidth);
    _currentPaintSettings = Paint()
      ..strokeWidth = 15
      ..color = Theme.of(context).colorScheme.onPrimary
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    _newPath = CanvasPath([], _currentPaintSettings);
    plan = ModalRoute.of(context)!.settings.arguments as TacticalPlan;
    if (plan.drawing == null) {
      _drawing = Drawing(paths: []);
    } else {
      _drawing = Drawing(paths: plan.drawing!.paths);
    }
    firstInit = false;
  }

  Future<void> _save() async {
    try {
      plan.setDrawing(_drawing);
      // RenderRepaintBoundary boundary = _globalKey.currentContext
      //     ?.findRenderObject() as RenderRepaintBoundary;
      // ui.Image image = await boundary.toImage();
      // ByteData? byteData =
      //     await image.toByteData(format: ui.ImageByteFormat.png);
      // Uint8List? pngBytes = byteData?.buffer.asUint8List();
      // var saved = await ImageGallerySaver.saveImage(
      //   pngBytes,
      //   quality: 100,
      //   name: DateTime.now().toIso8601String() + ".png",
      //   isReturnImagePathOfIOS: true,
      // );
      // print(saved);
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  void _clear() {
    setState(() {
      _drawing.paths = [];
      _newPath = null;
    });
  }

  void _undo() {
    setState(() {
      if (_drawing.paths.isNotEmpty) {
        _drawing.paths.removeLast();
      }
      _newPath = null;
    });
  }

  void showColorPickerDialog() async {
    final Color? color = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ColorPickerDialog(selectedColor: _currentPaintSettings.color);
      },
    );
    if (color != null) {
      setState(() {
        _currentPaintSettings = _currentPaintSettings..color = color;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).viewPadding.top),
          const Spacer(),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: buildAllPaths(context),
          ),
          const SizedBox(height: 8),
          buildToolbar(),
          const Spacer(),
          CancelSaveBarWidget(saveFunction: _save),
        ],
      ),
    );
  }

  GestureDetector buildAllPaths(BuildContext context) {
    return GestureDetector(
      onPanStart: erasing ? onErasingStart : onDrawingStart,
      onPanUpdate: erasing ? onErasingUpdate : onDrawingUpdate,
      child: RepaintBoundary(
        child: Container(
          width: _courtManager.canvasWidth,
          height: _courtManager.canvasHeight,
          alignment: Alignment.topLeft,
          color: Theme.of(context).colorScheme.surface,
          child: StreamBuilder<Drawing>(
            stream: _drawingStreamController.stream,
            builder: (_, __) {
              return _courtManager.buildCourtDrawingWidget(_drawing);
            },
          ),
        ),
      ),
    );
  }

  void onErasingStart(DragStartDetails det) {
    _removePathOnTouch(det.localPosition);
  }

  void onErasingUpdate(DragUpdateDetails det) {
    _removePathOnTouch(det.localPosition);
  }

  void _removePathOnTouch(Offset touchPoint) {
    _drawing.paths.removeWhere((path) {
      double touchOffset = path!.paint.strokeWidth / 2 + 10;
      for (var point in path.points) {
        if (touchPoint.dx > point.dx - touchOffset &&
            touchPoint.dx < point.dx + touchOffset &&
            touchPoint.dy > point.dy - touchOffset &&
            touchPoint.dy < point.dy + touchOffset) {
          return true;
        }
      }
      return false;
    });
    setState(() {});
  }

  void onDrawingStart(DragStartDetails det) {
    Offset point = det.localPosition;
    _newPath = CanvasPath([point], _paintFrom(_currentPaintSettings));
    _newPath!.movePathTo(point.dx, point.dy);
    _drawing.paths.add(_newPath);
    _drawingStreamController.add(_drawing);
  }

  void onDrawingUpdate(DragUpdateDetails det) {
    Offset point = det.localPosition;
    _newPath!.makeLineTo(point.dx, point.dy);
    _newPath!.points.add(point);
    _drawingStreamController.add(_drawing);
  }

  Paint _paintFrom(Paint paint) {
    return Paint()
      ..color = paint.color
      ..strokeWidth = paint.strokeWidth
      ..blendMode = paint.blendMode
      ..strokeCap = paint.strokeCap
      ..shader = paint.shader
      ..style = paint.style;
  }

  Row buildToolbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 16),
        buildClearButton(),
        buildUndoButton(),
        buildStrokeSlider(),
        buildColorButton(Colors.blue),
        buildEraserButton(),
        const SizedBox(width: 16),
      ],
    );
  }

  SliderTheme buildStrokeSlider() {
    return SliderTheme(
      data: SliderThemeData(
        thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: _currentPaintSettings.strokeWidth / 2),
        trackHeight: _currentPaintSettings.strokeWidth / 5,
      ),
      child: Expanded(
        child: Slider(
          activeColor: _currentPaintSettings.color,
          value: _currentPaintSettings.strokeWidth,
          min: 1,
          max: 30,
          onChanged: erasing
              ? null
              : (value) {
                  setState(() {
                    _currentPaintSettings = _currentPaintSettings
                      ..strokeWidth = value;
                  });
                },
        ),
      ),
    );
  }

  IconButton buildColorButton(Color color) {
    return IconButton(
      disabledColor: Colors.grey,
      onPressed: erasing ? null : showColorPickerDialog,
      icon: CircleAvatar(
        backgroundColor: erasing ? Colors.grey : _currentPaintSettings.color,
        child: Icon(
          Icons.color_lens,
          size: 20.0,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }

  IconButton buildUndoButton() {
    return IconButton(
      onPressed: _undo,
      icon: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(
          Icons.undo,
          size: 20.0,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }

  IconButton buildEraserButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          erasing = !erasing;
        });
      },
      icon: CircleAvatar(
        backgroundColor:
            erasing ? Colors.green : Theme.of(context).colorScheme.onPrimary,
        child: Icon(
          Icons.edit_off,
          size: 20.0,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }

  IconButton buildClearButton() {
    return IconButton(
      onPressed: _clear,
      icon: CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.remove,
          size: 20.0,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _drawingStreamController.close();
    super.dispose();
  }
}
