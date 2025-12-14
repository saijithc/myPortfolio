// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:async';

Future<bool> openUrl(String url, {String? webTarget}) async {
  try {
    final target = webTarget ?? '_blank';
    final anchor = html.AnchorElement(href: url)
      ..target = target
      ..rel = 'noopener';
    // Programmatically trigger click for reliable navigation
    anchor.click();
    return true;
  } catch (_) {
    try {
      // Last resort: assign window location
      html.window.location.href = url;
      return true;
    } catch (_) {
      return false;
    }
  }
}


