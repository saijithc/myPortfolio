import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../models/achievement.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/section_header.dart';

class NewAchievementsSection extends StatelessWidget {
  const NewAchievementsSection({super.key});

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
        vertical: isMobile ? 40 : 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TerminalHeader(command: 'cat why_hire.txt'),
          Consumer<PortfolioViewModel>(
            builder: (context, viewModel, child) {
              return ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                children: viewModel.achievements.map((a) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _MetricCard(achievement: a),
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

class _MetricCard extends StatelessWidget {
  final Achievement achievement;
  const _MetricCard({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final a = achievement;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: AppTheme.primaryContainer, width: 4)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a.title.toUpperCase(), style: AppTheme.codeMedium.copyWith(fontSize: 10, color: AppTheme.onSurfaceVariant)),
                const SizedBox(height: 4),
                Text('${a.value}${a.suffix}', style: AppTheme.headingDisplay.copyWith(fontSize: 28, color: AppTheme.primaryContainer)),
              ],
            ),
          ),
          Icon(Icons.trending_up, color: AppTheme.primaryContainer, size: 32),
        ],
      ),
    );
  }
}
