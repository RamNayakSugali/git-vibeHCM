// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:upgrader/upgrader.dart';
import 'package:http/http.dart';

import '../untils/export_file.dart';
import 'dart:async';
import 'package:pub_semver/pub_semver.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
//import 'package:new_version_plus/new_version_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_in_store_app_version_checker/flutter_in_store_app_version_checker.dart';

// import 'package:custom_upgrader/custom_upgrader.dart';
// class update extends StatefulWidget {
//   const update({super.key});

//   @override
//   State<update> createState() => _updateState();
// }

// class _updateState extends State<update> {
//   PackageInfo _packageInfo = PackageInfo(
//     appName: 'Unknown',
//     packageName: 'Unknown',
//     version: 'Unknown',
//     buildNumber: 'Unknown',
//     buildSignature: 'Unknown',
//     installerStore: 'Unknown',
//   );

//   @override
//   void initState() {
//     super.initState();
//     _initPackageInfo();
//   }

//   Future<void> _initPackageInfo() async {
//     final info = await PackageInfo.fromPlatform();
//     setState(() {
//       _packageInfo = info;
//     });
//   }

//   /////////////////////////////update

//   ////////

//   Widget _infoTile(String title, String subtitle) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "App Version :  ",
//           style: TextStyle(
//               fontSize: 13.sp, fontWeight: FontWeight.bold, color: Klightgray),
//         ),
//         Text(
//           subtitle.isEmpty ? '0.0.0.' : subtitle,
//           style: TextStyle(
//               // wordSpacing: 2,
//               fontSize: 13.sp,
//               fontWeight: FontWeight.bold,
//               color: KdarkText),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return UpgradeAlert(
//       child:
//     );
//   }
// }
class update extends StatefulWidget {
  const update({super.key});

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  late InStoreAppVersionChecker _tikTokChecker;
  // String? tikTokValue;
  String? newVersionValue;
  String? currentValue;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tikTokChecker = InStoreAppVersionChecker(
      appId: 'com.vibhohcm.vibeshr',
      //com.vibhohcm.vibeshr
      //  appId: 'com.zhiliaoapp.musically',
      androidStore: AndroidStore.googlePlayStore,
    );

    checkVersion();
    //  currentVersion();
  }

  void checkVersion() async {
    setState(() {
      isLoading = true;
    });
    Future.wait([
      _tikTokChecker
          .checkUpdate()
          .then((value) => newVersionValue = value.newVersion.toString()),
    ]).then((_) => setState(() {}));
    Future.wait([
      _tikTokChecker
          .checkUpdate()
          .then((value) => currentValue = value.currentVersion.toString()),
    ]).then((_) => setState(() {}));
    setState(() {
      isLoading = false;
    });
  }

  // void currentVersion() async {
  //   Future.wait([
  //     _tikTokChecker
  //         .checkUpdate()
  //         .then((value) => currentValue = value.currentVersion.toString()),
  //   ]).then((_) => setState(() {}));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        appBar: VibhoAppBar(
          title: "Update",
          bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
          dontHaveBackAsLeading: false,
        ),
        body: currentValue != null
            //isLoading == false
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: 180.w,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "App Version :  ",
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Klightgray),
                      ),
                      Text(
                        currentValue ?? '',
                        style: TextStyle(
                          // wordSpacing: 2,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: selectedTheme == "Lighttheme"
                              ? KdarkText
                              : Kwhite,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 30.h,
                  ),
                  Version.parse(currentValue!) > Version.parse(newVersionValue!)
                      ? Text(
                          "HCM App Is Up To Date",
                          style: TextStyle(
                            // wordSpacing: 2,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: selectedTheme == "Lighttheme"
                                ? Klightgray
                                : Kwhite,
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            Uri url = Uri.parse(Platform.isAndroid
                                ? "https://play.google.com/store/apps/details?id=com.vibhohcm.vibeshr"
                                : "https://apps.apple.com/my/app/vibhohcm-app/id6463864220");
                            if (await canLaunch(url.toString())) {
                              await launch(url.toString());
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Column(children: [
                            Text(
                              "Latest Version Is Available",
                              style: TextStyle(
                                // wordSpacing: 2,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: selectedTheme == "Lighttheme"
                                    ? Klightgray
                                    : Kwhite,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Click Here",
                              style: TextStyle(
                                // wordSpacing: 2,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: selectedTheme == "Lighttheme"
                                    ? Klightgray
                                    : Kwhite,
                              ),
                            )
                          ]),
                        ),
                  // Text(
                  //   currentValue ?? 'Loading ...',
                  //   style: TextStyle(
                  //       // wordSpacing: 2,
                  //       fontSize: 13.sp,
                  //       fontWeight: FontWeight.bold,
                  //       color: KdarkText),
                  // ),
                  // _infoTile('App version', _packageInfo.version),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              )
            : Center(
                child: SpinKitFadingCircle(
                color: KOrange,
                size: 50.sp,
              ))

        // UpgradeAlert(
        //   child: Center(child: Text('Checking...')),
        // )

        // Stack(
        //   children: [
        //     Image.asset(
        //       "assets/images/screen.png",
        //       height: double.infinity,
        //       width: double.infinity,
        //       fit: BoxFit.fill,
        //     ),
        //     Column(
        //        mainAxisAlignment: MainAxisAlignment.center,
        //       // crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         SizedBox(
        //           height:100.h,
        //         ),
        //          Image.asset(
        //       "assets/images/logo.png",

        //       width: 200.w,
        //       fit: BoxFit.fill,
        //     ),
        //         SizedBox(
        //           height: 10.h,
        //         ),
        //         Text(
        //           " App Version : 1.0.0 ",
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //               fontSize: 13.sp, fontWeight: kFW600, color: KdarkText),
        //         ),
        //         SizedBox(
        //           height: 120.h,
        //         ),
        //         CustomButton(
        //             Color: KOrange,
        //             textColor: Kwhite,
        //             borderRadius: BorderRadius.circular(20.r),
        //             height: 38.h,
        //             width: double.infinity,
        //             margin: EdgeInsets.all(25.r),
        //             label: "Check for updates",
        //             fontSize: 12.sp,
        //             fontWeight: kFW700,
        //             isLoading: false,
        //             onTap: () {})
        //       ],
        //     ),
        //   ],
        // )
        // Container(
        //   width: double.infinity,
        //   child: Image.asset(
        //     "assets/images/soon.png",
        //     fit: BoxFit.cover,
        //   ),
        // )
        // Center(
        //   child: Text(
        //     "Coming Soon !",
        //     style: TextStyle(fontSize: 13.sp, color: KdarkText, fontWeight: kFW600),
        //   ),
        // ),
        );
  }
}

 
// class update extends StatefulWidget {
//   const update({super.key});

//   @override
//   State<update> createState() => _updateState();
// }

// class _updateState extends State<update> {
//   PackageInfo _packageInfo = PackageInfo(
//     appName: 'Unknown',
//     packageName: 'Unknown',
//     version: 'Unknown',
//     buildNumber: 'Unknown',
//     buildSignature: 'Unknown',
//     installerStore: 'Unknown',
//   );

//   @override
//   void initState() {
//     super.initState();
//     _initPackageInfo();
//   }

//   Future<void> _initPackageInfo() async {
//     final info = await PackageInfo.fromPlatform();
//     setState(() {
//       _packageInfo = info;
//     });
//   }

//   /////////////////////////////update

//   ////////

//   Widget _infoTile(String title, String subtitle) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "App Version :  ",
//           style: TextStyle(
//               fontSize: 13.sp, fontWeight: FontWeight.bold, color: Klightgray),
//         ),
//         Text(
//           subtitle.isEmpty ? '0.0.0.' : subtitle,
//           style: TextStyle(
//               // wordSpacing: 2,
//               fontSize: 13.sp,
//               fontWeight: FontWeight.bold,
//               color: KdarkText),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return UpgradeAlert(
//       child: Scaffold(
//         backgroundColor: Kwhite,
//         appBar: const VibhoAppBar(
//           title: "Update",
//           bColor: Kwhite,
//           dontHaveBackAsLeading: false,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           //crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Center(
//               child: Image.asset(
//                 "assets/images/logo.png",
//                 width: 180.w,
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             _infoTile('App version', _packageInfo.version),
//             SizedBox(
//               height: 30.h,
//             ),
//           ],
//         ),

//         // UpgradeAlert(
//         //   child: Center(child: Text('Checking...')),
//         // )

//         // Stack(
//         //   children: [
//         //     Image.asset(
//         //       "assets/images/screen.png",
//         //       height: double.infinity,
//         //       width: double.infinity,
//         //       fit: BoxFit.fill,
//         //     ),
//         //     Column(
//         //        mainAxisAlignment: MainAxisAlignment.center,
//         //       // crossAxisAlignment: CrossAxisAlignment.center,
//         //       children: [
//         //         SizedBox(
//         //           height:100.h,
//         //         ),
//         //          Image.asset(
//         //       "assets/images/logo.png",

//         //       width: 200.w,
//         //       fit: BoxFit.fill,
//         //     ),
//         //         SizedBox(
//         //           height: 10.h,
//         //         ),
//         //         Text(
//         //           " App Version : 1.0.0 ",
//         //           textAlign: TextAlign.center,
//         //           style: TextStyle(
//         //               fontSize: 13.sp, fontWeight: kFW600, color: KdarkText),
//         //         ),
//         //         SizedBox(
//         //           height: 120.h,
//         //         ),
//         //         CustomButton(
//         //             Color: KOrange,
//         //             textColor: Kwhite,
//         //             borderRadius: BorderRadius.circular(20.r),
//         //             height: 38.h,
//         //             width: double.infinity,
//         //             margin: EdgeInsets.all(25.r),
//         //             label: "Check for updates",
//         //             fontSize: 12.sp,
//         //             fontWeight: kFW700,
//         //             isLoading: false,
//         //             onTap: () {})
//         //       ],
//         //     ),
//         //   ],
//         // )
//         // Container(
//         //   width: double.infinity,
//         //   child: Image.asset(
//         //     "assets/images/soon.png",
//         //     fit: BoxFit.cover,
//         //   ),
//         // )
//         // Center(
//         //   child: Text(
//         //     "Coming Soon !",
//         //     style: TextStyle(fontSize: 13.sp, color: KdarkText, fontWeight: kFW600),
//         //   ),
//         // ),
//       ),
//     );
//   }
// }
