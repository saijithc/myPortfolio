import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

export 'app_theme_data.dart';

class AppTheme {
  static const Color surface = Color(0xFF050505);
  static const Color surfaceDim = Color(0xFF121414);
  static const Color surfaceBright = Color(0xFF383939);
  static const Color surfaceContainerLowest = Color(0xFF0d0e0f);
  static const Color surfaceContainerLow = Color(0xFF1a1c1c);
  static const Color surfaceContainer = Color(0xFF111111);
  static const Color surfaceContainerHigh = Color(0xFF292a2a);
  static const Color surfaceContainerHighest = Color(0xFF343535);
  static const Color background = Color(0xFF050505);

  static const Color onSurface = Color(0xFFe3e2e2);
  static const Color onSurfaceVariant = Color(0xFFe4beb1);
  static const Color outline = Color(0xFFab897d);
  static const Color outlineVariant = Color(0xFF5b4137);

  static const Color primary = Color(0xFFffb59a);
  static const Color onPrimary = Color(0xFF5a1b00);
  static const Color primaryContainer = Color(0xFFff5c00);
  static const Color onPrimaryContainer = Color(0xFF521800);
  static const Color primaryFixed = Color(0xFFffdbce);
  static const Color primaryFixedDim = Color(0xFFffb59a);

  static const Color secondary = Color(0xFFd3fbff);
  static const Color onSecondary = Color(0xFF00363a);
  static const Color secondaryContainer = Color(0xFF00eefc);
  static const Color onSecondaryContainer = Color(0xFF00686f);

  static const Color errorColor = Color(0xFFffb4ab);
  static const Color onError = Color(0xFF690005);
  static const Color errorContainer = Color(0xFF93000a);

  static Color neonBorderColor = primaryContainer.withValues(alpha: 0.3);
  static Color neonShadowColor = primaryContainer.withValues(alpha: 0.15);

  static BoxDecoration neonBorder({
    double radius = 12,
    Color? borderColor,
    Color? shadowColor,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: borderColor ?? primaryContainer.withValues(alpha: 0.3),
      ),
      boxShadow: [
        BoxShadow(
          color: shadowColor ?? primaryContainer.withValues(alpha: 0.15),
          blurRadius: 15,
        ),
      ],
    );
  }

  static BoxDecoration surfaceCard({
    double radius = 12,
    Color? bgColor,
    bool withBorder = true,
  }) {
    return BoxDecoration(
      color: bgColor ?? surfaceContainer,
      borderRadius: BorderRadius.circular(radius),
      border: withBorder
          ? Border.all(color: primaryContainer.withValues(alpha: 0.3))
          : null,
      boxShadow: [
        BoxShadow(
          color: primaryContainer.withValues(alpha: 0.15),
          blurRadius: 15,
        ),
      ],
    );
  }

  static TextStyle headingDisplay = GoogleFonts.hankenGrotesk(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: onSurface,
    height: 1.1,
    letterSpacing: -0.02,
  );

  static TextStyle headingLarge = GoogleFonts.hankenGrotesk(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: onSurface,
    height: 1.2,
  );

  static TextStyle headingMedium = GoogleFonts.hankenGrotesk(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: onSurface,
    height: 1.3,
  );

  static TextStyle bodyLarge = GoogleFonts.hankenGrotesk(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: onSurface,
    height: 1.6,
  );

  static TextStyle bodyMedium = GoogleFonts.hankenGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: onSurfaceVariant,
    height: 1.6,
  );

  static TextStyle codeMedium = GoogleFonts.jetBrainsMono(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: onSurfaceVariant,
    height: 1.5,
  );

  static TextStyle labelSmall = GoogleFonts.jetBrainsMono(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: onSurfaceVariant,
    height: 1,
    letterSpacing: 0.1,
  );

  static TextStyle terminalHeader = GoogleFonts.jetBrainsMono(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: primaryContainer,
    letterSpacing: 0.1,
    height: 1,
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.dark(
      primary: primaryContainer,
      onPrimary: onPrimaryContainer,
      primaryContainer: primaryContainer,
      surface: surface,
      error: errorColor,
      onError: onError,
      onSurface: onSurface,
    ),
    textTheme: TextTheme(
      displayLarge: headingDisplay,
      headlineLarge: headingLarge,
      headlineMedium: headingMedium,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      labelSmall: labelSmall,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: headingMedium,
      iconTheme: const IconThemeData(color: onSurface),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceContainerLowest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryContainer.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryContainer.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryContainer, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor),
      ),
      labelStyle: bodyMedium,
      hintStyle: codeMedium.copyWith(color: outline),
    ),
  );

  // Backward compat for old sections
  static const Color neonGreen = Color(0xFFFF5C00);
  static const Color neonGreenLight = Color(0xFFFF7A33);
  static const Color neonGreenDark = Color(0xFFCC4A00);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF808080);
  static const Color accentDark = Color(0xFF222222);
  static const Color successColor = Color(0xFF00FF88);
  static const Color warningColor = Color(0xFFFFAA00);
  static const Color primaryDark = Color(0xFF050505);
  static const Color secondaryDark = Color(0xFF111111);

  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.elasticOut;

  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF9F9F9),
    colorScheme: const ColorScheme.light(
      primary: neonGreenDark,
      onPrimary: Color(0xFFF9F9F9),
      surface: Color(0xFFFFFFFF),
    ),
  );
}
