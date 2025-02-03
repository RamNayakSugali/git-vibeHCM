// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vibeshr/database_helper.dart';

import '../untils/export_file.dart';

class Setting_view extends StatefulWidget {
  const Setting_view({super.key});

  @override
  State<Setting_view> createState() => _Setting_viewState();
}

class _Setting_viewState extends State<Setting_view> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  final service = FlutterBackgroundService();

  List Setting_list = [
    {
      "name": "My Profile",
      "Subimage": "assets/images/arrow.svg",
      "subname": "Lorem Epson is a Dummy Text",
      "route": KProfile,
      //"color": KPurple,
      // "route": KAttendance
    },
    {
      "name": "Change Password",
      "Subimage": "assets/images/arrow.svg",
      "subname": "Lorem Epson is a Dummy Text",
      "route": KChangePassword,
      //"color": KPurple,
      // "route": KAttendance
    },
    // {
    //   "name": "Security",
    //   "Subimage": "assets/images/arrow.svg",
    //   "subname": "Lorem Epson is a Dummy Text",
    //   "route": KSecurity,
    //   //"color": KOrange,
    //   // "route": KRecharge
    // },
    // {
    //   "name": "Notifications",
    //   "Subimage": "assets/images/arrow.svg",
    //   "subname": "Lorem Epson is a Dummy Text",
    //   "route": KNotification,

    //   ///KAnimated,
    //   // "color": Kgreen,
    // },
    {
      "name": "Privacy Policy",
      "Subimage": "assets/images/arrow.svg",
      "subname": "Lorem Epson is a Dummy Text",
      "route": Kpolicy,
    },
    {
      "name": "Terms and Conditions",
      "Subimage": "assets/images/arrow.svg",
      "subname": "Lorem Epson is a Dummy Text",
      "route": Kterms_services
      // "color": KDarkblue,
    },
    {
      "name": "Check for Updates",
      "Subimage": "assets/images/arrow.svg",
      "subname": "Lorem Epson is a Dummy Text",
      "route": Kupdates,
      // "color": Kpink,
    },
    {
      "name": "Help Desk",
      "Subimage": "assets/images/arrow.svg",
      "subname": "Lorem Epson is a Dummy Text",
      "route": KHelpDesk,
      // "color": Kpink,
    },
  ];
  @override
  void initState() {
    super.initState();
    selectedTheme;
  }

  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) async {
    setState(() {
      selectedTheme == "Lighttheme"
          ? selectedTheme = "Dark theme"
          : selectedTheme = "Lighttheme";
    });
  }

  bool isSwitched1 = false;
  var textValue1 = 'Switch is OFF';

  void toggleSwitch1(bool value) async {
    if (isSwitched1 == false) {
      setState(() {
        isSwitched1 = true;
      });
    } else {
      setState(() {
        isSwitched1 = false;
      });
    }
    UserSimplePreferences().setMapShowSTatuc(isSwitched1);
  }

  bool isSwitched2 = false;
  var textValue2 = 'Switch is OFF';

  void toggleSwitch2(bool value) async {
    if (isSwitched2 == false) {
      setState(() {
        isSwitched2 = true;
      });
    } else {
      setState(() {
        isSwitched2 = false;
      });
    }
    UserSimplePreferences().setBioMetricSTatuc(isSwitched2);
  }

  void toggleSelfie(bool value) async {
    setState(() {
      UserSimplePreferences().setSelfeeEnableSTatuc(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      // bottomNavigationBar: CustomButton(
      //     margin: EdgeInsets.all(10.r),
      //     borderRadius: BorderRadius.circular(20.r),
      //     Color: KOrange,
      //     height: 40.h,
      //     label: "Log Out",
      //     textColor: Kwhite,
      //     fontWeight: kFW900,
      //     fontSize: 13.sp,
      //     isLoading: false,
      //     onTap: () {
      //       UserSimplePreferences.clearAllData();
      //       Get.toNamed(KLogin_id);
      //     }),
      appBar: VibhoAppBar(
        bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        title: 'Settings',
        dontHaveBackAsLeading: false,
        // trailing: GestureDetector(
        //   onTap: () {
        //     Get.toNamed(KNotification);
        //   },
        //   child: Padding(
        //     padding: EdgeInsets.only(right: 15.w, top: 5.h),
        //     child: Row(
        //       children: [
        //         Image.asset(
        //           UserSimplePreferences.getNotifications() == "0"
        //               ? "assets/images/notification_inactive.png"
        //               : "assets/images/bell.png",
        //           // "assets/images/bell.png",
        //           width: 25,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(13.r),
          child: Column(children: [
            for (int i = 0; i < Setting_list.length; i++)
              GestureDetector(
                onTap: () => {
                  Get.toNamed(Setting_list[i]["route"]),
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                      color:
                          selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0.5,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                          color: Ktextcolor.withOpacity(0.2),
                        )
                      ],
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Ktextcolor.withOpacity(0.01),
                      //     blurRadius: 5,
                      //     offset: const Offset(0, 0),
                      //     spreadRadius: 2,
                      //   )
                      // ],
                      borderRadius: BorderRadius.circular(10.r)),
                  //margin: EdgeInsets.all(13.r),
                  child: ListTile(
                    title: Text(
                      Setting_list[i]["name"],
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color:
                            selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
                      ),
                    ),
                    // subtitle: Text(
                    //   Setting[i]["name"],
                    // ),
                    // subtitle: Text(
                    //   //"Lorem Epson is a Dummy Text",
                    //    Setting_list[i]["Subtext"],
                    //   maxLines: 2,
                    //   textAlign: TextAlign.left,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: TextStyle(
                    //       fontSize: kTenFont,
                    //       fontWeight: kFW500,
                    //       color: Klight),
                    // ),
                    trailing: SvgPicture.asset(Setting_list[i]["Subimage"],
                        color: KOrange,
                        alignment: Alignment.bottomLeft,
                        fit: BoxFit.fill,
                        semanticsLabel: 'Acme Logo'),
                  ),
                ),
              ),
            Container(
              margin: EdgeInsets.only(top: 10.h),
              decoration: BoxDecoration(
                  color: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0.5,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                      color: Ktextcolor.withOpacity(0.2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10.r)),
              child: ListTile(
                  title: Text(
                    "Show Location",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: kFW900,
                        color:
                            selectedTheme == "Lighttheme" ? KdarkText : Kwhite),
                  ),
                  trailing: Switch(
                    onChanged: toggleSwitch1,
                    value: UserSimplePreferences.getMapShowStatic() ?? true,
                    activeColor: Kwhite,
                    activeTrackColor: Kgreen.withOpacity(0.7),
                    inactiveThumbColor: Klightgray,
                    inactiveTrackColor: KRed.withOpacity(0.5),
                  )),
            ),
            GestureDetector(
              onTap: () => {},
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                    color: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0.5,
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                        color: Ktextcolor.withOpacity(0.2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10.r)),
                child: ListTile(
                  title: Text(
                    "Lock Screen",
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
                    ),
                  ),
                  trailing: Switch(
                    onChanged: toggleSwitch2,
                    value: UserSimplePreferences.getBioMetricStatic() ?? false,
                    activeColor: Kwhite,
                    activeTrackColor: Kgreen.withOpacity(0.7),
                    inactiveThumbColor: Klightgray,
                    inactiveTrackColor: KRed.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => {},
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                    color: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0.5,
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                        color: Ktextcolor.withOpacity(0.2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10.r)),
                child: ListTile(
                  title: Text(
                    "Dark Mode",
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
                    ),
                  ),
                  trailing: Switch(
                    onChanged: toggleSwitch,
                    value: selectedTheme == "Lighttheme" ? false : true,
                    activeColor: Kwhite,
                    activeTrackColor: Kgreen.withOpacity(0.7),
                    inactiveThumbColor: Klightgray,
                    inactiveTrackColor: KRed.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            if (dashboardController.role["is_selfie_enabled"] != null) ...[
              if (dashboardController.role["is_selfie_enabled"] == true) ...[
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    margin: EdgeInsets.only(top: 10.h),
                    decoration: BoxDecoration(
                        color: selectedTheme == "Lighttheme"
                            ? Kwhite
                            : Kthemeblack,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 0.5,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                            color: Ktextcolor.withOpacity(0.2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10.r)),
                    child: ListTile(
                      title: Text(
                        "Enable Selfie",
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: selectedTheme == "Lighttheme"
                              ? KdarkText
                              : Kwhite,
                        ),
                      ),
                      trailing: Switch(
                        onChanged: toggleSelfie,
                        value: UserSimplePreferences.getSelfeeEnableStatic() ??
                            true,
                        activeColor: Kwhite,
                        activeTrackColor: Kgreen.withOpacity(0.7),
                        inactiveThumbColor: Klightgray,
                        inactiveTrackColor: KRed.withOpacity(0.5),
                      ),
                    ),
                  ),
                )
              ]
            ],
            SizedBox(
              height: 30.h,
            ),
            CustomButton(
                margin: EdgeInsets.all(10.r),
                borderRadius: BorderRadius.circular(20.r),
                Color: KOrange,
                height: 40.h,
                label: "Log Out",
                textColor: Kwhite,
                fontWeight: kFW900,
                fontSize: 13.sp,
                isLoading: false,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Are You Sure',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: kFW700,
                                  color: selectedTheme == "Lighttheme"
                                      ? KdarkText
                                      : Kwhite)),
                          content: Text('You Want To LogOut ?',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: kFW700,
                                  color: selectedTheme == "Lighttheme"
                                      ? KdarkText.withOpacity(0.7)
                                      : Kwhite)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('No',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: kFW700,
                                      color: selectedTheme == "Lighttheme"
                                          ? KdarkText
                                          : Kwhite)),
                            ),
                            TextButton(
                              // textColor: Color(0xFF6200EE),
                              onPressed: () async {
                                List dataList =
                                    await _databaseHelper.getDataList();
                                UserSimplePreferences.clearAllData();
                                // await _databaseHelper.deleteTask(0);
                                await _databaseHelper.del(dataList[0].name1);
                                _deleteCacheDir();
                                _deleteAppDir();
                                service.invoke("stopService");

                                ///
                                /// Delete the database at the given path.
                                ///
                                // Future<void> deleteDatabase(String path) =>
                                //     _databaseHelper.database;

                                Get.offAllNamed(Kwebaddress_login);
                                Get.back();
                              },
                              child: Text('Yes',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: kFW700,
                                      color: selectedTheme == "Lighttheme"
                                          ? KdarkText
                                          : Kwhite)),
                            )
                          ],
                        );
                      });
                }
                ),
          ]),
        ),
      ),
    );
  }

  //Delete Storage
  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }
  // Future<void> _deleteCacheDir() async {
  //   final cacheDir = await getTemporaryDirectory();

  //   if (cacheDir.existsSync()) {
  //     cacheDir.deleteSync(recursive: true);
  //     Fluttertoast.showToast(msg: "Cache Deleted");
  //   } else {
  //     Fluttertoast.showToast(msg: "Cache Deleted");
  //   }
  // }

  // Future<void> _deleteAppDir() async {
  //   final appDir = await getApplicationSupportDirectory();

  //   if (appDir.existsSync()) {
  //     appDir.deleteSync(recursive: true);

  //     Fluttertoast.showToast(msg: "Storage Deleted");
  //   } else {
  //     Fluttertoast.showToast(msg: "Storage Deleted");
  //   }
  // }
}
