import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:vibeshr/untils/export_file.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  ServiceController serviceController = Get.put(ServiceController());
  ScrollController _controller = ScrollController();

  List<ChatMessage> messages = [
    ChatMessage(
        messageContent:
            "Hi👋🏻 there! I am the VIBHOHCM Bot and I’m here to help you . Please choose the option which best describes your. ",
        messageType: "receiver"),
    ChatMessage(
        messageContent: "I Want To Apply For Leave",
        messageType: "option",
        identifier: 1),
    ChatMessage(
        messageContent: "Check Status Of Last Applied Leave",
        messageType: "option",
        identifier: 2),
    ChatMessage(
        messageContent: "How many leaves do i have?",
        messageType: "option",
        identifier: 3),
    ChatMessage(
        messageContent: "Payslip of this month",
        messageType: "option",
        identifier: 4),
    ChatMessage(
        messageContent: "Attendance report for this month",
        messageType: "option",
        identifier: 5),
    ChatMessage(
        messageContent: "Check In Today", messageType: "option", identifier: 6),
    ChatMessage(
        messageContent: "Check Out today",
        messageType: "option",
        identifier: 7),
  ];
  bool isSend = false;
  Map messageData = {};
  Future chatAPI(String message) async {
    setState(() {
      isSend = true;
    });
    Map data = await Services.chatWithBot(
        message: message, endpoint: KChatMessageAPIURL);
    messageData = data;
    try {
      if (messageData != {}) {
        setState(() {
          scrollToBottom();
          messages.add(ChatMessage(
              messageContent: messageData["data"]["choices"][0]["message"]
                  ["content"],
              messageType: "receiver"));
          scrollToBottom();
        });
      }
    } catch (e) {
      setState(() {
        scrollToBottom();
        messages.add(ChatMessage(
            messageContent: messageData["message"], messageType: "receiver"));
        scrollToBottom();
      });
    }
    // }
    setState(() {
      isSend = false;
    });
  }

  Future chatAPIOptions(Map payload) async {
    setState(() {
      isSend = true;
    });
    Map data = await Services.chatWithBot(
        message: payload, endpoint: KChatOptionsAPIURL);
    messageData = data;
    if (messageData != {}) {
      if (messageData["options"] == null) {
        if (messageData["widget"] != null) {
          setState(() {
            scrollToBottom();
            messages.add(ChatMessage(
                messageContent: messageData["message"],
                identifier: messageData["widget"] == "pdfviewer"
                    ? messageData["link"]
                    : messageData["identifier"],
                messageType: "widget",
                widget: messageData["widget"]));
            scrollToBottom();
          });
        } else {
          setState(() {
            scrollToBottom();
            messages.add(ChatMessage(
                messageContent: messageData["message"],
                messageType: "receiver"));
            scrollToBottom();
          });
        }
      } else {
        setState(() {
          scrollToBottom();
          for (int i = 0; i < messageData["options"].length; i++) {
            messages.add(ChatMessage(
                messageContent: messageData["options"][i]["value"],
                identifier: messageData["options"][i]["identifier"],
                messageType: "option"));
            scrollToBottom();
          }
        });
      }
    }
    // }
    setState(() {
      isSend = false;
    });
  }

  void scrollToBottom() {
    setState(() {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration:
            const Duration(milliseconds: 300), // You can adjust the duration
        curve: Curves.easeOut,
      );
    });
  }

  // String? pdfPath;
  // Future<void> downloadPDF(String pdfUrl) async {
  //   var dir = await DownloadsPathProvider.downloadsDirectory;
  //   final response = await http.get(Uri.parse("https://"+pdfUrl));
  //   if (response.statusCode == 200) {
  //     final bytes = response.bodyBytes;
  //     final pdfFileName = 'file.pdf'; // You can set any desired filename
  //     String savePath = '${dir!.path}/$pdfFileName';
  //     bool isExist = await io.File(savePath).exists();
  //     int i = 0;
  //     if (isExist) {
  //       while (isExist) {
  //         i = i + 1;
  //         savePath = "${dir.path}/($i)$pdfFileName";
  //         isExist = await io.File(savePath).exists();
  //         io.File(savePath).existsSync();
  //       }
  //     }
  //     final pdf = pw.Document();
  //     File f = File(savePath);
  //     final pdfBytes = await pdf.save();
  //     await f.writeAsBytes(pdfBytes.toList());

  //     // final pdfFile = await File(path);
  //     // if (pdfFile.existsSync()) {
  //     //   setState(() {
  //     //     pdfPath = pdfFile.path;
  //     //   });
  //     // }
  //   }
  // }

  String messageSending = "";
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          selectedTheme == "Lighttheme" ? Colors.grey.shade200 : Kthemeblack,

      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h), // here the desired height
          child: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: selectedTheme == "Lighttheme" ? kblack : Kwhite,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            // elevation: 8,
            backgroundColor:
                selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
            title: Padding(
              padding: const EdgeInsets.only(top: 2.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Chat with VIBHO",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: kFW800,
                      color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
                      //   KdarkText,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Your personal AI ChatBot",
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: kFW600,
                      color: selectedTheme == "Lighttheme"
                          ? KdarkText.withOpacity(0.8)
                          : Kwhite,
                      //   KdarkText,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          )),
      //  backgroundColor: Kbackground,
      // appBar: VibhoAppBar(
      //   bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      //   title: "Chat board",
      //   trailing: GestureDetector(
      //     onTap: () {
      //       Get.toNamed(KNotification);
      //     },
      //     child: Padding(
      //       padding: EdgeInsets.only(right: 15.w),
      //       child: Image.asset(
      //         UserSimplePreferences.getNotifications() == "0"
      //             ? "assets/images/notification_inactive.png"
      //             : "assets/images/bell.png",
      //         //  "assets/images/bell.png",
      //         width: 25,
      //       ),
      //     ),
      //   ),
      // ),
      body: Stack(
        children: <Widget>[
          Column(children: [
            Expanded(
              child: ListView.builder(
                controller: _controller,
                itemCount: messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 80.h),
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return messages[index].messageType == "widget"
                      ? messages[index].widget == "pdfviewer"
                          ? GestureDetector(
                              onTap: () async {
                                if (messages[index]
                                    .identifier
                                    .toString()
                                    .contains("https://")) {
                                  debugPrint(
                                      "Downwload payslip ${messages[index].identifier.toString().replaceAll("https://", "").trim()}");
                                  if (messages[index]
                                          .identifier
                                          .toString()
                                          .replaceAll("https://", "")
                                          .trim()
                                          .toString()
                                          .contains(".pdf") ==
                                      false) {
                                    Get.to(TimeSheetWebView(
                                      url: "https://" +
                                          messages[index]
                                              .identifier
                                              .toString()
                                              .replaceAll("https://", "")
                                              .trim(),
                                      name: "Payslip",
                                    ));
                                  } else {
                                    var dir = await DownloadsPathProvider
                                        .downloadsDirectory;
                                    String savename = "payslip.pdf";
                                    String savePath =
                                        "${dir!.path}/(1)$savename";
                                    bool isExist =
                                        await io.File(savePath).exists();
                                    int i = 0;
                                    if (isExist) {
                                      while (isExist) {
                                        i = i + 1;
                                        savePath = "${dir.path}/($i)$savename";
                                        isExist =
                                            await io.File(savePath).exists();
                                        io.File(savePath).existsSync();
                                      }
                                    }
                                    try {
                                      debugPrint("started downloading...");
                                      await Dio().download(
                                          "https://www.africau.edu/images/default/sample.pdf",
                                          savePath,
                                          onReceiveProgress: (received, total) {
                                        if (total != -1) {
                                          debugPrint((received / total * 100)
                                                  .toStringAsFixed(0) +
                                              "%");
                                          //you can build progressbar feature too
                                        }
                                      });
                                      debugPrint(
                                          "File is saved to download folder.");
                                    } on DioError catch (e) {
                                      print(e.message);
                                    }
                                  }
                                  // launchUrl(Uri.parse("https://${messages[index]
                                  //       .identifier
                                  //       .toString()
                                  //       .replaceAll("https://", "")
                                  //       .trim()}"));
                                  // }
                                }
                                if (messages[index]
                                    .identifier
                                    .toString()
                                    .contains("http://")) {
                                  debugPrint(
                                      "Downwload payslip ${messages[index].identifier.toString().replaceAll("http://", "").trim()}");
                                  if (await canLaunchUrl(Uri.parse(
                                      messages[index]
                                          .identifier
                                          .toString()
                                          .replaceAll("https://", "")
                                          .trim()))) {
                                    await launchUrl(Uri.parse(messages[index]
                                        .identifier
                                        .toString()
                                        .replaceAll("https://", "")
                                        .trim()));
                                  }
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.r, top: 2.r),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 270.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13.r),
                                      color: Kwhite,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      messages[index].messageContent!,
                                      style: GoogleFonts.inter(
                                          letterSpacing: 0.2,
                                          wordSpacing: 0.1,
                                          fontSize: 11.sp,
                                          fontWeight: kFW700,
                                          color: KOrange),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          // background: white,
                                          primary: KOrange,
                                          //onPrimary: white,
                                          onSurface: Colors.black,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                           // primary: Kbluedark,
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (picked != null) {
                                  setState(() {
                                    messages.add(ChatMessage(
                                        messageContent: picked.toString(),
                                        messageType: "sender"));
                                    scrollToBottom();
                                    chatAPIOptions({
                                      "identifier": messages[index].identifier,
                                      "value": picked.toString()
                                    });
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.r, top: 2.r),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 270.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13.r),
                                      color: Kwhite,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      messages[index].messageContent!,
                                      style: GoogleFonts.inter(
                                          letterSpacing: 0.2,
                                          wordSpacing: 0.1,
                                          fontSize: 11.sp,
                                          fontWeight: kFW700,
                                          color: KOrange),
                                    ),
                                  ),
                                ),
                              ),
                            )
                      : messages[index].messageType == "option"
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  messages.add(ChatMessage(
                                      messageContent:
                                          messages[index].messageContent,
                                      messageType: "sender"));
                                  scrollToBottom();
                                  chatAPIOptions({
                                    "identifier": messages[index].identifier,
                                    "value": messages[index].messageContent
                                  });
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.r, top: 2.r),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 270.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13.r),
                                      color: Kwhite,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      messages[index].messageContent!,
                                      style: GoogleFonts.inter(
                                          letterSpacing: 0.2,
                                          wordSpacing: 0.1,
                                          fontSize: 11.sp,
                                          fontWeight: kFW700,
                                          color: KOrange),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              // margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(6),

                              child: Align(
                                alignment:
                                    (messages[index].messageType == "receiver"
                                        ? Alignment.topLeft
                                        : Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: messages[index].messageType ==
                                            "receiver"
                                        ? BorderRadius.only(
                                            bottomRight: Radius.circular(20.r),
                                            topLeft: Radius.circular(20.r),
                                            topRight: Radius.circular(20.r))
                                        : BorderRadius.only(
                                            bottomLeft: Radius.circular(20.r),
                                            topLeft: Radius.circular(20.r),
                                            topRight: Radius.circular(20.r)),
                                    color: (messages[index].messageType ==
                                            "receiver"
                                        ? Kwhite
                                        : KOrange.withOpacity(0.9)),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    messages[index].messageContent!,
                                    style: TextStyle(
                                        letterSpacing: 0.5,
                                        wordSpacing: 1,
                                        fontSize: 11.sp,
                                        fontWeight: kFW700,
                                        color: messages[index].messageType ==
                                                "receiver"
                                            ? KdarkText
                                            : Kwhite),
                                  ),
                                ),
                              ),
                            );
                },
              ),
            ),
            SizedBox(
              height: 70.h,
            )
          ]),
          isSend == false
              ? const SizedBox()
              : const Align(
                  alignment: Alignment.bottomLeft,
                  child: SpinKitThreeBounce(
                    color: KOrange,
                    size: 30.0,
                  ),
                ),
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Container(
          //     margin: EdgeInsets.all(10.r),
          //     padding: const EdgeInsets.all(10),
          //     height: 60,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(13.r),
          //         //color: KOrange.withOpacity(0.3),
          //         color: Klightpink),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         // GestureDetector(
          //         //   onTap: () {},
          //         //   child: Container(
          //         //     height: 30,
          //         //     width: 30,
          //         //     decoration: BoxDecoration(
          //         //       color: Colors.lightBlue,
          //         //       borderRadius: BorderRadius.circular(30),
          //         //     ),
          //         //     child: const Icon(
          //         //       Icons.add,
          //         //       color: Colors.white,
          //         //       size: 20,
          //         //     ),
          //         //   ),
          //         // ),
          //         const SizedBox(
          //           width: 5,
          //         ),
          //         Expanded(
          //           child: TextField(
          //             controller: serviceController.message,
          //             onChanged: (value) {
          //               setState(() {
          //                 messageSending = value;
          //               });
          //             },
          //             decoration: InputDecoration(
          //                 hintText: "Send message........",
          //                 hintStyle: TextStyle(
          //                     color: KdarkText.withOpacity(0.8),
          //                     fontSize: 13.sp,
          //                     fontWeight: kFW500),
          //                 border: InputBorder.none),
          //           ),
          //         ),
          //         const SizedBox(
          //           width: 15,
          //         ),
          //         FloatingActionButton(
          //           onPressed: () {
          //             setState(() {
          //               messages.add(ChatMessage(
          //                   messageContent: serviceController.message.text,
          //                   messageType: "sender"));
          //               messageSending = serviceController.message.text;
          //               serviceController.message.clear();
          //               FocusManager.instance.primaryFocus?.unfocus();
          //               chatAPI(messageSending);
          //             });
          //           },
          //           child: Icon(
          //             Icons.send,
          //             color: Kwhite,
          //             size: 18,
          //           ),
          //           backgroundColor: KOrange,
          //           elevation: 10,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      bottomSheet: BottomSheet(
        backgroundColor:
            selectedTheme == "Lighttheme" ? Colors.grey.shade200 : Kthemeblack,
        onClosing: () {},
        builder: (context) {
          return Container(
            margin: EdgeInsets.all(10.r),
            padding: const EdgeInsets.all(10),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.r),
                //color: KOrange.withOpacity(0.3),

                boxShadow: [
                  BoxShadow(
                    color: selectedTheme == "Lighttheme"
                        ? Ktextcolor.withOpacity(0.5)
                        : Colors.transparent,
                    blurRadius: 5,
                    offset: const Offset(0, 7),
                    spreadRadius: 2,
                  )
                ],
                color: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // GestureDetector(
                //   onTap: () {},
                //   child: Container(
                //     height: 30,
                //     width: 30,
                //     decoration: BoxDecoration(
                //       color: Colors.lightBlue,
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //     child: const Icon(
                //       Icons.add,
                //       color: Colors.white,
                //       size: 20,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextField(
                    controller: serviceController.message,
                    onChanged: (value) {
                      setState(() {
                        messageSending = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Send message........",
                        hintStyle: TextStyle(
                            color: selectedTheme == "Lighttheme"
                                ? KdarkText.withOpacity(0.5)
                                : Kwhite,
                            fontSize: 13.sp,
                            fontWeight: kFW700),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      messages.add(ChatMessage(
                          messageContent: serviceController.message.text,
                          messageType: "sender"));
                      scrollToBottom();
                      messageSending = serviceController.message.text;
                      serviceController.message.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                      chatAPI(messageSending);
                    });
                  },
                  child: Image.asset(
                    "assets/images/tele.png",
                    height: 25,
                  ),
                  // Icon(
                  //   Icons.send,
                  //   color: Kwhite,
                  //   size: 18,
                  // ),
                  backgroundColor: KOrange,
                  elevation: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ChatMessage {
  String? messageContent;
  String? messageType;
  dynamic identifier;
  dynamic widget;
  ChatMessage(
      {@required this.messageContent,
      @required this.messageType,
      this.identifier,
      this.widget});
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({
    super.key,
    this.showIndicator = false,
    this.bubbleColor = KOrange,
    this.flashingCircleDarkColor = Kwhite,
    this.flashingCircleBrightColor = Ktextcolor,
  });

  final bool showIndicator;
  final Color bubbleColor;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _appearanceController;

  late Animation<double> _indicatorSpaceAnimation;

  late Animation<double> _smallBubbleAnimation;
  late Animation<double> _mediumBubbleAnimation;
  late Animation<double> _largeBubbleAnimation;

  late AnimationController _repeatingController;
  final List<Interval> _dotIntervals = const [
    Interval(0.25, 0.8),
    Interval(0.35, 0.9),
    Interval(0.45, 1.0),
  ];

  @override
  void initState() {
    super.initState();

    _appearanceController = AnimationController(
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _indicatorSpaceAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ).drive(Tween<double>(
      begin: 0.0,
      end: 60.0,
    ));

    _smallBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    );
    _mediumBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.2, 0.6, curve: Curves.easeOut),
    );
    _largeBubbleAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeOut),
    );

    _repeatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    if (widget.showIndicator) {
      _showIndicator();
    }
  }

  @override
  void didUpdateWidget(TypingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showIndicator != oldWidget.showIndicator) {
      if (widget.showIndicator) {
        _showIndicator();
      } else {
        _hideIndicator();
      }
    }
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    _repeatingController.dispose();
    super.dispose();
  }

  void _showIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 750)
      ..forward();
    _repeatingController.repeat();
  }

  void _hideIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 150)
      ..reverse();
    _repeatingController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _indicatorSpaceAnimation,
      builder: (context, child) {
        return SizedBox(
          height: _indicatorSpaceAnimation.value,
          child: child,
        );
      },
      child: Stack(
        children: [
          AnimatedBubble(
            animation: _smallBubbleAnimation,
            left: 6,
            bottom: 6,
            bubble: CircleBubble(
              size: 6,
              bubbleColor: widget.bubbleColor,
            ),
          ),
          AnimatedBubble(
            animation: _mediumBubbleAnimation,
            left: 10,
            bottom: 10,
            bubble: CircleBubble(
              size: 16,
              bubbleColor: widget.bubbleColor,
            ),
          ),
          AnimatedBubble(
            animation: _largeBubbleAnimation,
            left: 12,
            bottom: 12,
            bubble: StatusBubble(
              repeatingController: _repeatingController,
              dotIntervals: _dotIntervals,
              flashingCircleDarkColor: widget.flashingCircleDarkColor,
              flashingCircleBrightColor: widget.flashingCircleBrightColor,
              bubbleColor: widget.bubbleColor,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedBubble extends StatelessWidget {
  const AnimatedBubble({
    super.key,
    required this.animation,
    required this.left,
    required this.bottom,
    required this.bubble,
  });

  final Animation<double> animation;
  final double left;
  final double bottom;
  final Widget bubble;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      bottom: bottom,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.scale(
            scale: animation.value,
            alignment: Alignment.bottomLeft,
            child: child,
          );
        },
        child: bubble,
      ),
    );
  }
}

class StatusBubble extends StatelessWidget {
  const StatusBubble({
    super.key,
    required this.repeatingController,
    required this.dotIntervals,
    required this.flashingCircleBrightColor,
    required this.flashingCircleDarkColor,
    required this.bubbleColor,
  });

  final AnimationController repeatingController;
  final List<Interval> dotIntervals;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;
  final Color bubbleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        color: bubbleColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FlashingCircle(
            index: 0,
            repeatingController: repeatingController,
            dotIntervals: dotIntervals,
            flashingCircleDarkColor: flashingCircleDarkColor,
            flashingCircleBrightColor: flashingCircleBrightColor,
          ),
          FlashingCircle(
            index: 1,
            repeatingController: repeatingController,
            dotIntervals: dotIntervals,
            flashingCircleDarkColor: flashingCircleDarkColor,
            flashingCircleBrightColor: flashingCircleBrightColor,
          ),
          FlashingCircle(
            index: 2,
            repeatingController: repeatingController,
            dotIntervals: dotIntervals,
            flashingCircleDarkColor: flashingCircleDarkColor,
            flashingCircleBrightColor: flashingCircleBrightColor,
          ),
        ],
      ),
    );
  }
}

class FlashingCircle extends StatelessWidget {
  const FlashingCircle({
    super.key,
    required this.index,
    required this.repeatingController,
    required this.dotIntervals,
    required this.flashingCircleBrightColor,
    required this.flashingCircleDarkColor,
  });

  final int index;
  final AnimationController repeatingController;
  final List<Interval> dotIntervals;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: repeatingController,
      builder: (context, child) {
        final circleFlashPercent = dotIntervals[index].transform(
          repeatingController.value,
        );
        final circleColorPercent = sin(pi * circleFlashPercent);

        return Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(
              flashingCircleDarkColor,
              flashingCircleBrightColor,
              circleColorPercent,
            ),
          ),
        );
      },
    );
  }
}

class FakeMessage extends StatelessWidget {
  const FakeMessage({
    super.key,
    required this.isBig,
  });

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      height: isBig ? 128 : 36,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.grey.shade300,
      ),
    );
  }
}

class CircleBubble extends StatelessWidget {
  const CircleBubble({
    super.key,
    required this.size,
    required this.bubbleColor,
  });

  final double size;
  final Color bubbleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bubbleColor,
      ),
    );
  }
}
