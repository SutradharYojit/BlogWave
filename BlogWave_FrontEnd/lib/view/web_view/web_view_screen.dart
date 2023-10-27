import 'package:blogwave_frontend/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView({super.key, required this.webView});

  final WebViewData webView;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final WebViewController controller = WebViewController();
  ValueNotifier<bool> _loading = ValueNotifier(false);

  void load(BuildContext context) {
    controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {

            if (progress == 100) {
              _loading.value = true;
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
        ),
      )
      ..loadRequest(
        Uri.parse(widget.webView.url),
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
                  controller: controller,
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
