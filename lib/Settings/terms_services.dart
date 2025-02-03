// ignore_for_file: camel_case_types

import 'package:vibeshr/untils/export_file.dart';
import 'package:webview_flutter/webview_flutter.dart';

class teams_services extends StatefulWidget {
  const teams_services({super.key});

  @override
  State<teams_services> createState() => _teams_servicesState();
}

class _teams_servicesState extends State<teams_services> {
  // final String COMING = 'assets/images/comingsoon.svg';
  // bool _isLoading = true;
  // late PDFDocument document;

  // @override
  // void initState() {
  //   super.initState();
  //   loadDocument();
  // }

  // loadDocument() async {
  //   document = await PDFDocument.fromAsset('assets/pdf/terms.pdf');

  //   setState(() => _isLoading = false);
  // }
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
    return Scaffold(
      backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      appBar: VibhoAppBar(
        title: "Terms and Conditions",
        bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        dontHaveBackAsLeading: false,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: 'https://www.vibhohcm.com/terms-of-use.html',
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

      //      SfPdfViewer.asset(
      //   'assets/pdf/terms.pdf',
      // ),

      // SvgPicture.asset(
      //   COMING,
      //   height: double.infinity,
      //   width: double.infinity,
      //   fit: BoxFit.cover,
      // ),
    );
  }
}
