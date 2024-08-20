import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(
                // 'https://qa-landing.novakidschool.com/h5p/wp-admin/admin-ajax.php?action=h5p_embed&id=8'
                'https://kvisaz.com'),
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
        ),
      ),
    );
  }
}
