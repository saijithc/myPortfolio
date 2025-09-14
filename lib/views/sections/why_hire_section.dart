import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../widgets/animated_counter.dart';
import '../../widgets/glow_card.dart';

class WhyHireSection extends StatelessWidget {
  const WhyHireSection({super.key});

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
            'Why Hire Me?',
            style: (isMobile ? AppTheme.headingMedium : AppTheme.headingLarge)
                .copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Section Subtitle
          Text(
            'What sets me apart from others',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.neonGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 60),
          
          // Why Hire Cards
          _buildWhyHireCards(context),
        ],
      ),
    );
  }

  Widget _buildWhyHireCards(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    final reasons = [
      {
        'title': 'Higher Conversion',
        'description': 'Proven UI/UX business impact',
        'icon': '📈',
        'value': 150,
        'suffix': '%',
        'subtitle': 'Average conversion increase',
      },
      {
        'title': 'Organic Traffic Growth',
        'description': 'Adapted from your resume achievements',
        'icon': '🚀',
        'value': 200,
        'suffix': '%',
        'subtitle': 'Traffic growth achieved',
      },
      {
        'title': 'Top 5 Search Rankings',
        'description': 'SEO understanding + app optimization',
        'icon': '🎯',
        'value': 5,
        'suffix': '+',
        'subtitle': 'Search rankings achieved',
      },
    ];

    if (isMobile) {
      // Mobile Layout - Single Column
      return Column(
        children: reasons.map<Widget>((reason) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _buildWhyHireCard(reason),
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
          childAspectRatio: 1.0,
        ),
        itemCount: reasons.length,
        itemBuilder: (context, index) {
          return _buildWhyHireCard(reasons[index]);
        },
      );
    }
  }

  Widget _buildWhyHireCard(Map<String, dynamic> reason) {
    return GlowCard(
      padding: const EdgeInsets.all(24),
      isGlowing: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Text(
            reason['icon'],
            style: const TextStyle(fontSize: 48),
          ),
          
          const SizedBox(height: 20),
          
          // Animated Counter
          AnimatedCounter(
            value: reason['value'],
            suffix: reason['suffix'],
            textStyle: AppTheme.headingMedium.copyWith(
              color: AppTheme.neonGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Subtitle
          Text(
            reason['subtitle'],
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.neonGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Title
          Text(
            reason['title'],
            style: AppTheme.headingSmall.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 12),
          
          // Description
          Text(
            reason['description'],
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
