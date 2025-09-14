import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/glow_card.dart';

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
          Text(
            'Services I Offer',
            style: (isMobile ? AppTheme.headingMedium : AppTheme.headingLarge)
                .copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Section Subtitle
          Text(
            'What I can do for your business',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.neonGreen,
              fontWeight: FontWeight.w600,
            ),
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

    if (isMobile) {
      // Mobile Layout - Single Column
      return Column(
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
          childAspectRatio: 1.0,
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
              child: Text(
                service.icon,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Service Title
          Text(
            service.title,
            style: AppTheme.headingSmall.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Service Description
          Text(
            service.description,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
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
                    child: Text(
                      feature,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          
          const Spacer(),
          
          // Learn More Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.neonGreen.withOpacity(0.3),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Learn More',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.neonGreen,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
