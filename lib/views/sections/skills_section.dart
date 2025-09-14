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
    );
  }

  Widget _buildSkillsGrid(BuildContext context, PortfolioViewModel viewModel) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    
    final categories = viewModel.skillCategories;

    if (isMobile) {
      // Mobile Layout - Single Column
      return Column(
        children: categories.map<Widget>((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  category,
                  style: AppTheme.headingSmall.copyWith(
                    color: AppTheme.neonGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              ...viewModel.getSkillsByCategory(category).map<Widget>((skill) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildSkillCard(skill),
                );
              }),
              
              const SizedBox(height: 32),
            ],
          );
        }).toList(),
      );
    } else {
      // Desktop/Tablet Layout - Grid
      return Column(
        children: categories.map<Widget>((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  category,
                  style: AppTheme.headingSmall.copyWith(
                    color: AppTheme.neonGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 3 : 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.0,
                ),
                itemCount: viewModel.getSkillsByCategory(category).length,
                itemBuilder: (context, index) {
                  final skill = viewModel.getSkillsByCategory(category)[index];
                  return _buildSkillCard(skill);
                },
              ),
              
              const SizedBox(height: 40),
            ],
          );
        }).toList(),
      );
    }
  }

  Widget _buildSkillCard(skill) {
    return GlowCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
