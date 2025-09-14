import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/glow_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
            'Work Experience',
            style: (isMobile ? AppTheme.headingMedium : AppTheme.headingLarge)
                .copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Section Subtitle
          Text(
            'My professional journey',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.neonGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 60),
          
          // Experience Timeline
          Consumer<PortfolioViewModel>(
            builder: (context, viewModel, child) {
              return _buildExperienceTimeline(context, viewModel.experiences);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceTimeline(BuildContext context, experiences) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Column(
      children: experiences.asMap().entries.map((entry) {
        final index = entry.key;
        final experience = entry.value;
        final isLast = index == experiences.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline Line
            if (!isMobile) ...[
              Column(
                children: [
                  // Timeline Dot
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppTheme.neonGreen,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.neonGreen.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  
                  // Timeline Line
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 100,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppTheme.accentDark,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                ],
              ),
              
              const SizedBox(width: 24),
            ],
            
            // Experience Card
            Expanded(
              child: _buildExperienceCard(experience),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildExperienceCard(experience) {
    return GlowCard(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company and Position
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.position,
                      style: AppTheme.headingSmall.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      experience.company,
                      style: AppTheme.bodyLarge.copyWith(
                        color: AppTheme.neonGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Duration Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.neonGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.neonGreen.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  '${experience.startDate} - ${experience.endDate ?? "Present"}',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.neonGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Responsibilities
          Text(
            'Key Responsibilities:',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 12),
          
          ...experience.responsibilities.map<Widget>((responsibility) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: const BoxDecoration(
                      color: AppTheme.neonGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      responsibility,
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          
          const SizedBox(height: 20),
          
          // Technologies Used
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: experience.technologies.map<Widget>((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.accentDark,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.neonGreen.withOpacity(0.2),
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
        ],
      ),
    );
  }
}
