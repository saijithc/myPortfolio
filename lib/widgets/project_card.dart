import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_theme.dart';
import '../views/project_details_page.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
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
                    color: AppTheme.neonGreen.withValues(alpha: 0.12),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
              child: Container(
                color: const Color(0xFF111111),
                width: double.infinity,
                height: isMobile ? 280 : 200,
                child: Stack(
                  children: [
                    Center(
                      child: project.imageUrl.isNotEmpty
                          ? Image.asset(
                              project.imageUrl,
                              fit: BoxFit.contain,
                              cacheWidth: 400,
                              errorBuilder: (context, error, stack) => Icon(
                                Icons.image_outlined,
                                size: 48,
                                color: AppTheme.neonGreen.withValues(
                                  alpha: 0.4,
                                ),
                              ),
                            )
                          : Icon(
                              Icons.image_outlined,
                              size: 48,
                              color: AppTheme.neonGreen.withValues(alpha: 0.4),
                            ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Text(
                          r'$ ./' +
                              project.title.toLowerCase().replaceAll(' ', '_'),
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 10,
                            color: AppTheme.textTertiary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 16 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r'$ ' + project.title,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: isMobile ? 15 : 16,
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      project.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const Spacer(),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: project.technologies.take(4).map<Widget>((
                        tech,
                      ) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
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
                              fontSize: 9,
                              color: AppTheme.neonGreen,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ProjectActionButton(
                          label: 'Details',
                          icon: Icons.terminal_rounded,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProjectDetailsPage(project: project),
                              ),
                            );
                          },
                        ),
                        if (project.githubUrl != null) ...[
                          const SizedBox(width: 8),
                          ProjectActionButton(
                            label: 'Code',
                            icon: Icons.code_rounded,
                            onTap: () => _launchUrl(project.githubUrl!),
                          ),
                        ],
                        const Spacer(),
                        if (project.androidUrl != null)
                          ProjectSmallIconButton(
                            icon: Icons.android,
                            onTap: () => _launchUrl(project.androidUrl!),
                          ),
                        if (project.iosUrl != null)
                          ProjectSmallIconButton(
                            icon: Icons.apple,
                            onTap: () => _launchUrl(project.iosUrl!),
                          ),
                        if (project.webUrl != null)
                          ProjectSmallIconButton(
                            icon: Icons.public,
                            onTap: () => _launchUrl(project.webUrl!),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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

class ProjectActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const ProjectActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<ProjectActionButton> createState() => _ProjectActionButtonState();
}

class _ProjectActionButtonState extends State<ProjectActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppTheme.neonGreen.withValues(alpha: 0.15)
                : AppTheme.neonGreen.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.neonGreen.withValues(alpha: 0.5)
                  : AppTheme.neonGreen.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 13, color: AppTheme.neonGreen),
              const SizedBox(width: 4),
              Text(
                widget.label,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: AppTheme.neonGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectSmallIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const ProjectSmallIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  State<ProjectSmallIconButton> createState() => _ProjectSmallIconButtonState();
}

class _ProjectSmallIconButtonState extends State<ProjectSmallIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(left: 4),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppTheme.neonGreen.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.neonGreen.withValues(alpha: 0.4)
                  : AppTheme.neonGreen.withValues(alpha: 0.15),
            ),
          ),
          child: Icon(
            widget.icon,
            size: 13,
            color: _isHovered ? AppTheme.neonGreen : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}
