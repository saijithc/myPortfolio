import 'package:flutter/material.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/glow_card.dart';
import '../../utils/text_utils.dart';
import '../project_details_page.dart';

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
          textCustom(
            text: 'Featured Projects',
            color: AppTheme.textPrimary,
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 20),
          
          // Section Subtitle
          textSemiBoldLarge(
            text: 'Some of my recent work',
            color: AppTheme.neonGreen,
            textAlign: TextAlign.center,
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

  Widget _platformButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.neonGreen.withOpacity(0.35), width: 1),
          color: AppTheme.neonGreen.withOpacity(0.08),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: AppTheme.neonGreen),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.neonGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _platformChip(IconData icon, {String? tooltip}) {
    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.neonGreen.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.neonGreen.withOpacity(0.35), width: 1),
      ),
      child: Icon(icon, size: 14, color: AppTheme.neonGreen),
    );
    if (tooltip != null) {
      return Tooltip(
        message: tooltip,
        textStyle: const TextStyle(color: Colors.black),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: chip,
      );
    }
    return chip;
  }

  Widget _buildProjectsGrid(BuildContext context,List<Project> projects) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    // Keep scrollController accessible if needed elsewhere; not used here after removing effects

    if (isMobile) {
      // Mobile Layout - Single Column
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: projects.map<Widget>((project) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _buildProjectCard(context, project),
          );
        }).toList(),
      );
    } else {
      // Desktop/Tablet Layout - Centered Grid with max card width
      final double maxExtent = isTablet ? 520 : 420;

      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: maxExtent,
              crossAxisSpacing: 28,
              mainAxisSpacing: 28,
              // Increase card height so details fit without inner scroll
              childAspectRatio: 0.68,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return _buildProjectCard(context, projects[index]);
            },
          ),
        ),
      );
    }
  }

  Widget _buildProjectCard(BuildContext context,Project project) {
    final bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return GlowCard(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image (tall screenshot friendly with preview)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Stack(
              children: [
                Container(
                  color: AppTheme.accentDark,
                  width: double.infinity,
                  height: isMobile ? 320 : 240,
                  child: InkWell(
                    onTap: () => _showImagePreview(context, project.imageUrl),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: AspectRatio(
                            aspectRatio: 9 / 19.5, // common mobile screenshot ratio
                            child: Hero(
                              tag: 'project-image-${project.imageUrl}',
                              child: project.imageUrl.isNotEmpty
                                  ? Image.asset(
                                      project.imageUrl,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stack) {
                                        return const Icon(
                                          Icons.broken_image_outlined,
                                          size: 56,
                                          color: AppTheme.neonGreen,
                                        );
                                      },
                                    )
                                  : const Icon(
                                      Icons.image,
                                      size: 64,
                                      color: AppTheme.neonGreen,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Platform chips overlay (top-right)
             
              ],
            ),
          ),
          
          // Project Content
          if (isMobile)
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
                
                // Project Description (brief)
                Text(
                  project.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
                
          const SizedBox(height: 10),
          
          // Long description hidden on card for cleaner preview
          const SizedBox.shrink(),
          
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
                
          const SizedBox(height: 16),
          
          // Hide features in preview
          const SizedBox.shrink(),
          
                const SizedBox(height: 16),
                
                // Store / Platform Links
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    if (project.androidUrl != null)
                      _platformButton(
                        context: context,
                        icon: Icons.android,
                        label: 'Android',
                        onTap: () => _launchUrl(project.androidUrl!),
                      ),
                    if (project.iosUrl != null)
                      _platformButton(
                        context: context,
                        icon: Icons.apple,
                        label: 'iOS',
                        onTap: () => _launchUrl(project.iosUrl!),
                      ),
                    if (project.webUrl != null)
                      _platformButton(
                        context: context,
                        icon: Icons.public,
                        label: 'Web',
                        onTap: () => _launchUrl(project.webUrl!),
                      ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // View Details button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProjectDetailsPage(project: project),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.neonGreen),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('View Details'),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Action Buttons
                Row(
                  children: [
              if (project.githubUrl != null) 
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _launchUrl(project.githubUrl!),
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
            )
          else
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
                  // Project Description (brief)
                  Text(
                    project.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
                    children: project.technologies.take(4).map<Widget>((tech) {
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
                  const SizedBox(height: 16),
                  // Hide features in preview (web/tablet)
                  const SizedBox.shrink(),
                  const SizedBox(height: 16),
                  // Store / Platform Links
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      if (project.androidUrl != null)
                        _platformButton(
                          context: context,
                          icon: Icons.android,
                          label: 'Android',
                          onTap: () => _launchUrl(project.androidUrl!),
                        ),
                      if (project.iosUrl != null)
                        _platformButton(
                          context: context,
                          icon: Icons.apple,
                          label: 'iOS',
                          onTap: () => _launchUrl(project.iosUrl!),
                        ),
                      if (project.webUrl != null)
                        _platformButton(
                          context: context,
                          icon: Icons.public,
                          label: 'Web',
                          onTap: () => _launchUrl(project.webUrl!),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // View Details button (web/tablet)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProjectDetailsPage(project: project),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.neonGreen),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('View Details'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Action Buttons
                  Row(
                    children: [
                      if (project.githubUrl != null) 
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _launchUrl(project.githubUrl!),
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

  void _showImagePreview(BuildContext context, String imagePath) {
    if (imagePath.isEmpty) return;
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              InteractiveViewer(
                minScale: 0.8,
                maxScale: 4.0,
                child: Center(
                  child: Hero(
                    tag: 'project-image-$imagePath',
                    child: AspectRatio(
                      aspectRatio: 9 / 19.5,
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
