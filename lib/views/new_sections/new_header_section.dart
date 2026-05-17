import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../constants/app_constants.dart';

class NewHeaderSection extends StatelessWidget {
  final VoidCallback? onConnectTap;
  const NewHeaderSection({super.key, this.onConnectTap});

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBreakpoints.of(context);
    final isMobile = bp.isMobile;
    final isTablet = bp.isTablet;
    final double horizontalPad = isMobile ? 16.0 : (isTablet ? 40.0 : 64.0);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isMobile ? 600 : 800,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPad,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Boot sequence text
          if (!isMobile)
            SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bootLine('[SYSTEM BOOT SEQUENCE...]'),
                  _bootLine('ESTABLISHING SECURE_CONNECTION... OK'),
                  _bootLine('MOUNTING UI_COMPONENTS... OK'),
                  _bootLine('SAIJITH_C_PROFILE_ID: 0x5341494A495448'),
                  _bootLine('ACCESS_GRANTED', isHighlight: true),
                ],
              ),
            ),
          const SizedBox(height: 32),
          // Terminal-framed profile image
          Container(
            width: isMobile ? 280 : 320,
            decoration: AppTheme.neonBorder(radius: 12, shadowColor: AppTheme.primaryContainer.withValues(alpha: 0.15)),
            child: Column(
              children: [
                // Title bar
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerHighest,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    border: Border(
                      bottom: BorderSide(color: AppTheme.primaryContainer.withValues(alpha: 0.2)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          _dot(Colors.red.withValues(alpha: 0.5)),
                          const SizedBox(width: 4),
                          _dot(Colors.yellow.withValues(alpha: 0.5)),
                          const SizedBox(width: 4),
                          _dot(Colors.green.withValues(alpha: 0.5)),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'profile_asset.png',
                        style: AppTheme.codeMedium.copyWith(fontSize: 10, color: AppTheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(11),
                    bottomRight: Radius.circular(11),
                  ),
                  child: Image.asset(
                    'assets/images/profile_image.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    cacheWidth: 640,
                    errorBuilder: (_, __, ___) => Container(
                      height: 200,
                      color: AppTheme.surfaceContainerLow,
                      child: Icon(Icons.person, size: 60, color: AppTheme.primaryContainer),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Title
          Text.rich(
            TextSpan(
              style: AppTheme.headingLarge.copyWith(
                fontSize: isMobile ? 32 : 48,
                shadows: [Shadow(color: AppTheme.primaryContainer.withValues(alpha: 0.7), blurRadius: 10)],
              ),
              children: [
                TextSpan(text: "Hi, I'm "),
                TextSpan(
                  text: "Saijith C.",
                  style: TextStyle(color: AppTheme.primaryContainer),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Subtitle with chevron_right and blinking cursor
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.chevron_right, size: 16, color: AppTheme.primaryContainer),
              const SizedBox(width: 4),
              Text(
                'FLUTTER DEVELOPER',
                style: AppTheme.codeMedium.copyWith(
                  color: AppTheme.primaryContainer,
                  letterSpacing: 0.1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const _BlinkingCursor(),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            AppConstants.tagline,
            style: AppTheme.bodyMedium.copyWith(
              fontSize: isMobile ? 13 : 15,
              color: AppTheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          // INITIALIZE_CONNECT button
          GestureDetector(
            onTap: onConnectTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              decoration: BoxDecoration(
                color: AppTheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.primaryContainer.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryContainer.withValues(alpha: 0.3),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Text(
                'INITIALIZE_CONNECT',
                style: AppTheme.codeMedium.copyWith(
                  color: AppTheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Scroll indicator
          Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.primaryContainer.withValues(alpha: 0.5),
            size: 28,
          ),
        ],
      ),
    );
  }

  Widget _bootLine(String text, {bool isHighlight = false}) {
    return Text(
      text,
      style: AppTheme.codeMedium.copyWith(
        fontSize: 9,
        color: isHighlight ? AppTheme.primaryContainer : AppTheme.primary.withValues(alpha: 0.5),
        height: 1.4,
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Text('|', style: TextStyle(color: AppTheme.primaryContainer, fontWeight: FontWeight.bold)),
    );
  }
}

