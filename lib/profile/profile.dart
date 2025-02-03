// ignore_for_file: camel_case_types, prefer_if_null_operators

import 'dart:ui';

import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:vibeshr/controllers/profileController.dart';

import '../untils/export_file.dart';

class Profile_view extends StatefulWidget {
  final int bACK;
  const Profile_view({super.key, required this.bACK});

  @override
  State<Profile_view> createState() => _Profile_viewState();
}

class _Profile_viewState extends State<Profile_view> {
  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  ServiceController serviceController = Get.put(ServiceController());
  ProfileController profileController = Get.put(ProfileController());

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
                  Text('Please allow location permission for the Attendance',
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

  _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
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

    profileController.isProfileLoading.value = false;

    return await Geolocator.getCurrentPosition();
  }

  String? _currentAddress;
  bool isLoading = false;
  void _getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });
    Position position = await _determinePosition();
    setState(() {
      serviceController.position = position;
      serviceController.latittude = serviceController.position!.latitude;
      serviceController.longitude = serviceController.position!.longitude;
      _getAddressFromLatLng(position);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(serviceController.position!.latitude,
            serviceController.position!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},${place.postalCode}';
        serviceController.address.value = _currentAddress.toString();
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  List<String> interests = [
    'Singing',
    'Exploring Places',
    'Storytelling',
    'Influencer',
  ];

  final String LOCATION = 'assets/images/location.svg';

  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) async {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
    UserSimplePreferences().setMapShowSTatuc(isSwitched);
  }

  Future<void> _refreshData() async {
    profileController.onInit();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        appBar: VibhoAppBar(
            bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
            //  bColor: selectedTheme == "Lighttheme" ? Kthemeblack : Kwhite,
            title: 'Profile',
            trailing: widget.bACK == 1
                ? Padding(
                    padding: EdgeInsets.only(right: 15.w, top: 5.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(KSetting);
                      },
                      child: Image.asset(
                        "assets/images/setting1.png",
                        width: 25.w,
                        color: selectedTheme == "Lighttheme" ? null : Kwhite,
                      ),
                    ),
                  )
                : const SizedBox(),
            //

            dontHaveBackAsLeading: widget.bACK == 1 ? true : false),
        body: RefreshIndicator(
            onRefresh: _refreshData,
            child: Obx(
              () => profileController.isProfileLoading.value == false
                  ? SingleChildScrollView(
                      child: Container(
                          margin: EdgeInsets.all(15.r),
                          child:
                              // profileController.profiledata["profile_pic"] !=
                              //         null
                              //     //profiledata != null
                              //     ?
                              Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showGeneralDialog(
                                    barrierDismissible: true,
                                    barrierLabel: '',
                                    barrierColor: Colors.black38,
                                    transitionDuration:
                                        const Duration(milliseconds: 200),
                                    pageBuilder: (ctx, anim1, anim2) =>
                                        AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(32.0))),
                                      backgroundColor:
                                          selectedTheme == "Lighttheme"
                                              ? const Color.fromRGBO(
                                                  255, 255, 255, 0.9)
                                              : Kthemeblack,
                                      title: Container(

                                          // decoration: BoxDecoration(
                                          //   borderRadius:
                                          //       BorderRadius.circular(80.r),
                                          // ),
                                          child: profileController.profiledata[
                                                          "profile_pic"] !=
                                                      null ||
                                                  profileController.profiledata[
                                                          "profile_pic"] !=
                                                      ""
                                              ? Image.network(
                                                  //   KProfileimage +
                                                  profileController.profiledata[
                                                      "profile_pic"],
                                                  // : (context,
                                                  //         child,
                                                  //         loadingProgress) =>
                                                  //     SizedBox(
                                                  //   height: 90.h,
                                                  //   width: 90.w,
                                                  //   child: Shimmer.fromColors(
                                                  //     baseColor: Colors.black12,
                                                  //     highlightColor: Colors
                                                  //         .white
                                                  //         .withOpacity(0.5),
                                                  //     child: Container(
                                                  //       decoration:
                                                  //           BoxDecoration(
                                                  //         shape:
                                                  //             BoxShape.circle,
                                                  //         color: Kwhite
                                                  //             .withOpacity(0.5),
                                                  //       ),
                                                  //       height: 90.h,
                                                  //       width: 90.w,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                    return profileController
                                                                    .profiledata[
                                                                "gender"] ==
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
                                                          );
                                                  },
                                                  fit: BoxFit.cover,
                                                )
                                              : profileController.profiledata[
                                                          "gender"] ==
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
                                                    )),
                                      elevation: 2,
                                    ),
                                    transitionBuilder:
                                        (ctx, anim1, anim2, child) =>
                                            BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 4 * anim1.value,
                                          sigmaY: 4 * anim1.value),
                                      child: FadeTransition(
                                        opacity: anim1,
                                        child: child,
                                      ),
                                    ),
                                    context: context,
                                  );
                                },
                                child: Container(
                                    margin: const EdgeInsets.all(5),
                                    height: 90.h,
                                    width: 90.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(80.r)),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(80.r),
                                        child: profileController.profiledata[
                                                        "profile_pic"] !=
                                                    null &&
                                                profileController.profiledata[
                                                        "profile_pic"] !=
                                                    ""
                                            ? CachedNetworkImage(
                                                imageUrl:
                                                    // KProfileimage +
                                                    profileController
                                                            .profiledata[
                                                        "profile_pic"],
                                                placeholder: (context, url) =>
                                                    SizedBox(
                                                  height: 90.h,
                                                  width: 90.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 90.h,
                                                      width: 90.w,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    profileController
                                                                    .profiledata[
                                                                "gender"] ==
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

                                            // Image.network(
                                            //     KProfileimage +
                                            //         profileController.profiledata[
                                            //             "profile_pic"],
                                            //     errorBuilder:
                                            //         (BuildContext context,
                                            //             Object exception,
                                            //             StackTrace? stackTrace) {
                                            //       return Image.asset(
                                            //         "assets/images/man.png",
                                            //         fit: BoxFit.contain,
                                            //       );
                                            //     },
                                            //     fit: BoxFit.cover,
                                            //   )
                                            : profileController.profiledata[
                                                        "gender"] ==
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
                                                  ))),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                profileController.profiledata["fname"] != null
                                    ? "${profileController.profiledata["fname"]} ${profileController.profiledata["lname"]}"
                                    : "-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: kFW700,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: profileController
                                              .profiledata["Designation"] !=
                                          null
                                      ? "${profileController.profiledata["Designation"]["designation_name"]} | "
                                      : "-",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: kFW400,
                                      color: selectedTheme == "Lighttheme"
                                          ? Klightblack.withOpacity(0.8)
                                          : Kwhite
                                      //  Klightblack.withOpacity(0.8)
                                      ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: profileController
                                                  .profiledata["emp_code"] !=
                                              null
                                          ? profileController
                                              .profiledata["emp_code"]
                                          : "-",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: kFW900,
                                          color: KOrange),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Get.toNamed(KEditProfile);
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(top: 4.h, bottom: 4.h),
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color: KDarkskyblue.withOpacity(0.15)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/write.png",
                                          width: 18,
                                          color: selectedTheme == "Lighttheme"
                                              ? Klightblack.withOpacity(0.8)
                                              : Kwhite,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          "Edit",
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.bold,
                                              color: selectedTheme ==
                                                      "Lighttheme"
                                                  ? Klightblack.withOpacity(0.8)
                                                  : Kwhite),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 15.h,
                              ),
                              Container(
                                  margin: EdgeInsets.all(5.r),
                                  padding: EdgeInsets.all(10.r),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13.r),
                                    color: selectedTheme == "Lighttheme"
                                        ? Kwhite
                                        : Kthemeblack,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Ktextcolor.withOpacity(0.15),
                                        blurRadius: 5,
                                        offset: const Offset(0, 0),
                                        spreadRadius: 4,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "About",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: kFW700,
                                            color: selectedTheme == "Lighttheme"
                                                ? KdarkText
                                                : Kwhite),
                                      ),

                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        profileController
                                                    .profiledata["comments"] !=
                                                null
                                            ? profileController.profiledata[
                                                        "comments"] !=
                                                    "\n"
                                                ? profileController
                                                    .profiledata["comments"]
                                                : " - "
                                            : " - ",
                                        maxLines: 8,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            height: 1.1.h,
                                            fontSize: 11.sp,
                                            fontWeight: kFW500,
                                            color: selectedTheme == "Lighttheme"
                                                ? Klightblack
                                                : Kwhite),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Text(
                                        "Personal Details",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: kFW700,
                                            color: selectedTheme == "Lighttheme"
                                                ? KdarkText
                                                : Kwhite),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Gender",
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: kFW700,
                                                    color: KOrange.withOpacity(
                                                        0.7)),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Text(
                                                profileController.profiledata[
                                                            "gender"] !=
                                                        null
                                                    ? profileController
                                                        .profiledata["gender"]
                                                    : "-",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: kFW700,
                                                    color: selectedTheme ==
                                                            "Lighttheme"
                                                        ? kblack
                                                        : Kwhite),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                "Date of Joining",
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: kFW700,
                                                    color: KOrange.withOpacity(
                                                        0.7)),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Text(
                                                profileController.profiledata[
                                                            "date_of_joining"] !=
                                                        null
                                                    ? DateFormat("dd-MMM-yyyy")
                                                        .format(DateTime.parse(
                                                            profileController
                                                                .profiledata[
                                                                    "date_of_joining"]
                                                                .toString()))
                                                    : "-",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: kFW700,
                                                    color: selectedTheme ==
                                                            "Lighttheme"
                                                        ? kblack
                                                        : Kwhite),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Date of Birth",
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: kFW700,
                                                    color: KOrange.withOpacity(
                                                        0.7)),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Text(
                                                profileController.profiledata[
                                                            "dob"] !=
                                                        null
                                                    ? DateFormat("dd-MMM-yyyy")
                                                        .format(DateTime.parse(
                                                            profileController
                                                                .profiledata[
                                                                    "dob"]
                                                                .toString()))
                                                    : "-",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: kFW700,
                                                    color: selectedTheme ==
                                                            "Lighttheme"
                                                        ? kblack
                                                        : Kwhite),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                "Account No:",
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: kFW700,
                                                    color: KOrange.withOpacity(
                                                        0.7)),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Text(
                                                profileController.profiledata[
                                                            "account_number"] !=
                                                        null
                                                    ? profileController
                                                        .profiledata[
                                                            "account_number"]
                                                        .toString()
                                                    : "-",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: kFW700,
                                                    color: selectedTheme ==
                                                            "Lighttheme"
                                                        ? kblack
                                                        : Kwhite),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Address:",
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: kFW700,
                                                color:
                                                    KOrange.withOpacity(0.7)),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                "assets/images/pray.png",
                                                width: 18,
                                                color: KOrange,
                                                fit: BoxFit.fill,
                                              ),
                                              SizedBox(
                                                width: 280.w,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    profileController
                                                            .profiledata
                                                            .isNotEmpty
                                                        ? profileController
                                                            .profiledata[
                                                                "permanent_address"]
                                                            .toString()
                                                            .trim()
                                                        : "-",
                                                    maxLines: 10,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontWeight: kFW700,
                                                        color: selectedTheme ==
                                                                "Lighttheme"
                                                            ? kblack
                                                            : Kwhite),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      //////////////////////Role
                                      profileController.roledata["Role"] != null
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  "Designation",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight: kFW700,
                                                      color: selectedTheme ==
                                                              "Lighttheme"
                                                          ? KdarkText
                                                          : Kwhite),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                  // profileController
                                                  //             .profiledata["comments"] !=
                                                  //         null
                                                  profileController.profiledata[
                                                              "Designation"][
                                                          "designation_name"] ??
                                                      "",

                                                  maxLines: 8,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontWeight: kFW700,
                                                      color: selectedTheme ==
                                                              "Lighttheme"
                                                          ? kblack
                                                              .withOpacity(0.7)
                                                          : Kwhite),
                                                ),
                                              ],
                                            )
                                          : SizedBox(),

                                      ///////////////
                                      ///////Mangers Tream
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      profileController.profiledata[
                                                      "LeadManager"] !=
                                                  null &&
                                              profileController.profiledata[
                                                      "ReportManager"] !=
                                                  null &&
                                              profileController.profiledata[
                                                      "HrManager"] !=
                                                  null
                                          ? Text(
                                              "Management Team",
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: kFW800,
                                                  color: selectedTheme ==
                                                          "Lighttheme"
                                                      ? KdarkText
                                                      : Kwhite),
                                            )
                                          : const SizedBox(),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          profileController.profiledata[
                                                      "LeadManager"] !=
                                                  null
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Lead Manager",
                                                      style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight: kFW700,
                                                          color: KOrange
                                                              .withOpacity(
                                                                  0.7)),
                                                    ),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    SizedBox(
                                                      width: 130.w,
                                                      child: Text(
                                                        profileController.profiledata[
                                                                        "LeadManager"]
                                                                    ["fname"] !=
                                                                null
                                                            ? "${profileController.profiledata["LeadManager"]["fname"]} ${profileController.profiledata["LeadManager"]["lname"]}"
                                                            : "-",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 11.sp,
                                                            fontWeight: kFW700,
                                                            color: selectedTheme ==
                                                                    "Lighttheme"
                                                                ? kblack
                                                                : Kwhite),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                          profileController.profiledata[
                                                      "ReportManager"] !=
                                                  null
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Reporting Manager",
                                                      style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight: kFW700,
                                                          color: KOrange
                                                              .withOpacity(
                                                                  0.7)),
                                                    ),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    SizedBox(
                                                      width: 130.w,
                                                      child: Text(
                                                        profileController.profiledata[
                                                                        "ReportManager"]
                                                                    ["fname"] !=
                                                                null
                                                            ? "${profileController.profiledata["ReportManager"]["fname"]} ${profileController.profiledata["ReportManager"]["lname"]}"
                                                            : "-",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 11.sp,
                                                            fontWeight: kFW700,
                                                            color: selectedTheme ==
                                                                    "Lighttheme"
                                                                ? kblack
                                                                : Kwhite),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      profileController
                                                  .profiledata["HrManager"] !=
                                              null
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "HR Manager",
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontWeight: kFW700,
                                                      color:
                                                          KOrange.withOpacity(
                                                              0.7)),
                                                ),
                                                Text(
                                                  profileController.profiledata[
                                                                  "HrManager"]
                                                              ["fname"] !=
                                                          null
                                                      ? "${profileController.profiledata["HrManager"]["fname"]} ${profileController.profiledata["HrManager"]["lname"]}"
                                                      : "-",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontWeight: kFW700,
                                                      color: selectedTheme ==
                                                              "Lighttheme"
                                                          ? kblack
                                                          : Kwhite),
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),

                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      // Text(
                                      //   "Interests",
                                      //   style: TextStyle(
                                      //       fontSize: 15.sp,
                                      //       fontWeight: kFW700,
                                      //       color: KdarkText),
                                      // ),
                                      // Container(
                                      //   alignment: Alignment.center,
                                      //   //height: MediaQuery.of(context).size.height * 0.0,
                                      //   child: Wrap(
                                      //       children: interests
                                      //           .map((interest) => Container(
                                      //                 margin: EdgeInsets.only(
                                      //                     right: 10.w, top: 10.h),
                                      //                 decoration: BoxDecoration(
                                      //                     borderRadius:
                                      //                         BorderRadius.circular(12.r),
                                      //                     border: Border.all(
                                      //                         color:
                                      //                             Kgreen.withOpacity(0.2))),
                                      //                 padding: EdgeInsets.symmetric(
                                      //                     horizontal: MediaQuery.of(context)
                                      //                             .size
                                      //                             .width *
                                      //                         0.040,
                                      //                     vertical: MediaQuery.of(context)
                                      //                             .size
                                      //                             .height *
                                      //                         0.0035),
                                      //                 child: Text(interest,
                                      //                     style: TextStyle(
                                      //                         fontSize: 11.5.sp,
                                      //                         fontWeight: kFW600,
                                      //                         color: Klightblack.withOpacity(
                                      //                             0.9))),
                                      //               ))
                                      //           .toList()),
                                      // ),
                                    ],
                                  )),
                              SizedBox(
                                height: 100.h,
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       "Show Location",
                              //       style: TextStyle(
                              //           fontSize: 13.sp,
                              //           fontWeight: kFW900,
                              //           color: selectedTheme == "Lighttheme"
                              //               ? KdarkText
                              //               : Kwhite),
                              //     ),
                              //     Switch(
                              //       onChanged: toggleSwitch,
                              //       value: UserSimplePreferences
                              //               .getMapShowStatic() ??
                              //           true,
                              //       activeColor: KOrange,
                              //       activeTrackColor: KOrange.withOpacity(0.7),
                              //       inactiveThumbColor: Klightgray,
                              //       inactiveTrackColor:
                              //           Klightgray.withOpacity(0.5),
                              //     )
                              //   ],
                              // ),
                            ],
                          )
                          // : Padding(
                          //     padding: EdgeInsets.only(top: 250.h),
                          //     child: const  SpinKitFadingCircle(
                          //       color: KOrange,
                          //       size: 25,
                          //     ),
                          //   ),
                          ))
                  : const SpinKitFadingCircle(
                      color: KOrange,
                      size: 50,
                    ),
            )));
  }
}
