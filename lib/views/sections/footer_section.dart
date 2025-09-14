import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';

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
                // Logo and Description
                // Expanded(
                //   flex: 2,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         AppConstants.appName,
                //         style: AppTheme.headingSmall.copyWith(
                //           color: AppTheme.neonGreen,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       const SizedBox(height: 16),
                //       Text(
                //         AppConstants.aboutSummary,
                //         style: AppTheme.bodyMedium.copyWith(
                //           color: AppTheme.textSecondary,
                //           height: 1.6,
                //         ),
                //         maxLines: 5,
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ],
                //   ),
                // ),
                
                // const SizedBox(width: 60),
                
                // Quick Links
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Links',
                        style: AppTheme.bodyLarge.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...AppConstants.navigationItems.map<Widget>((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: InkWell(
                            onTap: () => _scrollToSection(context, item),
                            child: Text(
                              item,
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.textSecondary,
                              ),
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
                      Text(
                        'Contact Info',
                        style: AppTheme.bodyLarge.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
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
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // // Social Links
            // Row(
            //   children: [
            //     Text(
            //       'Follow me:',
            //       style: AppTheme.bodyMedium.copyWith(
            //         color: AppTheme.textPrimary,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //     const SizedBox(width: 16),
            //     _buildSocialIcon(
            //       'GitHub',
            //       () => _launchUrl('https://${AppConstants.contactInfo.github}'),
            //     ),
            //     const SizedBox(width: 16),
            //     _buildSocialIcon(
            //       'LinkedIn',
            //       () => _launchUrl('https://${AppConstants.contactInfo.linkedin}'),
            //     ),
            //   ],
            // ),
          ] else ...[
            // Mobile Footer
            Column(
              children: [
                // Logo and Description
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.appName,
                      style: AppTheme.headingSmall.copyWith(
                        color: AppTheme.neonGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppConstants.aboutSummary,
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Quick Links
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Links',
                      style: AppTheme.bodyLarge.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: AppConstants.navigationItems.map<Widget>((item) {
                        return InkWell(
                          onTap: () => _scrollToSection(context, item),
                          child: Text(
                            item,
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Contact Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Info',
                      style: AppTheme.bodyLarge.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
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
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Social Links
                // Row(
                //   children: [
                //     Text(
                //       'Follow me:',
                //       style: AppTheme.bodyMedium.copyWith(
                //         color: AppTheme.textPrimary,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //     const SizedBox(width: 16),
                //     _buildSocialIcon(
                //       'GitHub',
                //       () => _launchUrl('https://${AppConstants.contactInfo.github}'),
                //     ),
                //     const SizedBox(width: 16),
                //     _buildSocialIcon(
                //       'LinkedIn',
                //       () => _launchUrl('https://${AppConstants.contactInfo.linkedin}'),
                //     ),
                //   ],
                // ),
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
          Text(
            '© 2024 ${AppConstants.contactInfo.name}. All rights reserved.',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textTertiary,
            ),
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
              child: Text(
                text,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(String tooltip, VoidCallback onTap) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.neonGreen.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.code,
            color: AppTheme.neonGreen,
            size: 20,
          ),
        ),
      ),
    );
  }

  void _scrollToSection(BuildContext context, String sectionName) {
    // This will be implemented with scroll controllers
    debugPrint('Scrolling to: $sectionName');
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
