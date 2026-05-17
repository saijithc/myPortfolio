import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class MouseGlow extends StatefulWidget {
  final Widget child;
  final Color? glowColor;
  final double glowOpacity;

  const MouseGlow({super.key, required this.child, this.glowColor, this.glowOpacity = 0.08});

  @override
  State<MouseGlow> createState() => _MouseGlowState();
}

class _MouseGlowState extends State<MouseGlow> {
  double _mouseX = 0;
  double _mouseY = 0;
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mouseX = event.localPosition.dx;
          _mouseY = event.localPosition.dy;
          _isVisible = true;
        });
      },
      onExit: (_) {
        setState(() => _isVisible = false);
      },
      child: Stack(
        children: [
          RepaintBoundary(child: widget.child),
          if (_isVisible)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _SpotlightPainter(
                    position: Offset(_mouseX, _mouseY),
                    color: widget.glowColor ?? AppTheme.neonGreen,
                    opacity: widget.glowOpacity,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  final Offset position;
  final Color color;
  final double opacity;

  _SpotlightPainter({required this.position, required this.color, this.opacity = 0.04});

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = RadialGradient(
      center: Alignment(
        (position.dx / size.width) * 2 - 1,
        (position.dy / size.height) * 2 - 1,
      ),
      radius: 0.8,
      colors: [
        color.withValues(alpha: opacity),
        color.withValues(alpha: opacity * 0.6),
        color.withValues(alpha: opacity * 0.2),
        Colors.transparent,
      ],
      stops: const [0.0, 0.3, 0.6, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..blendMode = BlendMode.srcOver;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _SpotlightPainter oldDelegate) {
    return oldDelegate.position != position;
  }
}
