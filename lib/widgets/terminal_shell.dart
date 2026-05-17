import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_theme.dart';

class TerminalShell extends StatelessWidget {
  final Widget child;
  final ScrollController scrollController;

  const TerminalShell({
    super.key,
    required this.child,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TerminalTitleBar(),
        Expanded(
          child: Stack(
            children: [
              child,
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _CRTScanlinePainter(
                      color: Colors.white.withValues(alpha: 0.015),
                      lineHeight: 2.0,
                      spacing: 4.0,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.05),
                          Colors.transparent,
                          Colors.transparent,
                          AppTheme.neonGreen.withValues(alpha: 0.03),
                        ],
                        stops: const [0.0, 0.1, 0.9, 1.0],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TerminalTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 450;

    return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 20,
            vertical: isMobile ? 8 : 12,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            border: Border(
              bottom: BorderSide(
                color: AppTheme.neonGreen.withValues(alpha: 0.25),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.neonGreen.withValues(alpha: 0.05),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            children: [
              Row(
                children: [
                  _buildDot(Colors.redAccent, isMobile: isMobile),
                  SizedBox(width: isMobile ? 6 : 8),
                  _buildDot(Colors.orangeAccent, isMobile: isMobile),
                  SizedBox(width: isMobile ? 6 : 8),
                  _buildDot(Colors.greenAccent, isMobile: isMobile),
                ],
              ),
              SizedBox(width: isMobile ? 8 : 16),
              Expanded(
                child: Text(
                  'guest@saijithc:~/portfolio',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: isMobile ? 10 : 13,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: isMobile ? 48 : 60),
            ],
          ),
        )
        .animate()
        .slideY(begin: -1, end: 0, duration: 400.ms, curve: Curves.easeOutCubic)
        .fadeIn(duration: 400.ms);
  }

  Widget _buildDot(Color color, {required bool isMobile}) {
    return Container(
      width: isMobile ? 8 : 10,
      height: isMobile ? 8 : 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 4),
        ],
      ),
    );
  }
}

class _CRTScanlinePainter extends CustomPainter {
  final Color color;
  final double lineHeight;
  final double spacing;

  _CRTScanlinePainter({
    required this.color,
    required this.lineHeight,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = lineHeight;

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CRTScanlinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.lineHeight != lineHeight ||
        oldDelegate.spacing != spacing;
  }
}
