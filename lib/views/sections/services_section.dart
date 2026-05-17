import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

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
          _SectionHeader(
            command: r'$ cat services.txt',
            subtitle: 'What I can do for your business',
            isMobile: isMobile,
          ),
          const SizedBox(height: 40),
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
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: services.map<Widget>((service) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _ServiceCard(service: service),
          );
        }).toList(),
      );
    } else {
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
          return _ServiceCard(service: services[index]);
        },
      );
    }
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
    final service = widget.service;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppTheme.neonGreen
                : AppTheme.neonGreen.withValues(alpha: 0.2),
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppTheme.neonGreen.withValues(alpha: 0.15),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.neonGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.neonGreen.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    service.icon,
                    style: GoogleFonts.jetBrainsMono(fontSize: 20),
                  ),
                ),
                const Spacer(),
                Text(
                  r'$',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    color: AppTheme.textTertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              service.title,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 15,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              service.description,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 12,
                color: AppTheme.textTertiary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            ...service.features.map<Widget>((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '> ',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        color: AppTheme.neonGreen,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        feature,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          color: AppTheme.textSecondary,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String command;
  final String subtitle;
  final bool isMobile;

  const _SectionHeader({
    required this.command,
    required this.subtitle,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: context.theme.secondaryDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.theme.neonGreen.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Text(
            command,
            style: context.theme.terminalText.copyWith(
              color: context.theme.textSecondary,
              fontSize: isMobile ? 13 : 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: context.theme.terminalText.copyWith(
              color: context.theme.neonGreen,
              fontSize: isMobile ? 16 : 20,
            ),
          ),
        ],
      ),
    );
  }
}
