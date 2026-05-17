import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:my_portfolio/models/skill.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../utils/url_opener.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../utils/text_utils.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    // Slow, smooth infinite rotation
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? 20
            : isTablet
            ? 60
            : 80,
        vertical: isMobile ? 60 : 100,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isDesktop ? 1200 : double.infinity,
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
                    r'$ cat skills.txt',
                    style: context.theme.terminalText.copyWith(
                      color: context.theme.textSecondary,
                      fontSize: isMobile ? 13 : 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Technologies I work with',
                    style: context.theme.terminalText.copyWith(
                      color: context.theme.neonGreen,
                      fontSize: isMobile ? 16 : 20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Rotating Skills Orbit
            Consumer<PortfolioViewModel>(
              builder: (context, viewModel, child) {
                return _buildSkillsOrbit(context, viewModel);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsOrbit(BuildContext context, PortfolioViewModel viewModel) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    // Get all skills from all categories
    final allSkills = viewModel.skills;

    if (allSkills.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: textMediumLarge(
            text: "No skills to display.",
            color: context.theme.textSecondary,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Orbit layout with smooth rotation
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final centerSize = isMobile
            ? 120.0
            : isTablet
            ? 150.0
            : 180.0;
        final nodeSize = isMobile
            ? 44.0
            : isTablet
            ? 52.0
            : 60.0;

        // Safe distances
        final double maxAllowedRadius = (maxWidth / 2) - (nodeSize / 2) - 12;
        final double minClearRadius = (centerSize / 2) + (nodeSize / 2) + 12;

        // Mobile: single circle (all skills)
        // Web/Tablet: keep exactly 3 nodes in the inner circle when possible
        late final List<Skill> outerSkills;
        late final List<Skill> innerSkills;
        if (isMobile) {
          outerSkills = allSkills;
          innerSkills = const <Skill>[];
        } else {
          if (allSkills.length > 3) {
            // Put last 3 skills in the inner ring for balanced distribution
            outerSkills = allSkills.take(allSkills.length - 3).toList();
            innerSkills = allSkills.skip(allSkills.length - 3).toList();
          } else {
            outerSkills = allSkills;
            innerSkills = const <Skill>[];
          }
        }

        // Adapt node size and radii to keep comfortable spacing
        double nodeSizeOuter = nodeSize;
        double radiusOuter;
        double? radiusInner;

        if (isMobile) {
          // Aim for minimal angular spacing via chord length
          final int n = outerSkills.length.clamp(1, 99);
          // Reduce icon size if too many
          if (n > 10) {
            nodeSizeOuter = math.max(30.0, nodeSize - (n - 10) * 1.2);
          }
          final double minChord = nodeSizeOuter + 14.0; // desired gap
          final double sinVal = math.sin(math.pi / n);
          double requiredR = sinVal == 0
              ? maxAllowedRadius
              : (minChord / (2 * sinVal));
          requiredR = requiredR.isFinite ? requiredR : maxAllowedRadius;
          // Cap to bounds
          radiusOuter = requiredR.clamp(minClearRadius, maxAllowedRadius);
          // If still crowded due to cap, shrink icons to fit available chord
          final double capacityChord = 2 * radiusOuter * sinVal - 6.0;
          if (capacityChord < nodeSizeOuter) {
            nodeSizeOuter = capacityChord.clamp(26.0, nodeSizeOuter);
          }
        } else {
          // Web/Tablet: inner ring close to center, outer ring farther with clear separation
          radiusInner = (minClearRadius + 16.0).clamp(
            minClearRadius,
            maxAllowedRadius,
          );
          final double desiredGapRadial =
              nodeSize + 26.0; // space between rings
          radiusOuter = (radiusInner + desiredGapRadial).clamp(
            minClearRadius,
            maxAllowedRadius,
          );
          // If outer hits boundary, pull inner inward but keep above clear radius
          if (radiusOuter >= maxAllowedRadius - 0.1) {
            radiusInner = math.max(
              minClearRadius + 10.0,
              radiusOuter - (nodeSize + 22.0),
            );
          }
        }

        // Total height to ensure no overflow/clipping
        final ringExtent = isMobile
            ? radiusOuter
            : math.max(radiusOuter, radiusInner ?? radiusOuter);
        final totalHeight =
            centerSize + 2 * (ringExtent + (nodeSizeOuter / 2) + 12);

        return SizedBox(
          height: totalHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer orbit rotating clockwise
              AnimatedBuilder(
                animation: _rotationController,
                builder: (context, _) {
                  final angleOffset = _rotationController.value * 2 * math.pi;
                  return Stack(
                    alignment: Alignment.center,
                    children: List.generate(outerSkills.length, (index) {
                      final theta =
                          (index / outerSkills.length) * 2 * math.pi +
                          angleOffset;
                      final dx = radiusOuter * math.cos(theta);
                      final dy = radiusOuter * math.sin(theta);
                      return Transform.translate(
                        offset: Offset(dx, dy),
                        transformHitTests: true,
                        child: _buildSkillNode(
                          outerSkills[index],
                          nodeSizeOuter,
                        ),
                      );
                    }),
                  );
                },
              ),

              // Inner orbit rotating counter-clockwise (web/tablet only when items exceed outer ring capacity)
              if (!isMobile && innerSkills.isNotEmpty)
                AnimatedBuilder(
                  animation: _rotationController,
                  builder: (context, _) {
                    final innerRadius = radiusInner ?? (minClearRadius + 14.0);
                    final angleOffset =
                        -_rotationController.value * 2 * math.pi;
                    return Stack(
                      alignment: Alignment.center,
                      children: List.generate(innerSkills.length, (index) {
                        final theta =
                            (index / innerSkills.length) * 2 * math.pi +
                            angleOffset;
                        final dx = innerRadius * math.cos(theta);
                        final dy = innerRadius * math.sin(theta);
                        return Transform.translate(
                          offset: Offset(dx, dy),
                          transformHitTests: true,
                          child: _buildSkillNode(
                            innerSkills[index],
                            nodeSize * 0.88,
                          ),
                        );
                      }),
                    );
                  },
                ),

              // Center profile image on top (non-interactive) so skills never cover it
              IgnorePointer(
                ignoring: true,
                child: _buildCenterProfile(centerSize),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCenterProfile(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: context.theme.cardGradient,
        border: Border.all(
          color: context.theme.neonGreen.withValues(alpha: 0.4),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: context.theme.neonGreen.withValues(alpha: 0.15),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/profile_image.png',
          fit: BoxFit.cover,
          cacheWidth: 360,
          cacheHeight: 360,
        ),
      ),
    );
  }

  Widget _buildSkillNode(Skill skill, double size) {
    final String url =
        skill.learnMoreUrl ??
        'https://www.google.com/search?q=${Uri.encodeComponent(skill.name)}';
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Semantics(
        button: true,
        label: '${skill.name}, proficiency ${skill.proficiency} percent',
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) async {
            log('skill: ${skill.learnMoreUrl}');
            final ok = await UrlOpener.open(url, webTarget: '_blank');
            if (!ok && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Could not open the link.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: SizedBox(
            width: size + 40,
            height: size + 28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: context.theme.cardGradient,
                    border: Border.all(
                      color: context.theme.neonGreen.withValues(alpha: 0.35),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: context.theme.neonGreen.withValues(alpha: 0.18),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipOval(
                      child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        skill.imagePath,
                        color: (skill.shouldAddColor ?? false)
                            ? Colors.white
                            : null,
                        fit: BoxFit.contain,
                        cacheWidth: 120,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: size + 40,
                  child: textSemiBoldMicro(
                    text: skill.name,
                    color: context.theme.textPrimary,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
