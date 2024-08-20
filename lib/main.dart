import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const SimpleWebViewApp());
}

class SimpleWebViewApp extends StatelessWidget {
  const SimpleWebViewApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple WebView',
      home: const WebViewScreen(),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

/** dont works in iframe or without it **/
class _WebViewScreenState extends State<WebViewScreen> {
  // HTML-контент с iframe
  final String htmlContentH5p = '''
  <!DOCTYPE html>
  <html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      body, html {
        height: 100%;
        margin: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #f0f0f0;
      }
      iframe {
        width: 80%;
        height: 80%;
        border: none;
      }
    </style>
  </head>
  <body>
    <iframe 
    allowfullscreen 
    allow="fullscreen; autoplay"
    src="https://qa-landing.novakidschool.com/h5p/wp-admin/admin-ajax.php?action=h5p_embed&id=8" />
  </body>
  </html>
  ''';

  final String htmlContentYoutube = '''
  <!DOCTYPE html>
  <html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      body, html {
        height: 100%;
        margin: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #f0f0f0;
      }
      iframe {
        width: 80%;
        height: 80%;
        border: none;
      }
    </style>
  </head>
  <body>
    <iframe 
    allowfullscreen 
    allow="fullscreen; autoplay"
    src="https://www.youtube.com/embed/dUsP6BdbDNM?autoplay=1&enablejsapi=1&origin=http%3A%2F%2Flocalhost%3A8083&widgetid=1" />
  </body>
  </html>
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialData: InAppWebViewInitialData(
            data: htmlContentYoutube,
            baseUrl: WebUri('https://qa-landing.novakidschool.com/'),
            mimeType: 'text/html',
            encoding: 'utf-8',
          ),
          // initialData: InAppWebViewInitialData(
          //   data: htmlContentH5p,
          //   baseUrl: WebUri('https://qa-landing.novakidschool.com/'),
          //   mimeType: 'text/html',
          //   encoding: 'utf-8',
          // ),
          // initialUrlRequest: URLRequest(
          //   url: WebUri(
          //       'https://qa-landing.novakidschool.com/h5p/wp-admin/admin-ajax.php?action=h5p_embed&id=8'
          //       // 'https://kvisaz.com'
          //       ),
          // ),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            mediaPlaybackRequiresUserGesture: false,
            useWideViewPort: true,
            loadWithOverviewMode: true,
            builtInZoomControls: true,
            domStorageEnabled: true,
            displayZoomControls: false,
            thirdPartyCookiesEnabled: true,
            allowsInlineMediaPlayback: true,
            allowsAirPlayForMediaPlayback: false,
            allowsPictureInPictureMediaPlayback: false,
          ),
          onPermissionRequest: (controller, requests) async {
            return PermissionResponse(
              resources: requests.resources,
              action: PermissionResponseAction.GRANT,
            );
          },
          onEnterFullscreen: (controller) {
            // Устанавливаем полноэкранный режим
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          },
          onExitFullscreen: (controller) {
            // Возвращаем стандартный режим
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
          },
        ),
      ),
    );
  }
}
