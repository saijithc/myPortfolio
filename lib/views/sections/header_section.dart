import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';
import '../../widgets/typing_animation.dart';

class HeaderSection extends StatelessWidget {
  final ScrollController scrollController;
  
  const HeaderSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                    children: AppConstants.navigationItems.map<Widget>((item) {
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
          Flexible(
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
                        width: .6,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.neonGreen.withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile_image.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            size: 80,
                            color: AppTheme.neonGreen,
                          );
                        },
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
    // Calculate approximate scroll positions for each section
    double targetOffset = 0;
    final screenHeight = MediaQuery.of(context).size.height;
    
    switch (sectionName.toLowerCase()) {
      case 'home':
        targetOffset = 0;
        break;
      case 'about me':
        targetOffset = screenHeight * 0.8; // Header section height
             case 'achievements':
        targetOffset = screenHeight * 1.5;
        
        break;
      case 'skills':
        targetOffset = screenHeight * 2.2; // Header + About sections
        break;
      case 'services':
        targetOffset = screenHeight * 3.5; // Header + About + Skills sections
        break;
      case 'experience':
        targetOffset = screenHeight * 5.0; // Previous sections
        break;
      case 'projects':
        targetOffset = screenHeight * 6.5; // Previous sections
        break;
      case 'case studies':
        targetOffset = screenHeight * 6.5; // Same as projects
        break;
      case 'pricing':
        targetOffset = screenHeight * 8.0; // Previous sections
        break;
      case 'contact':
        targetOffset = screenHeight * 0.8; // Previous sections
        break;
      default:
        targetOffset = 0;
    }
    
    scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
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
          children: AppConstants.navigationItems.map<Widget>((item) {
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
