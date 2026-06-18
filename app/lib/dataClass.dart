import 'package:flutter/material.dart';

class imageObject{
  double x = 0;
  double y = 0;
  double width = 100;
  double height = 100;
  int objectType = 0;
  int sourceIndex = 0;
  double scale;
  double rotation;
  Color color;

  imageObject({
    required this.x,
    required this.y,
    this.width = 100,
    this.height = 100,
    this.objectType = 0,
    this.sourceIndex = 0,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.color = Colors.white,
  });
}

class paintPoint{
  Offset position = Offset(0, 0);
  Color color = Colors.white;
  bool stop = false;

  paintPoint({
    required this.position,
    required this.color,
    required this.stop,
  });
}

class textObject{
  Offset position = Offset(0, 0);
  Color color = Colors.white;
  String text = "";
  double scale;
  double rotation;

  textObject({
    required this.position,
    required this.color,
    required this.text,
    this.scale = 1.0,
    this.rotation = 0.0,
  });
}

class DrawPainter extends CustomPainter {
  final List<paintPoint> points;
  DrawPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i].stop != true && points[i + 1].stop != true) {
        paint.color = points[i].color;
        canvas.drawLine(points[i].position!, points[i + 1].position!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => true;
}