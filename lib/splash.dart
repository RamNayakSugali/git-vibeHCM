// ignore_for_file: camel_case_types

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

import 'untils/export_file.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  Future<void> authinticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to show Vibho HCM',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          stickyAuth: false,
        ),
      );
      if (didAuthenticate == true) {
        if (!Get.isRegistered<DynamicLinkServices>()) {
          Get.put<DynamicLinkServices>(DynamicLinkServices());
        }
        try {
          await Get.find<DynamicLinkServices>().initDynamicLink();
        } on Exception catch (e) {
          debugPrint('DynamicLink init Exception - ${e.toString()}');
        }
        // Get.toNamed(KBottom_navigation);
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        // Add handling of no hardware here.
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
      } else {
        // ...
      }
    }
  }

  bool? isUserLoggedIn;
  bool? isAdmin;
  // static const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //   'high_importance_channel', // id
  //   'High Importance Notifications', // title
  //   // 'This channel is used for important notifications.',  // description
  //   importance: Importance.max,
  // );
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // void requestPermission() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   print('User granted permission');
    // } else if (settings.authorizationStatus ==
    //     AuthorizationStatus.provisional) {
    //   print('User granted provisional permission');
    // } else {
    //   print('User declined or has not accepted permission');
    // }
  //}

  // void listenFCM() async {
  //   print("listen");

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Has message');
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null && !kIsWeb) {
  //       print("got a notification");
  //     // Navigator.push(context,MaterialPageRoute(builder: (context)=>ReportRequestScreen(uid: "",)));

  //       flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             importance: Importance.max,
  //             priority: Priority.high,
  //             //      one that already exists in example app.
  //             icon: 'mipmap/ic_launcher',
  //           ),
  //         ),
  //       );
  //     }
  //   });
  // }
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.',  // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
      
  void listenFCM() async {
    print("listen");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Has message');

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        debugPrint("got a notification");
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              importance: Importance.max,
              priority: Priority.high,
              icon: 'mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
      
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    super.initState();
    listenFCM();
    requestPermission();
    isUserLoggedIn = UserSimplePreferences.getLoginStatus();
    var data = UserSimplePreferences.getWebUrl() ?? "";
    var devUrldata = UserSimplePreferences.getDevUrl() ?? STAICURL;
    setState(() {
      KWebURL = data;
      KSubDomainURL = data;
      if (devUrldata != "") {
        kDEVURL = devUrldata;
      }
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (isUserLoggedIn != null && isUserLoggedIn == true) {
        var data = UserSimplePreferences.getBioMetricStatic();
        if (data == null || data == false) {
          if (!Get.isRegistered<DynamicLinkServices>()) {
            Get.put<DynamicLinkServices>(DynamicLinkServices());
          }
          try {
            Get.find<DynamicLinkServices>().initDynamicLink();
          } on Exception catch (e) {
            debugPrint('DynamicLink init Exception - ${e.toString()}');
          }
        } else {
          authinticate();
        }
      } else {
        Get.toNamed(KOnboarding);
      }
    });
  }

  intializeapp() async {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            color: Kwhite,
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/images/splash.png",
              fit: BoxFit.fill,
            )),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png", width: 170.w

                  //fit: BoxFit.fill,
                  ),
              SizedBox(height: 13.h),
              Container(
                width: 170.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Kwhite,
                ),
                padding: EdgeInsets.all(3.r),
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 10000),
                  curve: Curves.easeInOut,
                  tween: Tween<double>(
                    begin: 0,
                    end: 60,
                  ),
                  builder: (context, value, _) => AnimatedProgressBar(
                      height: 5.h,
                      width: 280.w,
                      value: value,
                      duration: const Duration(seconds: 10),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.yellowAccent,
                          Colors.deepOrange,
                          KDarkskyblue,
                          KBlue,
                        ],
                      ),
                      backgroundColor: Kwhite),
                  // LinearProgressIndicator(
                  //     backgroundColor: Kwhite, value: value),
                ),
              ),
         
            ],
          ),
        )
      ],
    );
  }
}
