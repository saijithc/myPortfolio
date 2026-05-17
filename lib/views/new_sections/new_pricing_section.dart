import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/section_header.dart';

class NewPricingSection extends StatelessWidget {
  const NewPricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBreakpoints.of(context);
    final isMobile = bp.isMobile;
    final isTablet = bp.isTablet;
    final double horizontalPad = isMobile ? 16.0 : (isTablet ? 40.0 : 64.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPad,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TerminalHeader(command: 'cat plans.txt'),
          Consumer<PortfolioViewModel>(
            builder: (context, viewModel, child) {
              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: isMobile
                    ? Column(
                        children: viewModel.pricingPlans.map<Widget>((plan) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _PricingCard(plan: plan),
                        )).toList(),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isTablet ? 2 : 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: isTablet ? 0.85 : 0.7,
                        ),
                        itemCount: viewModel.pricingPlans.length,
                        itemBuilder: (_, i) => _PricingCard(plan: viewModel.pricingPlans[i]),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PricingCard extends StatefulWidget {
  final dynamic plan;
  const _PricingCard({required this.plan});

  @override
  State<_PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<_PricingCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final plan = widget.plan;
    final isPopular = plan.isPopular;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTheme.normalAnimation,
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isPopular
                ? AppTheme.primaryContainer
                : AppTheme.primaryContainer.withValues(alpha: 0.2),
            width: isPopular ? 1.5 : 1,
          ),
          boxShadow: isPopular
              ? [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.2), blurRadius: 30)]
              : _isHovered
                  ? [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.08), blurRadius: 16)]
                  : [],
        ),
        child: Column(
          children: [
            if (isPopular)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(11), topRight: Radius.circular(11)),
                ),
                child: Text('MOST_STABLE', style: AppTheme.codeMedium.copyWith(fontSize: 10, color: AppTheme.onPrimaryContainer, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(plan.name.toUpperCase(), style: AppTheme.codeMedium.copyWith(fontSize: 12, color: isPopular ? AppTheme.primaryContainer : AppTheme.onSurfaceVariant)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(plan.currency, style: AppTheme.headingMedium.copyWith(color: AppTheme.onSurface)),
                        Text('${plan.price}', style: AppTheme.headingDisplay.copyWith(fontSize: 36, color: AppTheme.onSurface)),
                      ],
                    ),
                    const Spacer(),
                    ...plan.features.map<Widget>((f) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(Icons.check, size: 14, color: AppTheme.primaryContainer),
                            const SizedBox(width: 6),
                            Expanded(child: Text(f, style: AppTheme.codeMedium.copyWith(fontSize: 10, color: AppTheme.onSurfaceVariant))),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isPopular ? AppTheme.primaryContainer : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: isPopular ? null : Border.all(color: AppTheme.primaryContainer.withValues(alpha: 0.5)),
                        boxShadow: isPopular ? [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.3), blurRadius: 10)] : [],
                      ),
                      child: Text(
                        (plan.ctaText as String).toUpperCase(),
                        style: AppTheme.codeMedium.copyWith(
                          fontSize: 10,
                          color: isPopular ? AppTheme.onPrimaryContainer : AppTheme.primaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
