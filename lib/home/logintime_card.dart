// ignore_for_file: camel_case_types, unused_local_variable, unnecessary_string_interpolations

import 'dart:io';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

import '../untils/export_file.dart';

class Login_time extends StatefulWidget {
  Map? homedir;
  Login_time({super.key, this.homedir});

  @override
  State<Login_time> createState() => _LogintimeState();
}

class _LogintimeState extends State<Login_time> {
  //////
  ///
  void _checkinStatuscheck() {
    if (widget.homedir!["checkin_checkout"]["check_in"]["status"] == true
        // dashboardController.homedata["checkin_checkout"]["check_in"
        //       ["status"] ==
        //   true
        ) {
      final service = FlutterBackgroundService();
      service.startService();
    }
  }

  @override
  void initState() {
    dashboardController.profileListApi();
    _checkinStatuscheck();
    super.initState();
  }

  String _verticalGroupValue = "office";
  final service = FlutterBackgroundService();
  // final _status = ["office", "home"];
  bool isLoading = false;
  var isLaodingMapsData = "none".obs;
  Future<void> getCurrentLocation() async {
    isLaodingMapsData.value = "started";
    Position? position = await _determinePosition();
    setState(() {
      serviceController.position = position;
      serviceController.latittude = serviceController.position!.latitude;
      serviceController.longitude = serviceController.position!.longitude;
      _getAddressFromLatLng(position!);
    });
  }

  String? _currentAddress;
  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(serviceController.position!.latitude,
            serviceController.position!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},${place.postalCode}';
        serviceController.address.value = _currentAddress.toString();
        serviceController.addressLatitude.value =
            serviceController.position!.latitude.toString();
        serviceController.addressLongitude.value =
            serviceController.position!.longitude.toString();
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<Position?> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      } else {
        await _showMyDialog();
        if (isPermissionGiven == true) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            return Future.error('Location permissions are denied');
          }
        } else {
          Fluttertoast.showToast(
            msg: "Denined Location Will Failed To Upload Attendance",
          );
        }
      }
    } else {
      setState(() {
        isPermissionGiven = true;
      });
    }
    Position? newPosition;
    try {
      newPosition = await Geolocator.getCurrentPosition();
      serviceController.loacationIsEnabled(true);
      debugPrint(newPosition.toString());
    } catch (e) {
      debugPrint("$e");
      setState(() {
        isLoading = false;
      });
      serviceController.loacationIsEnabled(false);
    }
    setState(() {
      isLaodingMapsData.value = "ended";
    });
    return newPosition!;
  }

  bool isPermissionGiven = false;
  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 350.h,

              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              // margin: EdgeInsets.only(left: .w,right: 20.w
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('Location Permission',
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: 14.sp,
                          fontWeight: kFW900)),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                      'VIBHOHCM APP collects Your Location Info to MarkUp your Attendance',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: kTenFont,
                          fontWeight: kFW500)),
                  SizedBox(
                    height: 15.h,
                  ),
                  Image.asset(
                    "assets/images/location.png",
                    width: 150.w,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Custom_OutlineButton(
                          borderRadius: BorderRadius.circular(15.r),
                          margin: EdgeInsets.all(10.r),
                          width: 110.w,
                          height: 35.h,
                          Color: KOrange,
                          textColor: KOrange,
                          fontSize: 12.sp,
                          fontWeight: kFW700,
                          label: "Cancel",
                          isLoading: false,
                          onTap: () {
                            setState(() {
                              isPermissionGiven = false;
                            });
                            Navigator.of(context).pop();
                          }),
                      CustomButton(
                          borderRadius: BorderRadius.circular(15.r),
                          margin: EdgeInsets.all(10.r),
                          width: 110.w,
                          height: 35.h,
                          Color: KOrange,
                          textColor: Kwhite,
                          fontSize: 12.sp,
                          fontWeight: kFW700,
                          label: "Accept",
                          isLoading: false,
                          onTap: () {
                            setState(() {
                              isPermissionGiven = true;
                            });
                            Navigator.of(context).pop();
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

  Future attendancesHandler(
      String type,
      String _verticalGroupValue,
      String currentlatitude,
      String currentLongitude,
      String currentlocationpoint) async {
    setState(() {
      isLoading = true;
    });
    await getCurrentLocation();
    setState(() {
      if (type == "in") {
        widget.homedir!["checkin_checkout"]["check_in"]["status"] = true;
        widget.homedir!["checkin_checkout"]["check_in"]["time"] =
            DateTime.now();
        widget.homedir!["checkin_checkout"]["check_out"]["status"] = false;
        final service = FlutterBackgroundService();

        service.startService();
        //  Fluttertoast.showToast(msg: "Background Service Started");
      } else {
        widget.homedir!["checkin_checkout"]["check_in"]["status"] = false;
        widget.homedir!["checkin_checkout"]["check_out"]["status"] = true;
        widget.homedir!["checkin_checkout"]["check_out"]["time"] =
            DateTime.now();
        //  final service = FlutterBackgroundService();
        service.invoke("stopService");
        //   Fluttertoast.showToast(msg: "Background Service Stopped");
      }
    });
    Map payload = {
      "type": type,
      "work_from": _verticalGroupValue,
      "latitude": currentlatitude,
      "longitude": currentLongitude,
      "location": currentlocationpoint
    };
    // {
    //   "type": type,
    //   "work_from": _verticalGroupValue,
    //   "latitude": currentlatitude,
    //   "longitude": currentLongitude,
    //   "location": currentlocationpoint
    // };
//     { serviceController.address.value
//   "type": "in",
//   "work_from": "office",
//   "latitude": "string",
//   "longitude": "string",
//   "location": "string"
// }
    //  {"type": type};

    Map value = await Services.checkinV2(payload);
    if (value["message"] != null) {
      // Fluttertoast.showToast(msg: value["message"]);
    } else {}

    setState(() {
      isLoading = false;
    });
  }

  Future attendancesHandlerWithSelfee(
      String type,
      String _verticalGroupValue,
      String currentlatitude,
      String currentLongitude,
      String currentlocationpoint,
      String selfee) async {
    setState(() {
      if (type == "in") {
        widget.homedir!["checkin_checkout"]["check_in"]["status"] = true;
        widget.homedir!["checkin_checkout"]["check_in"]["time"] =
            DateTime.now();
        widget.homedir!["checkin_checkout"]["check_out"]["status"] = false;
        final service = FlutterBackgroundService();
        service.startService();
        //  Fluttertoast.showToast(msg: "Background Service Started");
      } else {
        widget.homedir!["checkin_checkout"]["check_in"]["status"] = false;
        widget.homedir!["checkin_checkout"]["check_out"]["status"] = true;
        widget.homedir!["checkin_checkout"]["check_out"]["time"] =
            DateTime.now();
        //  final service = FlutterBackgroundService();
        service.invoke("stopService");
        //   Fluttertoast.showToast(msg: "Background Service Stopped");
      }
    });
    Map payload = {
      "type": type,
      "work_from": _verticalGroupValue,
      "latitude": currentlatitude,
      "longitude": currentLongitude,
      "location": currentlocationpoint,
      "selfie": selfee
    };
    // {
    //   "type": type,
    //   "work_from": _verticalGroupValue,
    //   "latitude": currentlatitude,
    //   "longitude": currentLongitude,
    //   "location": currentlocationpoint
    // };
//     { serviceController.address.value
//   "type": "in",
//   "work_from": "office",
//   "latitude": "string",
//   "longitude": "string",
//   "location": "string"
// }
    //  {"type": type};

    Map value = await Services.checkinV2(payload);
    if (value["message"] != null) {
      // Fluttertoast.showToast(msg: value["message"]);
    } else {}
  }

  final String DATE = 'assets/images/date.svg';
  final String LOCATION = 'assets/images/location.svg';
  ServiceController serviceController = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {
    ////
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm a').format(now);

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 6),
                color: Ktextcolor.withOpacity(0.2),
              )
            ],
            // boxShadow: [
            //   BoxShadow(
            //     color: Ktextcolor.withOpacity(0.5),
            //     blurRadius: 10,
            //     offset: const Offset(0, 0),
            //     spreadRadius: 2,
            //   )
            // ],
            borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          children: [
            UserSimplePreferences.getMapShowStatic() != null
                ? UserSimplePreferences.getMapShowStatic() != false
                    ? Container(
                        height: 140.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Kwhite,
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.r),
                                topRight: Radius.circular(8.r)),
                            child: const Google_map()),
                      )
                    : const SizedBox()
                : Container(
                    height: 140.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Kwhite,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.r),
                            topRight: Radius.circular(8.r)),
                        child: const Google_map()),
                  ),
            Container(
              padding: EdgeInsets.all(13.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        //DateFormat('hh:mm a').format(DateTime.now()),

                        "${TimeOfDay.fromDateTime(DateTime.now()).format(context)} ",
                        style: TextStyle(
                            fontSize: kEighteenFont,
                            fontWeight: kFW600,
                            color: selectedTheme == "Lighttheme"
                                ? KdarkText
                                : Kwhite),
                      ),
                      isLoading == false
                          ? widget.homedir != null
                              ?
                              // ? (widget.homedir!["checkin_checkout"]
                              //                 ["check_out"]["status"] ==
                              //             true &&
                              //         widget.homedir!["checkin_checkout"]
                              //                 ["check_in"]["status"] ==
                              //             true)
                              //     ? CustomButton(
                              //         Color: KOrange,
                              //         fontWeight: kFW600,
                              //         fontSize: 13.sp,
                              //         borderRadius: BorderRadius.circular(5.r),
                              //         Padding: EdgeInsets.only(
                              //             left: 20.w,
                              //             right: 20.w,
                              //             top: 6.h,
                              //             bottom: 6.h),
                              //         label: "Check In",
                              //         //  "Check-In",
                              //         textColor: Kwhite,
                              //         isLoading: false,
                              //         onTap: () {
                              //           attendancesHandler("in");
                              //         })
                              //     :
                              Obx(() => CustomButton(
                                      Color: KOrange,
                                      // Color: widget.homedir!["checkin_checkout"] !=
                                      //         null
                                      //     ? widget.homedir!["checkin_checkout"]
                                      //                     ["check_out"]
                                      //                 ["status"] !=
                                      //             true
                                      //         ? widget.homedir!["checkin_checkout"]
                                      //                         ["check_in"]
                                      //                     ["status"] ==
                                      //                 true
                                      //             ? KOrange
                                      //             : KOrange
                                      //         : Klightgray
                                      //     : KOrange,
                                      // Klightgray.withOpacity(0.6),

                                      fontWeight: kFW600,
                                      fontSize: 13.sp,
                                      borderRadius: BorderRadius.circular(5.r),
                                      Padding: EdgeInsets.only(
                                          left: 20.w,
                                          right: 20.w,
                                          top: 6.h,
                                          bottom: 6.h),
                                      label: widget.homedir![
                                                  "checkin_checkout"] !=
                                              null
                                          ? widget.homedir!["checkin_checkout"]
                                                      ["check_in"]["status"] ==
                                                  true
                                              ? "Check Out"
                                              : "Check In"
                                          : "Check In",
                                      //  "Check-In",
                                      textColor: Kwhite,
                                      isLoading: false,
                                      onTap: () async {
                                        if (dashboardController
                                                .role["is_selfie_enabled"] !=
                                            null) {
                                          if (dashboardController
                                                  .role["is_selfie_enabled"] ==
                                              false) {
                                            widget.homedir!["checkin_checkout"]
                                                            ["check_in"]
                                                        ["status"] ==
                                                    true
                                                // ? widget.homedir![
                                                //                 "checkin_checkout"]
                                                //             [
                                                //             "check_in"]["status"] ==
                                                //         true
                                                ? attendancesHandler(
                                                    "out",
                                                    _verticalGroupValue,
                                                    serviceController
                                                        .addressLatitude.value,
                                                    serviceController
                                                        .addressLongitude.value,
                                                    serviceController
                                                        .address.value)
                                                : attendancesHandler(
                                                    "in",
                                                    _verticalGroupValue,
                                                    serviceController
                                                        .addressLatitude.value,
                                                    serviceController
                                                        .addressLongitude.value,
                                                    serviceController
                                                        .address.value);
                                          } else {
                                            if (UserSimplePreferences
                                                        .getSelfeeEnableStatic() !=
                                                    null &&
                                                UserSimplePreferences
                                                        .getSelfeeEnableStatic() !=
                                                    false) {
                                              if (widget.homedir![
                                                          "checkin_checkout"]
                                                      ["check_in"]["status"] ==
                                                  false) {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                File? selectedImage;
                                                debugPrint("Task Selfee");
                                                await getCurrentLocation();
                                                var image = await ImagePicker()
                                                    .pickImage(
                                                        source:
                                                            ImageSource.camera,
                                                        preferredCameraDevice:
                                                            CameraDevice.front,
                                                        imageQuality: 6);
                                                if (image != null) {
                                                  selectedImage =
                                                      File(image.path);
                                                  Map imageValue =
                                                      await Services
                                                          .uploadSelfeeToServer(
                                                              selectedImage
                                                                  .path,
                                                              "other");
                                                  attendancesHandlerWithSelfee(
                                                      "in",
                                                      _verticalGroupValue,
                                                      serviceController
                                                          .addressLatitude
                                                          .value,
                                                      serviceController
                                                          .addressLongitude
                                                          .value,
                                                      serviceController
                                                          .address.value,
                                                      imageValue["Location"]);
                                                }
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              } else {
                                                attendancesHandler(
                                                    "out",
                                                    _verticalGroupValue,
                                                    serviceController
                                                        .addressLatitude.value,
                                                    serviceController
                                                        .addressLongitude.value,
                                                    serviceController
                                                        .address.value);
                                              }
                                            } else {
                                              widget.homedir!["checkin_checkout"]
                                                              ["check_in"]
                                                          ["status"] ==
                                                      true
                                                  // ? widget.homedir![
                                                  //                 "checkin_checkout"]
                                                  //             [
                                                  //             "check_in"]["status"] ==
                                                  //         true
                                                  ? attendancesHandler(
                                                      "out",
                                                      _verticalGroupValue,
                                                      serviceController
                                                          .addressLatitude
                                                          .value,
                                                      serviceController
                                                          .addressLongitude
                                                          .value,
                                                      serviceController
                                                          .address.value)
                                                  : attendancesHandler(
                                                      "in",
                                                      _verticalGroupValue,
                                                      serviceController
                                                          .addressLatitude
                                                          .value,
                                                      serviceController
                                                          .addressLongitude
                                                          .value,
                                                      serviceController
                                                          .address.value);
                                            }
                                          }
                                        } else {
                                          widget.homedir!["checkin_checkout"]
                                                      ["check_in"]["status"] ==
                                                  true
                                              // ? widget.homedir![
                                              //                 "checkin_checkout"]
                                              //             [
                                              //             "check_in"]["status"] ==
                                              //         true
                                              ? attendancesHandler(
                                                  "out",
                                                  _verticalGroupValue,
                                                  serviceController
                                                      .addressLatitude.value,
                                                  serviceController
                                                      .addressLongitude.value,
                                                  serviceController
                                                      .address.value)
                                              : attendancesHandler(
                                                  "in",
                                                  _verticalGroupValue,
                                                  serviceController
                                                      .addressLatitude.value,
                                                  serviceController
                                                      .addressLongitude.value,
                                                  serviceController
                                                      .address.value);
                                        }
                                      })
                                  // CustomButton(
                                  //     Color: widget.homedir!["checkin_checkout"] !=
                                  //             null
                                  //         ? widget.homedir!["checkin_checkout"]
                                  //                     ["check_out"]["status"] !=
                                  //                 true
                                  //             ? widget.homedir!["checkin_checkout"]
                                  //                             ["check_in"]
                                  //                         ["status"] ==
                                  //                     true
                                  //                 ? KOrange
                                  //                 : KOrange
                                  //             : Klightgray
                                  //         : KOrange,
                                  //     // Klightgray.withOpacity(0.6),

                                  //     fontWeight: kFW600,
                                  //     fontSize: 13.sp,
                                  //     borderRadius: BorderRadius.circular(5.r),
                                  //     Padding: EdgeInsets.only(
                                  //         left: 20.w,
                                  //         right: 20.w,
                                  //         top: 6.h,
                                  //         bottom: 6.h),
                                  //     label: widget.homedir!["checkin_checkout"] !=
                                  //             null
                                  //         ? widget.homedir!["checkin_checkout"]
                                  //                     ["check_out"]["status"] !=
                                  //                 true
                                  //             ? widget.homedir!["checkin_checkout"]
                                  //                             ["check_in"]
                                  //                         ["status"] ==
                                  //                     true
                                  //                 ? "Check Out"
                                  //                 : "Check In"
                                  //             : "Done"
                                  //         : "Check In",
                                  //     //  "Check-In",
                                  //     textColor: Kwhite,
                                  //     isLoading: false,
                                  //     onTap: () {
                                  //       widget.homedir!["checkin_checkout"]
                                  //                   ["check_out"]["status"] !=
                                  //               true
                                  //           ? widget.homedir![
                                  //                           "checkin_checkout"]
                                  //                       [
                                  //                       "check_in"]["status"] ==
                                  //                   true
                                  //               ? attendancesHandler(
                                  //                   "out",
                                  //                   _verticalGroupValue,
                                  //                   serviceController
                                  //                       .addressLatitude.value,
                                  //                   serviceController
                                  //                       .addressLongitude.value,
                                  //                   serviceController
                                  //                       .address.value)
                                  //               : attendancesHandler(
                                  //                   "in",
                                  //                   _verticalGroupValue,
                                  //                   serviceController
                                  //                       .addressLatitude.value,
                                  //                   serviceController
                                  //                       .addressLongitude.value,
                                  //                   serviceController
                                  //                       .address.value)
                                  //           : null;
                                  //     })
                                  )
                              : const SizedBox()
                          : Container(
                              width: 80.w,
                              alignment: Alignment.center,
                              child: SpinKitFadingCircle(
                                color: KOrange,
                                size: 25,
                              ),
                            )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(DATE,
                          color: selectedTheme == "Lighttheme"
                              ? KCustomDarktwo
                              : Kwhite,
                          semanticsLabel: 'Acme Logo'),
                      SizedBox(
                        width: 8.w,
                      ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text:
                              "${DateFormat.MMMd().format(DateTime.now())} | ",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: kFW500,
                              color: selectedTheme == "Lighttheme"
                                  ? KCustomDark
                                  : Kwhite),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${DateFormat.E().format(DateTime.now())} ',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: kFW500,
                                  color: selectedTheme == "Lighttheme"
                                      ? KCustomDark
                                      : Kwhite
                                  //  KCustomDark
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Obx(() => serviceController.address.value == ""
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "No Location Address Found",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: kFW700,
                                color: KCustomDark),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(LOCATION,
                                color: selectedTheme == "Lighttheme"
                                    ? KCustomDarktwo
                                    : Kwhite,
                                semanticsLabel: 'Acme Logo'),
                            //  Image.asset("assets/images/location.svg"),
                            SizedBox(
                              width: 8.w,
                            ),

                            SizedBox(
                                width: 250.w,
                                child: Text(
                                  // "Hello,/ world! i a-m 'fo+o'"
                                  //     .replaceAll(new RegExp('\W+'), ''),
                                  serviceController.address.value
                                      .replaceAll(RegExp(r'[+-/_]'), ''),

                                  /// serviceController.address.value,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW400,
                                      height: 1.2,
                                      color: selectedTheme == "Lighttheme"
                                          ? KCustomDarktwo
                                          : Kwhite),
                                )),
                          ],
                        )),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.homedir!["checkin_checkout"] != null
                          ? widget.homedir!["checkin_checkout"]["check_in"]
                                      ["time"] !=
                                  null
                              ? Text(
                                  "Check-in:${DateFormat(' hh:mm aaa').format(DateTime.parse(widget.homedir!["checkin_checkout"]["check_in"]["time"].toString()))}",
                                  style: GoogleFonts.inter(
                                      fontSize: 11.sp,
                                      color: selectedTheme == "Lighttheme"
                                          ? KdarkText
                                          : Kwhite,
                                      fontWeight: kFW600),
                                )
                              : const SizedBox()
                          : const SizedBox(),
                      widget.homedir!["checkin_checkout"] != null
                          ? widget.homedir!["checkin_checkout"]["check_out"]
                                      ["time"] !=
                                  null
                              ? Text(
                                  "Check-out:${DateFormat(' hh:mm aaa').format(DateTime.parse(widget.homedir!["checkin_checkout"]["check_out"]["time"].toString()))}",
                                  style: GoogleFonts.inter(
                                      fontSize: 11.sp,
                                      color: KdarkText,
                                      fontWeight: kFW600),
                                )
                              : const SizedBox()
                          : const SizedBox(),
                    ],
                  ),
                  // Obx(() => widget.homedir!["checkin_checkout"]["check_in"]
                  //             ["status"] !=
                  //         true
                  //     // widget.homedir!["checkin_checkout"]["check_in"]
                  //     //                 ["status"] !=
                  //     //             true
                  //     //             &&
                  //     //         widget.homedir!["checkin_checkout"]["check_out"]
                  //     //                 ["status"] !=
                  //     //             true
                  //     ? Padding(
                  //         padding:
                  //             const EdgeInsets.only(left: 16.0, right: 16.0),
                  //         child: RadioGroup<String>.builder(
                  //           direction: Axis.horizontal,
                  //           activeColor: KOrange,
                  //           groupValue: _verticalGroupValue,
                  //           horizontalAlignment: MainAxisAlignment.start,
                  //           onChanged: (value) => setState(() {
                  //             _verticalGroupValue = value ?? '';
                  //           }),
                  //           items: _status,
                  //           textStyle: TextStyle(
                  //               fontSize: kTwelveFont,
                  //               fontWeight: FontWeight.bold,
                  //               color: selectedTheme == "Lighttheme"
                  //                   ? KCustomDarktwo
                  //                   : Kwhite),
                  //           itemBuilder: (item) => RadioButtonBuilder(
                  //             item.capitalizeFirst!,
                  //           ),
                  //         ),
                  //       )
                  //     : const SizedBox()),
                ],
              ),
            )
          ],
        ));
  }
}
