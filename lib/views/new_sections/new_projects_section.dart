import 'package:flutter/material.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/section_header.dart';
import '../project_details_page.dart';

class NewProjectsSection extends StatelessWidget {
  const NewProjectsSection({super.key});

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
          const TerminalHeader(command: 'cat projects.txt'),
          Consumer<PortfolioViewModel>(
            builder: (context, viewModel, child) {
              return ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                  children: viewModel.projects.map((project) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: isMobile ? 20 : 28),
                      child: _ProjectCard(project: project, isMobile: isMobile),
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

class _ProjectCard extends StatefulWidget {
  final Project project;
  final bool isMobile;
  const _ProjectCard({required this.project, required this.isMobile});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final isMobile = widget.isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTheme.normalAnimation,
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryContainer.withValues(alpha: 0.5)
                : AppTheme.primaryContainer.withValues(alpha: 0.2),
          ),
          boxShadow: _isHovered
              ? [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.08), blurRadius: 20)]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (p.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(11), topRight: Radius.circular(11)),
                child: Image.asset(
                  p.imageUrl,
                  height: isMobile ? 160 : 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  cacheWidth: 800,
                  errorBuilder: (_, __, ___) => Container(
                    height: isMobile ? 160 : 200,
                    color: AppTheme.surfaceContainer,
                    child: Icon(Icons.image_outlined, color: AppTheme.outline),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(isMobile ? 16 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.title.toUpperCase(), style: AppTheme.headingMedium.copyWith(fontSize: isMobile ? 16 : 18, color: AppTheme.onSurface)),
                  const SizedBox(height: 8),
                  Text(p.description, style: AppTheme.codeMedium.copyWith(fontSize: isMobile ? 11 : 12, color: AppTheme.onSurfaceVariant)),
                  if (p.technologies.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: p.technologies.map<Widget>((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppTheme.primaryContainer.withValues(alpha: 0.2)),
                          ),
                          child: Text(tech, style: AppTheme.codeMedium.copyWith(fontSize: 9, color: AppTheme.primaryContainer)),
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 16),
                  _ViewDetailsButton(project: p, isMobile: isMobile),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewDetailsButton extends StatelessWidget {
  final Project project;
  final bool isMobile;
  const _ViewDetailsButton({required this.project, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProjectDetailsPage(project: project)),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 16, vertical: isMobile ? 8 : 10),
        decoration: BoxDecoration(
          color: AppTheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.3), blurRadius: 10)],
        ),
        child: Text(
          'VIEW_DETAILS',
          style: AppTheme.codeMedium.copyWith(
            fontSize: isMobile ? 10 : 11,
            color: AppTheme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
