import 'dart:math' as math;
import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  final double animationValue;
  final Color neonGreenColor;

  BackgroundPainter(this.animationValue, this.neonGreenColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    for (int i = 0; i < 3; i++) {
      final progress = (animationValue + (i * 0.33)) % 1.0;
      final x = size.width * (0.2 + (i * 0.3));
      final y = size.height * (0.3 + math.sin(progress * 2 * math.pi) * 0.2);
      final radius = 150 + (math.sin(progress * 2 * math.pi) * 50);

      paint.shader = RadialGradient(
        colors: [
          neonGreenColor.withValues(alpha: 0.1),
          neonGreenColor.withValues(alpha: 0.05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: Offset(x, y), radius: radius));

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
