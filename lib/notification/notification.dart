// ignore_for_file: camel_case_types, depend_on_referenced_packages

import '../untils/export_file.dart';

class Notification_screen extends StatefulWidget {
  const Notification_screen({super.key});

  @override
  State<Notification_screen> createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notification_screen> {
  bool isLoadingDeleted = false;
  deleteEmployeeNotification(int id) async {
    setState(() {
      isLoadingDeleted = true;
      for (int i = 0; i < newNotificationsPacks.length; i++) {
        if (id == newNotificationsPacks[i]["notification_employee_id"]) {
          setState(() {
            newNotificationsPacks.remove(newNotificationsPacks[i]);
          });
        }
      }
    });
    Map value = await Services.deleteNotifications(id);
    if (value["message"] == null) {
    } else {}
    setState(() {
      isLoadingDeleted = false;
    });
  }

  List newNotificationsPacks = [];
  Map notifiydata = {};
  bool isLoading = false;
  Future notifiyHandler() async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.notification();

    if (data["message"] != null) {
      // Fluttertoast.showToast(
      //   msg: data["message"],
      // );
    } else {
      setState(() {
        notifiydata = data;
        for (int i = 0; i < notifiydata["rows"].length; i++) {
          if (notifiydata["rows"][i]["is_active"] == 1) {
            newNotificationsPacks.add(notifiydata["rows"][i]);
          }
        }
      });

      //   if (data["message"] != null) {
      //     Fluttertoast.showToast(
      //       msg: data["message"],
      //     );
      //   } else {
      //     myLeavesTypes = data["rows"];
      //     for (int i = 0; i < myLeavesTypes.length; i++) {
      //       if (myLeavesTypes[i]["is_active"] == 1) {
      //         options.add(myLeavesTypes[i]["leave_type_name"]);
      //       }
      //     }
      //   }
      //   //   } else {
      //     myLeavesTypes = data["rows"];
      //     for (int i = 0; i < myLeavesTypes.length; i++) {
      //       if (myLeavesTypes[i]["is_active"] == 1) {
      //         options.add(myLeavesTypes[i]["leave_type_name"]);
      //       }
      //     }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    notifiyHandler();
    super.initState();
  }

  bool isSwitched = false;
  var textValue = 'Switch is OFF';
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        UserSimplePreferences.setNotificationStatus(status: true);
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
    } else {
      setState(() {
        isSwitched = false;
        UserSimplePreferences.setNotificationStatus(status: false);
        textValue = 'Switch Button is OFF';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
          titleSpacing: 0,
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: 0.w, top: 5.h),
          //     child: GestureDetector(
          //       onTap: () {
          //         Get.toNamed(KNotification);
          //       },
          //       child: Row(
          //         children: [
          //           Text(
          //             "",
          //             style: TextStyle(
          //                 fontSize: 11.sp, color: KOrange, fontWeight: kFW600),
          //           ),
          //           Switch(
          //             onChanged: toggleSwitch,
          //             value: UserSimplePreferences.getNotificationStatus() ??
          //                 isSwitched,
          //             activeColor: KOrange,
          //             activeTrackColor: KOrange.withOpacity(0.8),
          //             inactiveThumbColor: Klightgray,
          //             inactiveTrackColor: Klightgray.withOpacity(0.5),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ],
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 23.w,
              color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
            ),
          ),
          title: Text(
            "Notifications",
            style: TextStyle(
              fontSize: kSixteenFont,
              fontWeight: kFW700,
              color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
              letterSpacing: 0.5,
            ),
          ),
        ),
        body:
            // UserSimplePreferences.getNotificationStatus() ??
            //         isSwitched == true
            isLoading == true
                ? Container(
                    margin: EdgeInsets.all(15.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 12.h,
                          width: 100.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 12.h,
                          width: 100.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 12.h,
                          width: 100.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 12.h,
                          width: 100.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 12.h,
                          width: 100.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 12.h,
                          width: 100.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 12.h,
                          width: 100.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 12.h,
                          width: 100.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 7.h,
                          width: 300.w,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white.withOpacity(0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                color: Kwhite.withOpacity(0.5),
                              ),
                              height: 50.h,
                              width: 250.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

                //  const Center(
                //     child:  SpinKitFadingCircle(
                //     color: KOrange,
                //     size: 15,
                //   ))
                : isLoading == false
                    ? notifiydata["rows"].length == 0
                        ? Center(
                            child: Column(
                            children: [
                              SvgPicture.asset("assets/images/oopsNoData.svg",
                                  // color: KOrange,
                                  fit: BoxFit.fill,
                                  semanticsLabel: 'No Data'),
                              SizedBox(
                                height: 40.h,
                              ),
                              Text(
                                "No Notifications Found",
                                style: TextStyle(
                                    fontWeight: kFW700, fontSize: kTwentyFont),
                              )
                            ],
                          ))
                        : Container(
                            margin: EdgeInsets.all(13.r),
                            child: ListView.builder(
                              itemCount: newNotificationsPacks.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  direction: DismissDirection.horizontal,
                                  background: Container(
                                    color: KOrange,
                                  ),
                                  secondaryBackground: Container(
                                    color: KRed.withOpacity(0.8),
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.w),
                                      child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(color: Kwhite),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onDismissed:
                                      (DismissDirection direction) async {
                                    await deleteEmployeeNotification(
                                        newNotificationsPacks[index]
                                            ["notification_employee_id"]);
                                  },
                                  // setState(() {
                                  //   notifiydata["rows"].removeAt(index);
                                  // });

                                  key: Key(
                                      newNotificationsPacks[index].toString()),
                                  child: GestureDetector(
                                    onTap: () {
                                      /// Get.toNamed(Kapply_leaves);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10.r),
                                      margin: EdgeInsets.only(top: 10.h),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(13.r),
                                        boxShadow: [
                                          selectedTheme == "Lighttheme"
                                              ? const BoxShadow(
                                                  color: Colors.transparent,
                                                  blurRadius: 0,
                                                  offset: Offset(0, 0),
                                                  spreadRadius: 0, //New
                                                )
                                              : BoxShadow(
                                                  color: Ktextcolor.withOpacity(
                                                      0.1),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 0),
                                                  spreadRadius: 2, //New
                                                )
                                        ],
                                        color: selectedTheme == "Lighttheme"
                                            ? Kwhite
                                            : Kthemeblack,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // newNotificationsPacks[index]
                                            //         ["notification_employee_id"]
                                            //     .toString(),
                                            newNotificationsPacks != null
                                                ? parse(newNotificationsPacks[
                                                                index]
                                                            ["Notification"]
                                                        ["title"])
                                                    .body!
                                                    .text
                                                : "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.spMax,
                                              fontWeight: kFW800,
                                              color:
                                                  selectedTheme == "Lighttheme"
                                                      ? KdarkText
                                                      : Kwhite,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.w,
                                          ),
                                          Text(
                                            notifiydata["rows"] != null
                                                ? parse(newNotificationsPacks[
                                                                index]
                                                            ["Notification"]
                                                        ["message"])
                                                    .body!
                                                    .text
                                                : "",
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: kFW600,
                                                color: Klightblack.withOpacity(
                                                    0.9)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            // ListView.builder(
                            //   itemCount: notifiydata["rows"].length,
                            //   itemBuilder: (context, index) {
                            //     return Container(
                            //       padding: EdgeInsets.all(10.r),
                            //       margin: EdgeInsets.only(top: 10.h),
                            //       width: double.infinity,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(13.r),
                            //         color: Kwhite,
                            //       ),
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             notifiydata["rows"] != null
                            //                 ? parse(notifiydata["rows"][index]
                            //                         ["Notification"]["title"])
                            //                     .body!
                            //                     .text
                            //                 : "",
                            //             maxLines: 1,
                            //             overflow: TextOverflow.ellipsis,
                            //             style: TextStyle(
                            //                 fontSize: 13.spMax,
                            //                 fontWeight: kFW800,
                            //                 color: KdarkText),
                            //           ),
                            //           SizedBox(
                            //             height: 7.w,
                            //           ),
                            //           Text(
                            //             notifiydata["rows"] != null
                            //                 ? parse(notifiydata["rows"][index]
                            //                         ["Notification"]["message"])
                            //                     .body!
                            //                     .text
                            //                 : "",
                            //             maxLines: 4,
                            //             overflow: TextOverflow.ellipsis,
                            //             style: TextStyle(
                            //                 fontSize: kTwelveFont,
                            //                 fontWeight: kFW600,
                            //                 color: Klightblack.withOpacity(0.9)),
                            //           ),
                            //         ],
                            //       ),
                            //     );
                            //   },
                            // ),
                          )
                    : const Center(
                        child: SpinKitFadingCircle(
                        color: KOrange,
                        size: 15,
                      ))
        // : const SizedBox()
        );
  }
}
