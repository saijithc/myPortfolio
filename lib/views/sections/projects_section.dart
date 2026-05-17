import 'package:flutter/material.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
                  r'$ cat projects.txt',
                  style: context.theme.terminalText.copyWith(
                    color: context.theme.textSecondary,
                    fontSize: isMobile ? 13 : 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Some of my recent work',
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
              return _ProjectsGrid(projects: viewModel.projects);
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectsGrid extends StatelessWidget {
  final List<Project> projects;
  const _ProjectsGrid({required this.projects});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    if (isMobile) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: projects.map<Widget>((project) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: ProjectCard(project: project),
          );
        }).toList(),
      );
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: isTablet ? 520 : 480,
            crossAxisSpacing: 28,
            mainAxisSpacing: 28,
            childAspectRatio: 0.72,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return ProjectCard(project: projects[index]);
          },
        ),
      ),
    );
  }
}
