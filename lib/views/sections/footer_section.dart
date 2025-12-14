import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';
import '../../utils/text_utils.dart';
import '../../view_models/portfolio_view_model.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: 60,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A1A1A),
            Color(0xFF0A0A0A),
          ],
        ),
      ),
      child: Column(
        children: [
          if (!isMobile) ...[
            // Desktop Footer
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                // Quick Links
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textBoldLarge(
                        text: 'Quick Links',
                        color: AppTheme.textPrimary,
                      ),
                      const SizedBox(height: 16),
                      ...AppConstants.navigationItems.map<Widget>((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: InkWell(
                            onTap: () => _scrollToSection(context, item),
                            child: textRegularDefault(
                              text: item,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                
                const SizedBox(width: 40),
                
                // Contact Info
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textBoldLarge(
                        text: 'Contact Info',
                        color: AppTheme.textPrimary,
                      ),
                      const SizedBox(height: 16),
                      _buildContactFooterItem(
                        Icons.email,
                        AppConstants.contactInfo.email,
                        onTap: () => _launchEmail(AppConstants.contactInfo.email),
                      ),
                     
                     
                     
                      const SizedBox(height: 8),
                      _buildContactFooterItem(
                        Icons.work,
                        'LinkedIn',
                        onTap: () => _launchUrl('https://${AppConstants.contactInfo.linkedin}'),
                      ), const SizedBox(height: 8),
                      _buildContactFooterItem(
                        Icons.code,
                        'GitHub',
                        onTap: () => _launchUrl('https://${AppConstants.contactInfo.github}'),
                      ), const SizedBox(height: 8),
                      _buildContactFooterItem(
                        Icons.phone,
                        AppConstants.contactInfo.phone,
                        onTap: () => _launchPhone(AppConstants.contactInfo.phone),
                      ), const SizedBox(height: 8),
                      _buildContactFooterItem(
                        Icons.location_on,
                        AppConstants.contactInfo.location,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            
           
          ] else ...[
            // Mobile Footer
            Column(
              children: [
                
                // Contact Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textBoldLarge(
                      text: 'Contact Info',
                      color: AppTheme.textPrimary,
                    ),
                    const SizedBox(height: 16),
                    _buildContactFooterItem(
                      Icons.email,
                      AppConstants.contactInfo.email,
                      onTap: () => _launchEmail(AppConstants.contactInfo.email),
                    ),
                    const SizedBox(height: 8),
                    _buildContactFooterItem(
                      Icons.phone,
                      AppConstants.contactInfo.phone,
                      onTap: () => _launchPhone(AppConstants.contactInfo.phone),
                    ),
                    const SizedBox(height: 8),
                    _buildContactFooterItem(
                      Icons.location_on,
                      AppConstants.contactInfo.location,
                    ),
                    const SizedBox(height: 8),
                    _buildContactFooterItem(
                      Icons.code,
                      'GitHub',
                      onTap: () => _launchUrl('https://${AppConstants.contactInfo.github}'),
                    ),
                    const SizedBox(height: 8),
                    _buildContactFooterItem(
                      Icons.work,
                      'LinkedIn',
                      onTap: () => _launchUrl('https://${AppConstants.contactInfo.linkedin}'),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                 // Quick Links
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textBoldLarge(
                      text: 'Quick Links',
                      color: AppTheme.textPrimary,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: AppConstants.navigationItems.map<Widget>((item) {
                        return InkWell(
                          onTap: () => _scrollToSection(context, item),
                          child: textRegularDefault(
                            text: item,
                            color: AppTheme.textSecondary,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ],
          
          const SizedBox(height: 40),
          
          // Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppTheme.neonGreen.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Copyright
          textRegularDefault(
            text: '© 2024 ${AppConstants.contactInfo.name}. All rights reserved.',
            color: AppTheme.textTertiary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactFooterItem(
    IconData icon,
    String text, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.neonGreen,
              size: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: textRegularSmall(
                text: text,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _scrollToSection(BuildContext context, String sectionName) {
    final viewModel = context.read<PortfolioViewModel>();
    GlobalKey? targetKey;
    switch (sectionName) {
      case 'Home':
        targetKey = viewModel.headerKey;
        break;
      case 'About Me':
        targetKey = viewModel.aboutKey;
        break;
      case 'Achievements':
        targetKey = viewModel.achievementsKey;
        break;
      case 'Skills':
        targetKey = viewModel.skillsKey;
        break;
      case 'Services':
        targetKey = viewModel.servicesKey;
        break;
      case 'Experience':
        targetKey = viewModel.experienceKey;
        break;
      default:
        targetKey = viewModel.headerKey;
        break;
    }

    final targetContext = targetKey.currentContext;
    if (targetContext == null) return;
    // Defer to next frame and ensure the render object is still attached before scrolling
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderObject = targetContext.findRenderObject();
      if (renderObject != null && renderObject.attached) {
        try {
          Scrollable.ensureVisible(
            targetContext,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutCubic,
            alignment: 0.05,
          );
        } catch (_) {
          // No-op: target might have been disposed in the meantime (e.g., hot reload)
        }
      }
    });
  }

  void _launchEmail(String email) async {
    final url = Uri.parse('mailto:$email');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _launchPhone(String phone) async {
    final url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
