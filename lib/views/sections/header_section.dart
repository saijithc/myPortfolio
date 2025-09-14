import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';
import '../../widgets/typing_animation.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Column(
        children: [
          // Navigation Bar
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 40,
              vertical: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Text(
                  AppConstants.appName,
                  style: AppTheme.headingSmall.copyWith(
                    color: AppTheme.neonGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                // Navigation Menu
                if (!isMobile) ...[
                  Row(
                    children: AppConstants.navigationItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextButton(
                          onPressed: () => _scrollToSection(context, item),
                          child: Text(
                            item,
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ] else ...[
                  IconButton(
                    onPressed: () => _showMobileMenu(context),
                    icon: const Icon(
                      Icons.menu,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Hero Content
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Image
                  Container(
                    width: isMobile ? 150 : 200,
                    height: isMobile ? 150 : 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.neonGreen,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.neonGreen.withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      backgroundColor: AppTheme.secondaryDark,
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: AppTheme.neonGreen,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Main Tagline
                  Text(
                    AppConstants.tagline,
                    style: (isMobile ? AppTheme.headingMedium : AppTheme.headingLarge)
                        .copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Animated Subtitle
                  TypingAnimation(
                    text: AppConstants.subtitle,
                    textStyle: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.neonGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // CTA Buttons
                  if (isMobile) ...[
                    _buildCTAButton(
                      context,
                      'Hire Me',
                      () => _scrollToSection(context, 'Contact'),
                      isPrimary: true,
                    ),
                    const SizedBox(height: 16),
                    _buildCTAButton(
                      context,
                      'Book a Meeting',
                      () => _openLinkedIn(context),
                      isPrimary: false,
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCTAButton(
                          context,
                          'Hire Me',
                          () => _scrollToSection(context, 'Contact'),
                          isPrimary: true,
                        ),
                        const SizedBox(width: 20),
                        _buildCTAButton(
                          context,
                          'Book a Meeting',
                          () => _openLinkedIn(context),
                          isPrimary: false,
                        ),
                      ],
                    ),
                  ],
                  
                  const SizedBox(height: 60),
                  
                  // Scroll Indicator
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppTheme.neonGreen,
                    size: 32,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButton(
    BuildContext context,
    String text,
    VoidCallback onPressed, {
    required bool isPrimary,
  }) {
    return SizedBox(
      width: ResponsiveBreakpoints.of(context).isMobile ? double.infinity : 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppTheme.neonGreen : Colors.transparent,
          foregroundColor: isPrimary ? AppTheme.primaryDark : AppTheme.neonGreen,
          side: isPrimary 
              ? null 
              : const BorderSide(color: AppTheme.neonGreen, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isPrimary ? 8 : 0,
        ),
        child: Text(
          text,
          style: AppTheme.buttonText.copyWith(
            color: isPrimary ? AppTheme.primaryDark : AppTheme.neonGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _scrollToSection(BuildContext context, String sectionName) {
    // This will be implemented with scroll controllers
    // For now, we'll just print the section name
    debugPrint('Scrolling to: $sectionName');
  }

  void _openLinkedIn(BuildContext context) async {
    final url = Uri.parse('https://${AppConstants.contactInfo.linkedin}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.secondaryDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppConstants.navigationItems.map((item) {
            return ListTile(
              title: Text(
                item,
                style: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _scrollToSection(context, item);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
