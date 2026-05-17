import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';

extension ThemeContextExtension on BuildContext {
  AppThemeData get theme => AppThemeData(this);
}

class AppThemeData {
  final BuildContext context;
  AppThemeData(this.context);

  bool get isLight => Theme.of(context).brightness == Brightness.light;

  Color get primaryDark => Theme.of(context).scaffoldBackgroundColor;
  Color get secondaryDark => Theme.of(context).colorScheme.surface;
  Color get accentDark =>
      Theme.of(context).dividerTheme.color ?? AppTheme.accentDark;

  Color get neonGreen => Theme.of(context).colorScheme.primary;
  Color get neonGreenLight => Theme.of(context).colorScheme.secondary;
  Color get neonGreenDark => AppTheme.neonGreenDark;

  Color get textPrimary =>
      Theme.of(context).textTheme.bodyLarge?.color ?? AppTheme.textPrimary;
  Color get textSecondary =>
      Theme.of(context).textTheme.bodyMedium?.color ?? AppTheme.textSecondary;
  Color get textTertiary =>
      Theme.of(context).textTheme.bodySmall?.color ?? AppTheme.textTertiary;

  Color get errorColor => Theme.of(context).colorScheme.error;
  Color get successColor => AppTheme.successColor;
  Color get warningColor => AppTheme.warningColor;

  LinearGradient get neonGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [neonGreen, neonGreenLight],
  );

  LinearGradient get darkGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryDark, secondaryDark],
  );

  LinearGradient get cardGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryDark, accentDark],
  );

  BoxDecoration get neonCardDecoration => BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: accentDark, width: 1),
    boxShadow: [
      BoxShadow(
        color: neonGreen.withValues(alpha: 0.1),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  );

  BoxDecoration get neonGlowDecoration => BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: neonGreen.withValues(alpha: 0.3), width: 1),
    boxShadow: [
      BoxShadow(
        color: neonGreen.withValues(alpha: 0.2),
        blurRadius: 30,
        offset: const Offset(0, 12),
      ),
      BoxShadow(
        color: neonGreen.withValues(alpha: 0.1),
        blurRadius: 60,
        offset: const Offset(0, 24),
      ),
    ],
  );

  BoxDecoration get neonButtonDecoration => BoxDecoration(
    gradient: neonGradient,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: neonGreen.withValues(alpha: 0.3),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  );

  TextStyle get headingLarge => Theme.of(context).textTheme.headlineLarge!;
  TextStyle get headingMedium => Theme.of(context).textTheme.headlineMedium!;
  TextStyle get headingSmall => Theme.of(context).textTheme.headlineSmall!;
  TextStyle get bodyLarge => Theme.of(context).textTheme.bodyLarge!;
  TextStyle get bodyMedium => Theme.of(context).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(context).textTheme.bodySmall!;
  TextStyle get buttonText => Theme.of(context).textTheme.labelLarge!;
  TextStyle get terminalText => GoogleFonts.jetBrainsMono(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: neonGreen,
    height: 1.2,
  );
  TextStyle get neonText => terminalText;

  Duration get fastAnimation => AppTheme.fastAnimation;
  Duration get normalAnimation => AppTheme.normalAnimation;
  Duration get slowAnimation => AppTheme.slowAnimation;
  Curve get defaultCurve => AppTheme.defaultCurve;
  Curve get bounceCurve => AppTheme.bounceCurve;
}
