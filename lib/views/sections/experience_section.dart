import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
                  r'$ cat experience.txt',
                  style: context.theme.terminalText.copyWith(
                    color: context.theme.textSecondary,
                    fontSize: isMobile ? 13 : 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'My professional journey',
                  style: context.theme.terminalText.copyWith(
                    color: context.theme.neonGreen,
                    fontSize: isMobile ? 16 : 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Consumer<PortfolioViewModel>(
            builder: (context, viewModel, child) {
              return _ExperienceTimeline(experiences: viewModel.experiences);
            },
          ),
        ],
      ),
    );
  }
}

class _ExperienceTimeline extends StatelessWidget {
  final List experiences;
  const _ExperienceTimeline({required this.experiences});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Column(
      children: experiences.asMap().entries.map<Widget>((entry) {
        final index = entry.key;
        final experience = entry.value;
        final isLast = index == experiences.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMobile)
              Column(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppTheme.neonGreen,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.neonGreen.withValues(alpha: 0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 120,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppTheme.neonGreen.withValues(alpha: 0.5),
                            AppTheme.neonGreen.withValues(alpha: 0.05),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            if (!isMobile) const SizedBox(width: 24),
            Expanded(
              child: _ExperienceCard(
                experience: experience,
                isLast: isLast,
                isMobile: isMobile,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final dynamic experience;
  final bool isLast;
  final bool isMobile;

  const _ExperienceCard({
    required this.experience,
    required this.isLast,
    required this.isMobile,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        margin: EdgeInsets.only(bottom: widget.isLast ? 0 : 24),
        padding: EdgeInsets.all(widget.isMobile ? 16 : 24),
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
                    color: AppTheme.neonGreen.withValues(alpha: 0.1),
                    blurRadius: 25,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r'$ ' + exp.position,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: widget.isMobile ? 14 : 16,
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        exp.company,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: widget.isMobile ? 12 : 13,
                          color: AppTheme.neonGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.neonGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppTheme.neonGreen.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    '${exp.startDate} - ${exp.endDate ?? "Present"}',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      color: AppTheme.neonGreen,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              r'$ cat responsibilities',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                color: AppTheme.textTertiary,
              ),
            ),
            const SizedBox(height: 8),
            ...exp.responsibilities.map<Widget>((resp) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '> ',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        color: AppTheme.neonGreen,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        resp,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          color: AppTheme.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),
            Text(
              r'$ echo $TECH_STACK',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                color: AppTheme.textTertiary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: exp.technologies.map<Widget>((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.neonGreen.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: AppTheme.neonGreen.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    tech,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      color: AppTheme.neonGreen,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
