import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_in_store_app_version_checker/flutter_in_store_app_version_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:upgrader/upgrader.dart';
import 'package:vibeshr/controllers/payslipController.dart';
import 'package:vibeshr/database_helper.dart';
import 'package:vibeshr/untils/export_file.dart';
//import 'package:connectivity/connectivity.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  void _addurlAndtoken(
      String location, String latitude, String longitude) async {
    Data newData = Data(name1: location, name2: latitude, name3: longitude);
    // Data newData = Data(
    //   lat: location,
    //   lon: latitude,
    //   address: longitude,
    // );
    await _databaseHelper.insertData(newData);
  }

  // void _checkinStatuscheck() {
  //   if (dashboardController.homedata["checkin_checkout"]["check_in"]
  //           ["status"] ==
  //       true) {
  //     final service = FlutterBackgroundService();
  //     service.startService();
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // dashboardController.onInit();
    _initPackageInfo();

    checkVersion();
    _addurlAndtoken(
        "$KWebURL", 'Bearer ${UserSimplePreferences.getToken()}', kDEVURL);
    // _checkinStatuscheck();

    selectedTheme;
  }

  final String INFOS = 'assets/images/nofeed.svg';
  checkForPopUp() {
    if (dashboardController.isLoading.value == false &&
        // dashboardController.isProfileLoading.value ==
        //     false &&
        dashboardController.isHRDataLoading.value == false &&
        dashboardController.leaverequest.value == false &&
        leavesController.myleavesLoading.value == false &&
        dashboardController.isHolydaysLoading.value == false) {
      checkToShowMessage();
    }
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  final _checker = InStoreAppVersionChecker();
  String oldVersion = "";
  String newVersion = "";
  String appUrl = "";
  bool canUpdate = false;
  Uri? url;

  void checkVersion() async {
    if (Platform.isAndroid) {
      await _checker.checkUpdate().then((value) {
        debugPrint("Checking...${value.appURL}");
        setState(() {
          canUpdate = value.canUpdate;
          oldVersion = value.currentVersion;
          newVersion = value.newVersion!;
          appUrl = value.appURL!;
          url = Uri.parse(Platform.isAndroid
              ? "https://play.google.com/store/apps/details?id=com.vibhohcm.vibeshr"
              : "https://apps.apple.com/my/app/vibhohcm-app/id6463864220");
        });
      });
      if (canUpdate) {
        showMyDialog(context);
      }
    }
  }

  Future<void> showMyDialog(context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 320.h,
              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              // margin: EdgeInsets.only(left: .w,right: 20.w
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: KdarkText,
                          size: 25,
                        )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Image.asset(
                    Platform.isAndroid
                        ? "assets/images/googleplay.png"
                        : "assets/images/appstore.png",
                    // color: KOrange,
                    width: 100.w,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('Update App ?',
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: 12.sp,
                          fontWeight: kFW900)),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Vibho Recommends that you update yoo the lastest version. You can download the latest version',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Klightgray,
                            fontSize: 12.sp,
                            fontWeight: kFW400)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                          borderRadius: BorderRadius.circular(15.r),
                          margin: EdgeInsets.all(10.r),
                          width: 110.w,
                          height: 35.h,
                          Color: KOrange,
                          textColor: Kwhite,
                          fontSize: 12.sp,
                          fontWeight: kFW700,
                          label: "Update",
                          isLoading: false,
                          onTap: () async {
                            if (await canLaunch(url.toString())) {
                              await launch(url.toString());
                            } else {
                              throw 'Could not launch $url';
                            }
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          );
        });
  }

  DashboardController dashboardController = Get.find<DashboardController>();
  LeavesController leavesController = Get.find<LeavesController>();
  PayslipController payslipController = Get.put(PayslipController());
  // callAPIs()async{
  //   await homepageApi();
  //   hrConfigs();
  //   getFeedback();
  //   profileListApi();
  //   notifiysHandler();
  // }

  // Map notifiydatas = {};
  // // bool isLoading = false;
  // bool isLoading = false;
  // Future notifiysHandler() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Map data = await Services.notification();

  //   if (data["message"] != null) {
  //     Fluttertoast.showToast(
  //       msg: data["message"],
  //     );
  //   } else {
  //     notifiydatas = data;
  //     await UserSimplePreferences.setNotifications(
  //         notificationCount: notifiydatas["rows"].length.toString());
  //     // notifiydatas["rows"].length
  //     //    await UserSimplePreferences.setToken(token: value["Token"]);
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // Map feedbackData = {};
  // getFeedback() async {
  //   Map data = await Services.getFeedback();
  //   feedbackData = data;
  // }

  // Map profiledata = {};
  // Map hrconfigs = {};

  // bool isProfileLoading = false;
  // Future profileListApi() async {
  //   setState(() {
  //     isProfileLoading = true;
  //   });
  //   Map data = await Services.employeeprofile();

  //   if (data["message"] != null) {
  //     Fluttertoast.showToast(
  //       msg: data["message"],
  //     );
  //   } else {
  //     profiledata = data["Employee"];
  //   }
  //   setState(() {
  //     isProfileLoading = false;
  //   });
  // }

  // hrConfigs() async {
  //   setState(() {
  //     isProfileLoading = true;
  //   });
  //   Map data = await Services.hrRequestApprovalConfigs();

  //   if (data["message"] != null) {
  //     Fluttertoast.showToast(
  //       msg: data["message"],
  //     );
  //   } else {
  //     hrconfigs = data;
  //   }
  //   setState(() {
  //     isProfileLoading = false;
  //   });
  // }

  // Map homedata = {};

  // Future homepageApi() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Map data = await Services.employeehome();

  //   if (data["message"] != null) {
  //     Fluttertoast.showToast(
  //       msg: data["message"],
  //     );
  //     if(data["message"]=="Unauthorized"){
  //       UserSimplePreferences.clearAllData();
  //       Get.toNamed(Kwebaddress_login);
  //     }
  //   } else {
  //     homedata = data;
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  //////////////////////////////////////
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  void showNoInternetDialog(BuildContext context) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('No Connection'),
        content: const Text('Please check your internet connectivity'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('No Internet Connection'),
    //       content: Text('Please check your internet connection and try again.'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: Text('OK'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void performAction() async {
    bool isConnected = await checkInternetConnection();

    if (!isConnected) {
      Get.toNamed(KNonetwork);
      // showNoInternetDialog(context);
      return;
    }
  }

  var showMessage = false.obs;
  void checkToShowMessage() {
    DateTime now = DateTime.now();
    int today = now.day;
    int? lastShownDay = UserSimplePreferences.getPopUpStatus() ?? 0;

    if (lastShownDay == today) {
      showMessage.value = true;
      UserSimplePreferences.setPopUpStatus(today);
    } else {
      showMessage.value = false;
    }
  }

  Future<void> _refreshDashboardData() async {
    setState(() {
      performAction();
      dashboardController.onInit();
      payslipController.onInit();
      // setState(() {
      //   dashboardController.requestCount.value = 0;
      // });
    });
  }

  _showBirthdayCard() {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black38,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        backgroundColor: selectedTheme == "Lighttheme"
            ? Color.fromRGBO(255, 255, 255, 0.9)
            : Kthemeblack,
        title: Container(
            // margin: const EdgeInsets.all(5),
            height: 45.h,
            width: 45.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80.r),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(80.r),
                // Image border
                child: dashboardController.birthdayDatafilter[0]
                                ["profile_pic"] !=
                            null &&
                        dashboardController.birthdayDatafilter[0]
                                ["profile_pic"] !=
                            ""
                    ? Image.network(
                        // KProfileimage +
                        dashboardController.birthdayDatafilter[0]
                            ["profile_pic"],
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            "assets/images/man.png",
                            fit: BoxFit.contain,
                          );
                        },
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/man.png",
                        fit: BoxFit.contain,
                      ))),
        content: Text(
          "${dashboardController.birthdayDatafilter[0]["fname"]} ${dashboardController.birthdayDatafilter[0]["lname"]}"
              .capitalize!,

          //   "Ram Nayak",
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 18.sp,
              fontWeight: kFW600,
              color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite),
        ),
        elevation: 2,
        actions: [
          GestureDetector(
            onTap: () async {
              var url = Uri.parse(
                  "tel:${dashboardController.birthdayDatafilter[0]["phone_no"]}");
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: SizedBox(
              // width: 180.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${dashboardController.birthdayDatafilter[0]["phone_no"]}",

                    //   $.rows.[]Employee.phone_no
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: kFW800,
                        color: selectedTheme == "Lighttheme"
                            ? KdarkText.withOpacity(0.5)
                            : Kwhite),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
                    Icons.phone,
                    size: kSixteenFont,
                    color: Kgreen,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          child: child,
          opacity: anim1,
        ),
      ),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    checkForPopUp();
    return UpgradeAlert(
        upgrader: Upgrader(dialogStyle: UpgradeDialogStyle.cupertino),
        child: Scaffold(
          backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
          appBar: const HomeAppBar(),
          floatingActionButton: Container(
              margin: EdgeInsets.only(bottom: 90.h),
              child: FloatingActionButton(
                backgroundColor: KOrange,
                onPressed: () async {
                  await Get.toNamed(Kchat);
                  setState(() {});
                },
                child: Icon(
                  Icons.chat,
                  color: Kwhite,
                  size: 25.r,
                ),
              )),
          body: RefreshIndicator(
            onRefresh: _refreshDashboardData,
            child: DynMouseScroll(
                durationMS: 500,
                scrollSpeed: 8,
                mobilePhysics: const AlwaysScrollableScrollPhysics(),
                builder: (context, controller, physics) => ListView(
                      controller: controller,
                      physics: physics,
                      children: [
                        Obx(
                          () => dashboardController.isLoading.value == false &&
                                  // dashboardController.isProfileLoading.value ==
                                  //     false &&
                                  dashboardController.isHRDataLoading.value ==
                                      false &&
                                  dashboardController.leaverequest.value ==
                                      false &&
                                  leavesController.myleavesLoading.value ==
                                      false &&
                                  dashboardController.isHolydaysLoading.value ==
                                      false
                              ? dashboardController.roleID.value != "Admin" &&
                                      dashboardController.profiledata.isNotEmpty
                                  ? Container(
                                      margin: EdgeInsets.all(13.r),
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              // TextButton(
                                              //     child: Text('Sql data'),
                                              //     onPressed: () {
                                              //       Get.toNamed(KDbTasks);
                                              //     }),
                                              // SizedBox(
                                              //   height: 25.h,
                                              // ),
                                              // TextButton(
                                              //     child: Text('Background Check'),
                                              //     onPressed: () async {
                                              //       final service =
                                              //           FlutterBackgroundService();
                                              //       var isRunning =
                                              //           await service.isRunning();
                                              //       if (isRunning) {
                                              //         service.invoke("stopService");
                                              //       } else {
                                              //         service.startService();
                                              //       }
                                              //     }),
                                              // SizedBox(
                                              //   height: 25.h,
                                              // ),
                                              //***************************** */
                                              const Welcome_card(),

                                              SizedBox(
                                                height: 25.h,
                                              ),
                                              Login_time(
                                                homedir: dashboardController
                                                    .homedata,
                                              ),
                                              SizedBox(
                                                height: 23.h,
                                              ),
                                              const Requests_Screen(),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Categories_Screen(
                                                homedir: dashboardController
                                                    .profiledata,
                                                hrconfigs: dashboardController
                                                    .hrconfigs,
                                                feedback: dashboardController
                                                    .feedbackData,
                                              ),
                                              dashboardController
                                                              .permissiondata[
                                                          "holidays"] ==
                                                      true
                                                  ? SizedBox(
                                                      height: 20.h,
                                                    )
                                                  : const SizedBox(),
                                              dashboardController
                                                              .permissiondata[
                                                          "holidays"] ==
                                                      true
                                                  ? const HolidayCard()
                                                  : const SizedBox(),
                                              //  const Holiday(),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              dashboardController
                                                              .permissiondata[
                                                          "brithdays"] ==
                                                      true
                                                  ? const BirthdayCard()
                                                  : const SizedBox(),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              dashboardController
                                                              .permissiondata[
                                                          "anniversaies"] ==
                                                      true
                                                  ? const AnneversaryCard()
                                                  : const SizedBox(),
                                              dashboardController
                                                              .permissiondata[
                                                          "anniversaies"] ==
                                                      true
                                                  ? SizedBox(
                                                      height: 20.h,
                                                    )
                                                  : const SizedBox(),
                                              // Commented because of static data
                                              // NewEmployeeCard(),
                                              SizedBox(
                                                height: 60.h,
                                              ),
                                              // SizedBox(
                                              //   height: 20.h,
                                              // ),
                                              // Birthdays()
                                            ],
                                          ),
                                          // Obx(() => dashboardController
                                          //         .birthdayDatafilter.isNotEmpty
                                          //     ? DateTime.parse(dashboardController
                                          //                         .birthdayDatafilter[
                                          //                     0]["dob"])
                                          //                 .day-1 ==
                                          //             DateTime.now().day
                                          //         ? Positioned(
                                          //             right: 0,
                                          //             top: 320.h,
                                          //             child: Lottie.asset(
                                          //                 "assets/images/birthday.json",
                                          //                 width: 200.w))
                                          //         : const SizedBox()
                                          //     : const SizedBox()),
                                          // Obx(() => showMessage.value == true
                                          //     ? Stack(
                                          //         children: [
                                          //           // _showBirthdayCard(),
                                          //           Lottie.asset(
                                          //             "assets/images/onetime.json",
                                          //             repeat: false,
                                          //           ),
                                          //         ],
                                          //       )
                                          //     : const SizedBox()),
                                          Obx(() => dashboardController
                                                  .birthdayDatafilter.isNotEmpty
                                              ? DateTime.parse(dashboardController.birthdayDatafilter[0]["dob"])
                                                              .day ==
                                                          DateTime.now().day &&
                                                      dashboardController
                                                                  .profiledata[
                                                              "emp_code"] ==
                                                          dashboardController
                                                                  .birthdayDatafilter[0]
                                                              ["emp_code"]
                                                  ? Positioned(
                                                      right: 0,
                                                      top: 25.h,
                                                      child: Lottie.asset(
                                                          "assets/images/happybirthday.json",
                                                          width: 100.w))
                                                  : const SizedBox()
                                              : const SizedBox()),
                                          Obx(() => dashboardController
                                                  .birthdayDatafilter.isNotEmpty
                                              ? DateTime.parse(dashboardController.birthdayDatafilter[0]["dob"])
                                                              .day ==
                                                          DateTime.now().day &&
                                                      dashboardController
                                                                  .profiledata[
                                                              "emp_code"] ==
                                                          dashboardController
                                                                  .birthdayDatafilter[0]
                                                              ["emp_code"]
                                                  ? Positioned(
                                                      right: 0,
                                                      top: 0.h,
                                                      child: Lottie.asset(
                                                          "assets/images/celebrations.json",
                                                          width: 120.w))
                                                  : const SizedBox()
                                              : const SizedBox())
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: 120.h,
                                        ),
                                        SvgPicture.asset(
                                          INFOS,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Text("No Access For Admin",
                                            style: TextStyle(
                                                color: kblack,
                                                fontSize: 25.sp,
                                                fontWeight: FontWeight.w800)),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        SizedBox(
                                          width: 200.w,
                                          child: Text(
                                              "Please Login Through WebSite",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Klightblack,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        CustomButton(
                                            height: 35.h,
                                            Color: KOrange,
                                            width: 100.w,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.r)),
                                            textColor: Kwhite,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            label: "Logout",
                                            isLoading: false,
                                            onTap: () {
                                              UserSimplePreferences
                                                  .clearAllData();
                                              Get.offAllNamed(
                                                  Kwebaddress_login);
                                            })
                                      ],
                                    )
                              ////loading
                              : Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 50.h,
                                            width: 50.w,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.black12,
                                              highlightColor:
                                                  Colors.white.withOpacity(0.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  // shape: BoxShape.circle,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color:
                                                      Kwhite.withOpacity(0.5),
                                                ),
                                                height: 50.h,
                                                width: 50.w,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          SizedBox(
                                            height: 50.h,
                                            width: 260.w,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.black12,
                                              highlightColor:
                                                  Colors.white.withOpacity(0.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  color:
                                                      Kwhite.withOpacity(0.5),
                                                ),
                                                height: 50.h,
                                                width: 250.w,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      SizedBox(
                                        height: 140.h,
                                        width: 320.w,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.black12,
                                          highlightColor:
                                              Colors.white.withOpacity(0.5),
                                          child: Container(
                                            height: 215.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                              color: Kwhite.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                        width: 320.w,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.black12,
                                          highlightColor:
                                              Colors.white.withOpacity(0.5),
                                          child: Container(
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                              color: Kwhite.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                        width: 320.w,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.black12,
                                          highlightColor:
                                              Colors.white.withOpacity(0.5),
                                          child: Container(
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                              color: Kwhite.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                        width: 320.w,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.black12,
                                          highlightColor:
                                              Colors.white.withOpacity(0.5),
                                          child: Container(
                                            height: 30.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                              color: Kwhite.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 100.h,
                                            width: 150.w,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.black12,
                                              highlightColor:
                                                  Colors.white.withOpacity(0.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color:
                                                      Kwhite.withOpacity(0.5),
                                                ),
                                                height: 100.h,
                                                width: 150.w,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          SizedBox(
                                            height: 100.h,
                                            width: 150.w,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.black12,
                                              highlightColor:
                                                  Colors.white.withOpacity(0.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color:
                                                      Kwhite.withOpacity(0.5),
                                                ),
                                                height: 100.h,
                                                width: 150.w,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 100.h,
                                            width: 150.w,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.black12,
                                              highlightColor:
                                                  Colors.white.withOpacity(0.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color:
                                                      Kwhite.withOpacity(0.5),
                                                ),
                                                height: 100.h,
                                                width: 150.w,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          SizedBox(
                                            height: 100.h,
                                            width: 150.w,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.black12,
                                              highlightColor:
                                                  Colors.white.withOpacity(0.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color:
                                                      Kwhite.withOpacity(0.5),
                                                ),
                                                height: 100.h,
                                                width: 150.w,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                ),
                        )
                      ],
                    )

                // SingleChildScrollView(
                //     child: isLoading == false && isProfileLoading == false
                //         ?
                //         Container(
                //             margin: EdgeInsets.all(13.r),
                //             child: Column(
                //               children: [
                //                 const Welcome_card(),
                //                 SizedBox(
                //                   height: 25.h,
                //                 ),
                //                 Login_time(
                //                   homedir: homedata,
                //                 ),
                //                 SizedBox(
                //                   height: 23.h,
                //                 ),
                //                 const Requests_Screen(),
                //                 SizedBox(
                //                   height: 20.h,
                //                 ),
                //                 Categories_Screen(
                //                     homedir: profiledata, hrconfigs: hrconfigs),
                //                 SizedBox(
                //                   height: 20.h,
                //                 ),
                //                 const Holiday(),
                //               ],
                //             ),
                //           )

                //         : const Center(
                //             child:  SpinKitFadingCircle(
                //               color: KOrange,
                //               size: 25,
                //             ),
                //           )
                //           ),

                ),
          ),
        ));
  }
}
