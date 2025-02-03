import 'package:vibeshr/untils/export_file.dart';
import 'package:webview_flutter/webview_flutter.dart';

class policy_view extends StatefulWidget {
  @override
  _policy_viewState createState() => _policy_viewState();
}

class _policy_viewState extends State<policy_view> {
  bool isLoading = true;

  late WebViewController webView;

  Future<bool> _onBack() async {
    var value = await webView.canGoBack();

    if (value) {
      await webView.goBack();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBack(),
      child: Scaffold(
        backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        appBar: VibhoAppBar(
          title: "Privacy Policy",
          bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
          dontHaveBackAsLeading: false,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              WebView(
                initialUrl: 'https://www.vibhohcm.com/privacy-policy.html',
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (url) {
                  setState(() {
                    isLoading = true;
                  });
                },
                onPageFinished: (status) {
                  setState(() {
                    isLoading = false;
                  });
                },
                onWebViewCreated: (WebViewController controller) {
                  webView = controller;
                },
              ),
              isLoading
                  ? Center(
                      child: SpinKitFadingCircle(
                      color: KOrange,
                      size: 50.sp,
                    ))
                  : Stack(),
            ],
          ),
        ),
      ),
    );
  }
}
//  import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

 

// class WebViewApp extends StatefulWidget {
//   const WebViewApp({super.key});

//   @override
//   State<WebViewApp> createState() => _WebViewAppState();
// }

// class _WebViewAppState extends State<WebViewApp> {
//   late final WebViewController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..loadRequest(
//         Uri.parse('https://flutter.dev'),
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter WebView'),
//       ),
//       body: WebViewWidget(
//         controller: controller,
//       ),
//     );
//   }
// }
// import 'package:webview_flutter/webview_flutter.dart';

// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// // #docregion platform_imports
// // Import for Android features.
// //import 'package:webview_flutter_android/webview_flutter_android.dart';
// // Import for iOS features.
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// class policy_view extends StatefulWidget {
//   const policy_view({super.key});

//   @override
//   State<policy_view> createState() => _policy_viewState();
// }

// class _policy_viewState extends State<policy_view> {
//   final String COMING = 'assets/images/comingsoon.svg';

//   late WebViewController _webViewController;
//   bool _isLoading = true;
//   late PDFDocument document;

//   @override
//   void initState() {
//     super.initState();
//     loadDocument();
//   }

//   loadDocument() async {
//     document = await PDFDocument.fromAsset('assets/pdf/policy.pdf');

//     setState(() => _isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Kwhite,
//         appBar: const VibhoAppBar(
//           title: "Privacy Policy",
//           bColor: Kwhite,
//           dontHaveBackAsLeading: false,
//         ),
//         body: WebView(
//           onWebViewCreated: (controller) {
//             // We are getting an instance of the controller in the callback
//             // So we take it assign it our late variable value
//             _webViewController = controller;
//           },
//           //  _isLoading == false
//           //     ? PDFViewer(
//           //         showIndicator: false,
//           //         showNavigation: false,
//           //         showPicker: false,
//           //         scrollDirection: Axis.vertical,
//           //         document: document,
//           //         zoomSteps: 2,
//           //       )
//           //     : const  SpinKitFadingCircle(
//           //         color: KOrange,
//           //         size: 25,
//           //       )
//         ));
//   }
// }
