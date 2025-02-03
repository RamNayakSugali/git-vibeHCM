// ignore_for_file: camel_case_types

import '../untils/export_file.dart';

class Welcome_card extends StatefulWidget {
  const Welcome_card({super.key});

  @override
  State<Welcome_card> createState() => _WelcomecardState();
}

class _WelcomecardState extends State<Welcome_card> {
  DashboardController dashboardController = Get.find<DashboardController>();

  void sendNotification() async {
    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //         // displayOnForeground: true,
    //         // displayOnBackground: true,
    //         id: 10,
    //         channelKey: 'call_channel',
    //         /* same name */
    //         title: 'SMS Alert ',
    //         body: "msg" ?? ""),
    //     actionButtons: [
    //       NotificationActionButton(
    //           key: "open",
    //           label: dashboardController.homedata!["checkin_checkout"]
    //                       ["check_in"]["status"] ==
    //                   true
    //               ? dashboardController.homedata!["checkin_checkout"]
    //                           ["check_out"]["status"] ==
    //                       true
    //                   ? " "
    //                   : "CheckOut"
    //               : "CheckIn",
    //           actionType: ActionType.SilentAction),
    //       NotificationActionButton(
    //           key: "delete",
    //           label: "Sick Leave",
    //           actionType: ActionType.Default)
    //     ]);
    // AwesomeNotifications().setListeners(
    //   onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    //   // onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
    //   // onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
    //   // onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    // );
    /////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////
//      AwesomeNotifications().setListeners(

// );

    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //   id: 1,
    //   channelKey: 'basic channel',
    //   actionType: ActionType.Default,
    //   title: 'Hello World',
    //   body: 'This is my first notification',
    //   icon: 'assets/images/accept.png', // Use the default app icon
    // ));
    // await AwesomeNotifications().createNotification(
    //   content: NotificationContent(
    //     id: 1,
    //     channelKey: 'basic_channel',
    //     title: 'Hello',
    //     body: 'This is an awesome notification!',
    //     icon: "assets/images/accept",

    //     bigPicture: "assets/images/accept", // Replace with your image path
    //     notificationLayout: NotificationLayout.BigPicture,
    //   ),
    //   // Set a valid small icon
    // );
  }

  // ignore: non_constant_identifier_names

  // AwesomeNotifications().actionStream.listen((action) {
  //       if(action.buttonKeyPressed == "open"){
  //         print("Open button is pressed");
  //       }else if(action.buttonKeyPressed == "delete"){
  //         print("Delete button is pressed.");
  //       }else{
  //          print(action.payload); //notification was pressed
  //       }
  //   });
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    // AwesomeNotifications().setListeners(
    //   onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    //   // onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
    //   // onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
    //   // onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    // );

    super.initState();
  }

  // @override
  // void initState() {
  //   // profileListHandler();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(KProfile);
      },
      child: Container(
        padding: EdgeInsets.all(10.r),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.r),
          color: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
          boxShadow: [
            BoxShadow(
              color: Ktextcolor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 0),
              spreadRadius: 2, //New
            )
          ],
        ),
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.all(5),
                height: 50.h,
                width: 50.h,
                decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Ktextcolor.withOpacity(0.3),
                  //     blurRadius: 10,
                  //     offset: const Offset(0, 0),
                  //     spreadRadius: 3, //New
                  //   )
                  // ],
                  borderRadius: BorderRadius.circular(13.r),
                  color: Kwhite,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(13.r),
                    child: Obx(
                      () => dashboardController.profiledata["profile_pic"] !=
                                  null &&
                              dashboardController.profiledata["profile_pic"] !=
                                  ""
                          ? CachedNetworkImage(
                              imageUrl:
                                  // KProfileimage +
                                  dashboardController
                                      .profiledata["profile_pic"],
                              errorWidget: (context, url, error) =>
                                  dashboardController.profiledata["gender"] ==
                                          "Male"
                                      ? Image.asset(
                                          "assets/images/man.png",
                                          height: 55.h,
                                          width: 55.h,
                                          fit: BoxFit.contain,
                                        )
                                      : Image.asset(
                                          "assets/images/girl.png",
                                          height: 55.h,
                                          width: 55.h,
                                          fit: BoxFit.contain,
                                        ),
                              fit: BoxFit.cover,
                            )
                          : dashboardController.profiledata["gender"] == "Male"
                              ? Image.asset(
                                  "assets/images/man.png",
                                  height: 55.h,
                                  width: 55.h,
                                  fit: BoxFit.contain,
                                )
                              : Image.asset(
                                  "assets/images/girl.png",
                                  height: 55.h,
                                  width: 55.h,
                                  fit: BoxFit.contain,
                                ),
                    ))),
            SizedBox(
              width: 5.w,
            ),
            SizedBox(
              width: 220.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: "Hi! ",
                      style: TextStyle(
                          fontSize: kSixteenFont,
                          fontWeight: kFW400,
                          color: selectedTheme == "Lighttheme"
                              ? KdarkText
                              : Kwhite),
                      children: <TextSpan>[
                        TextSpan(
                          text: dashboardController.profiledata.isNotEmpty
                              ? "${dashboardController.profiledata["fname"]} ${dashboardController.profiledata["lname"].toString().length > 8 ? "${dashboardController.profiledata["lname"].toString().substring(0, 7)}..." : dashboardController.profiledata["lname"]}👋"
                              : "👋",
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: kSixteenFont,
                              fontWeight: kFW700,
                              color: selectedTheme == "Lighttheme"
                                  ? KdarkText
                                  : Kwhite),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7.w,
                  ),
                  Text(
                    dashboardController.profiledata.isNotEmpty
                        ? dashboardController.profiledata["Designation"]
                            ["designation_name"]
                        : "",
                    style: TextStyle(
                        fontSize: kTwelveFont,
                        fontWeight: FontWeight.bold,
                        color: Klightblack),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

DashboardController dashboardController = Get.find<DashboardController>();

class AnotherController extends GetxController {
  @pragma("vm:entry-point")
  //static Future<void> onActionReceivedMethod(
  //     ReceivedAction receivedAction) async {
  //   print(receivedAction.actionType.toString());
  //   if (receivedAction.actionType.toString() == "ActionType.SilentAction") {
  //     //////////////////////////////
  //     //////
  //     var type = "in".obs;
  //     // String _verticalGroupValue = "office";
  //     if (dashboardController.homedata!["checkin_checkout"]["check_in"]
  //             ["status"] ==
  //         true) {
  //       type.value = "out";
  //     }

  //     final _status = ["office", "home"];
  //     var isLoading = false.obs;
  //     // bool isLoading = false;
  //     Future attendancesHandler(String type, String _verticalGroupValue) async {
  //       isLoading(true);

  //       // if (type == "in") {
  //       //   dashboardController.homedata!["checkin_checkout"]["check_in"]["status"] = true;
  //       //   widget.homedir!["checkin_checkout"]["check_in"]["time"] =
  //       //       DateTime.now();
  //       //   widget.homedir!["checkin_checkout"]["check_out"]["status"] = false;
  //       // } else {
  //       //   widget.homedir!["checkin_checkout"]["check_in"]["status"] = false;
  //       //   widget.homedir!["checkin_checkout"]["check_out"]["status"] = true;
  //       //   widget.homedir!["checkin_checkout"]["check_out"]["time"] =
  //       //       DateTime.now();
  //       // }

  //       Map payload = {"type": type, "work_from": "office"};
  //       //  {"type": type};

  //       Map value = await Services.checkin(payload);
  //       if (value["message"] != null) {
  //         Fluttertoast.showToast(msg: value["message"]);
  //       } else {}
  //       isLoading(false);
  //       // setState(() {
  //       //   isLoading = false;
  //       // });
  //     }
  //     //////////////////////////////////////////////////////////////////////
  //     // Map payload = {"type": "in", "work_from": "office"};

  //     // Map value = await Services.checkin(payload);
  //     // if (value["message"] != null) {
  //     //   Fluttertoast.showToast(msg: value["message"]);
  //     // } else {}

  //     print("jkhbhk scsk----------------------------------");
  //   } else if (receivedAction.actionType.toString() == "ActionType.Default") {
  //     DateTime now = DateTime.now();
  //     String todayDate = DateFormat('yyyy-MM-dd').format(now);
  //     var payload = {
  //       "leave_type_id": UserSimplePreferences.getSickLeaveID() ?? "4",
  //       "leave_type": "Sick Leave",
  //       "from_date": todayDate,
  //       "to_date": todayDate,
  //       "reason": "Applied Immediate Leave"
  //     };

  //     Map value = await Services.createLeaveV2(payload);
  //     Fluttertoast.showToast(
  //       msg: value["message"],
  //     );
  //   }

  //   print(
  //       "jai------------------------------bheem-------------------------onjokjmmo");
  // }
//}

//class NotificationController extends GetxController {
  /// Use this method to detect when a new notification or a schedule is created
  // @pragma("vm:entry-point")
  // static Future<void> onNotificationCreatedMethod(
  //     ReceivedNotification receivedNotification) async {
  //   print("nee amm xcnlndlns ldn");
  //   // Your code goes here
  // }

  // /// Use this method to detect every time that a new notification is displayed
  // @pragma("vm:entry-point")
  // static Future<void> onNotificationDisplayedMethod(
  //     ReceivedNotification receivedNotification) async {
  //   // Your code goes here
  // }

  // /// Use this method to detect if the user dismissed a notification
  // @pragma("vm:entry-point")
  // static Future<void> onDismissActionReceivedMethod(
  //     ReceivedAction receivedAction) async {
  //   // Your code goes here
  // }

  // /// Use this method to detect when the user taps on a notification or action button
  // @pragma("vm:entry-point")
  // static Future<void> onActionReceivedMethod(
  //     ReceivedAction receivedAction) async {
  //   print(receivedAction.actionType.toString());
  //   if (receivedAction.actionType.toString() == "ActionType.SilentAction") {
  //     //////////////////////////////
  //     //////
  //     var type = "in".obs;
  //     // String _verticalGroupValue = "office";
  //     if (dashboardController.homedata!["checkin_checkout"]["check_in"]
  //             ["status"] ==
  //         true) {
  //       type.value = "out";
  //     }
  //     ;

  //     // final _status = ["office", "home"];
  //     // var isLoading = false.obs;

  //     Map payload = {"type": type.value, "work_from": "office"};

  //     Map value = await Services.checkin(payload);
  //     if (value["message"] != null) {
  //       Fluttertoast.showToast(msg: value["message"]);
  //     } else {}
  //     // bool isLoading = false;
  //     // Future attendancesHandler(String type) async {
  //     //   isLoading(true);

  //     //   // if (type == "in") {
  //     //   //   dashboardController.homedata!["checkin_checkout"]["check_in"]["status"] = true;
  //     //   //   widget.homedir!["checkin_checkout"]["check_in"]["time"] =
  //     //   //       DateTime.now();
  //     //   //   widget.homedir!["checkin_checkout"]["check_out"]["status"] = false;
  //     //   // } else {
  //     //   //   widget.homedir!["checkin_checkout"]["check_in"]["status"] = false;
  //     //   //   widget.homedir!["checkin_checkout"]["check_out"]["status"] = true;
  //     //   //   widget.homedir!["checkin_checkout"]["check_out"]["time"] =
  //     //   //       DateTime.now();
  //     //   // }

  //     //   Map payload = {"type": type, "work_from": "office"};
  //     //   //  {"type": type};

  //     //   Map value = await Services.checkin(payload);
  //     //   if (value["message"] != null) {
  //     //     Fluttertoast.showToast(msg: value["message"]);
  //     //   } else {}
  //     //   isLoading(false);
  //     //   // setState(() {
  //     //   //   isLoading = false;
  //     //   // });
  //     // }
  //     //////////////////////////////////////////////////////////////////////
  //     // Map payload = {"type": "in", "work_from": "office"};

  //     // Map value = await Services.checkin(payload);
  //     // if (value["message"] != null) {
  //     //   Fluttertoast.showToast(msg: value["message"]);
  //     // } else {}

  //     print("jkhbhk scsk----------------------------------");
  //   }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // if (receivedAction.actionType.toString() == "ActionType.SilentAction") {
  //   // var payload = {
  //   //   "leave_type_id": 4,
  //   //   "leave_type": "Sick Leave",
  //   //   "from_date": "2023-12-27",
  //   //   "to_date": "2023-12-27",
  //   //   "reason": "Suffering Fever"
  //   // };

  //   // Map value = await Services.createLeaveV2(payload);
  //   // print(value);
  //   Map payload = {"type": "out", "work_from": "office"};
  //   //  {"type": type};

  //   Map value = await Services.checkin(payload);
  //   if (value["message"] != null) {
  //     Fluttertoast.showToast(msg: value["message"]);
  //   } else {}

  //   // dashboardController.homedata!["checkin_checkout"]["check_out"]["status"] != true
  //   //     ?dashboardController.homedata!["checkin_checkout"]["check_in"]["status"] == true

  //   //        ? attendancesHandler("out", _verticalGroupValue)
  //   //         : attendancesHandler("in", _verticalGroupValue)
  //   //     : null;

  //   print("jkhbhk scsk----------------------------------");
  //   // if(receivedAction.id == 17897583){
  //   //   // do something...
  //   // }
  // }
  ///////////////////////////////////////////////////////////////////////////////////////////////
  // else if (receivedAction.actionType.toString() == "ActionType.Default") {
  //   DateTime now = DateTime.now();
  //   String todayDate = DateFormat('yyyy-MM-dd').format(now);
  //   var payload = {
  //     "leave_type_id": UserSimplePreferences.getSickLeaveID() ?? "4",
  //     "leave_type": "Sick Leave",
  //     "from_date": todayDate,
  //     "to_date": todayDate,
  //     "reason": "Applied Immediate Leave"
  //   };

  //   Map value = await Services.createLeaveV2(payload);
  //   Fluttertoast.showToast(
  //     msg: value["message"],
  //   );
  //   // print(value);
  // }

  // {
  //   print(
  //       " Clicked on else...................................----------------------------------");
  //   // var payload = {
  //   //   "leave_type_id": 4,
  //   //   "leave_type": "Sick Leave",
  //   //   "from_date": "2023-12-27",
  //   //   "to_date": "2023-12-27",
  //   //   "reason": "Suffering Fever"
  //   // };

  //   // Map value = await Services.createLeaveV2(payload);
  //   // print(value);
  //   // createLeaveV2(payload)
  // }

  //print("jkhbhk scsk----------------------------------");
  // receivedAction.actionType.toString();
  // Your code goes here

  // Navigate into pages, avoiding to open the notification details page over another details page already opened
  // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
  //         (route) => (route.settings.name != '/notification-page') || route.isFirst,
  //     arguments: receivedAction);
//   }
// }

// class NotificationControllers extends StatefulWidget {
//   const NotificationControllers({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<NotificationControllers> createState() =>
//       _NotificationControllersState();
// }

// class _NotificationControllersState extends State<NotificationControllers> {
//   // void _incrementCounter() {
//   //   setState(() {
//   //     // This call to setState tells the Flutter framework that something has
//   //     // changed in this State, which causes it to rerun the build method below
//   //     // so that the display can reflect the updated values. If we changed
//   //     // _counter without calling setState(), then the build method would not be
//   //     // called again, and so nothing would appear to happen.
//   //     _counter++;
//   //   });
//   // }
//   @pragma("vm:entry-point")
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     if (receivedAction.actionType.toString() == "ActionType.SilentAction") {
//       Map payload = {"type": "in", "work_from": "office"};
//       //  {"type": type};

//       Map value = await Services.checkin(payload);
//       if (value["message"] != null) {
//         Fluttertoast.showToast(msg: value["message"]);
//       } else {}

//       // dashboardController.homedata!["checkin_checkout"]["check_out"]["status"] != true
//       //     ?dashboardController.homedata!["checkin_checkout"]["check_in"]["status"] == true

//       //        ? attendancesHandler("out", _verticalGroupValue)
//       //         : attendancesHandler("in", _verticalGroupValue)
//       //     : null;

//       print("jkhbhk scsk----------------------------------");
//       // if(receivedAction.id == 17897583){
//       //   // do something...
//       // }
//     }

//     print("jkhbhk scsk----------------------------------");
//     // receivedAction.actionType.toString();
//     // Your code goes here

//     // Navigate into pages, avoiding to open the notification details page over another details page already opened
//     // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
//     //         (route) => (route.settings.name != '/notification-page') || route.isFirst,
//     //     arguments: receivedAction);
//   }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              "ram",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        // onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


