import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/glow_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: 80,
      ),
      child: Column(
        children: [
          // Section Title
          Text(
            'Featured Projects',
            style: (isMobile ? AppTheme.headingMedium : AppTheme.headingLarge)
                .copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Section Subtitle
          Text(
            'Some of my recent work',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.neonGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 60),
          
          // Projects Grid
          Consumer<PortfolioViewModel>(
            builder: (context, viewModel, child) {
              return _buildProjectsGrid(context, viewModel.projects);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, projects) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    if (isMobile) {
      // Mobile Layout - Single Column
      return Column(
        children: projects.map<Widget>((project) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _buildProjectCard(context, project),
          );
        }).toList(),
      );
    } else {
      // Desktop/Tablet Layout - Grid
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 2 : 3,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 0.8,
        ),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return _buildProjectCard(context, projects[index]);
        },
      );
    }
  }

  Widget _buildProjectCard(BuildContext context, project) {
    return GlowCard(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: AppTheme.accentDark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.image,
                size: 64,
                color: AppTheme.neonGreen,
              ),
            ),
          ),
          
          // Project Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Title
                Text(
                  project.title,
                  style: AppTheme.headingSmall.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Project Description
                Text(
                  project.description,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Technologies Used
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: project.technologies.take(3).map<Widget>((tech) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.neonGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.neonGreen.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        tech,
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.neonGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 20),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _launchUrl(project.githubUrl),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.neonGreen,
                          foregroundColor: AppTheme.primaryDark,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('View Code'),
                      ),
                    ),
                    
                    if (project.liveUrl != null) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _launchUrl(project.liveUrl!),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppTheme.neonGreen),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Live Demo'),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
