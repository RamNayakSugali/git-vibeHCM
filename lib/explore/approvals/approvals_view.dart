// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:vibeshr/controllers/claimsController.dart';
import 'package:vibeshr/untils/export_file.dart';

class Approval_view extends StatefulWidget {
  const Approval_view({super.key});

  @override
  State<Approval_view> createState() => _Approval_viewState();
}

class _Approval_viewState extends State<Approval_view> {
  ClaimController claimController = Get.put(ClaimController());
  bool isLoading = false;
  var approvalConfirm = {};
  @override
  void initState() {
    getApprovalConfirmationAPI();
    super.initState();
  }

  updateLeaveClaimStats(String status, String reason, int leaveid) async {
    setState(() {
      isLoading = true;
    });
    Map payload = {"leave_status": status, "reason": reason};
    Map data = await Services.hrUpdateEmployeesLeaves(payload, leaveid);

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      setState(() {
        claimController.leaveSingleDataView.value = data;
        claimController.updateLeaveUpdatedValue(data);
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  getApprovalConfirmationAPI() async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.hrRequestApprovalConfigs();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      approvalConfirm = data;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      appBar: VibhoAppBar(
        title: "Full View",
        dontHaveBackAsLeading: false,
        bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      ),
      body: isLoading == false
          ? SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.all(18.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(3),
                              height: 50.h,
                              width: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.r),
                                color: selectedTheme == "Lighttheme"
                                    ? Kwhite
                                    : Kthemeblack,
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      13.r), // Image border
                                  child: Image.asset("assets/images/man.png"))),
                          SizedBox(
                            width: 5.w,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: kFW600,
                                        color: selectedTheme == "Lighttheme"
                                            ? KdarkText.withOpacity(0.5)
                                            : Kwhite),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        claimController.peoplesdata["rows"]
                                                .where((element) =>
                                                    element["emp_id"] ==
                                                    claimController
                                                            .leaveSingleDataView[
                                                        "emp_id"])
                                                .toList()
                                                .isNotEmpty
                                            ? claimController
                                                .peoplesdata["rows"]
                                                .where((element) =>
                                                    element["emp_id"] ==
                                                    claimController
                                                            .leaveSingleDataView[
                                                        "emp_id"])
                                                .toList()[0]["Employee"]["fname"]
                                            // .toList()[0]["username"]
                                            : "Self",
                                        // claimController
                                        //     .leaveSingleDataViewPersonName.value,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: kFW700,
                                            color: selectedTheme == "Lighttheme"
                                                ? KdarkText
                                                : Kwhite),
                                      ),
                                      Text(
                                        claimController.peoplesdata["rows"]
                                                .where((element) =>
                                                    element["emp_id"] ==
                                                    claimController
                                                            .leaveSingleDataView[
                                                        "emp_id"])
                                                .toList()
                                                .isNotEmpty
                                            ? claimController
                                                .peoplesdata["rows"]
                                                .where((element) =>
                                                    element["emp_id"] ==
                                                    claimController
                                                            .leaveSingleDataView[
                                                        "emp_id"])
                                                .toList()[0]["Employee"]["lname"]
                                            // .toList()[0]["username"]
                                            : "",
                                        // claimController
                                        //     .leaveSingleDataViewPersonName.value,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: kFW700,
                                            color: KdarkText),
                                      ),
                                    ],
                                  ),
                                  // Text(

                                  //   maxLines: 1,
                                  //   style: TextStyle(
                                  //       fontSize: 13.sp,
                                  //       fontWeight: kFW700,
                                  //       color: KdarkText),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              claimController.leaveSingleDataView[
                                          "leave_status"] ==
                                      1
                                  ? CustomButton(
                                      height: 25.h,
                                      width: 100.w,
                                      fontSize: kTenFont,
                                      fontWeight: kFW700,
                                      Color: Kgreen.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5.r),
                                      Padding: EdgeInsets.only(
                                          left: 8.w,
                                          right: 8.w,
                                          top: 3.h,
                                          bottom: 3.h),
                                      textColor: Kgreen,
                                      label: "Approved",
                                      isLoading: false,
                                      onTap: () {})
                                  : claimController.leaveSingleDataView[
                                              "leave_status"] ==
                                          2
                                      ? CustomButton(
                                          height: 25.h,
                                          width: 100.w,
                                          fontSize: kTenFont,
                                          fontWeight: kFW700,
                                          Color: KRed.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          Padding: EdgeInsets.only(
                                              left: 8.w,
                                              right: 8.w,
                                              top: 3.h,
                                              bottom: 3.h),
                                          textColor: KRed,
                                          label: "Rejected",
                                          isLoading: false,
                                          onTap: () {
                                            updateLeaveClaimStats(
                                                "Reject",
                                                claimController
                                                        .leaveSingleDataView[
                                                    "reason"],
                                                claimController
                                                        .leaveSingleDataView[
                                                    "employee_leaves_lid"]);
                                          })
                                      : const SizedBox()
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Start Date",
                                  style: TextStyle(
                                    fontSize: 11.5.sp,
                                    fontWeight: kFW600,
                                    color: Klightblack.withOpacity(0.8),
                                  )),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                  DateFormat("dd MMM yy").format(DateTime.parse(
                                      claimController
                                          .leaveSingleDataView["from_date"])),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: kFW700,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite,
                                  )),
                            ],
                          ),
                          SizedBox(
                            width: 120.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("End Date",
                                  style: TextStyle(
                                    fontSize: 11.5.sp,
                                    fontWeight: kFW600,
                                    color: Klightblack.withOpacity(0.8),
                                  )),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                  DateFormat("dd MMM yy").format(DateTime.parse(
                                      claimController
                                          .leaveSingleDataView["to_date"])),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: kFW700,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Leave Type",
                                  style: TextStyle(
                                    fontSize: 11.5.sp,
                                    fontWeight: kFW600,
                                    color: Klightblack.withOpacity(0.8),
                                  )),
                              SizedBox(
                                height: 5.h,
                              ),
                              SizedBox(
                                width: 100.w,
                                child: Text(
                                    claimController.leaveSingleDataView[
                                                "leave_type"] !=
                                            ""
                                        ? claimController
                                            .leaveSingleDataView["leave_type"]
                                        : "-",
                                    maxLines: 1,
                                    style: TextStyle(
                                      height: 1.2,
                                      letterSpacing: 0.5,
                                      fontSize: 13.sp,
                                      fontWeight: kFW700,
                                      color: selectedTheme == "Lighttheme"
                                          ? KdarkText
                                          : Kwhite,
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 90.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Employee ID",
                                style: TextStyle(
                                  fontSize: 11.5.sp,
                                  fontWeight: kFW600,
                                  color: Klightblack.withOpacity(0.8),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                claimController
                                    .leaveSingleDataViewPersonName.value,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: kFW700,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Reason",
                              style: TextStyle(
                                fontSize: 11.5.sp,
                                fontWeight: kFW600,
                                color: Klightblack.withOpacity(0.8),
                              )),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              claimController.leaveSingleDataView["reason"] !=
                                      ""
                                  ? claimController
                                      .leaveSingleDataView["reason"]
                                  : "-",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: kFW700,
                                color: selectedTheme == "Lighttheme"
                                    ? KdarkText
                                    : Kwhite,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      claimController.leaveSingleDataView["leave_status"] == 1
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Approved Date",
                                    style: TextStyle(
                                      fontSize: 11.5.sp,
                                      fontWeight: kFW600,
                                      color: Klightblack.withOpacity(0.8),
                                    )),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                    claimController.leaveSingleDataView[
                                                "approved_date"] ==
                                            null
                                        ? "-"
                                        : DateFormat("dd MMM yy").format(
                                            DateTime.parse(claimController
                                                    .leaveSingleDataView[
                                                "approved_date"])),
                                    style: TextStyle(
                                      height: 1.2,
                                      letterSpacing: 0.5,
                                      fontSize: 13.sp,
                                      fontWeight: kFW700,
                                      color: KdarkText,
                                    )),
                              ],
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: 200.h,
                      ),
                      Column(
                        children: [
                          approvalConfirm["leaves"]["write"] == true
                              ? claimController.leaveSingleDataView[
                                          "leave_status"] !=
                                      1
                                  ? CustomButton(
                                      borderRadius: BorderRadius.circular(30.r),
                                      margin: EdgeInsets.all(15.r),
                                      width: double.infinity,
                                      height: 35.h,
                                      Color: KOrange,
                                      textColor: Kwhite,
                                      fontSize: 13.sp,
                                      fontWeight: kFW700,
                                      label: "Approve",
                                      isLoading: false,
                                      onTap: () {
                                        updateLeaveClaimStats(
                                            "Approve",
                                            claimController
                                                .leaveSingleDataView["reason"],
                                            claimController.leaveSingleDataView[
                                                "employee_leaves_lid"]);
                                      })
                                  : const SizedBox()
                              : const SizedBox(),
                          approvalConfirm["leaves"]["write"] == true
                              ? claimController.leaveSingleDataView[
                                          "leave_status"] !=
                                      2
                                  ? CustomButton(
                                      borderRadius: BorderRadius.circular(30.r),
                                      margin: EdgeInsets.all(10.r),
                                      width: double.infinity,
                                      height: 35.h,
                                      Color: Kwhite,
                                      textColor: KOrange,
                                      fontSize: 13.sp,
                                      fontWeight: kFW700,
                                      label: "Decline",
                                      isLoading: false,
                                      onTap: () {
                                        updateLeaveClaimStats(
                                            "Reject",
                                            "Leave Rejected",
                                            claimController.leaveSingleDataView[
                                                "employee_leaves_lid"]);
                                        // _showDialog(context);
                                      })
                                  : const SizedBox()
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  )),
            )
          : const SpinKitFadingCircle(
              color: KOrange,
              size: 25,
            ),
    );
  }
}

class ClaimApproval_view extends StatefulWidget {
  const ClaimApproval_view({super.key});

  @override
  State<ClaimApproval_view> createState() => _ClaimApproval_viewState();
}

class _ClaimApproval_viewState extends State<ClaimApproval_view> {
  ClaimController claimController = Get.put(ClaimController());
  // var fullInfo = Get.arguments["data"];
  // var name = Get.arguments["name"];
  bool isLoading = false;
  var approvalConfirm = {};
  @override
  void initState() {
    getApprovalConfirmationAPI();
    super.initState();
  }

  updateLeaveClaimStats(String status, String reason, int claimid) async {
    setState(() {
      isLoading = true;
    });
    Map payload = {"is_approved": status, "comments": reason};
    Map data = await Services.hrUpdateEmployeesClaim(payload, claimid);

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      setState(() {
        claimController.claimSingleDataView.value = data;
        claimController
            .updateClaimUpdatedValue(claimController.claimSingleDataView);
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  getApprovalConfirmationAPI() async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.hrRequestApprovalConfigs();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      approvalConfirm = data;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      appBar: VibhoAppBar(
          title: "Full View",
          dontHaveBackAsLeading: false,
          bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
          dorefresh: true),
      body: isLoading == false
          ? SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.all(18.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.all(3),
                                  height: 50.h,
                                  width: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13.r),
                                    color: selectedTheme == "Lighttheme"
                                        ? Kwhite
                                        : Kthemeblack,
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          13.r), // Image border
                                      child: Image.asset(
                                          "assets/images/man.png"))),
                              SizedBox(
                                width: 5.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   "Name",
                                  //   style: TextStyle(
                                  //       fontSize: 12.sp,
                                  //       fontWeight: kFW600,
                                  //       color: KdarkText.withOpacity(0.5)),
                                  // ),
                                  // SizedBox(
                                  //   height: 5.h,
                                  // ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            claimController.peoplesdata["rows"]
                                                    .where((element) =>
                                                        element["emp_id"] ==
                                                        claimController
                                                                .claimSingleDataView[
                                                            "emp_id"])
                                                    .toList()
                                                    .isNotEmpty
                                                ? claimController
                                                        .peoplesdata["rows"]
                                                        .where((element) =>
                                                            element["emp_id"] ==
                                                            claimController
                                                                    .claimSingleDataView[
                                                                "emp_id"])
                                                        .toList()[0]["Employee"]
                                                    ["fname"]
                                                // .toList()[0]["username"]
                                                : "Self",
                                            // "-",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: kFW700,
                                              color:
                                                  selectedTheme == "Lighttheme"
                                                      ? KdarkText
                                                      : Kwhite,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Text(
                                            claimController.peoplesdata["rows"]
                                                    .where((element) =>
                                                        element["emp_id"] ==
                                                        claimController
                                                                .claimSingleDataView[
                                                            "emp_id"])
                                                    .toList()
                                                    .isNotEmpty
                                                ? claimController
                                                        .peoplesdata["rows"]
                                                        .where((element) =>
                                                            element["emp_id"] ==
                                                            claimController
                                                                    .claimSingleDataView[
                                                                "emp_id"])
                                                        .toList()[0]["Employee"]
                                                    ["lname"]
                                                // .toList()[0]["username"]
                                                : "",

                                            // "-",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: kFW700,
                                              color: KdarkText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        claimController
                                            .claimSingleDataViewPersonName
                                            .value,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: kFW600,
                                            color: KdarkText.withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                  // Text(
                                  //   claimController
                                  //       .claimSingleDataViewPersonName.value,
                                  //   maxLines: 1,
                                  //   style: TextStyle(
                                  //       fontSize: 13.sp,
                                  //       fontWeight: kFW700,
                                  //       color: KdarkText),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          claimController.claimSingleDataView["is_approved"] ==
                                  "Approved"
                              ? CustomButton(
                                  height: 25.h,
                                  width: 100.w,
                                  fontSize: kTenFont,
                                  fontWeight: kFW700,
                                  Color: Kgreen.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5.r),
                                  Padding: EdgeInsets.only(
                                      left: 8.w,
                                      right: 8.w,
                                      top: 3.h,
                                      bottom: 3.h),
                                  textColor: Kgreen,
                                  label: "Approved",
                                  isLoading: false,
                                  onTap: () {})
                              : claimController
                                          .claimSingleDataView["is_approved"] ==
                                      "Rejected"
                                  ? CustomButton(
                                      height: 25.h,
                                      width: 100.w,
                                      fontSize: kTenFont,
                                      fontWeight: kFW700,
                                      Color: KRed.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5.r),
                                      Padding: EdgeInsets.only(
                                          left: 8.w,
                                          right: 8.w,
                                          top: 3.h,
                                          bottom: 3.h),
                                      textColor: KRed,
                                      label: "Rejected",
                                      isLoading: false,
                                      onTap: () {})
                                  : claimController.claimSingleDataView[
                                              "is_approved"] ==
                                          "Pending"
                                      ? CustomButton(
                                          height: 25.h,
                                          width: 100.w,
                                          fontSize: kTenFont,
                                          fontWeight: kFW700,
                                          Color: KRed.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          Padding: EdgeInsets.only(
                                              left: 8.w,
                                              right: 8.w,
                                              top: 3.h,
                                              bottom: 3.h),
                                          textColor: KRed,
                                          label: "Pending",
                                          isLoading: false,
                                          onTap: () {})
                                      : const SizedBox()
                        ],
                      ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "Employee ID",
                      //       style: TextStyle(
                      //         fontSize: 11.5.sp,
                      //         fontWeight: kFW600,
                      //         color: Klightblack.withOpacity(0.8),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: 5.h,
                      //     ),
                      //     Text(
                      //       claimController.claimSingleDataViewPersonName.value,
                      //       maxLines: 1,
                      //       style: TextStyle(
                      //           fontSize: 13.sp,
                      //           fontWeight: kFW700,
                      //           color: KdarkText),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date :",
                                  style: TextStyle(
                                    fontSize: 11.5.sp,
                                    fontWeight: kFW600,
                                    color: Klightblack.withOpacity(0.8),
                                  )),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                  DateFormat("dd MMM yy").format(DateTime.parse(
                                      claimController
                                          .claimSingleDataView["date"])),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: kFW700,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite,
                                  )),
                            ],
                          ),
                          // SizedBox(
                          //   width: 100.w,
                          // ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text("End Date",
                          //         style: TextStyle(
                          //           fontSize: 11.5.sp,
                          //           fontWeight: kFW600,
                          //           color: Klightblack.withOpacity(0.8),
                          //         )),
                          //     SizedBox(
                          //       height: 5.h,
                          //     ),
                          //     Text(
                          //         DateFormat("dd MMM yy")
                          //             .format(DateTime.parse(fullInfo["to_date"])),
                          //         style: TextStyle(
                          //           fontSize: 13.sp,
                          //           fontWeight: kFW700,
                          //           color: KdarkText,
                          //         )),
                          //   ],
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Claim Amount :",
                              style: TextStyle(
                                fontSize: 11.5.sp,
                                fontWeight: kFW600,
                                color: Klightblack.withOpacity(0.8),
                              )),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                              claimController.claimSingleDataView["amount"]
                                  .toString(),
                              style: TextStyle(
                                height: 1.2,
                                letterSpacing: 0.5,
                                fontSize: 12.sp,
                                fontWeight: kFW700,
                                color: selectedTheme == "Lighttheme"
                                    ? KdarkText
                                    : Kwhite,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Reason :",
                              style: TextStyle(
                                fontSize: 11.5.sp,
                                fontWeight: kFW600,
                                color: Klightblack.withOpacity(0.8),
                              )),
                          SizedBox(
                            width: 5.w,
                          ),
                          SizedBox(
                            width: 250.w,
                            child: ReadMoreText(
                              claimController.claimSingleDataView["comments"] !=
                                      ""
                                  ? claimController
                                      .claimSingleDataView["comments"]
                                  : "-",
                              // trimLines: 1,
                              colorClickableText: KOrange,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: kFW700,
                                color: selectedTheme == "Lighttheme"
                                    ? KdarkText
                                    : Kwhite,
                              ),
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'See more',
                              trimExpandedText: '...See less',
                              moreStyle: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: kFW700,
                                  color: selectedTheme == "Lighttheme"
                                      ? KOrange
                                      : Kwhite),
                              lessStyle: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: kFW700,
                                  color: selectedTheme == "Lighttheme"
                                      ? KOrange
                                      : Kwhite),
                            ),
                          ),
                          // Text(
                          //     claimController.claimSingleDataView["comments"] !=
                          //             ""
                          //         ? claimController
                          //             .claimSingleDataView["comments"]
                          //         : "-",
                          //     style: TextStyle(
                          //       fontSize: 13.sp,
                          //       fontWeight: kFW700,
                          //       color: selectedTheme == "Lighttheme"
                          //           ? KdarkText
                          //           : Kwhite,
                          //     )),
                        ],
                      ),

                      SizedBox(
                        height: 15.h,
                      ),
                      // fullInfo["leave_status"] == 1
                      //     ? Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text("Approved Date",
                      //               style: TextStyle(
                      //                 fontSize: 11.5.sp,
                      //                 fontWeight: kFW600,
                      //                 color: Klightblack.withOpacity(0.8),
                      //               )),
                      //           SizedBox(
                      //             height: 5.h,
                      //           ),
                      //           Text(
                      //               DateFormat("dd MMM yy").format(
                      //                   DateTime.parse(fullInfo["approved_date"])),
                      //               style: TextStyle(
                      //                 height: 1.2,
                      //                 letterSpacing: 0.5,
                      //                 fontSize: 13.sp,
                      //                 fontWeight: kFW700,
                      //                 color: KdarkText,
                      //               )),
                      //         ],
                      //       )
                      //     : const SizedBox(),
                      // SizedBox(
                      //   height: 200.h,
                      // ),
                      Container(
                          // margin: EdgeInsets.all(13.r),
                          height: 180.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.r),
                            //border: Border.all(color: Ktextcolor)
                            //color: Kwhite,
                          ),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(12.r), // Image border
                              child: claimController
                                          .claimSingleDataView["ClaimDocuments"]
                                          .length >
                                      0
                                  ? claimController.claimSingleDataView[
                                              "ClaimDocuments"][0] !=
                                          null
                                      ?
                                      //   Image.file(
                                      //   File(claimData["ClaimDocuments"][0]["file_name_path"]),
                                      //   fit: BoxFit.cover,
                                      //   height: 100,
                                      //   width: 100,
                                      // )
                                      CachedNetworkImage(
                                          imageUrl:
                                              //  KClaimsimage +
                                              claimController
                                                          .claimSingleDataView[
                                                      "ClaimDocuments"][0]
                                                  ["file_name_path"],
                                          height: 180.h,
                                          placeholder: (context, url) =>
                                              SizedBox(
                                            height: 180.h,
                                            width: double.infinity,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.black12,
                                              highlightColor:
                                                  Colors.white.withOpacity(0.5),
                                              child: Container(
                                                height: 180.h,
                                                color: Kwhite.withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                          //                   SizedBox(
                                          //   height: 50.h,
                                          //   width: 267.w,
                                          //   child: Shimmer.fromColors(
                                          //     baseColor: Colors.black12,
                                          //     highlightColor: Colors.white.withOpacity(0.5),
                                          //     child: Container(
                                          //       decoration: BoxDecoration(
                                          //         borderRadius:
                                          //             BorderRadius.all(Radius.circular(10.0)),
                                          //         color: Kwhite.withOpacity(0.5),
                                          //       ),
                                          //       height: 50.h,
                                          //       width: 250.w,
                                          //     ),
                                          //   ),
                                          // ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            "assets/images/logo.png",
                                            fit: BoxFit.contain,
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : const Center(child: Text("No Recepit"))
                                  : const Center(child: Text("No Recepit")))),
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //   approvalConfirm["leaves"]["write"] == true
                          approvalConfirm["calims"]["write"] == true
                              ? claimController
                                          .claimSingleDataView["is_approved"] !=
                                      "Approved"
                                  ? CustomButton(
                                      borderRadius: BorderRadius.circular(30.r),
                                      margin: EdgeInsets.all(15.r),
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height: 35.h,
                                      Color: KOrange,
                                      textColor: Kwhite,
                                      fontSize: 13.sp,
                                      fontWeight: kFW700,
                                      label: "Approve",
                                      isLoading: false,
                                      onTap: () {
                                        updateLeaveClaimStats(
                                            "Approved",
                                            claimController.claimSingleDataView[
                                                "comments"],
                                            claimController.claimSingleDataView[
                                                "claim_id"]);
                                      })
                                  : const SizedBox()
                              : const SizedBox(),
                          approvalConfirm["calims"]["write"] == true
                              //  approvalConfirm["leaves"]["write"] == true
                              ? claimController
                                          .claimSingleDataView["is_approved"] !=
                                      "Rejected"
                                  // ? claimController
                                  //             .claimSingleDataView["is_approved"] ==
                                  //         "Rejected"
                                  ? Custom_OutlineButton(
                                      borderRadius: BorderRadius.circular(30.r),
                                      margin: EdgeInsets.all(10.r),
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height: 35.h,
                                      Color: KRed,
                                      textColor: KRed,
                                      fontSize: 13.sp,
                                      fontWeight: kFW700,
                                      label: "Decline",
                                      isLoading: false,
                                      onTap: () {
                                        updateLeaveClaimStats(
                                            "Rejected",
                                            claimController.claimSingleDataView[
                                                "comments"],
                                            claimController.claimSingleDataView[
                                                "claim_id"]);
                                      },
                                    )
                                  : const SizedBox()
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  )),
            )
          : const SpinKitFadingCircle(
              color: KOrange,
              size: 50,
            ),
    );
  }
}
