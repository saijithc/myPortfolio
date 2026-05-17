import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class CyberpunkBackground extends StatelessWidget {
  const CyberpunkBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = context.theme.isLight;

    return Stack(
      children: [
        // Base background
        Container(color: context.theme.primaryDark),
        // Dotted matrix grid
        Positioned.fill(
          child: CustomPaint(
            painter: _GridPainter(
              color: context.theme.textSecondary.withValues(
                alpha: isLight ? 0.08 : 0.12,
              ),
              spacing: 30.0,
            ),
          ),
        ),
        // Grain/noise overlay for cinematic feel
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _NoisePainter(
                color: Colors.white,
                opacity: isLight ? 0.015 : 0.025,
              ),
            ),
          ),
        ),
        // Vignette effect
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  Colors.transparent,
                  context.theme.primaryDark.withValues(
                    alpha: isLight ? 0.3 : 0.7,
                  ),
                  context.theme.primaryDark,
                ],
                stops: const [0.3, 0.7, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color color;
  final double spacing;

  _GridPainter({required this.color, required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.spacing != spacing;
  }
}

class _NoisePainter extends CustomPainter {
  final Color color;
  final double opacity;

  _NoisePainter({required this.color, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 200; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final r = random.nextDouble() * 2.0 + 0.5;
      paint.color = color.withValues(alpha: opacity * random.nextDouble());
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _NoisePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.opacity != opacity;
  }
}
