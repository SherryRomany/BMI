import 'package:flutter/material.dart';
import 'dart:math';

class BMIGaugePainter extends CustomPainter {
  final double bmi;

  BMIGaugePainter({required this.bmi});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Draw the gauge background
    final gaugePaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 20;

    // Draw underweight section (blue)
    gaugePaint.color = Colors.blue;
    canvas.drawArc(
      rect,
      -3.14,
      0.8,
      false,
      gaugePaint,
    );

    // Draw normal section (green)
    gaugePaint.color = Colors.green;
    canvas.drawArc(
      rect,
      -2.34,
      0.8,
      false,
      gaugePaint,
    );

    // Draw overweight section (orange)
    gaugePaint.color = Colors.orange;
    canvas.drawArc(
      rect,
      -1.54,
      0.8,
      false,
      gaugePaint,
    );

    // Draw obese section (red)
    gaugePaint.color = Colors.red;
    canvas.drawArc(
      rect,
      -0.74,
      0.74,
      false,
      gaugePaint,
    );

    // Calculate needle position based on BMI
    double angle;
    if (bmi < 10) {
      angle = -3.14; // Min angle
    } else if (bmi > 40) {
      angle = 0; // Max angle
    } else {
      // Map BMI (10 to 40) to angle (-3.14 to 0)
      angle = -3.14 + (bmi - 10) * (3.14 / 30);
    }

    // Draw the needle
    final needlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(rect.width / 2, rect.height);
    final needleLength = rect.width * 0.4;
    final endPoint = Offset(
      center.dx + cos(angle) * needleLength,
      center.dy + sin(angle) * needleLength,
    );

    canvas.drawLine(center, endPoint, needlePaint);

    // Draw the center circle
    final centerCirclePaint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 5, centerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}