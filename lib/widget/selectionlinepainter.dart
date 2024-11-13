import 'package:flutter/material.dart';

class SelectionLinePainter extends CustomPainter {
  final Offset? start;
  final Offset? end;
  final double cellSize;
  final Color color;
  final bool showLine;
  final List<Offset> permanentLines;

  SelectionLinePainter(
    this.start,
    this.end,
    this.cellSize,
    this.color,
    this.showLine,
    this.permanentLines,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < permanentLines.length; i += 2) {
      final pStart = Offset(permanentLines[i].dx * cellSize + cellSize / 2,
          permanentLines[i].dy * cellSize + cellSize / 2);
      final pEnd = Offset(permanentLines[i + 1].dx * cellSize + cellSize / 2,
          permanentLines[i + 1].dy * cellSize + cellSize / 2);
      canvas.drawLine(pStart, pEnd, paint);
    }

    if (start != null && end != null && showLine) {
      final pStart = Offset(start!.dx * cellSize + cellSize / 2,
          start!.dy * cellSize + cellSize / 2);
      final pEnd = Offset(
          end!.dx * cellSize + cellSize / 2, end!.dy * cellSize + cellSize / 2);
      canvas.drawLine(pStart, pEnd, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
