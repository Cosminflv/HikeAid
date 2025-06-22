import 'package:flutter/material.dart';

class RulerPainter extends CustomPainter {
  final int unitsBetweenLabels;
  final double smallTickHeight;
  final double largeTickHeight;

  final List<String> labels;
  final Color color;

  RulerPainter({
    this.smallTickHeight = 5.0,
    this.largeTickHeight = 20.0,
    required this.unitsBetweenLabels,
    required this.labels,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final tickCount = (labels.length - 1) * unitsBetweenLabels + 1;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    double tickSpace = size.width / (tickCount - 1);

    for (int step = 0; step < tickCount; step++) {
      double startX = step * tickSpace;
      bool isLargeTick = false;

      if (step % (unitsBetweenLabels) == 0) {
        isLargeTick = true;
      }

      if (isLargeTick) {
        canvas.drawLine(
          Offset(startX, size.height / 2 + 5),
          Offset(startX, size.height),
          paint,
        );
      } else {
        canvas.drawLine(
          Offset(startX, size.height / 4 * 3 + 2),
          Offset(startX, size.height),
          paint,
        );
      }

      if (isLargeTick) {
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: labels[step ~/ unitsBetweenLabels],
            style: TextStyle(
              color: color,
              fontSize: 10.0,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        var offset = Offset(startX - textPainter.width / 2, 0);

        if (step == 0) {
          offset = Offset(0, offset.dy);
        } else if (step == tickCount - 1) {
          offset = Offset(size.width - textPainter.width, offset.dy);
        }

        textPainter.paint(canvas, offset);
      }
    }

    canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ChartAxisRuler extends StatelessWidget {
  final List<String> labels;
  final Color color;

  const ChartAxisRuler({super.key, required this.labels, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width - 10, 25),
      painter: RulerPainter(
        smallTickHeight: 5.0,
        largeTickHeight: 10.0,
        unitsBetweenLabels: 5,
        labels: labels,
        color: color,
      ),
    );
  }
}
