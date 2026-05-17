import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
export 'package:google_fonts/google_fonts.dart';

/// A collection of styled text widgets with combinations of font sizes and weights.

// Font Sizes
const double fontSizeMicro = 12;
const double fontSizeSmall = 14;
const double fontSizeDefault = 16;
const double fontSizeLarge = 18;

// Font Weights
const FontWeight fontWeightRegular = FontWeight.w400;
const FontWeight fontWeightMedium = FontWeight.w500;
const FontWeight fontWeightSemiBold = FontWeight.w600;
const FontWeight fontWeightBold = FontWeight.w700;
const FontWeight fontWeightExtraBold = FontWeight.w800;
const FontWeight fontWeightBlack = FontWeight.w900;

// Utility function to create a text widget with Poppins (for headings)
Widget styledText({
  required String text,
  required Color color,
  double fontSize = fontSizeDefault,
  FontWeight fontWeight = fontWeightRegular,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) {
  return Text(
    text,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    style: GoogleFonts.poppins(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
    ),
  );
}

// Utility function to create body text with Inter (for body text)
Widget styledBodyText({
  required String text,
  required Color color,
  double fontSize = fontSizeDefault,
  FontWeight fontWeight = fontWeightRegular,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) {
  return Text(
    text,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    style: GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
    ),
  );
}

/// Text widget with font size 12 and weight Regular (w400) - Uses Inter for body text
Widget textRegularMicro({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledBodyText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeMicro,
  fontWeight: fontWeightRegular,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 14 and weight Regular (w400) - Uses Inter for body text
Widget textRegularSmall({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledBodyText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeSmall,
  fontWeight: fontWeightRegular,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 16 and weight Regular (w400) - Uses Inter for body text
Widget textRegularDefault({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledBodyText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeDefault,
  fontWeight: fontWeightRegular,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 18 and weight Regular (w400) - Uses Inter for body text
Widget textRegularLarge({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledBodyText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeLarge,
  fontWeight: fontWeightRegular,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 12 and weight Medium (w500)
Widget textMediumMicro({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  maxLines: maxLines,
  overflow: overflow,
  fontSize: fontSizeMicro,
  fontWeight: fontWeightMedium,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 14 and weight Medium (w500)
Widget textMediumSmall({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  maxLines: maxLines,
  overflow: overflow,
  fontSize: fontSizeSmall,
  fontWeight: fontWeightMedium,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 16 and weight Medium (w500)
Widget textMediumDefault({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeDefault,
  fontWeight: fontWeightMedium,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 18 and weight Medium (w500)
Widget textMediumLarge({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  maxLines: maxLines,
  overflow: overflow,
  fontSize: fontSizeLarge,
  fontWeight: fontWeightMedium,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 12 and weight SemiBold (w600)
Widget textSemiBoldMicro({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeMicro,
  fontWeight: fontWeightSemiBold,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 14 and weight SemiBold (w600)
Widget textSemiBoldSmall({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeSmall,
  fontWeight: fontWeightSemiBold,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 16 and weight SemiBold (w600)
Widget textSemiBoldDefault({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  maxLines: maxLines,
  overflow: overflow,
  fontSize: fontSizeDefault,
  fontWeight: fontWeightSemiBold,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 18 and weight SemiBold (w600)
Widget textSemiBoldLarge({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeLarge,
  fontWeight: fontWeightSemiBold,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 12 and weight Bold (w700)
Widget textBoldMicro({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeMicro,
  fontWeight: fontWeightBold,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 14 and weight Bold (w700)
Widget textBoldSmall({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeSmall,
  fontWeight: fontWeightBold,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 16 and weight Bold (w700)
Widget textBoldDefault({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  maxLines: maxLines,
  overflow: overflow,
  fontSize: fontSizeDefault,
  fontWeight: fontWeightBold,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 18 and weight Bold (w700)
Widget textBoldLarge({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeLarge,
  fontWeight: fontWeightBold,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 12 and weight ExtraBold (w800)
Widget textExtraBoldMicro({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  maxLines: maxLines,
  fontSize: fontSizeMicro,
  fontWeight: fontWeightExtraBold,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 14 and weight ExtraBold (w800)
Widget textExtraBoldSmall({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeSmall,
  fontWeight: fontWeightExtraBold,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 16 and weight ExtraBold (w800)
Widget textExtraBoldDefault({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeDefault,
  fontWeight: fontWeightExtraBold,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 18 and weight ExtraBold (w800)
Widget textExtraBoldLarge({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  maxLines: maxLines,
  overflow: overflow,
  fontSize: fontSizeLarge,
  fontWeight: fontWeightExtraBold,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 12 and weight Black (w900)
Widget textBlackMicro({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeMicro,
  fontWeight: fontWeightBlack,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 14 and weight Black (w900)
Widget textBlackSmall({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  maxLines: maxLines,
  overflow: overflow,
  fontSize: fontSizeSmall,
  fontWeight: fontWeightBlack,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 16 and weight Black (w900)
Widget textBlackDefault({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSizeDefault,
  fontWeight: fontWeightBlack,
  textAlign: textAlign,
  decoration: decoration,
);

/// Text widget with font size 18 and weight Black (w900)
Widget textBlackLarge({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  maxLines: maxLines,
  overflow: overflow,
  fontSize: fontSizeLarge,
  fontWeight: fontWeightBlack,
  textAlign: textAlign,
  decoration: decoration,
);

/// Custom text widget with configurable font size and weight
Widget textCustom({
  required String text,
  required Color color,
  TextAlign textAlign = TextAlign.start,
  double? fontSize,
  FontWeight? fontWeight,
  TextOverflow? overflow,
  int? maxLines,
  TextDecoration? decoration,
}) => styledText(
  text: text,
  color: color,
  overflow: overflow,
  maxLines: maxLines,
  fontSize: fontSize ?? fontSizeLarge,
  fontWeight: fontWeight ?? fontWeightBlack,
  textAlign: textAlign,
  decoration: decoration,
);
