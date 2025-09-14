import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/glow_card.dart';

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
          Text(
            'Skills & Expertise',
            style: (isMobile ? AppTheme.headingMedium : AppTheme.headingLarge)
                .copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Section Subtitle
          Text(
            'Technologies I work with',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.neonGreen,
              fontWeight: FontWeight.w600,
            ),
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
          child: Text(
            "No skills to display.",
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    if (isMobile) {
      // Mobile Layout - Single Column
      return Column(
        children: allSkills.map<Widget>((skill) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildSkillCard(skill),
          );
        }).toList(),
      );
    } else {
      // Desktop/Tablet/Web Layout - Grid
      return LayoutBuilder(
        builder: (context, constraints) {
          // Calculate optimal columns based on available width
          double availableWidth = constraints.maxWidth;
          int crossAxisCount;

          if (isTablet) {
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

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: isDesktop ? 32 : 24,
              mainAxisSpacing: isDesktop ? 32 : 24,
              childAspectRatio: 1.0,
            ),
            itemCount: allSkills.length,
            itemBuilder: (context, index) {
              final skill = allSkills[index];
              return _buildSkillCard(skill);
            },
          );
        },
      );
    }
  }
  Widget _buildSkillCard(skill) {
    return GlowCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Skill Icon
          Text(
            skill.icon,
            style: const TextStyle(fontSize: 32),
          ),
          
          const SizedBox(height: 16),
          
          // Skill Name
          Text(
            skill.name,
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 12),
          
          // Proficiency Bar
          Container(
            width: double.infinity,
            height: 6,
            decoration: BoxDecoration(
              color: AppTheme.accentDark,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: skill.proficiency / 100,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.neonGradient,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Proficiency Percentage
          Text(
            '${skill.proficiency}%',
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.neonGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
