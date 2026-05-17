import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          colors: [Color(0xFF1A1A1A), Color(0xFF0A0A0A)],
        ),
      ),
      child: Column(
        children: [
          Text(
            r'$ cat contact.txt',
            style: context.theme.terminalText.copyWith(
              color: context.theme.textSecondary,
              fontSize: isMobile ? 13 : 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Get in touch',
            style: context.theme.terminalText.copyWith(
              color: context.theme.neonGreen,
              fontSize: isMobile ? 16 : 20,
            ),
          ),
          const SizedBox(height: 40),
          if (!isMobile) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildContactFooterItem(
                        context,
                        Icons.email,
                        AppConstants.contactInfo.email,
                        onTap: () =>
                            _launchEmail(AppConstants.contactInfo.email),
                      ),
                      const SizedBox(height: 8),
                      _buildContactFooterItem(
                        context,
                        Icons.code,
                        'GitHub',
                        onTap: () => _launchUrl(
                          'https://${AppConstants.contactInfo.github}',
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildContactFooterItem(
                        context,
                        Icons.work,
                        'LinkedIn',
                        onTap: () => _launchUrl(
                          'https://${AppConstants.contactInfo.linkedin}',
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildContactFooterItem(
                        context,
                        Icons.phone,
                        AppConstants.contactInfo.phone,
                        onTap: () =>
                            _launchPhone(AppConstants.contactInfo.phone),
                      ),
                      const SizedBox(height: 8),
                      _buildContactFooterItem(
                        context,
                        Icons.location_on,
                        AppConstants.contactInfo.location,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ] else ...[
            Column(
              children: [
                _buildContactFooterItem(
                  context,
                  Icons.email,
                  AppConstants.contactInfo.email,
                  onTap: () => _launchEmail(AppConstants.contactInfo.email),
                ),
                const SizedBox(height: 8),
                _buildContactFooterItem(
                  context,
                  Icons.phone,
                  AppConstants.contactInfo.phone,
                  onTap: () => _launchPhone(AppConstants.contactInfo.phone),
                ),
                const SizedBox(height: 8),
                _buildContactFooterItem(
                  context,
                  Icons.location_on,
                  AppConstants.contactInfo.location,
                ),
                const SizedBox(height: 8),
                _buildContactFooterItem(
                  context,
                  Icons.code,
                  'GitHub',
                  onTap: () =>
                      _launchUrl('https://${AppConstants.contactInfo.github}'),
                ),
                const SizedBox(height: 8),
                _buildContactFooterItem(
                  context,
                  Icons.work,
                  'LinkedIn',
                  onTap: () => _launchUrl(
                    'https://${AppConstants.contactInfo.linkedin}',
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 40),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  context.theme.neonGreen.withValues(alpha: 0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '© 2024 ${AppConstants.contactInfo.name}. All rights reserved.',
            style: context.theme.terminalText.copyWith(
              color: context.theme.textTertiary,
              fontSize: isMobile ? 11 : 13,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactFooterItem(
    BuildContext context,
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
            Icon(icon, color: context.theme.neonGreen, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.jetBrainsMono(
                  color: context.theme.textSecondary,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
