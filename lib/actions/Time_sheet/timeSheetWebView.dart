import "package:vibeshr/untils/export_file.dart";
import 'package:webview_flutter/platform_interface.dart';

import 'webSiteView.dart';

class TimeSheetWebView extends StatefulWidget {
  String url;
  String name;
  TimeSheetWebView({super.key, required this.url, required this.name});

  @override
  State<TimeSheetWebView> createState() => _TimeSheetWebViewState();
}

class _TimeSheetWebViewState extends State<TimeSheetWebView> {
  @override
  void initState() {
    getPath();
    super.initState();
  }

  var path;
  getPath() async {
    path = await DownloadsPathProvider.downloadsDirectory;
  }

  //ScreenshotController screenshotController = ScreenshotController();
  WebViewController? controller;
  bool isNoDataFound = false;
  bool isDownloading = false;
  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VibhoAppBar(
        bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        //  Kwhite
        title: "Download Report",
        dontHaveBackAsLeading: false,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(15.r),
        child: CustomButton(
            //  margin: EdgeInsets.all(15),
            height: 38.h,
            width: 500,
            textColor: Kwhite,
            borderRadius: BorderRadius.circular(20.r),
            Color: KOrange,
            fontSize: 13.sp,
            fontWeight: kFW600,
            label:
                isDownloading == false ? "Download Report" : "Downloading...",
            isLoading: false,
            onTap: () async {
              setState(() {
                isDownloading = true;
              });
              var dir = await DownloadsPathProvider.downloadsDirectory;
              String savename = "${widget.name}.pdf";
              String savePath = "${dir!.path}/(1)$savename";

              if (dir != null) {
                // try {
                //   await screenshotController
                //       .capture()
                //       .then((capturedImage) async {
                //     // var imagePdf = await ImageToPdf.imageList(listOfFiles: [File.fromRawPath(capturedImage!)]);

                //     bool isExist = await io.File(savePath).exists();
                //     final image = pw.MemoryImage(capturedImage!);

                //     final pdf = pw.Document();
                //     pdf.addPage(
                //       pw.Page(
                //         build: (pw.Context context) => pw.Center(
                //           child: pw.Image(image),
                //         ),
                //       ),
                //     );

                //     int i = 0;
                //     if (isExist) {
                //       while (isExist) {
                //         i = i + 1;
                //         savePath = "${dir.path}/($i)$savename";
                //         isExist = await io.File(savePath).exists();
                //         io.File(savePath).existsSync();
                //       }
                //     }
                //     File f = File(savePath);
                //     final pdfBytes = await pdf.save();
                //     await f.writeAsBytes(pdfBytes.toList());
                //     // await f.writeAsBytes(capturedImage!);

                //     //   var filePath =
                //     //     await PspdfkitProcessor.instance.generatePdf(pages, tempDocumentPath);
                //     // await Pspdfkit.present(filePath!);
                //     // await f.writeAsBytes(imagePdf!);
                //     // ShowCapturedWidget(context, capturedImage!);
                //   }).catchError((onError) {
                //     print("Error was " + onError);
                //   });
                //   Fluttertoast.showToast(
                //     msg: "File is saved to $savePath",
                //   );
                //   openFileManager();
                //   setState(() {
                //     isDownloading = false;
                //   });
                // } on DioError catch (e) {
                //   print("error message is " + e.message);
                // }
                setState(() {
                  isDownloading = false;
                });
              }
            }),
      ),
      body: isLoding == false
          ?
          // Screenshot(
          //     controller: screenshotController,
          //     child:
          WebView(
              onWebViewCreated: (WebViewController webViewController) {
                // Get reference to WebView controller to access it globally
                controller = webViewController;
              },
              onPageStarted: (url) {
                debugPrint(widget.url);
              },
              onWebResourceError: (error) {
                debugPrint("----------------------------------------------");
                Get.back(result: {"error": "No Data Fount"});
                return;
              },
              onPageFinished: (url) async {
                debugPrint("finish ---------------${url}");
                // var data = await controller!.runJavascriptReturningResult("console.log(document.documentElement.innerHTML)");
                String data = await controller!.runJavascriptReturningResult(
                    "document.documentElement.innerHTML");
                if (data.contains("no data found") ||
                    data.contains("Call to undefined method") ||
                    data.contains("Exception")) {
                  setState(() {
                    isNoDataFound = false;
                    Get.back(result: {"error": "No Data Fount"});
                  });
                }
                // if(data.contains("no data found")){
                //   setState(() {
                //     isNoDataFound=false;
                //     Get.back(result: {"error":"No Data Fount"});
                //   });
                // }
              },
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.url,
              zoomEnabled: false,
              // javascriptChannels: Set.from([
              //   JavascriptChannel(
              //       name: 'Print',
              //       onMessageReceived: (JavascriptMessage message) {
              //         print(message.message);
              //       })
              // ]),
            )
          //)
          : const Center(
              child: SpinKitFadingCircle(
              color: KOrange,
              size: 15,
            )),
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(child: Image.memory(capturedImage)),
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No back history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (await webViewController.canGoForward()) {
              await webViewController.goForward();
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No forward history item')),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => webViewController.reload(),
        ),
      ],
    );
  }
}
