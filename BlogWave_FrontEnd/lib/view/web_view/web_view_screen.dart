import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../resources/resources.dart';

class WebView extends StatefulWidget {
  const WebView({super.key, required this.webView});

  final WebViewData webView;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final WebViewController controller = WebViewController(); // Web view controller to manage the web view
  ValueNotifier<bool> _loading = ValueNotifier(false); // Notifier for tracking loading progress

// Method to load the web view
  void load(BuildContext context) {
    controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Callback when the web view loading progress changes
            if (progress == 100) {
              _loading.value = true; // Set loading status to true when progress reaches 100%
            }
          },
          onPageStarted: (String url) {
            // Callback when a new page starts loading in the web view
          },
          onPageFinished: (String url) {
            // Callback when a page finishes loading in the web view
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.webView.url), // Load the web view with the provided URL
      );
  }


  @override
  void initState() {
    super.initState();
    load(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.webView.title),
      ),
      body: ValueListenableBuilder(
        valueListenable: _loading,
        builder: (context, value, child) {
          return value
              ? WebViewWidget(
            controller: controller, // Pass the WebViewController to the WebViewWidget
          )
              : const Center(
                  child: SpinKitWave(
                    color: ColorManager.blackColor,
                    size: 50.0,
                  ),
                );
        },
      ),
    );
  }
}

class WebViewData {
  WebViewData({
    required this.title,
    required this.url,
  });

  final String url;
  final String title;
}
