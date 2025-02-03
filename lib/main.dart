import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibeshr/back_services.dart';

import 'firebase_options.dart';
import 'untils/export_file.dart';
import 'untils/routes.dart';

String _identifier = 'Unknown';

void main() async {
  // AwesomeNotifications().initialize(
  //     // set the icon to null if you want to use the default app icon
  //     null,
  //     [
  //       NotificationChannel(
  //         channelGroupKey: 'basic_channel_group',
  //         channelKey: 'call_channel',
  //         /* same name */
  //         channelName: 'Basic notifications',
  //         channelDescription: 'Notification channel for basic tests',
  //         defaultColor: Color(0xFF9D50DD),
  //         ledColor: Colors.white,
  //         importance: NotificationImportance.High,
  //         enableVibration: true,
  //       ),
  //     ],
  //     // Channel groups are only visual and are not required
  //     channelGroups: [
  //       NotificationChannelGroup(
  //         channelGroupName: 'Basic group',
  //         channelGroupKey: 'basic_channel_group',
  //       )
  //     ],
  //     debug: true);

  // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  //   if (!isAllowed) {
  //     AwesomeNotifications().requestPermissionToSendNotifications();
  //   }
  // });
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  initFirebase();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await UserSimplePreferences.init();
  //HttpOverrides.global = MyHttpOverrides();
  await initializeService();
  runApp(MyApp());
}

initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String? token = await FirebaseMessaging.instance.getToken();
  UserSimplePreferences.setfcmToken(token);
  print("FCM token${token}");
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );
  @override
  void initState() {
    super.initState();

    getConnectivity();
    initUniqueIdentifierState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;
    UserSimplePreferences.setuniquecode(identifier);
    setState(() {
      _identifier = identifier;
    });
  }
// void _checkVersion() async {
//     final newVersion = NewVersion(
//       androidId: "com.snapchat.android",
//     );
//     final status = await newVersion.getVersionStatus();
//     newVersion.showUpdateDialog(
//       context: context,
//       versionStatus: status,
//       dialogTitle: "UPDATE!!!",
//       dismissButtonText: "Skip",
//       dialogText: "Please update the app from " + "${status.localVersion}" + " to " + "${status.storeVersion}",
//       dismissAction: () {
//         SystemNavigator.pop();
//       },
//       updateButtonText: "Lets update",
//     );

//     print("DEVICE : " + status.localVersion);
//     print("STORE : " + status.storeVersion);
//   }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            title: 'Vibho HCM',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Objectivity',
              bottomSheetTheme: const BottomSheetThemeData(
                  backgroundColor: Colors.transparent),
            ),
            getPages: Routes.routes,
            initialRoute:
                // KDbTasks
                !Platform.isWindows ? kSplashPage : Kwebaddress_login);
      },
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
