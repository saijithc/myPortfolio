import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';
import '../../widgets/typing_animation.dart';
import '../../utils/text_utils.dart';
import '../../view_models/portfolio_view_model.dart';

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
                textBoldDefault(
                  text: AppConstants.appName,
                  color: AppTheme.neonGreen,
                ),
                
                // Navigation Menu
                if (!isMobile) ...[
                  Row(
                    children: AppConstants.navigationItems.map<Widget>((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextButton(
                          onPressed: () => _scrollToSection(context, item),
                          child: textMediumDefault(
                            text: item,
                            color: AppTheme.textPrimary,
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
                  textCustom(
                    text: AppConstants.tagline,
                    color: AppTheme.textPrimary,
                    fontSize: isMobile ? 24 : 32,
                    fontWeight: FontWeight.bold,
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
                      () => _openEmailHireMe(),
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
                        () => _openEmailHireMe(),
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
        child: textBoldDefault(
          text: text,
          color: isPrimary ? AppTheme.primaryDark : AppTheme.neonGreen,
        ),
      ),
    );
  }

  void _scrollToSection(BuildContext context, String sectionName) {
    final viewModel = Provider.of<PortfolioViewModel>(context, listen: false);

    GlobalKey? key;
    switch (sectionName.toLowerCase()) {
      case 'home':
        key = viewModel.headerKey;
        break;
      case 'about me':
        key = viewModel.aboutKey;
        break;
      case 'achievements':
        key = viewModel.achievementsKey;
        break;
      case 'skills':
        key = viewModel.skillsKey;
        break;
      case 'services':
        key = viewModel.servicesKey;
        break;
      case 'experience':
        key = viewModel.experienceKey;
        break;
      case 'projects':
      case 'case studies':
        key = viewModel.projectsKey;
        break;
      case 'pricing':
        key = viewModel.pricingKey;
        break;
      case 'contact':
        key = viewModel.contactKey;
        break;
    }

    final targetContext = key?.currentContext;
    if (targetContext == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderObject = targetContext.findRenderObject();
      if (renderObject != null && renderObject.attached) {
        try {
          Scrollable.ensureVisible(
            targetContext,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
            alignment: 0.08,
          );
        } catch (_) {}
      }
    });
  }

  void _openLinkedIn(BuildContext context) async {
    final url = Uri.parse('https://${AppConstants.contactInfo.linkedin}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _openEmailHireMe() async {
    final email = 'saijith053@gmail.com';
    final subject = 'Interested in hiring you';
    final body = 'Hi Saijith,\n\nI came across your portfolio and would like to discuss an opportunity.\n\nThanks,\n';
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
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
              title: textRegularLarge(
                text: item,
                color: AppTheme.textPrimary,
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
