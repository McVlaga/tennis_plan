import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:tennis_plan/constants/constants.dart';
import 'package:tennis_plan/match_detail/plan/models/tactical_plans.dart';
import 'package:tennis_plan/match_detail/plan/tactics/court_painter.dart';
import 'package:tennis_plan/match_detail/plan/tactics/drawing.dart';
import 'package:tennis_plan/match_detail/plan/tactics/canvas_path.dart';
import 'package:tennis_plan/match_detail/plan/tactics/painter.dart';
import 'package:tennis_plan/matches/models/a_match.dart';
import 'package:tennis_plan/matches/models/matches.dart';

class DrawPlanScreen extends StatefulWidget {
  const DrawPlanScreen({Key? key}) : super(key: key);

  static const routeName = '/add-edit-plan';

  @override
  State<DrawPlanScreen> createState() => _DrawPlanScreenState();
}

class _DrawPlanScreenState extends State<DrawPlanScreen> {
  bool firstInit = true;
  late AMatch match;
  late TacticalPlans tempPlans;

  final GlobalKey _globalKey = GlobalKey();
  final Drawing _drawing = Drawing(paths: []);
  CanvasPath? _newPath;
  Paint _currentPaintSettings = Paint()
    ..strokeWidth = 15
    ..color = Colors.orange
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  final StreamController<Drawing> _drawingStreamController =
      StreamController<Drawing>.broadcast();

  late double paddingTop;
  late double canvasHeight;
  late double canvasWidth;
  static const courtAspectRatio = 1.2;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstInit) {
      _newPath = CanvasPath([], _currentPaintSettings);
      initCanvasSizes();
      String matchId = ModalRoute.of(context)!.settings.arguments as String;
      match = Provider.of<Matches>(
        context,
        listen: false,
      ).findById(matchId);
      tempPlans = match.tacticalPlans;
      firstInit = false;
    }
  }

  void initCanvasSizes() {
    final deviceHeight = MediaQuery.of(context).size.height;
    paddingTop = deviceHeight / 10;
    canvasHeight = deviceHeight - deviceHeight / 3;

    final courtHeight = deviceHeight - deviceHeight / 3 - paddingTop * 2;
    canvasWidth = courtHeight / courtAspectRatio;
  }

  Future<void> save() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      tempPlans.addPlan('Plan A', 'Description', pngBytes);
      match.setTacticalPlans(tempPlans);
      var saved = await ImageGallerySaver.saveImage(
        pngBytes!,
        quality: 100,
        name: DateTime.now().toIso8601String() + ".png",
        isReturnImagePathOfIOS: true,
      );
      Navigator.of(context).pop();
      print(saved);
    } catch (e) {
      print(e);
    }
  }

  void clear() {
    setState(() {
      _drawing.paths = [];
      _newPath = null;
    });
  }

  void undo() {
    setState(() {
      if (_drawing.paths.isNotEmpty) {
        _drawing.paths.removeLast();
      }
      _newPath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a plan'),
        backgroundColor: Colors.blue,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Container(
                width: canvasWidth,
                height: canvasHeight,
                color: Theme.of(context).colorScheme.surface,
                child: Stack(
                  children: [
                    buildAllPaths(context),
                    //buildCurrentPath(context),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            buildToolbar(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.paddingTwo,
                right: Dimensions.paddingTwo,
                bottom: Dimensions.paddingTwo,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.borderRadius),
                ),
                child: Material(
                  color: Colors.blue,
                  child: InkWell(
                    onTap: save,
                    child: SizedBox(
                      height: Dimensions.addMatchDialogInputHeight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'SAVE',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildAllPaths(BuildContext context) {
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      child: RepaintBoundary(
        key: _globalKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.topLeft,
          color: Colors.transparent,
          child: Stack(
            children: [
              CustomPaint(painter: CourtPainter(context)),
              StreamBuilder<Drawing>(
                stream: _drawingStreamController.stream,
                builder: (context, snapshot) {
                  return CustomPaint(
                    painter: Painter(drawing: _drawing),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPanStart(DragStartDetails det) {
    Offset point = det.localPosition;
    _newPath = CanvasPath([point], _paintFrom(_currentPaintSettings));
    _newPath!.movePathTo(point.dx, point.dy);
    _drawing.paths.add(_newPath);
    _drawingStreamController.add(_drawing);
  }

  onPanUpdate(DragUpdateDetails det) {
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
      ),
      child: Expanded(
        child: Slider(
          activeColor: _currentPaintSettings.color,
          value: _currentPaintSettings.strokeWidth,
          min: 1,
          max: 30,
          onChanged: (value) {
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
      onPressed: () {
        setState(() {
          _currentPaintSettings = _currentPaintSettings..color = color;
        });
      },
      icon: CircleAvatar(
        backgroundColor: _currentPaintSettings.color,
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
      onPressed: undo,
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
      onPressed: () {},
      icon: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
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
      onPressed: clear,
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
