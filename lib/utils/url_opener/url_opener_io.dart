import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openUrl(String url, {String? webTarget}) async {
  final uri = Uri.parse(url);
  try {
    if (await canLaunchUrl(uri)) {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok) {
        return await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
      return true;
    }
  } catch (_) {}
  return false;
}


