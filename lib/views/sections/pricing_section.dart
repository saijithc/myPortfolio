import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/glow_card.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

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
            'Pricing Plans',
            style: (isMobile ? AppTheme.headingMedium : AppTheme.headingLarge)
                .copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Section Subtitle
          Text(
            'Choose the perfect plan for your project',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.neonGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 60),
          
          // Pricing Cards
          Consumer<PortfolioViewModel>(
            builder: (context, viewModel, child) {
              return _buildPricingCards(context, viewModel.pricingPlans);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCards(BuildContext context, pricingPlans) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    if (isMobile) {
      // Mobile Layout - Single Column
      return Column(
        children: pricingPlans.map<Widget>((plan) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _buildPricingCard(context, plan),
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
          childAspectRatio: 0.8,
        ),
        itemCount: pricingPlans.length,
        itemBuilder: (context, index) {
          return _buildPricingCard(context, pricingPlans[index]);
        },
      );
    }
  }

  Widget _buildPricingCard(BuildContext context, plan) {
    return GlowCard(
      padding: const EdgeInsets.all(0),
      isGlowing: plan.isPopular,
      child: Column(
        children: [
          // Popular Badge
          if (plan.isPopular)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                gradient: AppTheme.neonGradient,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Text(
                'Most Popular',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.primaryDark,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          
          // Plan Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Plan Name
                Text(
                  plan.name,
                  style: AppTheme.headingSmall.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Plan Description
                Text(
                  plan.description,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 24),
                
                // Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      plan.currency,
                      style: AppTheme.headingSmall.copyWith(
                        color: AppTheme.neonGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      plan.price.toString(),
                      style: AppTheme.headingLarge.copyWith(
                        color: AppTheme.neonGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Features List
                ...plan.features.map<Widget>((feature) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: AppTheme.neonGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: AppTheme.primaryDark,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature,
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                
                const SizedBox(height: 32),
                
                // CTA Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _selectPlan(context, plan),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: plan.isPopular 
                          ? AppTheme.neonGreen 
                          : AppTheme.accentDark,
                      foregroundColor: plan.isPopular 
                          ? AppTheme.primaryDark 
                          : AppTheme.neonGreen,
                      side: plan.isPopular 
                          ? null 
                          : const BorderSide(color: AppTheme.neonGreen),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: plan.isPopular ? 8 : 0,
                    ),
                    child: Text(
                      plan.ctaText,
                      style: AppTheme.buttonText.copyWith(
                        color: plan.isPopular 
                            ? AppTheme.primaryDark 
                            : AppTheme.neonGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectPlan(BuildContext context, plan) {
    // Show a dialog or navigate to contact form
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.secondaryDark,
        title: Text(
          'Selected: ${plan.name}',
          style: AppTheme.headingSmall.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        content: Text(
          'Great choice! Let\'s discuss your project requirements.',
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Scroll to contact section
            },
            child: const Text('Contact Me'),
          ),
        ],
      ),
    );
  }
}
