import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/glow_card.dart';
import '../../utils/text_utils.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

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
          textCustom(
            text: 'Services I Offer',
            color: AppTheme.textPrimary,
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 20),
          
          // Section Subtitle
          textSemiBoldLarge(
            text: 'What I can do for your business',
            color: AppTheme.neonGreen,
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 60),
          
          // Services Grid
          Consumer<PortfolioViewModel>(
            builder: (context, viewModel, child) {
              return _buildServicesGrid(context, viewModel.services);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context, services) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    if (isMobile) {
      // Mobile Layout - Single Column
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: services.map<Widget>((service) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _buildServiceCard(service),
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
          childAspectRatio: 1.18, // Increased aspect ratio to reduce card height
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _buildServiceCard(services[index]);
        },
      );
    }
  }

  Widget _buildServiceCard(service) {
    return GlowCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Service Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.neonGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.neonGreen.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Center(
              child: textCustom(
                text: service.icon,
                color: AppTheme.neonGreen,
                fontSize: 28,
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Service Title
          textBoldDefault(
            text: service.title,
            color: AppTheme.textPrimary,
          ),
          
          const SizedBox(height: 12),
          
          // Service Description
          textRegularDefault(
            text: service.description,
            color: AppTheme.textSecondary,
          ),
          
          const SizedBox(height: 20),
          
          // Service Features
          ...service.features.map<Widget>((feature) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppTheme.neonGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: textRegularSmall(
                      text: feature,
                      color: AppTheme.textTertiary,
                    ),
                  ),
                ],
              ),
            );
          }),
          
          const SizedBox(height: 20),
          
          // Learn More Button
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.symmetric(vertical: 12),
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       color: AppTheme.neonGreen.withOpacity(0.3),
          //       width: 1,
          //     ),
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   child: textSemiBoldDefault(
          //     text: 'Learn More',
          //     color: AppTheme.neonGreen,
          //     textAlign: TextAlign.center,
          //   ),
          // ),
        ],
      ),
    );
  }
}
