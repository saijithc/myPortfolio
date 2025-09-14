import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';
import '../../widgets/animated_counter.dart';
import '../../widgets/glow_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
            'About Me',
            style: (isMobile ? AppTheme.headingMedium : AppTheme.headingLarge)
                .copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Section Subtitle
          Text(
            'Get to know me better',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.neonGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 60),
          
          // Content Row
          if (isMobile) ...[
            _buildMobileLayout(context),
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column - About Text
                Expanded(
                  flex: 2,
                  child: _buildAboutText(context),
                ),
                
                const SizedBox(width: 60),
                
                // Right Column - Contact Info
                Expanded(
                  flex: 1,
                  child: _buildContactInfo(context),
                ),
              ],
            ),
          ],
          
          const SizedBox(height: 80),
          
          // Achievement Counters
          _buildAchievementCounters(context),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildAboutText(context),
        const SizedBox(height: 40),
        _buildContactInfo(context),
      ],
    );
  }

  Widget _buildAboutText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.aboutSummary,
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.textSecondary,
            height: 1.6,
          ),
        ),
        
        const SizedBox(height: 30),
        
        // Location
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: AppTheme.neonGreen,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              AppConstants.contactInfo.location,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
 Widget _buildContactInfo(BuildContext context) {
    final contactInfo = AppConstants.contactInfo;
    
    return GlowCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: AppTheme.headingSmall.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 24),
          
          _buildContactItem(
            Icons.person,
            'Name',
            contactInfo.name,
          ),
          
          const SizedBox(height: 20),
          
          _buildContactItem(
            Icons.email,
            'Email',
            contactInfo.email,
            onTap: () => _launchEmail(contactInfo.email),
          ),
          
          const SizedBox(height: 20),
          
          _buildContactItem(
            Icons.phone,
            'Phone',
            contactInfo.phone,
            onTap: () => _launchPhone(contactInfo.phone),
          ),
          
          const SizedBox(height: 20),
          
          _buildContactItem(
            Icons.location_on,
            'Location',
            contactInfo.location,
          ),
          
          const SizedBox(height: 32),
          
          // Social Links
          Text(
            'Connect with me',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              _buildSocialButton(
                'GitHub',
                Icons.code,
                () => _launchUrl('https://${contactInfo.github}'),
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                'LinkedIn',
                Icons.work,
                () => _launchUrl('https://${contactInfo.linkedin}'),
              ),
            ],
          ),
        ],
      ),
    );
  }
 Widget _buildSocialButton(String label, IconData icon, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.neonGreen.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: AppTheme.neonGreen,
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.neonGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Widget _buildContactInfo(BuildContext context) {
  //   final contactInfo = AppConstants.contactInfo;
    
  //   return GlowCard(
  //     padding: const EdgeInsets.all(24),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Contact Information',
  //           style: AppTheme.headingSmall.copyWith(
  //             color: AppTheme.textPrimary,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
          
  //         const SizedBox(height: 24),
          
  //         _buildContactItem(
  //           Icons.person,
  //           'Name',
  //           contactInfo.name,
  //         ),
          
  //         const SizedBox(height: 16),
          
  //         _buildContactItem(
  //           Icons.email,
  //           'Email',
  //           contactInfo.email,
  //           onTap: () => _launchEmail(contactInfo.email),
  //         ),
          
  //         const SizedBox(height: 16),
          
  //         _buildContactItem(
  //           Icons.phone,
  //           'Phone',
  //           contactInfo.phone,
  //           onTap: () => _launchPhone(contactInfo.phone),
  //         ),
          
  //         const SizedBox(height: 16),
          
  //         _buildContactItem(
  //           Icons.location_on,
  //           'Location',
  //           contactInfo.location,
  //         ),
          
  //         const SizedBox(height: 24),
          
  //         // Social Links
  //         Row(
  //           children: [
  //             _buildSocialIcon(
  //               'GitHub',
  //               () => _launchUrl('https://${contactInfo.github}'),
  //             ),
  //             const SizedBox(width: 16),
  //             _buildSocialIcon(
  //               'LinkedIn',
  //               () => _launchUrl('https://${contactInfo.linkedin}'),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildContactItem(
    IconData icon,
    String label,
    String value, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.neonGreen,
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: onTap != null ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(
                Icons.open_in_new,
                color: AppTheme.neonGreen,
                size: 16,
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
          padding: const EdgeInsets.all(12),
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

  Widget _buildAchievementCounters(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final achievements = AppConstants.achievements;

    return Column(
      children: [
        Text(
          'My Achievements',
          style: AppTheme.headingSmall.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        const SizedBox(height: 40),
        
        if (isMobile) ...[
          // Mobile Layout - Single Column
          ...achievements.map<Widget>((achievement) => Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _buildAchievementCard(achievement),
          )),
        ] else ...[
          // Desktop Layout - Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 1.2,
            ),
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              return _buildAchievementCard(achievements[index]);
            },
          ),
        ],
      ],
    );
  }

  Widget _buildAchievementCard(achievement) {
    return GlowCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            achievement.icon,
            style: const TextStyle(fontSize: 32),
          ),
          
          const SizedBox(height: 16),
          
          AnimatedCounter(
            value: achievement.value,
            suffix: achievement.suffix,
            textStyle: AppTheme.headingMedium.copyWith(
              color: AppTheme.neonGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            achievement.title,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 4),
          
          Text(
            achievement.description,
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
