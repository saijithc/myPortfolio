import 'url_opener/url_opener_stub.dart'
    if (dart.library.html) 'url_opener/url_opener_web.dart'
    if (dart.library.io) 'url_opener/url_opener_io.dart';

class UrlOpener {
  static Future<bool> open(String url, {String? webTarget}) {
    return openUrl(url, webTarget: webTarget);
  }
}
