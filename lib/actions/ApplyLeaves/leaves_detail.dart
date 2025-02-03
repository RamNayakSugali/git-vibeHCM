// ignore_for_file: camel_case_types

import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:vibeshr/untils/export_file.dart';

class leave_detail extends StatefulWidget {
  const leave_detail({super.key});

  @override
  State<leave_detail> createState() => _leave_detailState();
}

class _leave_detailState extends State<leave_detail> {
  var leaveid = Get.arguments;
  DashboardController dashboardController = Get.find<DashboardController>();
  LeavesController leavesController = Get.find<LeavesController>();
  Map leaveldetaildata = {};

  bool isLoading = false;
  Future leavelHandler() async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.leaveldetail();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      leaveldetaildata = data;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // dashboardController.onInit();
    // leavesController.onInit();
    leavelHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      appBar: VibhoAppBar(
        title: "Leave Details",
        bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        dontHaveBackAsLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(13.r),
            child: Obx(
              () => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 12.w, top: 8.h),
                        child: Text(
                          // ignore: unnecessary_null_comparison
                          leavesController.profile["Employee"] != null
                              ? leavesController.profile["Employee"]["fname"]
                              : "No Name",
                          style: TextStyle(
                              fontSize: kSixteenFont.sp,
                              fontWeight: kFW700,
                              color: selectedTheme == "Lighttheme"
                                  ? kblack
                                  : Kwhite),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.roundToDouble())),
                          child: Image.asset(
                            "assets/images/buble.png",
                            width: 90.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(13.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Status : ",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: kTwelveFont,
                                fontWeight: kFW600,
                                color: Klightblack,
                                //Klightblack
                              ),
                            ),
                            Text(
                              leaveid["leave_status"] == 0
                                  ? "In Progress"
                                  : leaveid["leave_status"] == 1
                                      ? "Approved"
                                      : leaveid["leave_status"] == 2
                                          ? "Rejected By Admin"
                                          : leaveid["leave_status"] == 3
                                              ? "Cancelled By You"
                                              : "-",
                              // leavesController.leavesdata[
                              //                 index][
                              //             "leave_status"] ==
                              //         0
                              //     ? "In Progress"
                              //     : leavesController.leavesdata[
                              //                     index]
                              //                 [
                              //                 "leave_status"] ==
                              //             1
                              //         ? "Approved"
                              //         : leavesController
                              //                         .leavesdata[index]
                              //                     [
                              //                     "leave_status"] ==
                              //                 2
                              //             ? "Rejected By Admin"
                              //             : leavesController.leavesdata[index]
                              //                         [
                              //                         "leave_status"] ==
                              //                     3
                              //                 ? "Cancelled By You"
                              //                 : "-",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: kTwelveFont,
                                fontWeight: kFW600,
                                color: leaveid["leave_status"] == 0
                                    ? KOrange
                                    : leaveid["leave_status"] == 1
                                        ? Kgreen
                                        : leaveid["leave_status"] == 2
                                            ? KRed
                                            : leaveid["leave_status"] == 3
                                                ? KRed
                                                : Klightblack,
                                // leavesController
                                //                     .leavesdata[
                                //                 index][
                                //             "leave_status"] ==
                                //         0
                                //     ? KOrange
                                //     : leavesController.leavesdata[
                                //                     index]
                                //                 [
                                //                 "leave_status"] ==
                                //             1
                                //         ? Kgreen
                                //         : leavesController.leavesdata[index]
                                //                     [
                                //                     "leave_status"] ==
                                //                 2
                                //             ? KRed
                                //             : leavesController.leavesdata[index]["leave_status"] ==
                                //                     0
                                //                 ? KRed
                                //                 : Klightblack,
                                //Klightblack
                              ),
                            ),
                            // Text(
                            //   leavesdata[index]["leave_status"].toString(),
                            //   style: TextStyle(
                            //       fontSize: 13.sp,
                            //       fontWeight: kFW600,
                            //       color: Kgreen),
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "From Date",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW600,
                                        color: Klightblack),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    DateFormat.yMMMd()
                                        .format(DateTime.parse(
                                            leaveid["from_date"]))
                                        .toString(),
                                    // leavesController
                                    //     .leavesdata[
                                    //         index][
                                    //         "from_date"]
                                    //     .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: kFW700,
                                        color: selectedTheme == "Lighttheme"
                                            ? kblack
                                            : Kwhite),
                                  ),
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "To Date",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW600,
                                        color: Klightblack),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    DateFormat.yMMMd()
                                        .format(
                                            DateTime.parse(leaveid["to_date"]))
                                        .toString(),
                                    // leavesController
                                    //     .leavesdata[
                                    //         index]
                                    //         ["to_date"]
                                    //     .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: kFW700,
                                        color: selectedTheme == "Lighttheme"
                                            ? kblack
                                            : Kwhite),
                                  ),
                                ]),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // Row(
                        //   mainAxisAlignment:
                        //       MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Column(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.start,
                        //         crossAxisAlignment:
                        //             CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             "Leave Type",
                        //             maxLines: 1,
                        //             overflow: TextOverflow.ellipsis,
                        //             style: TextStyle(
                        //                 fontSize: kTwelveFont,
                        //                 fontWeight: kFW600,
                        //                 color: Klightblack),
                        //           ),
                        //           SizedBox(
                        //             height: 5.h,
                        //           ),
                        //           Text(
                        //             leavesdata[index]["leave_type"],

                        //             maxLines: 1,
                        //             overflow: TextOverflow.ellipsis,
                        //             style: TextStyle(
                        //                 fontSize: 13.sp,
                        //                 fontWeight: kFW700,
                        //                 color: kblack),
                        //           ),
                        //         ]),
                        //     Column(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.start,
                        //         crossAxisAlignment:
                        //             CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             "Leave Days",
                        //             maxLines: 2,
                        //             overflow: TextOverflow.ellipsis,
                        //             style: TextStyle(
                        //                 fontSize: kTwelveFont,
                        //                 fontWeight: kFW600,
                        //                 color: Klightblack),
                        //           ),
                        //           SizedBox(
                        //             height: 5.h,
                        //           ),
                        //           Text(
                        //              leavesdata[index]["leave_days"].toString(),

                        //             maxLines: 3,
                        //             overflow: TextOverflow.ellipsis,
                        //             style: TextStyle(
                        //                 fontSize: 13.sp,
                        //                 fontWeight: kFW700,
                        //                 color: kblack),
                        //           ),
                        //         ]),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Reason : ",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: kTwelveFont,
                                    fontWeight: kFW600,
                                    color: Klightblack),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              SizedBox(
                                width: 220.w,
                                child: ReadMoreText(
                                  leaveid["reason"] ?? "",
                                  // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImVtYWlsIjoicmFtYW5heWFrLnNAdmliaG90ZWNoLmNvbSIsImlkIjoxMDMsImNvbnN1bWVyX2lkIjoxLCJlbXBfaWQiOjUzLCJ1c2VybmFtZSI6IlZUSU4yNCIsInB3ZCI6IjI4Mjk2NzZlM2Q2NDJhYTE0ZWNhNmRkNzZmZTgxZjVlIiwiaXNfY3Jvbl9nZW5lcmF0ZV9wd2QiOm51bGwsImlzX2Nyb25fZm9yZ290X3B3ZCI6bnVsbCwiaXNfYWN0aXZlIjoxLCJyb2xlX2lkIjoiRW1wbG95ZWUiLCJvbmJvYXJkaW5nX3N0YXR1cyI6ImNvbXBsZXRlZCIsImlzX2Noa19sb2dpbiI6MSwicmVmcmVzaF90b2tlbiI6ImdMWVB0WWRmVERGb01IMDlQVlVYenZLdUlhd3NJZGdBcVRuWExUZFhzSWkyV0NmS2oyVHpHUTNON1lnMVhGOFJtVkJtU0NjQVBYdGlLZkpEOWVqb1dSMXVZTnB2ZkZOMnE3ZldndkJBeXJEcE9iNFBsMnNNMmFNWkF6N0x1WGppY0pnaXpSTXlzY2JXRXVoa3FCd1daclpYakZxZHVlY0hyY2RZb1dVa3YwNGFRdzcxdW5iWGJuWGhmbDZWNEFncko1SGdxeWs3YXFOdHJFaVdueFhHdTVFNjV1Mk44SHpSOWxTQjM2RWF6NGxKTmF0MFAzTTJ4cXVQcXIzakRNbkwxMDMiLCJmY21fdG9rZW4iOiJmVW4zMFgzTVFPdTRfMHhsVGFvSlZ6OkFQQTkxYkdORWZCTDRONGVmSzdUM0d2Y1pQWnp0UHl4NWFZX2pudURoYS1iVlF4Q1BhclhVUFVPU3JvRU56aWhaZmdWU1B4LWh6OHlzV2xNdnM2TTlnVVZrTU14ZV9Dd21UMUlrTGRlUDhhb25kVHdQMl96ZUQ2MnJ0eGVFNTQ3OGdXVVpBU21rOWc4IiwiY3JlYXRlZF9hdCI6IjIwMjMtMDgtMjJUMjA6NDA6MDQuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDI0LTAxLTE5VDEwOjEyOjM0LjAwMFoifSwiaWF0IjoxNzA1NjU5MzQzLCJleHAiOjE3MzcxOTUzNDN9.fNv2oRaM2nyOGvWm-XleuE5u-PATyz8su5n8gWYm_B0",
                                  // trimLines: 1,
                                  colorClickableText: KOrange,
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: kFW700,
                                      color: selectedTheme == "Lighttheme"
                                          ? kblack
                                          : Kwhite),
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'See more',
                                  trimExpandedText: '...See less',
                                  moreStyle: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: kFW700,
                                      color: selectedTheme == "Lighttheme"
                                          ? KOrange
                                          : Kwhite),
                                  lessStyle: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: kFW700,
                                      color: selectedTheme == "Lighttheme"
                                          ? KOrange
                                          : Kwhite),
                                ),
                              ),
                              // Text(
                              //   leaveid["reason"] ?? "",
                              //   // leavesController
                              //   //         .leavesdata[
                              //   //     index]["reason"],
                              //   // maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              //   style: TextStyle(
                              //       fontSize: 13.sp,
                              //       fontWeight: kFW700,
                              //       color: selectedTheme == "Lighttheme"
                              //           ? kblack
                              //           : Kwhite),
                              // ),
                            ]),
                        SizedBox(
                          height: 5.h,
                        ),
                        leaveid["leave_status"] == 0
                            ? SizedBox()
                            : leaveid["leave_status"] == 1
                                ? leaveid["LeaveAccept"].length == 0
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Accepted By : ",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: kTwelveFont,
                                                      fontWeight: kFW600,
                                                      color: Klightblack),
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                SizedBox(
                                                  // color: KOrange,
                                                  width: 200.w,
                                                  child: Text(
                                                    leaveid["LeaveAccept"][0]
                                                        ["emp_name"],
                                                    // leavesController.leavesdata[index]["LeaveAccept"][0]["emp_name"],
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight: kFW700,
                                                        color: selectedTheme ==
                                                                "Lighttheme"
                                                            ? kblack
                                                            : Kwhite),
                                                  ),
                                                ),
                                                // Text(
                                                //   leaveid["LeaveAccept"][0]
                                                //       ["emp_name"],
                                                //   maxLines: 2,
                                                //   overflow:
                                                //       TextOverflow.ellipsis,
                                                //   style: TextStyle(
                                                //       fontSize: 13.sp,
                                                //       fontWeight: kFW700,
                                                //       color: selectedTheme ==
                                                //               "Lighttheme"
                                                //           ? kblack
                                                //           : Kwhite),
                                                // ),
                                              ]),
                                          SizedBox(
                                            height: 5.h,
                                          )
                                        ],
                                      )
                                : leaveid["leave_status"] == 2
                                    ? leaveid["LeaveReject"].length == 0
                                        ? SizedBox()
                                        : Column(
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Rejected By : ",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: kTwelveFont,
                                                          fontWeight: kFW600,
                                                          color: Klightblack),
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    Text(
                                                      leaveid["LeaveReject"][0]
                                                          ["emp_name"],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight: kFW700,
                                                          color: selectedTheme ==
                                                                  "Lighttheme"
                                                              ? kblack
                                                              : Kwhite),
                                                    ),
                                                  ]),
                                              SizedBox(
                                                height: 5.h,
                                              )
                                            ],
                                          )
                                    : leaveid["leave_status"] == 3
                                        ? SizedBox()
                                        : SizedBox(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Type : ",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: kTwelveFont,
                                    fontWeight: kFW600,
                                    color: Klightblack),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              SizedBox(
                                width: 250.w,
                                child: Text(
                                  leaveid["leave_type"] == ""
                                      ? "Applied from Web"
                                      : leaveid["leave_type"],
                                  // leavesController
                                  //             .leavesdata[
                                  //         index]
                                  //     ["leave_type"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: kFW700,
                                      color: selectedTheme == "Lighttheme"
                                          ? kblack
                                          : Kwhite),
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: 40.h,
                        ),
                        leaveid["leave_status"] == 0
                            ? CustomButton(
                                Color: KOrange,
                                width: double.infinity,
                                height: 38.h,
                                borderRadius: BorderRadius.circular(30.r),
                                textColor: Kwhite,
                                fontSize: 13.sp,
                                fontWeight: kFW800,
                                label: "Cancel Leave",
                                isLoading: false,
                                onTap: () 
                                {
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
                                                  color: selectedTheme ==
                                                          "Lighttheme"
                                                      ? KdarkText
                                                      : Kwhite)),
                                          content: Text(
                                              'You Want To Cancel The Leave ?',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: kFW700,
                                                  color: selectedTheme ==
                                                          "Lighttheme"
                                                      ? KdarkText
                                                      : Kwhite)),
                                          actions: [
                                            Obx(() => leavesController
                                                        .isLeaveCanleLoading
                                                        .value ==
                                                    false
                                                ? TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text('No',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: kFW700,
                                                            color: selectedTheme ==
                                                                    "Lighttheme"
                                                                ? KdarkText
                                                                : Kwhite)),
                                                  )
                                                : const SizedBox()),
                                            Obx(
                                              () => leavesController
                                                          .isLeaveCanleLoading
                                                          .value ==
                                                      false
                                                  ? TextButton(
                                                      // textColor: Color(0xFF6200EE),
                                                      onPressed: () async {
                                                        //callCancle FUnction
                                                        await leavesController
                                                            .cancleLeave(leaveid[
                                                                "employee_leaves_lid"]);
                                                        setState(() {
                                                          leavesController
                                                              .pendingLeavesCount
                                                              // dashboardController
                                                              //         .requestCount
                                                              .value = leavesController
                                                                  .pendingLeavesCount
                                                                  // dashboardController
                                                                  //         .requestCount
                                                                  .value -
                                                              1;
                                                        });

                                                        Get.back();
                                                        Get.back();
                                                        // Get.toNamed(
                                                        //     KBottom_navigation);
                                                        // Navigator.pop(context);
                                                      },
                                                      child: Text('Yes',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  kFW700,
                                                              color: selectedTheme ==
                                                                      "Lighttheme"
                                                                  ? KdarkText
                                                                  : Kwhite)),
                                                    )
                                                  : const SpinKitFadingCircle(
                                                      color: KOrange,
                                                      size: 15,
                                                    ),
                                            )
                                          ],
                                        );
                                      });
                                },
                              )
                            : SizedBox()
                      ],
                    ),
                  )
                ],
              ),
            )

            // Column(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.all(13.r),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               RichText(
            //                 textAlign: TextAlign.left,
            //                 text: TextSpan(
            //                   text: DateFormat.yMMMd()
            //                       .format(DateTime.parse(leaveid["from_date"]))
            //                       .toString(),
            //                   style: TextStyle(
            //                       fontSize: 14.sp,
            //                       fontWeight: kFW700,
            //                       color: selectedTheme == "Lighttheme"
            //                           ? KdarkText
            //                           : Kwhite),
            //                   children: <TextSpan>[
            //                     TextSpan(
            //                       text: ' - ',
            //                       style: TextStyle(
            //                           fontSize: kSixteenFont,
            //                           fontWeight: kFW700,
            //                           color: KOrange),
            //                     ),
            //                     TextSpan(
            //                       text: DateFormat.yMMMd()
            //                           .format(DateTime.parse(leaveid["to_date"]))
            //                           .toString(),
            //                       style: TextStyle(
            //                           fontSize: 14.sp,
            //                           fontWeight: kFW700,
            //                           color: selectedTheme == "Lighttheme"
            //                               ? KdarkText
            //                               : Kwhite),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 10.w,
            //               ),
            //               // Obx(() => Text(
            //               //       leavesController.leavesdata[
            //               //                       index][
            //               //                   "leave_status"] ==
            //               //               0
            //               //           ? "In Progress"
            //               //           : leavesController.leavesdata[
            //               //                           index][
            //               //                       "leave_status"] ==
            //               //                   1
            //               //               ? "Approved"
            //               //               : leavesController.leavesdata[
            //               //                               index]
            //               //                           [
            //               //                           "leave_status"] ==
            //               //                       2
            //               //                   ? "Rejected By Admin"
            //               //                   : leavesController.leavesdata[index]
            //               //                               [
            //               //                               "leave_status"] ==
            //               //                           3
            //               //                       ? "Cancelled By You"
            //               //                       : "-",
            //               //       maxLines: 1,
            //               //       overflow:
            //               //           TextOverflow.ellipsis,
            //               //       style: TextStyle(
            //               //         fontSize: 10.sp,
            //               //         fontWeight: kFW900,
            //               //         color: leavesController
            //               //                             .leavesdata[
            //               //                         index][
            //               //                     "leave_status"] ==
            //               //                 0
            //               //             ? KOrange
            //               //             : leavesController.leavesdata[
            //               //                             index]
            //               //                         [
            //               //                         "leave_status"] ==
            //               //                     1
            //               //                 ? Kgreen
            //               //                 : leavesController
            //               //                                 .leavesdata[index]
            //               //                             [
            //               //                             "leave_status"] ==
            //               //                         2
            //               //                     ? KRed
            //               //                     : leavesController.leavesdata[index]
            //               //                                 [
            //               //                                 "leave_status"] ==
            //               //                             3
            //               //                         ? KRed
            //               //                         : Klightblack,
            //               //         //Klightblack
            //               //       ),
            //               //     )
            //               //     ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: 5.w,
            //           ),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               SizedBox(
            //                 width: 200.w,
            //                 child: RichText(
            //                   overflow: TextOverflow.ellipsis,
            //                   textAlign: TextAlign.left,
            //                   maxLines: 1,
            //                   text: TextSpan(
            //                     text: "leave type",
            //                     style: TextStyle(
            //                         fontSize: kFourteenFont,
            //                         fontWeight: kFW400,
            //                         color: selectedTheme == "Lighttheme"
            //                             ? Klightgray
            //                             : Kwhite),
            //                     children: <TextSpan>[
            //                       TextSpan(
            //                         text: ' - ',
            //                         style: TextStyle(
            //                             fontSize: kFourteenFont,
            //                             fontWeight: kFW700,
            //                             color: KOrange),
            //                       ),
            //                       TextSpan(
            //                         text: leaveid["leave_type"] == ""
            //                             ? "Applied from Web"
            //                             : leaveid["leave_type"],
            //                         style: TextStyle(
            //                             fontSize: kFourteenFont,
            //                             fontWeight: kFW700,
            //                             color: selectedTheme == "Lighttheme"
            //                                 ? Klightgray
            //                                 : Kwhite),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //               // Row(
            //               //   children: [
            //               //     Text(
            //               //       "leave type",
            //               //       maxLines: 2,
            //               //       overflow:
            //               //           TextOverflow.ellipsis,
            //               //       style: TextStyle(
            //               //           fontSize: kFourteenFont,
            //               //           fontWeight: kFW400,
            //               //           color: selectedTheme ==
            //               //                   "Lighttheme"
            //               //               ? Klightgray
            //               //               : Kwhite),
            //               //     ),
            //               //     Text(
            //               //       ' - ',
            //               //       overflow:
            //               //           TextOverflow.ellipsis,
            //               //       style: TextStyle(
            //               //           fontSize: kFourteenFont,
            //               //           fontWeight: kFW700,
            //               //           color: KOrange),
            //               //     ),
            //               //     Text(
            //               //       dashboardController.requestdata[
            //               //                           "rows"]
            //               //                       [index][
            //               //                   "leave_type"] ==
            //               //               ""
            //               //           ? "Applied from Web"
            //               //           : dashboardController
            //               //                       .requestdata[
            //               //                   "rows"][index]
            //               //               ["leave_type"],
            //               //       maxLines: 2,
            //               //       overflow:
            //               //           TextOverflow.ellipsis,
            //               //       style: TextStyle(
            //               //           fontSize: kFourteenFont,
            //               //           fontWeight: kFW700,
            //               //           color: selectedTheme ==
            //               //                   "Lighttheme"
            //               //               ? Klightgray
            //               //               : Kwhite),
            //               //     ),
            //               //   ],
            //               // ),
            //               RichText(
            //                 textAlign: TextAlign.left,
            //                 maxLines: 1,
            //                 overflow: TextOverflow.ellipsis,
            //                 text: TextSpan(
            //                   text: "leave days",
            //                   style: TextStyle(
            //                       fontSize: kFourteenFont,
            //                       fontWeight: kFW400,
            //                       color: selectedTheme == "Lighttheme"
            //                           ? Klightgray
            //                           : Kwhite),
            //                   children: <TextSpan>[
            //                     TextSpan(
            //                       text: ' - ',
            //                       style: TextStyle(
            //                           fontSize: kFourteenFont,
            //                           fontWeight: kFW700,
            //                           color: KOrange),
            //                     ),
            //                     TextSpan(
            //                       text: leaveid["leave_days"].toString(),
            //                       style: TextStyle(
            //                           fontSize: kFourteenFont,
            //                           fontWeight: kFW700,
            //                           color: selectedTheme == "Lighttheme"
            //                               ? Klightgray
            //                               : Kwhite),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: 5.h,
            //           ),
            //           RichText(
            //             textAlign: TextAlign.left,
            //             maxLines: 1,
            //             overflow: TextOverflow.ellipsis,
            //             text: TextSpan(
            //               text: "Reason",
            //               style: TextStyle(
            //                   fontSize: kFourteenFont,
            //                   fontWeight: kFW400,
            //                   color: selectedTheme == "Lighttheme"
            //                       ? Klightgray
            //                       : Kwhite),
            //               children: <TextSpan>[
            //                 TextSpan(
            //                   text: ' - ',
            //                   style: TextStyle(
            //                       fontSize: kFourteenFont,
            //                       fontWeight: kFW700,
            //                       color: KOrange),
            //                 ),
            //                 TextSpan(
            //                   text: leaveid["reason"] ?? "",
            //                   style: TextStyle(
            //                       fontSize: kFourteenFont,
            //                       fontWeight: kFW700,
            //                       color: selectedTheme == "Lighttheme"
            //                           ? Klightgray
            //                           : Kwhite),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     )
            //   ],
            // ),
            ),
      ),
    );
  }
}
