import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryDark = Color(0xFF0A0A0A);
  static const Color secondaryDark = Color(0xFF1A1A1A);
  static const Color accentDark = Color(0xFF2A2A2A);
  
  static const Color neonGreen = Color(0xFF00FF88);
  static const Color neonGreenLight = Color(0xFF00FFAA);
  static const Color neonGreenDark = Color(0xFF00CC6A);
  
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF808080);
  
  static const Color errorColor = Color(0xFFFF4444);
  static const Color successColor = Color(0xFF00FF88);
  static const Color warningColor = Color(0xFFFFAA00);

  // Gradients
  static const LinearGradient neonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [neonGreen, neonGreenLight],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryDark, secondaryDark],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryDark, accentDark],
  );

  // Text Styles
  static TextStyle get headingLarge => GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    height: 1.2,
  );

  static TextStyle get headingMedium => GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    height: 1.3,
  );

  static TextStyle get headingSmall => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.4,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: textPrimary,
    height: 1.6,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textSecondary,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textTertiary,
    height: 1.4,
  );

  static TextStyle get buttonText => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: primaryDark,
    height: 1.2,
  );

  static TextStyle get neonText => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: neonGreen,
    height: 1.2,
  );

  // Theme Data
  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: primaryDark,
    
    colorScheme: const ColorScheme.dark(
      primary: neonGreen,
      secondary: neonGreenLight,
      surface: secondaryDark,
      background: primaryDark,
      error: errorColor,
      onPrimary: primaryDark,
      onSecondary: primaryDark,
      onSurface: textPrimary,
      onBackground: textPrimary,
      onError: textPrimary,
    ),

    textTheme: TextTheme(
      headlineLarge: headingLarge,
      headlineMedium: headingMedium,
      headlineSmall: headingSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: buttonText,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: headingSmall.copyWith(color: textPrimary),
      iconTheme: const IconThemeData(color: textPrimary),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: neonGreen,
        foregroundColor: primaryDark,
        textStyle: buttonText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 0,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: neonGreen,
        side: const BorderSide(color: neonGreen, width: 2),
        textStyle: neonText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),

    cardTheme: CardThemeData(
      color: secondaryDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: accentDark, width: 1),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: accentDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: neonGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor),
      ),
      labelStyle: bodyMedium.copyWith(color: textSecondary),
      hintStyle: bodyMedium.copyWith(color: textTertiary),
    ),

    dividerTheme: const DividerThemeData(
      color: accentDark,
      thickness: 1,
      space: 1,
    ),
  );

  // Box Decorations
  static BoxDecoration get neonCardDecoration => BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: accentDark, width: 1),
    boxShadow: [
      BoxShadow(
        color: neonGreen.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  );

  static BoxDecoration get neonGlowDecoration => BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: neonGreen.withOpacity(0.3), width: 1),
    boxShadow: [
      BoxShadow(
        color: neonGreen.withOpacity(0.2),
        blurRadius: 30,
        offset: const Offset(0, 12),
      ),
      BoxShadow(
        color: neonGreen.withOpacity(0.1),
        blurRadius: 60,
        offset: const Offset(0, 24),
      ),
    ],
  );

  static BoxDecoration get neonButtonDecoration => BoxDecoration(
    gradient: neonGradient,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: neonGreen.withOpacity(0.3),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  );

  // Animations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.elasticOut;
}
