import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../constants/app_constants.dart';
import '../../utils/url_opener.dart';
import '../../utils/pdf_downloader.dart';

class NewFooterSection extends StatelessWidget {
  const NewFooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBreakpoints.of(context);
    final isMobile = bp.isMobile;
    final isTablet = bp.isTablet;
    final double horizontalPad = isMobile ? 16.0 : (isTablet ? 40.0 : 64.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPad,
        vertical: isMobile ? 40 : 60,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.primaryContainer.withValues(alpha: 0.1))),
      ),
      child: Column(
        children: [
          Text('\$ cat contact.txt', style: AppTheme.codeMedium.copyWith(fontSize: 11, color: AppTheme.primaryFixedDim)),
          const SizedBox(height: 16),
          Text(
            '© ${DateTime.now().year} ROOT_ACCESS_GRANTED // STACK: FLUTTER & FIREBASE',
            style: AppTheme.codeMedium.copyWith(fontSize: 10, color: AppTheme.outline),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FooterLink(
                label: 'GITHUB',
                url: 'https://${AppConstants.contactInfo.github}',
              ),
              const SizedBox(width: 24),
              _FooterLink(
                label: 'LINKEDIN',
                url: 'https://${AppConstants.contactInfo.linkedin}',
              ),
              const SizedBox(width: 24),
              if (AppConstants.contactInfo.instagram != null)
                _FooterLink(
                  label: 'INSTAGRAM',
                  url: 'https://${AppConstants.contactInfo.instagram}',
                ),
              const SizedBox(width: 24),
              _FooterResumeLink(),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final String url;
  const _FooterLink({required this.label, required this.url});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => UrlOpener.open(widget.url),
        child: Text(
          widget.label,
          style: AppTheme.codeMedium.copyWith(
            fontSize: 10,
            color: _isHovered ? AppTheme.secondaryContainer : AppTheme.outline,
          ),
        ),
      ),
    );
  }
}

class _FooterResumeLink extends StatefulWidget {
  const _FooterResumeLink();

  @override
  State<_FooterResumeLink> createState() => _FooterResumeLinkState();
}

class _FooterResumeLinkState extends State<_FooterResumeLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => downloadPdfFromAssets(
          'assets/pdf/Saijith C .pdf',
          'Saijith_C_Resume.pdf',
        ),
        child: Text(
          'RESUME',
          style: AppTheme.codeMedium.copyWith(
            fontSize: 10,
            color: _isHovered ? AppTheme.secondaryContainer : AppTheme.outline,
          ),
        ),
      ),
    );
  }
}
