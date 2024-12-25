import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TermPolicyPage extends StatefulWidget {
  const TermPolicyPage({
    super.key,
    this.url = 'https://newwave.vn/vi/privacy-policy/',
  });

  final String url;

  @override
  State<TermPolicyPage> createState() => _TermPolicyPageState();
}

class _TermPolicyPageState extends State<TermPolicyPage> {
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    underPageBackgroundColor: Colors.white,
  );
  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = kIsWeb ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                unawaited(webViewController?.reload());
              } else if (defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.macOS) {
                unawaited(
                  webViewController?.loadUrl(
                    urlRequest: URLRequest(
                      url: await webViewController?.getUrl(),
                    ),
                  ),
                );
              }
            },
          );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Term & Policy'),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            initialSettings: settings,
            pullToRefreshController: pullToRefreshController,
            onWebViewCreated: (controller) async {
              webViewController = controller;
            },
            onLoadStop: (controller, url) async {
              unawaited(pullToRefreshController?.endRefreshing());
            },
            onReceivedError: (controller, request, error) {
              pullToRefreshController?.endRefreshing();
            },
          ),
        ],
      ),
    );
  }
}
