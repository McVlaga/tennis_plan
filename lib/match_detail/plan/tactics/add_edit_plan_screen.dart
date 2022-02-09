import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddEditPlanScreen extends StatefulWidget {
  const AddEditPlanScreen({Key? key}) : super(key: key);

  static const routeName = '/add-edit-plan';

  @override
  State<AddEditPlanScreen> createState() => _AddEditPlanScreenState();
}

class _AddEditPlanScreenState extends State<AddEditPlanScreen> {
  GlobalKey _globalKey = new GlobalKey();
  List<DrawnLine> lines = <DrawnLine>[];
  DrawnLine? line;
  Color selectedColor = Colors.green;
  double selectedWidth = 10;

  StreamController<List<DrawnLine>> linesStreamController =
      StreamController<List<DrawnLine>>.broadcast();
  StreamController<DrawnLine> currentLineStreamController =
      StreamController<DrawnLine>.broadcast();

  Future<void> save() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      // var saved = await ImageGallerySaver.saveImage(
      //   pngBytes,
      //   quality: 100,
      //   name: DateTime.now().toIso8601String() + ".png",
      //   isReturnImagePathOfIOS: true,
      // );
      // print(saved);
    } catch (e) {
      print(e);
    }
  }

  Future<void> clear() async {
    setState(() {
      lines = [];
      line = null;
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
      body: Padding(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Container(
                width: MediaQuery.of(context).size.width - 32,
                height: 480,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Stack(
                  children: [
                    CustomPaint(painter: CourtPainter(context)),
                    buildAllPaths(context),
                    buildCurrentPath(context),
                  ],
                ),
              ),
            ),
            buildColorToolbar(),
            buildStrokeToolbar(),
          ],
        ),
      ),
    );
  }

  RepaintBoundary buildAllPaths(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(4.0),
        alignment: Alignment.topLeft,
        child: StreamBuilder<List<DrawnLine>>(
          stream: linesStreamController.stream,
          builder: (context, snapshot) {
            return CustomPaint(
              painter: Sketcher(
                lines: lines,
              ),
            );
          },
        ),
      ),
    );
  }

  GestureDetector buildCurrentPath(BuildContext context) {
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: RepaintBoundary(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(4.0),
          alignment: Alignment.topLeft,
          color: Colors.transparent,
          child: StreamBuilder<DrawnLine>(
            stream: currentLineStreamController.stream,
            builder: (context, snapshot) {
              return CustomPaint(
                painter: Sketcher(
                  lines: [line],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void onPanStart(DragStartDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset point;

    point = box.globalToLocal(details.localPosition);
    line = DrawnLine([point], selectedColor, selectedWidth);
  }

  void onPanUpdate(DragUpdateDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset point;

    point = box.globalToLocal(details.localPosition);

    List<Offset> path = List.from(line!.path)..add(point);
    line = DrawnLine(path, selectedColor, selectedWidth);
    currentLineStreamController.add(line!);
  }

  void onPanEnd(DragEndDetails details) {
    lines = List.from(lines)..add(line!);

    linesStreamController.add(lines);
  }

  Row buildStrokeToolbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildStrokeButton(5.0),
        buildStrokeButton(10.0),
        buildStrokeButton(15.0),
      ],
    );
  }

  GestureDetector buildStrokeButton(double strokeWidth) {
    return GestureDetector(
      onTap: () {
        selectedWidth = strokeWidth;
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: strokeWidth * 2,
          height: strokeWidth * 2,
          decoration: BoxDecoration(
              color: selectedColor, borderRadius: BorderRadius.circular(12.0)),
        ),
      ),
    );
  }

  Row buildColorToolbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildClearButton(),
        buildSaveButton(),
        buildColorButton(Colors.red),
        buildColorButton(Colors.blue),
        buildColorButton(Colors.orange),
        buildColorButton(Colors.green),
        buildColorButton(Colors.white),
      ],
    );
  }

  Padding buildColorButton(Color color) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FloatingActionButton(
        heroTag: color,
        mini: true,
        backgroundColor: color,
        child: Container(),
        onPressed: () {
          setState(() {
            selectedColor = color;
          });
        },
      ),
    );
  }

  GestureDetector buildSaveButton() {
    return GestureDetector(
      onTap: save,
      child: CircleAvatar(
        child: Icon(
          Icons.save,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }

  GestureDetector buildClearButton() {
    return GestureDetector(
      onTap: clear,
      child: CircleAvatar(
        child: Icon(
          Icons.create,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Sketcher extends CustomPainter {
  final List<DrawnLine?> lines;

  Sketcher({required this.lines});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < lines.length; ++i) {
      if (lines[i] == null) continue;
      int length = lines[i]!.path.length;
      for (int j = 0; j < length - 1; ++j) {
        if (lines[i]!.path[j] != null && lines[i]?.path[j + 1] != null) {
          paint.color = lines[i]!.color;
          paint.strokeWidth = lines[i]!.width;
          canvas.drawLine(lines[i]!.path[j], lines[i]!.path[j + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return true;
  }
}

class DrawnLine {
  final List<Offset> path;
  final Color color;
  final double width;

  DrawnLine(this.path, this.color, this.width);
}

class CourtPainter extends CustomPainter {
  CourtPainter(this.context) {
    width = MediaQuery.of(context).size.width;
    courtWidth = width - paddingLeft - paddingRight;
    courtHeight = 320;
  }

  final BuildContext context;
  late double width;
  late double courtWidth;
  late double courtHeight;
  final double paddingLeft = 32;
  final double paddingRight = 32;
  final double paddingTop = 80;

  @override
  void paint(Canvas canvas, Size size) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = darkMode ? Colors.white : Colors.black;

    Path path = Path();

    path.moveTo(paddingLeft, paddingTop);
    path.lineTo(paddingLeft, paddingTop + courtHeight);
    path.lineTo(courtWidth, paddingTop + courtHeight);
    path.lineTo(courtWidth, 80);
    path.lineTo(paddingRight, 80);
    path.moveTo(paddingLeft + 30, 80);
    path.lineTo(paddingLeft + 30, 400);
    path.moveTo(courtWidth - 30, 80);
    path.lineTo(courtWidth - 30, paddingTop + courtHeight);
    path.moveTo((courtWidth + paddingLeft) / 2, 160);
    path.lineTo((courtWidth + paddingLeft) / 2, 320);
    path.moveTo(paddingLeft + 30, 160);
    path.lineTo(courtWidth - 30, 160);
    path.moveTo(paddingLeft + 30, 320);
    path.lineTo(courtWidth - 30, 320);
    path.moveTo(24, 240);
    path.lineTo(courtWidth + 8, 240);

    canvas.drawPath(path, paint);
  }

  // 4
  @override
  bool shouldRepaint(CourtPainter delegate) {
    return true;
  }
}
