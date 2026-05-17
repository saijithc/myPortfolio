import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 40,
            vertical: isMobile ? 40 : 80,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: context.theme.secondaryDark.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: context.theme.neonGreen.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      r'$ cat about.txt',
                      style: context.theme.terminalText.copyWith(
                        color: context.theme.textSecondary,
                        fontSize: isMobile ? 13 : 15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Get to know me better',
                      style: context.theme.terminalText.copyWith(
                        color: context.theme.neonGreen,
                        fontSize: isMobile ? 16 : 20,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Content
              _buildAboutText(context),

              // const SizedBox(height: 80),

              // Achievement Counters
              // _buildAchievementCounters(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutText(BuildContext context) {
    return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.theme.secondaryDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.theme.neonGreen.withValues(alpha: 0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: context.theme.neonGreen.withValues(alpha: 0.05),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Terminal Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: context.theme.accentDark,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(11),
                    topRight: Radius.circular(11),
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: context.theme.neonGreen.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        _buildTerminalDot(Colors.redAccent),
                        const SizedBox(width: 8),
                        _buildTerminalDot(Colors.orangeAccent),
                        const SizedBox(width: 8),
                        _buildTerminalDot(Colors.greenAccent),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        'guest@saijithc:~/about',
                        style: context.theme.bodySmall.copyWith(
                          color: context.theme.textSecondary,
                          fontFamily: 'JetBrains Mono',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // Balance for centering
                  ],
                ),
              ),
              // Terminal Body
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '> cat about_me.txt',
                      style: context.theme.terminalText.copyWith(
                        color: context.theme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppConstants.aboutSummary,
                      style: context.theme.terminalText.copyWith(
                        color: context.theme.textPrimary,
                        height: 1.6,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '> location --show',
                      style: context.theme.terminalText.copyWith(
                        color: context.theme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: context.theme.neonGreen,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppConstants.contactInfo.location,
                          style: context.theme.terminalText.copyWith(
                            color: context.theme.neonGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Blinking cursor
                    Text(
                          '> _',
                          style: context.theme.terminalText.copyWith(
                            color: context.theme.neonGreen,
                          ),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .fadeIn(duration: 400.ms)
                        .fadeOut(duration: 400.ms, delay: 400.ms),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut)
        .fadeIn(duration: 600.ms);
  }

  Widget _buildTerminalDot(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
