import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/section_header.dart';

class NewExperienceSection extends StatelessWidget {
  const NewExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBreakpoints.of(context);
    final isMobile = bp.isMobile;
    final isTablet = bp.isTablet;
    final double horizontalPad = isMobile ? 16.0 : (isTablet ? 40.0 : 64.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPad,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TerminalHeader(command: 'history | grep jobs'),
          Consumer<PortfolioViewModel>(
            builder: (context, viewModel, child) {
              final experiences = viewModel.experiences;
              return ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Column(
                  children: experiences.asMap().entries.map<Widget>((entry) {
                    final i = entry.key;
                    final exp = entry.value;
                    final isLast = i == experiences.length - 1;
                    return Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: i == 0 ? AppTheme.primaryContainer : AppTheme.surfaceContainerHighest,
                                  border: i != 0 ? Border.all(color: AppTheme.primaryContainer.withValues(alpha: 0.3)) : null,
                                  boxShadow: i == 0
                                      ? [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.5), blurRadius: 10)]
                                      : [],
                                ),
                              ),
                              if (!isLast)
                                Container(
                                  width: 2,
                                  height: 100,
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        AppTheme.primaryContainer.withValues(alpha: 0.4),
                                        AppTheme.primaryContainer.withValues(alpha: 0.02),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Expanded(child: _ExpCard(experience: exp)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ExpCard extends StatefulWidget {
  final dynamic experience;
  const _ExpCard({required this.experience});

  @override
  State<_ExpCard> createState() => _ExpCardState();
}

class _ExpCardState extends State<_ExpCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTheme.normalAnimation,
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryContainer.withValues(alpha: 0.5)
                : AppTheme.primaryContainer.withValues(alpha: 0.2),
          ),
          boxShadow: _isHovered
              ? [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.08), blurRadius: 16)]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exp.position, style: AppTheme.codeMedium.copyWith(fontSize: 14, color: AppTheme.onSurface, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(exp.company, style: AppTheme.codeMedium.copyWith(fontSize: 12, color: AppTheme.primaryContainer)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    exp.isCurrent ? '${exp.startDate} - PRESENT' : '${exp.startDate} - ${exp.endDate}',
                    style: AppTheme.codeMedium.copyWith(fontSize: 10, color: AppTheme.primaryContainer),
                  ),
                ),
              ],
            ),
            if (exp.technologies != null && exp.technologies.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: (exp.technologies as List).map<Widget>((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppTheme.primaryContainer.withValues(alpha: 0.2)),
                    ),
                    child: Text(tech, style: AppTheme.codeMedium.copyWith(fontSize: 9, color: AppTheme.onSurfaceVariant)),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
