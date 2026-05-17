// ignore_for_file: deprecated_member_use
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/foundation.dart';

Future<bool> downloadPdf(Uint8List bytes, String fileName) async {
  try {
    // Create a Blob from the bytes
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create an anchor element and trigger download
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName);
    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();

    // Clean up the object URL after a short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      html.Url.revokeObjectUrl(url);
    });

    return true;
  } catch (e) {
    debugPrint('Error downloading PDF on web: $e');
    return false;
  }
}
