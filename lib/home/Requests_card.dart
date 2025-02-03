// ignore_for_file: camel_case_types, file_names

import 'package:intl/intl.dart';

import '../untils/export_file.dart';

class Requests_Screen extends StatefulWidget {
  const Requests_Screen({super.key});

  @override
  State<Requests_Screen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<Requests_Screen> {
  //  DashboardController dashboardController = Get.find<DashboardController>();
  LeavesController leavesController = Get.find<LeavesController>();

  // Map Requestdata = {};

  // bool isLoading = false;
  // Future RequestListHandler() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Map data = await Services.employeehome();

  //   if (data["message"] != null) {
  //     Fluttertoast.showToast(
  //       msg: data["message"],
  //     );
  //   } else {
  //     Requestdata = data["requests"];
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  void initState() {
    // RequestListHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => leavesController.pendingLeavesCount == 0

        // dashboardController.requestCount == 0
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Leave Requests",
                    style: TextStyle(
                      fontSize: kSixteenFont,
                      fontWeight: kFW700,
                      color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  CircleAvatar(
                      radius: 10.r,
                      backgroundColor: KOrange,
                      child: Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Obx(
                            () => Text(
                              leavesController.leavesdata.isNotEmpty
                                  // dashboardController.requestdata.isNotEmpty
                                  ? leavesController.pendingLeavesCount
                                      .toString()

                                      //dashboardController.requestdata["count"]
                                      .toString()
                                  : "-",
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: kFW600,
                                  color: Kwhite),
                            ),
                          ))),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                  height: 65.h,
                  child: leavesController.myleavesLoading.value == false
                      //dashboardController.leaverequest.value == false
                      ? ListView.builder(
                          itemCount: leavesController.leavesdata.length,
                          //    dashboardController.requestdata["rows"].length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(KLeave_detail,
                                    arguments:
                                        leavesController.leavesdata[index]
                                    // dashboardController
                                    //     .requestdata["rows"][index]
                                    );
                              },
                              child: leavesController.leavesdata[index]
                                          ["leave_status"] !=
                                      // dashboardController.requestdata["rows"]
                                      //             [index]["leave_status"] !=
                                      0
                                  ? SizedBox()
                                  : Container(
                                      margin: EdgeInsets.all(3.r),
                                      padding: EdgeInsets.only(
                                          left: 10.w,
                                          right: 10.w,
                                          top: 10.h,
                                          bottom: 10.h),
                                      decoration: BoxDecoration(
                                        color: selectedTheme == "Lighttheme"
                                            ? Kwhite
                                            : Kthemeblack,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 1.5,
                                            blurRadius: 3,
                                            offset: const Offset(0, 2),
                                            color: Ktextcolor.withOpacity(0.25),
                                          )
                                        ],
                                        
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.left,
                                                text: TextSpan(
                                                  text: DateFormat.yMMMd()
                                                      .format(DateTime.parse(leavesController
                                                              .leavesdata[index]
                                                          // dashboardController
                                                          //             .requestdata[
                                                          //         "rows"][index]
                                                          ["from_date"]))
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: kFW700,
                                                      color: selectedTheme ==
                                                              "Lighttheme"
                                                          ? KdarkText
                                                          : Kwhite),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: ' - ',
                                                      style: TextStyle(
                                                          fontSize:
                                                              kSixteenFont,
                                                          fontWeight: kFW700,
                                                          color: KOrange),
                                                    ),
                                                    TextSpan(
                                                      text: DateFormat.yMMMd()
                                                          .format(DateTime.parse(leavesController
                                                                      .leavesdata[
                                                                  index]
                                                              // dashboardController
                                                              //             .requestdata[
                                                              //         "rows"][index]
                                                              ["to_date"]))
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight: kFW700,
                                                          color: selectedTheme ==
                                                                  "Lighttheme"
                                                              ? KdarkText
                                                              : Kwhite),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.w,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: "",
                                                  style: TextStyle(
                                                      fontSize: kFourteenFont,
                                                      fontWeight: kFW400,
                                                      color: selectedTheme ==
                                                              "Lighttheme"
                                                          ? Klightgray
                                                          : Kwhite),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: leavesController
                                                                          .leavesdata[
                                                                      index][
                                                                  "leave_type"] ==
                                                              ""
                                                          ? "Applied from Web"
                                                          : leavesController
                                                                      .leavesdata[
                                                                  index]
                                                              ["leave_type"],
                                                      style: TextStyle(
                                                          fontSize:
                                                              kFourteenFont,
                                                          fontWeight: kFW700,
                                                          color: selectedTheme ==
                                                                  "Lighttheme"
                                                              ? Klightgray
                                                              : Kwhite),
                                                    ),
                                                    TextSpan(
                                                      text: ' | ',
                                                      style: TextStyle(
                                                          fontSize:
                                                              kFourteenFont,
                                                          fontWeight: kFW700,
                                                          color: KOrange),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Obx(() => Text(
                                                    leavesController.leavesdata[
                                                                    index][
                                                                "leave_status"] ==
                                                            0
                                                        ? "In Progress"
                                                        : leavesController.leavesdata[
                                                                        index][
                                                                    "leave_status"] ==
                                                                1
                                                            ? "Approved"
                                                            : leavesController.leavesdata[
                                                                            index]
                                                                        [
                                                                        "leave_status"] ==
                                                                    2
                                                                ? "Rejected By Admin"
                                                                : leavesController.leavesdata[index]
                                                                            [
                                                                            "leave_status"] ==
                                                                        3
                                                                    ? "Cancelled By You"
                                                                    : "-",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight: kFW900,
                                                      color: leavesController
                                                                          .leavesdata[
                                                                      index][
                                                                  "leave_status"] ==
                                                              0
                                                          ? KOrange
                                                          : leavesController.leavesdata[
                                                                          index]
                                                                      [
                                                                      "leave_status"] ==
                                                                  1
                                                              ? Kgreen
                                                              : leavesController
                                                                              .leavesdata[index]
                                                                          [
                                                                          "leave_status"] ==
                                                                      2
                                                                  ? KRed
                                                                  : leavesController.leavesdata[index]
                                                                              [
                                                                              "leave_status"] ==
                                                                          3
                                                                      ? KRed
                                                                      : Klightblack,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                            );
                          })
                      : const SpinKitFadingCircle(
                          color: KOrange,
                          size: 25,
                        ))
            ],
          ));
  }
}
