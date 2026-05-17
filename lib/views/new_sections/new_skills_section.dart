import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../constants/app_constants.dart';
import '../../utils/url_opener.dart';
import '../../widgets/section_header.dart';

class NewSkillsSection extends StatelessWidget {
  const NewSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBreakpoints.of(context);
    final isMobile = bp.isMobile;
    final isTablet = bp.isTablet;
    final horizontalPad = isMobile ? 16.0 : (isTablet ? 40.0 : 64.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPad,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TerminalHeader(command: 'cat skills.txt'),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 4),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: isMobile ? 1.3 : 1.5,
              ),
              itemCount: AppConstants.skills.length,
              itemBuilder: (_, i) => _SkillCard(skill: AppConstants.skills[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final dynamic skill;
  const _SkillCard({required this.skill});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.skill;
    return GestureDetector(
      onTap: () {
        if (s.learnMoreUrl != null) {
          UrlOpener.open(s.learnMoreUrl);
        }
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
        duration: AppTheme.normalAnimation,
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryContainer.withValues(alpha: 0.5)
                : AppTheme.primaryContainer.withValues(alpha: 0.2),
          ),
          boxShadow: _isHovered
              ? [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.1), blurRadius: 12)]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: s.imagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            s.imagePath,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Icon(Icons.code, size: 16, color: AppTheme.primaryContainer),
                          ),
                        )
                      : Icon(Icons.code, size: 16, color: AppTheme.primaryContainer),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    s.name,
                    style: AppTheme.codeMedium.copyWith(
                      fontSize: 12,
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              s.category,
              style: AppTheme.codeMedium.copyWith(fontSize: 9, color: AppTheme.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: s.proficiency / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.primaryContainer,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${s.proficiency}%',
              style: AppTheme.codeMedium.copyWith(fontSize: 8, color: AppTheme.primaryContainer, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
