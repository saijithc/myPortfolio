import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/section_header.dart';

class NewServicesSection extends StatelessWidget {
  const NewServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBreakpoints.of(context);
    final isMobile = bp.isMobile;
    final isTablet = bp.isTablet;
    final horizontalPad = isMobile ? 16.0 : (isTablet ? 40.0 : 64.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPad,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TerminalHeader(command: 'cat services.txt'),
          Consumer<PortfolioViewModel>(
            builder: (context, viewModel, child) {
              final services = viewModel.services;
              final count = services.length;
              return ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 3),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: isMobile ? 1.5 : 1.8,
                    ),
                    itemCount: count,
                    itemBuilder: (_, i) => _ServiceCard(service: services[i]),
                  ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final dynamic service;
  const _ServiceCard({required this.service});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.service;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTheme.normalAnimation,
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryContainer.withValues(alpha: 0.5)
                : AppTheme.primaryContainer.withValues(alpha: 0.2),
          ),
          boxShadow: _isHovered
              ? [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.1), blurRadius: 12)]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(s.icon ?? '', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 12),
            Text(
              s.title,
              style: AppTheme.headingMedium.copyWith(
                fontSize: 13,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                s.description ?? '',
                style: AppTheme.codeMedium.copyWith(
                  fontSize: 10,
                  color: AppTheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
