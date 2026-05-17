import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/glow_card.dart';
import '../../utils/text_utils.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
          // Section Title
          textCustom(
            text: 'Get In Touch',
            color: context.theme.textPrimary,
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          // Section Subtitle
          textSemiBoldLarge(
            text: 'Let\'s discuss your project',
            color: context.theme.neonGreen,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 60),

          // Contact Content
          if (isMobile) ...[
            _buildMobileContactLayout(context),
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contact Info
                Expanded(flex: 1, child: _buildContactInfo(context)),

                const SizedBox(width: 60),

                // Contact Form
                Expanded(flex: 2, child: _buildContactForm(context)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMobileContactLayout(BuildContext context) {
    return Column(
      children: [
        _buildContactInfo(context),
        const SizedBox(height: 40),
        _buildContactForm(context),
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
          textBoldDefault(
            text: 'Contact Information',
            color: context.theme.textPrimary,
          ),

          const SizedBox(height: 24),

          _buildContactItem(context, Icons.person, 'Name', contactInfo.name),

          const SizedBox(height: 20),

          _buildContactItem(
            context,
            Icons.email,
            'Email',
            contactInfo.email,
            onTap: () => _launchEmail(contactInfo.email),
          ),

          const SizedBox(height: 20),

          _buildContactItem(
            context,
            Icons.phone,
            'Phone',
            contactInfo.phone,
            onTap: () => _launchPhone(contactInfo.phone),
          ),

          const SizedBox(height: 20),

          _buildContactItem(
            context,
            Icons.location_on,
            'Location',
            contactInfo.location,
          ),

          const SizedBox(height: 32),

          // Social Links
          textSemiBoldLarge(
            text: 'Connect with me',
            color: context.theme.textPrimary,
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              _buildSocialButton(
                context,
                'GitHub',
                Icons.code,
                () => _launchUrl('https://${contactInfo.github}'),
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                context,
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

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: context.theme.neonGreen, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textRegularSmall(
                    text: label,
                    color: context.theme.textTertiary,
                  ),
                  const SizedBox(height: 4),
                  textCustom(
                    text: value,
                    color: context.theme.textPrimary,
                    fontWeight: onTap != null
                        ? FontWeight.w500
                        : FontWeight.normal,
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(Icons.open_in_new, color: context.theme.neonGreen, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.theme.neonGreen.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: context.theme.neonGreen, size: 24),
              const SizedBox(height: 8),
              textMediumDefault(
                text: label,
                color: context.theme.neonGreen,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Consumer<PortfolioViewModel>(
      builder: (context, viewModel, child) {
        return GlowCard(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: viewModel.contactFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textBoldDefault(
                  text: 'Send me a message',
                  color: context.theme.textPrimary,
                ),

                const SizedBox(height: 24),

                // Name Field
                TextFormField(
                  controller: viewModel.nameController,
                  validator: viewModel.validateName,
                  decoration: const InputDecoration(
                    labelText: 'Your Name',
                    hintText: 'Enter your full name',
                  ),
                ),

                const SizedBox(height: 20),

                // Email Field
                TextFormField(
                  controller: viewModel.emailController,
                  validator: viewModel.validateEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter your email address',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 20),

                // Message Field
                TextFormField(
                  controller: viewModel.messageController,
                  validator: viewModel.validateMessage,
                  decoration: const InputDecoration(
                    labelText: 'Message',
                    hintText: 'Tell me about your project...',
                  ),
                  maxLines: 5,
                ),

                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: viewModel.isSubmittingContact
                        ? null
                        : viewModel.submitContactForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.theme.neonGreen,
                      foregroundColor: context.theme.primaryDark,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: viewModel.isSubmittingContact
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: context.theme.primaryDark,
                              strokeWidth: 2,
                            ),
                          )
                        : textBoldDefault(
                            text: 'Send Message',
                            color: context.theme.primaryDark,
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
