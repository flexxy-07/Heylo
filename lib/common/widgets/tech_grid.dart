import 'package:flutter/material.dart';
import 'package:heylo/theme/app_pallete.dart';

class TechGrid extends StatelessWidget {
  const TechGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: TechGridPainter(),
    );
  }
}

class TechGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppPallete.primary.withOpacity(0.05)
      ..strokeWidth = 1.0;

    const step = 40.0;

    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
