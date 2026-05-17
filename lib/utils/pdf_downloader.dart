import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'pdf_downloader_stub.dart'
    if (dart.library.html) 'pdf_downloader_web.dart'
    if (dart.library.io) 'pdf_downloader_io.dart';

Future<bool> downloadPdfFromAssets(String assetPath, String fileName) async {
  try {
    // Load the PDF asset as bytes
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();

    // Use platform-specific download implementation
    return downloadPdf(bytes, fileName);
  } catch (e) {
    debugPrint('Error downloading PDF: $e');
    return false;
  }
}
