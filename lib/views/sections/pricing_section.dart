import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/glow_card.dart';
import '../../utils/text_utils.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        children: [
          // Section Title
          textCustom(
            text: 'Pricing Plans',
            color: context.theme.textPrimary,
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          // Section Subtitle
          textSemiBoldLarge(
            text: 'Choose the perfect plan for your project',
            color: context.theme.neonGreen,
            textAlign: TextAlign.center,
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
              decoration: BoxDecoration(
                gradient: context.theme.neonGradient,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Text(
                'Most Popular',
                style: context.theme.bodyMedium.copyWith(
                  color: context.theme.primaryDark,
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
                  style: context.theme.headingSmall.copyWith(
                    color: context.theme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // Plan Description
                Text(
                  plan.description,
                  style: context.theme.bodyMedium.copyWith(
                    color: context.theme.textSecondary,
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
                      style: context.theme.headingSmall.copyWith(
                        color: context.theme.neonGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      plan.price.toString(),
                      style: context.theme.headingLarge.copyWith(
                        color: context.theme.neonGreen,
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
                          decoration: BoxDecoration(
                            color: context.theme.neonGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: context.theme.primaryDark,
                            size: 14,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature,
                            style: context.theme.bodyMedium.copyWith(
                              color: context.theme.textSecondary,
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
                          ? context.theme.neonGreen
                          : context.theme.accentDark,
                      foregroundColor: plan.isPopular
                          ? context.theme.primaryDark
                          : context.theme.neonGreen,
                      side: plan.isPopular
                          ? null
                          : BorderSide(color: context.theme.neonGreen),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: plan.isPopular ? 8 : 0,
                    ),
                    child: Text(
                      plan.ctaText,
                      style: context.theme.buttonText.copyWith(
                        color: plan.isPopular
                            ? context.theme.primaryDark
                            : context.theme.neonGreen,
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
        backgroundColor: context.theme.secondaryDark,
        title: Text(
          'Selected: ${plan.name}',
          style: context.theme.headingSmall.copyWith(
            color: context.theme.textPrimary,
          ),
        ),
        content: Text(
          'Great choice! Let\'s discuss your project requirements.',
          style: context.theme.bodyMedium.copyWith(
            color: context.theme.textSecondary,
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
