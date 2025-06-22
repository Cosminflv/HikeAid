import 'package:flutter/material.dart';

class ChartCursor extends StatelessWidget {
  const ChartCursor({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinePainter(),
    );
  }
}

class LinePainter extends CustomPainter {
  LinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0;

    // Draw vertical line
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);

    // Draw drag handle
    final path = Path();

    path.addPolygon([
      const Offset(0, 0),
      Offset(size.width, 0),
      Offset(size.width, 5),
      Offset(size.width, 12),
      Offset(size.width / 2, 20),
      const Offset(0, 12),
      const Offset(0, 5),
      const Offset(0, 0),
    ], true);

    canvas.drawPath(path, paint);

    canvas.drawLine(
        Offset(size.width / 2, 9),
        Offset(size.width / 2, 19),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
