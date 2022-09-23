import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Privacy & Policy"),
        foregroundColor: Colors.red[500],
      ),
      body: const WebView(
        initialUrl: 'https://rapid.quizpe.in/privacy_policy',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
