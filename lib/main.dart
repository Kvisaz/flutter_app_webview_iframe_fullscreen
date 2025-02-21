import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:math';

const testUrl =
    'https://kvisaz.github.io/flutter_app_webview_iframe_fullscreen/index.html';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri(getCachebustedUrl(testUrl)),
            ),
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
            onReceivedError: (controller, request, error) {
              print(
                  "webview console error === ${error.type} ${error.description}");
            },
            onConsoleMessage: (controller, consoleMessage) {
              print("webview console === ${consoleMessage.message}");
            }),
      ),
    );
  }
}

String getCachebustedUrl(String originalUrl) {
  final random = Random();
  final randomNumber = random.nextInt(1000000);
  return '$originalUrl?cache_buster=$randomNumber';
}
