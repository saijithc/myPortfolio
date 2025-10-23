import 'package:flutter/material.dart';
import 'package:my_portfolio/models/skill.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/glow_card.dart';
import '../../utils/text_utils.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : isTablet ? 60 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isDesktop ? 1200 : double.infinity,
        ),
        child: Column(
          children: [
          // Section Title
          textCustom(
            text: 'Skills & Expertise',
            color: AppTheme.textPrimary,
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 20),
          
          // Section Subtitle
          textSemiBoldLarge(
            text: 'Technologies I work with',
            color: AppTheme.neonGreen,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 60),
          
          // Skills Grid
          Consumer<PortfolioViewModel>(
            builder: (context, viewModel, child) {
              return _buildSkillsGrid(context, viewModel);
            },
          ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsGrid(BuildContext context, PortfolioViewModel viewModel) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    // Get all skills from all categories
    final allSkills = viewModel.skills;

    if (allSkills.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: textMediumLarge(
            text: "No skills to display.",
            color: AppTheme.textSecondary,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Grid Layout for all screen sizes
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate optimal columns based on available width
        double availableWidth = constraints.maxWidth;
        int crossAxisCount;

        if (isMobile) {
          crossAxisCount = 2; // Always 2 columns on mobile
        } else if (isTablet) {
          crossAxisCount = availableWidth > 600 ? 3 : 2;
        } else if (isDesktop) {
          if (availableWidth > 1200) {
            crossAxisCount = 5;
          } else if (availableWidth > 1000) {
            crossAxisCount = 4;
          } else if (availableWidth > 800) {
            crossAxisCount = 3;
          } else {
            crossAxisCount = 2;
          }
        } else {
          crossAxisCount = 2;
        }

        return Container(
          constraints: BoxConstraints(
            minHeight: 200,
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: isMobile ? 16 : isDesktop ? 32 : 24,
              mainAxisSpacing: isMobile ? 16 : isDesktop ? 32 : 24,
              childAspectRatio: isMobile ? 0.85 : 0.9, // Reduced aspect ratio to accommodate content
            ),
            itemCount: allSkills.length,
            itemBuilder: (context, index) {
              final skill = allSkills[index];
              return _buildSkillCard(skill);
            },
          ),
        );
      },
    );
  }
  Widget _buildSkillCard(Skill skill) {
    return GlowCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Skill Icon
          SizedBox(
            height: 42,
            width: 42,
            child: Image.asset(
              skill.imagePath,
              height: 42,
              width: 42,
              color: (skill.shouldAddColor ?? false) ? Colors.white : null,
              fit: BoxFit.contain,
            ),
          ),
        
          
          const SizedBox(height: 12),
          
          // Skill Name
          textSemiBoldDefault(
            text: skill.name,
            color: AppTheme.textPrimary,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 8),
          
          // Proficiency Bar
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.accentDark,
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: skill.proficiency / 100,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.neonGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 6),
          
          // Proficiency Percentage
          textMediumMicro(
            text: '${skill.proficiency}%',
            color: AppTheme.neonGreen,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 12),
          
          // Learn More Button
          if (skill.learnMoreUrl != null)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _launchUrl(skill.learnMoreUrl!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentDark,
                  foregroundColor: AppTheme.neonGreen,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(color: AppTheme.neonGreen.withOpacity(0.3)),
                  ),
                ),
                child: textSemiBoldMicro(
                  text: 'Learn More',
                  color: AppTheme.neonGreen,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
