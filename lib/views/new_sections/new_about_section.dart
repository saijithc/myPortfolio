import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../constants/app_constants.dart';
import '../../widgets/section_header.dart';

class NewAboutSection extends StatelessWidget {
  const NewAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBreakpoints.of(context);
    final isMobile = bp.isMobile;
    final isTablet = bp.isTablet;
    final horizontalPad = isMobile ? 16.0 : (isTablet ? 40.0 : 64.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPad,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TerminalHeader(command: 'cat about.txt'),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: isMobile
                ? Column(
                    children: [
                      _aboutCard(),
                      const SizedBox(height: 16),
                      _decorativeAsset(),
                    ],
                  )
                : IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 3, child: _aboutCard()),
                        const SizedBox(width: 24),
                        Expanded(flex: 2, child: _decorativeAsset()),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _aboutCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryContainer.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.15), blurRadius: 15)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppTheme.primaryContainer.withValues(alpha: 0.2))),
            ),
            child: Text(
              '\$ cat about.txt',
              style: AppTheme.codeMedium.copyWith(fontSize: 12, color: AppTheme.primaryContainer),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppConstants.aboutSummary,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.onSurfaceVariant,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 20),
          _infoLine('>>', 'Backend: Firebase / Cloud Functions'),
          const SizedBox(height: 8),
          _infoLine('>>', 'Clean Architecture: MVVM / MVC'),
          const SizedBox(height: 8),
          _infoLine('>>', 'Performance: Render optimization & caching'),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: AppTheme.primaryContainer),
              const SizedBox(width: 8),
              Text(
                AppConstants.contactInfo.location,
                style: AppTheme.codeMedium.copyWith(color: AppTheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('_', style: TextStyle(color: AppTheme.primaryContainer, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _decorativeAsset() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryContainer.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.15), blurRadius: 15)],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              border: Border(bottom: BorderSide(color: AppTheme.primaryContainer.withValues(alpha: 0.2))),
            ),
            child: Text(
              'asset_06.log',
              style: AppTheme.codeMedium.copyWith(fontSize: 10, color: AppTheme.onSurfaceVariant),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(11),
              bottomRight: Radius.circular(11),
            ),
            child: Image.asset(
              'assets/images/decorative_1.png',
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (_, __, ___) => Container(
                height: 200,
                color: AppTheme.surfaceContainerLow,
                child: Icon(Icons.image, color: AppTheme.outline),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoLine(String prefix, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$prefix ', style: AppTheme.codeMedium.copyWith(color: AppTheme.primaryContainer)),
        Expanded(
          child: Text(text, style: AppTheme.codeMedium.copyWith(color: AppTheme.onSurfaceVariant)),
        ),
      ],
    );
  }
}
