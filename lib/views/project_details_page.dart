import 'package:flutter/material.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_theme.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;
  const ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Scaffold(
    
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32, vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       _header(context),
                        const SizedBox(height: 24),
                      _buildHeroImage(context, height: 420),
                      const SizedBox(height: 24),
                      _buildTitleBlock(),
                      const SizedBox(height: 20),
                      _buildTechnologiesBlock(),
                      const SizedBox(height: 20),
                      _buildFeaturesBlock(),
                      const SizedBox(height: 24),
                      _buildLinksBlock(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                                 _header(context),
                        const SizedBox(height: 24),
                            _buildHeroImage(context, height: 520),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                  const SizedBox(height: 60),
                            _buildTitleBlock(),
                            const SizedBox(height: 20),
                            _buildTechnologiesBlock(),
                            const SizedBox(height: 20),
                            _buildFeaturesBlock(limit: 12),
                            const SizedBox(height: 24),
                            _buildLinksBlock(),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Row _header(BuildContext context) {
    return Row(
        children: [
          IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios_rounded)),
          Text(
            project.title,
            style: AppTheme.headingSmall.copyWith(color: AppTheme.textPrimary),
          ),
        ],
      );
  }

  Widget _buildHeroImage(BuildContext context, {required double height}) {
    return Center(
      child: SizedBox(
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: AspectRatio(
            aspectRatio: 9 / 19.5,
            child: Hero(
              tag: 'project-image-${project.imageUrl}',
              child: project.imageUrl.isNotEmpty
                  ? Image.asset(project.imageUrl, fit: BoxFit.cover)
                  : const Icon(Icons.image, size: 64, color: AppTheme.neonGreen),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.title,
          style: AppTheme.headingSmall.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          project.description,
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textSecondary,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          project.longDescription,
          style: AppTheme.bodySmall.copyWith(
            color: AppTheme.textTertiary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTechnologiesBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Technologies',
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.technologies.map<Widget>((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFeaturesBlock({int? limit}) {
    final items = limit != null ? project.features.take(limit) : project.features;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Highlights',
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        ...items.map<Widget>((feature) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppTheme.neonGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    feature,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildLinksBlock() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        if (project.androidUrl != null)
          _linkButton(
            icon: Icons.android,
            label: 'Android',
            onTap: () => _launch(project.androidUrl!),
          ),
        if (project.iosUrl != null)
          _linkButton(
            icon: Icons.apple,
            label: 'iOS',
            onTap: () => _launch(project.iosUrl!),
          ),
        if (project.webUrl != null)
          _linkButton(
            icon: Icons.public,
            label: 'Web',
            onTap: () => _launch(project.webUrl!),
          ),
      ],
    );
  }

  Widget _linkButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}


