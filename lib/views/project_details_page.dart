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
      backgroundColor: AppTheme.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32, vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _header(context, isMobile),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: _buildHeroImage(context),
                      ),
                      const SizedBox(height: 24),
                      _buildContent(context, isMobile),
                    ],
                  )
                : IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 64) * 0.25,
                        child: Column(
                          children: [
                            _header(context, isMobile),
                            const SizedBox(height: 16),
                            Expanded(
                              child: _buildHeroImage(context),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 64) * 0.5,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 40),
                              _buildContent(context, isMobile),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleBlock(context),
        const SizedBox(height: 24),
        _buildTechnologiesBlock(context),
        const SizedBox(height: 24),
        _buildFeaturesBlock(context),
        const SizedBox(height: 24),
        _buildLinksBlock(context),
      ],
    );
  }

  Widget _header(BuildContext context, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, size: 20, color: AppTheme.primaryContainer),
          ),
          const SizedBox(width: 12),
          Text(
            '\$ cd ../${project.title.toLowerCase().replaceAll(' ', '_')}',
            style: AppTheme.codeMedium.copyWith(
              fontSize: isMobile ? 11 : 13,
              color: AppTheme.primaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Hero(
          tag: 'project-image-${project.imageUrl}',
          child: project.imageUrl.isNotEmpty
              ? Image.asset(project.imageUrl, fit: BoxFit.cover)
              : Container(
                  color: AppTheme.surfaceContainerLow,
                  child: Icon(Icons.image_outlined, size: 48, color: AppTheme.outline),
                ),
        ),
      ),
    );
  }

  Widget _buildTitleBlock(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.title.toUpperCase(),
          style: AppTheme.headingMedium.copyWith(
            fontSize: 18,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          project.description,
          style: AppTheme.codeMedium.copyWith(
            fontSize: 12,
            color: AppTheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          project.longDescription,
          style: AppTheme.codeMedium.copyWith(
            fontSize: 11,
            color: AppTheme.outline,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTechnologiesBlock(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// TECH_STACK',
          style: AppTheme.codeMedium.copyWith(
            fontSize: 11,
            color: AppTheme.primaryFixedDim,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: project.technologies.map<Widget>((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppTheme.primaryContainer.withValues(alpha: 0.2)),
              ),
              child: Text(
                tech,
                style: AppTheme.codeMedium.copyWith(
                  fontSize: 9,
                  color: AppTheme.primaryContainer,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFeaturesBlock(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// FEATURES',
          style: AppTheme.codeMedium.copyWith(
            fontSize: 11,
            color: AppTheme.primaryFixedDim,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.primaryContainer.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: project.features.map<Widget>((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '>>',
                      style: AppTheme.codeMedium.copyWith(
                        fontSize: 11,
                        color: AppTheme.primaryContainer,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: AppTheme.codeMedium.copyWith(
                          fontSize: 11,
                          color: AppTheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLinksBlock(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '          // DOWNLOADS',
          style: AppTheme.codeMedium.copyWith(
            fontSize: 11,
            color: AppTheme.primaryFixedDim,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            if (project.androidUrl != null)
              _linkButton(
                icon: Icons.android,
                label: 'android_build.apk',
                onTap: () => _launch(project.androidUrl!),
              ),
            if (project.iosUrl != null)
              _linkButton(
                icon: Icons.apple,
                label: 'ios_release.ipa',
                onTap: () => _launch(project.iosUrl!),
              ),
            if (project.webUrl != null)
              _linkButton(
                icon: Icons.public,
                label: 'web_deploy',
                onTap: () => _launch(project.webUrl!),
              ),
          ],
        ),
      ],
    );
  }

  Widget _linkButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.primaryContainer.withValues(alpha: 0.3)),
          color: AppTheme.primaryContainer.withValues(alpha: 0.08),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppTheme.primaryContainer),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTheme.codeMedium.copyWith(
                fontSize: 11,
                color: AppTheme.primaryContainer,
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
