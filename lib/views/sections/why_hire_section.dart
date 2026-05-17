import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../widgets/animated_counter.dart';

class WhyHireSection extends StatelessWidget {
  const WhyHireSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                  r'$ cat why_hire.txt',
                  style: context.theme.terminalText.copyWith(
                    color: context.theme.textSecondary,
                    fontSize: isMobile ? 13 : 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'What sets me apart',
                  style: context.theme.terminalText.copyWith(
                    color: context.theme.neonGreen,
                    fontSize: isMobile ? 16 : 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          _WhyHireCards(),
        ],
      ),
    );
  }
}

class _WhyHireCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    final reasons = [
      {
        'title': 'Higher Conversion',
        'description': 'Proven UI/UX business impact',
        'icon': '📈',
        'value': 100,
        'suffix': '%',
        'subtitle': 'Average conversion increase',
      },
      {
        'title': 'Traffic Growth',
        'description': 'Organic traffic improvement',
        'icon': '🚀',
        'value': 100,
        'suffix': '%',
        'subtitle': 'Traffic growth achieved',
      },
      {
        'title': 'Top Rankings',
        'description': 'SEO + app optimization',
        'icon': '🎯',
        'value': 5,
        'suffix': '+',
        'subtitle': 'Search rankings achieved',
      },
    ];

    if (isMobile) {
      return Column(
        children: reasons.map<Widget>((reason) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _MetricCard(reason: reason),
          );
        }).toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 2 : 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 0.85,
      ),
      itemCount: reasons.length,
      itemBuilder: (context, index) {
        return _MetricCard(reason: reasons[index]);
      },
    );
  }
}

class _MetricCard extends StatefulWidget {
  final Map<String, dynamic> reason;
  const _MetricCard({required this.reason});

  @override
  State<_MetricCard> createState() => _MetricCardState();
}

class _MetricCardState extends State<_MetricCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.reason;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppTheme.neonGreen
                : AppTheme.neonGreen.withValues(alpha: 0.2),
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppTheme.neonGreen.withValues(alpha: 0.15),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              r'$ ./metrics.sh',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 9,
                color: AppTheme.textTertiary,
              ),
            ),
            const SizedBox(height: 16),
            Text(r['icon'], style: GoogleFonts.jetBrainsMono(fontSize: 32)),
            const SizedBox(height: 12),
            AnimatedCounter(
              value: r['value'],
              suffix: r['suffix'],
              textStyle: GoogleFonts.jetBrainsMono(
                fontSize: 36,
                color: AppTheme.neonGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              r['subtitle'],
              style: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                color: AppTheme.neonGreen,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              r['title'],
              style: GoogleFonts.jetBrainsMono(
                fontSize: 13,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              r['description'],
              style: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                color: AppTheme.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
