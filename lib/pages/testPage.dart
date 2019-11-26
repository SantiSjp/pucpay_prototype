import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class TestPage extends StatefulWidget {
  final String url;
  TestPage(this.url);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final Completer<WebViewController> _controller = 
  Completer<WebViewController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.url,
        onWebViewCreated: (WebViewController 
        webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  } 
}
