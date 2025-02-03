import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:vibeshr/controllers/claimsController.dart';

import '../../untils/export_file.dart';

class Approval_data extends StatefulWidget {
  Map approvalConfirmdata;
  Approval_data({super.key, required this.approvalConfirmdata});

  @override
  State<Approval_data> createState() => _Approval_dataState();
}

class _Approval_dataState extends State<Approval_data> {
  TextEditingController rejectReasonController = TextEditingController();

  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();
  FocusNode _focustwoNode = FocusNode();
  FocusNode _focusthreeNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _showKeyboard(node) {
    FocusScope.of(context).requestFocus(node);
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _handleTapOutside() {
    _hideKeyboard();
  }

  bool isExpanded = false;
  String clickedOption = "Pending";
  // var approvalConfirm = {};
  ClaimController claimController = Get.put(ClaimController());
  DashboardController dashboardController = Get.find<DashboardController>();
  var reasonDecline = "";
  // getApprovalConfirmationAPI() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Map data = await Services.hrRequestApprovalConfigs();

  //   if (data["message"] != null) {
  //     Fluttertoast.showToast(
  //       msg: data["message"],
  //     );
  //   } else {
  //     approvalConfirm = data;
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  getData() {
    claimController.leavesData.clear();
    if (clickedOption == "Pending" &&
        claimController.leaveslList["rows"] != null) {
      for (int i = 0; i < claimController.leaveslList["rows"].length; i++) {
        if (claimController.leaveslList["rows"][i]["leave_status"] == 0) {
          claimController.leavesData
              .add(claimController.leaveslList["rows"][i]);
        }
      }
    } else if (clickedOption == "Approved") {
      for (int i = 0; i < claimController.leaveslList["rows"].length; i++) {
        if (claimController.leaveslList["rows"][i]["leave_status"] == 1) {
          claimController.leavesData
              .add(claimController.leaveslList["rows"][i]);
        }
      }
    } else if (clickedOption == "Rejected") {
      for (int i = 0; i < claimController.leaveslList["rows"].length; i++) {
        if (claimController.leaveslList["rows"][i]["leave_status"] == 2) {
          claimController.leavesData
              .add(claimController.leaveslList["rows"][i]);
        }
      }
    }
  }

  bool isLoading = false;
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
        claimController.leaveSingleDataView.value = data;
        //  claimController.leavesData;
        claimController.updateLeaveUpdatedValue(data);
        _refreshQuickApplroval();
        data["leave_status"] == 1
            ? Fluttertoast.showToast(
                msg: "Leave is Approved",
              )
            : Fluttertoast.showToast(
                msg: "Leave is Declined",
              );
        // claimController.leavesData;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    claimController.peoplesdata;

    //  getApprovalConfirmationAPI();
    super.initState();
  }

  Future<void> _refreshQuickApplroval() async {
    setState(() {
      getData();
      claimController.onInit();
    });
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refreshQuickApplroval,
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) =>
             SingleChildScrollView(
                  child: GestureDetector(
                    onTap: _handleTapOutside,
                    child: Container(
                      margin: EdgeInsets.all(13.r),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      clickedOption = "Pending";
                                      getData();
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10.w),
                                    padding: EdgeInsets.only(
                                        left: 15.w,
                                        right: 15.w,
                                        top: 8.h,
                                        bottom: 8.h),
                                    decoration: clickedOption == "Pending"
                                        ? BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border: Border.all(color: KOrange),
                                            color: KOrange)
                                        : BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border:
                                                Border.all(color: Ktextcolor)),
                                    child: Text(
                                      "Pending",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: clickedOption == "Pending"
                                              ? kFW700
                                              : kFW500,
                                          color: clickedOption == "Pending"
                                              ? Kwhite
                                              : null),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      clickedOption = "Approved";
                                      getData();
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10.w),
                                    padding: EdgeInsets.only(
                                        left: 15.w,
                                        right: 15.w,
                                        top: 8.h,
                                        bottom: 8.h),
                                    decoration: clickedOption == "Approved"
                                        ? BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border: Border.all(color: KOrange),
                                            color: KOrange)
                                        : BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border:
                                                Border.all(color: Ktextcolor)),
                                    child: Text(
                                      "Approved",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight:
                                              clickedOption == "Approved"
                                                  ? kFW700
                                                  : kFW500,
                                          color: clickedOption == "Approved"
                                              ? Kwhite
                                              : null),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      clickedOption = "Rejected";
                                      getData();
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 15.w,
                                        right: 15.w,
                                        top: 8.h,
                                        bottom: 8.h),
                                    decoration: clickedOption == "Rejected"
                                        ? BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border: Border.all(color: KOrange),
                                            color: KOrange)
                                        : BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border:
                                                Border.all(color: Ktextcolor)),
                                    child: Text(
                                      "Rejected",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight:
                                              clickedOption == "Rejected"
                                                  ? kFW700
                                                  : kFW500,
                                          color: clickedOption == "Rejected"
                                              ? Kwhite
                                              : null),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          widget.approvalConfirmdata["leaves"] == null ||
                                  claimController.leavesData.isEmpty ||
                                  claimController.peoplesdata["rows"] == null
                              ? Container(
                                  margin: EdgeInsets.only(top: 50.h),
                                  alignment: Alignment.center,
                                  child: Center(
                                      child: Column(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/oopsNoData.svg",
                                          // color: KOrange,
                                          fit: BoxFit.fill,
                                          semanticsLabel: 'No Data'),
                                      SizedBox(
                                        height: 40.h,
                                      ),
                                      Text(
                                        "No Leaves Available",
                                        style: TextStyle(
                                            fontWeight: kFW700,
                                            fontSize: kTwentyFont),
                                      )
                                    ],
                                  )))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: claimController.leavesData.length,
                                  itemBuilder: (context, index) {
                                    return dashboardController
                                                .profiledata["emp_id"] ==
                                            claimController.leavesData[index]
                                                ["emp_id"]
                                        ? SizedBox()
                                        :
                                        // AnimatedContainer(
                                        //     duration:
                                        //         Duration(milliseconds: 300),
                                        ////////Written Here
                                        claimController.leavesData[index]
                                                            ["leave_status"] ==
                                                        1 &&
                                                    clickedOption ==
                                                        "Pending" ||
                                                claimController.leavesData[index]
                                                            ["leave_status"] ==
                                                        2 &&
                                                    clickedOption == "Pending"
                                            ? SizedBox()
                                            : Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.h),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    color: selectedTheme ==
                                                            "Lighttheme"
                                                        ? clickedOption == "Pending"
                                                            ? Kwhite
                                                            : clickedOption == "Approved"
                                                                ? Kgreen.withOpacity(0.1)
                                                                : KRed.withOpacity(0.1)
                                                        : Kthemeblack),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              claimController
                                                                          .peoplesdata[
                                                                              "rows"]
                                                                          .where((element) =>
                                                                              element["emp_id"] ==
                                                                              claimController.leavesData[index]["emp_id"])
                                                                          .toList()[0]["Employee"]["gender"] ==
                                                                      "Male"
                                                                  ? Image.asset(
                                                                      "assets/images/man.png",
                                                                      height:
                                                                          35.h,
                                                                      width:
                                                                          35.h,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    )
                                                                  : Image.asset(
                                                                      "assets/images/girl.png",
                                                                      height:
                                                                          35.h,
                                                                      width:
                                                                          35.h,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                              SizedBox(
                                                                  width: 5.w),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        claimController.peoplesdata["rows"].where((element) => element["emp_id"] == claimController.leavesData[index]["emp_id"]).toList().isNotEmpty
                                                                            ? claimController.peoplesdata["rows"].where((element) => element["emp_id"] == claimController.leavesData[index]["emp_id"]).toList()[0]["Employee"]["fname"]
                                                                            : "Self",
                                                                        // "-",
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize: 12
                                                                                .sp,
                                                                            fontWeight:
                                                                                kFW700,
                                                                            color: selectedTheme == "Lighttheme"
                                                                                ? kblack
                                                                                : Kwhite),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              2.w),
                                                                      Text(
                                                                        claimController.peoplesdata["rows"].where((element) => element["emp_id"] == claimController.leavesData[index]["emp_id"]).toList().isNotEmpty
                                                                            ? claimController.peoplesdata["rows"].where((element) => element["emp_id"] == claimController.leavesData[index]["emp_id"]).toList()[0]["Employee"]["lname"]
                                                                            : "",
                                                                        // "-",
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize: 12
                                                                                .sp,
                                                                            fontWeight:
                                                                                kFW700,
                                                                            color: selectedTheme == "Lighttheme"
                                                                                ? kblack
                                                                                : Kwhite),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        "${DateFormat("MMM dd, yyyy").format(DateTime.parse(claimController.leavesData[index]["from_date"]))}  - ",
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                kTenFont,
                                                                            fontWeight:
                                                                                kFW600,
                                                                            color:
                                                                                kblack.withOpacity(0.5)),
                                                                      ),
                                                                      Text(
                                                                        " ${DateFormat("MMM dd, yyyy").format(DateTime.parse(claimController.leavesData[index]["to_date"]))}", //Expand COntainer
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                kTenFont,
                                                                            fontWeight:
                                                                                kFW600,
                                                                            color:
                                                                                kblack.withOpacity(0.5)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 8.h,
                                                          ),
                                                          ReadMoreText(
                                                            "\u2022 ${claimController.leavesData[index]["reason"].toString().capitalizeFirst!}",

                                                            // trimLines: 1,
                                                            colorClickableText:
                                                                KOrange,
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    kFW700,
                                                                color: selectedTheme ==
                                                                        "Lighttheme"
                                                                    ? kblack
                                                                        .withOpacity(
                                                                            0.7)
                                                                    : Kwhite),
                                                            trimMode:
                                                                TrimMode.Line,
                                                            trimCollapsedText:
                                                                'See more',
                                                            trimExpandedText:
                                                                '...See less',
                                                            moreStyle: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    kFW700,
                                                                color: selectedTheme ==
                                                                        "Lighttheme"
                                                                    ? KOrange
                                                                    : Kwhite),
                                                            lessStyle: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    kFW700,
                                                                color: selectedTheme ==
                                                                        "Lighttheme"
                                                                    ? KOrange
                                                                    : Kwhite),
                                                          ),
                                                          // Text(
                                                          //   claimController
                                                          //           .leavesData[
                                                          //       index]["reason"],
                                                          //   maxLines: 2,
                                                          //   overflow:
                                                          //       TextOverflow
                                                          //           .ellipsis,
                                                          //   style: TextStyle(
                                                          //       height: 1.2,
                                                          //       letterSpacing:
                                                          //           0.5,
                                                          //       wordSpacing:
                                                          //           0.5,
                                                          //       fontSize: 13.sp,
                                                          //       fontWeight:
                                                          //           kFW900,
                                                          //       color: selectedTheme ==
                                                          //               "Lighttheme"
                                                          //           ? KdarkText
                                                          //           : Kwhite),
                                                          // ),
                                                          SizedBox(
                                                            height: 7.h,
                                                          ),
                                                          clickedOption ==
                                                                  "Pending"
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    // approvalConfirm
                                                                    widget.approvalConfirmdata["leaves"]["write"] ==
                                                                            true
                                                                        ? claimController.leavesData[index]["leave_status"] !=
                                                                                1
                                                                            ? GestureDetector(
                                                                                onTap: () async {
                                                                                  setState(() {
                                                                                    claimController.leavesData[index]["leave_status"] = 1;
                                                                                  });
                                                                                  await updateLeaveClaimStats("Approve", claimController.leavesData[index]["reason"], claimController.leavesData[index]["employee_leaves_lid"]
                                                                                      //claimController
                                                                                      // .leaveSingleDataView["reason"],
                                                                                      // claimController.leaveSingleDataView[
                                                                                      //     "employee_leaves_lid"]
                                                                                      );
                                                                                },
                                                                                child: Container(
                                                                                  height: 28.h,
                                                                                  width: 120.w,
                                                                                  alignment: Alignment.center,
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: Border.all(color: Kgreen.withOpacity(0.3), width: 1)),
                                                                                  child: Text(
                                                                                    "Approve",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(fontSize: kTenFont, color: Kgreen, fontWeight: kFW600),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            // Custom_OutlineButton(
                                                                            //     height: 28.h,
                                                                            //     width: 105.w,
                                                                            //     textColor: Kgreen,
                                                                            //     borderRadius:
                                                                            //         BorderRadius.circular(
                                                                            //             8.r),
                                                                            //     Color: Kgreen.withOpacity(
                                                                            //         0.3),
                                                                            //     fontSize: kTenFont,
                                                                            //     fontWeight: kFW600,
                                                                            //     label: "Approve",
                                                                            //     isLoading: false,

                                                                            //   )
                                                                            : SizedBox()
                                                                        : SizedBox(),
                                                                    widget.approvalConfirmdata["leaves"]["write"] ==
                                                                            true
                                                                        ? claimController.leavesData[index]["leave_status"] !=
                                                                                2
                                                                            ? GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    // Toggle the expansion state
                                                                                    isExpanded = !isExpanded;
                                                                                  });
                                                                                  _onSelected(index);
                                                                                },
                                                                                // onTap: () {    // vvip code
                                                                                //   updateLeaveClaimStats(
                                                                                //       "Reject",
                                                                                //       claimController.leavesData[index]["reason"],
                                                                                //       //   "Leave Rejected",
                                                                                //       claimController.leavesData[index]["employee_leaves_lid"]
                                                                                //       // claimController.leaveSingleDataView[
                                                                                //       //     "employee_leaves_lid"]
                                                                                //       );
                                                                                // },
                                                                                child: Container(
                                                                                  //  work here
                                                                                  height: 28.h,
                                                                                  width: 120.w,
                                                                                  alignment: Alignment.center,
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: Border.all(color: KRed.withOpacity(0.3), width: 1)),
                                                                                  child: Text(
                                                                                    "Decline",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(fontSize: kTenFont, color: KRed, fontWeight: kFW600),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            // Custom_OutlineButton(
                                                                            //     height: 28.h,
                                                                            //     width: 105.w,
                                                                            //     textColor: KOrange,
                                                                            //     borderRadius:
                                                                            //         BorderRadius.circular(
                                                                            //             8.r),
                                                                            //     Color: KOrange,
                                                                            //     fontSize: kTenFont,
                                                                            //     fontWeight: kFW600,
                                                                            //     label: "Decline",
                                                                            //     isLoading: false,
                                                                            //     onTap: () {
                                                                            //       updateLeaveClaimStats(
                                                                            //           "Reject",
                                                                            //           claimController
                                                                            //                       .leavesData[
                                                                            //                   index]
                                                                            //               ["reason"],
                                                                            //           //   "Leave Rejected",
                                                                            //           claimController
                                                                            //                       .leavesData[
                                                                            //                   index][
                                                                            //               "employee_leaves_lid"]
                                                                            //           // claimController.leaveSingleDataView[
                                                                            //           //     "employee_leaves_lid"]
                                                                            //           );
                                                                            //     },
                                                                            //   )
                                                                            : SizedBox()
                                                                        : SizedBox()
                                                                  ],
                                                                )
                                                              // Align(
                                                              //     alignment: Alignment.bottomRight,
                                                              //     child: Custom_OutlineButton(
                                                              //         height: 28.h,
                                                              //         width: 105.w,
                                                              //         textColor: KOrange,
                                                              //         borderRadius:
                                                              //             BorderRadius.circular(8.r),
                                                              //         Color: KOrange,
                                                              //         fontSize: kTenFont,
                                                              //         fontWeight: kFW600,
                                                              //         label: "View More",
                                                              //         isLoading: false,
                                                              //         onTap: () async {
                                                              //           claimController.viewSingleLeave(
                                                              //               claimController
                                                              //                   .leavesData[index],
                                                              //               claimController
                                                              //                       .peoplesdata["rows"]
                                                              //                       .where((element) =>
                                                              //                           element[
                                                              //                               "emp_id"] ==
                                                              //                           claimController
                                                              //                                       .leavesData[
                                                              //                                   index]
                                                              //                               ["emp_id"])
                                                              //                       .toList()
                                                              //                       .isNotEmpty
                                                              //                   ? claimController
                                                              //                       .peoplesdata["rows"]
                                                              //                       .where((element) =>
                                                              //                           element[
                                                              //                               "emp_id"] ==
                                                              //                           claimController
                                                              //                                   .leavesData[
                                                              //                               index]["emp_id"])
                                                              //                       //   .toList()[0]["Employee"]
                                                              //                       .toList()[0]["username"]
                                                              //                   : "Self");
                                                              //           var x = await Get.toNamed(
                                                              //               KApproval_view);
                                                              //           // : {"data":leavesData[index],"name" :  claimController.peoplesdata["rows"].where((element) => element["emp_id"]==leavesData[index]["emp_id"]).toList().isNotEmpty?  claimController.peoplesdata["rows"].where((element) => element["emp_id"]==leavesData[index]["emp_id"]).toList()[0]["username"]:"Slef" });
                                                              //           setState(() {
                                                              //             getData();
                                                              //           });
                                                              //         }),
                                                              //   )

                                                              : const SizedBox(),
                                                          /////////////////////////////////////////////////////
                                                          _selectedIndex !=
                                                                  index
                                                              ? const SizedBox()
                                                              : clickedOption ==
                                                                      "Pending"
                                                                  ? isExpanded
                                                                      ? Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 10.h,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 200.w,
                                                                                  height: 30.h,
                                                                                  child:
                                                                                      // CustomFormField(
                                                                                      //     controller: rejectReasonController,
                                                                                      //     maxLines: 1,
                                                                                      //     readOnly: false,
                                                                                      //     labelText: "Reason",
                                                                                      //     hintText: ""),
                                                                                      TextFormField(
                                                                                    focusNode: _focusNode,
                                                                                    onTap: () {
                                                                                      _showKeyboard(_focusNode);
                                                                                    },
                                                                                    // textCapitalization: TextCapitalization.characters,
                                                                                    style: TextStyle(
                                                                                      fontSize: 12.sp,
                                                                                      fontWeight: kFW600,
                                                                                      color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
                                                                                    ),
                                                                                    textAlignVertical: TextAlignVertical.center,
                                                                                    decoration: InputDecoration(
                                                                                      focusColor: Colors.white,
                                                                                      contentPadding: const EdgeInsets.only(left: 20.0, bottom: 6.0, top: 8.0),
                                                                                      // contentPadding: const EdgeInsets.symmetric(
                                                                                      //     vertical: 13.0, horizontal: 10.0),

                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(20.r),
                                                                                      ),
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderSide: const BorderSide(color: Ktextcolor, width: 0.5),
                                                                                        borderRadius: BorderRadius.circular(30.r),
                                                                                      ),
                                                                                      errorBorder: OutlineInputBorder(
                                                                                        borderSide: const BorderSide(color: Ktextcolor, width: 0.5),
                                                                                        borderRadius: BorderRadius.circular(30.r),
                                                                                      ),
                                                                                      disabledBorder: OutlineInputBorder(
                                                                                        borderSide: const BorderSide(color: Ktextcolor, width: 0.5),
                                                                                        borderRadius: BorderRadius.circular(30.r),
                                                                                      ),
                                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                                        borderSide: const BorderSide(color: Ktextcolor, width: 1),
                                                                                        borderRadius: BorderRadius.circular(30.r),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: const BorderSide(color: Ktextcolor, width: 0.5),
                                                                                        borderRadius: BorderRadius.circular(30.r),
                                                                                      ),
                                                                                      fillColor: Colors.grey,

                                                                                      hintText: "Reason",

                                                                                      //make hint text
                                                                                      hintStyle: TextStyle(
                                                                                        color: selectedTheme == "Lighttheme" ? Klightgray.withOpacity(0.5) : Kwhite,
                                                                                        fontSize: kTenFont,
                                                                                        fontWeight: FontWeight.w700,
                                                                                      ),

                                                                                      //create lable
                                                                                      labelText: 'Reason',
                                                                                      //lable style
                                                                                      labelStyle: TextStyle(
                                                                                        color: selectedTheme == "Lighttheme" ? Klightgray : Kwhite,
                                                                                        fontSize: kTwelveFont,
                                                                                        fontWeight: FontWeight.w800,
                                                                                      ),
                                                                                    ),
                                                                                    validator: (value) {
                                                                                      (input) => input.isValidEmail() ? null : "Check your Employee Id";
                                                                                      if (value!.isEmpty) {
                                                                                        return 'Please enter Employee Id';
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                    onChanged: (String value) {
                                                                                      reasonDecline = value;
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                GestureDetector(
                                                                                  // onTap:
                                                                                  //     () {
                                                                                  //   setState(() {
                                                                                  //     // Toggle the expansion state
                                                                                  //     isExpanded = !isExpanded;
                                                                                  //   });
                                                                                  // },
                                                                                  onTap: () async {
                                                                                    // vvip code
                                                                                    setState(() {
                                                                                      // Toggle the expansion state
                                                                                      isExpanded = !isExpanded;
                                                                                      claimController.leavesData[index]["leave_status"] = 2;
                                                                                    });
                                                                                    await updateLeaveClaimStats(
                                                                                        "Reject",
                                                                                        reasonDecline,
                                                                                        // rejectReasonController.text,
                                                                                        // rejectReasonController.text,
                                                                                        // claimController.leavesData[index]["reason"],
                                                                                        //   "Leave Rejected",
                                                                                        claimController.leavesData[index]["employee_leaves_lid"]
                                                                                        // claimController.leaveSingleDataView[
                                                                                        //     "employee_leaves_lid"]
                                                                                        );

                                                                                    // setState(() {
                                                                                    //   // Toggle the expansion state
                                                                                    //   isExpanded = isExpanded;
                                                                                    // });
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 28.h,
                                                                                    width: 60.w,
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: Border.all(color: KRed.withOpacity(0.3), width: 1)),
                                                                                    child: Text(
                                                                                      "Submit",
                                                                                      textAlign: TextAlign.center,
                                                                                      style: TextStyle(fontSize: kTenFont, color: KRed, fontWeight: kFW600),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : SizedBox()
                                                                  : SizedBox(),

                                                          //////////////////////////////////////////////////////////////////
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                  })
                        ],
                      ),
                    ),
                  ),
                )
          
            //your Widget..
            ));
  }
}

//////Calims Approval
class Claim_Approval_data extends StatefulWidget {
  const Claim_Approval_data({super.key});

  @override
  State<Claim_Approval_data> createState() => _Claim_Approval_dataState();
}

class _Claim_Approval_dataState extends State<Claim_Approval_data> {
  ClaimController claimController = Get.put(ClaimController());

  String clickedOption = "Pending";
  getData() {
    claimController.claimsData.clear();
    if (clickedOption == "Pending") {
      for (int i = 0; i < claimController.claimsList["rows"].length; i++) {
        if (claimController.claimsList["rows"][i]["is_approved"] == "Pending") {
          claimController.claimsData.add(claimController.claimsList["rows"][i]);
        }
      }
    } else if (clickedOption == "Approved") {
      for (int i = 0; i < claimController.claimsList["rows"].length; i++) {
        if (claimController.claimsList["rows"][i]["is_approved"] ==
            "Approved") {
          claimController.claimsData.add(claimController.claimsList["rows"][i]);
        }
      }
    } else if (clickedOption == "Rejected") {
      for (int i = 0; i < claimController.claimsList["rows"].length; i++) {
        if (claimController.claimsList["rows"][i]["is_approved"] ==
            "Rejected") {
          claimController.claimsData.add(claimController.claimsList["rows"][i]);
        }
      }
    } else if (clickedOption == "Paid") {
      for (int i = 0; i < claimController.claimsList["rows"].length; i++) {
        if (claimController.claimsList["rows"][i]["is_approved"] == "Paid") {
          claimController.claimsData.add(claimController.claimsList["rows"][i]);
        }
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> _refreshQuickApplrove() async {
    setState(() {
      getData();
      claimController.onInit();
    });
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refreshQuickApplrove,
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(13.r),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    clickedOption = "Pending";
                                    getData();
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10.w),
                                  padding: EdgeInsets.only(
                                      left: 15.w,
                                      right: 15.w,
                                      top: 8.h,
                                      bottom: 8.h),
                                  decoration: clickedOption == "Pending"
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(color: KOrange),
                                          color: KOrange)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border:
                                              Border.all(color: Ktextcolor)),
                                  child: Text(
                                    "Pending",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: clickedOption == "Pending"
                                            ? kFW700
                                            : kFW500,
                                        color: clickedOption == "Pending"
                                            ? Kwhite
                                            : null),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    clickedOption = "Approved";
                                    getData();
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10.w),
                                  padding: EdgeInsets.only(
                                      left: 15.w,
                                      right: 15.w,
                                      top: 8.h,
                                      bottom: 8.h),
                                  decoration: clickedOption == "Approved"
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(color: KOrange),
                                          color: KOrange)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border:
                                              Border.all(color: Ktextcolor)),
                                  child: Text(
                                    "Approved",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: clickedOption == "Approved"
                                            ? kFW700
                                            : kFW500,
                                        color: clickedOption == "Approved"
                                            ? Kwhite
                                            : null),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    clickedOption = "Rejected";
                                    getData();
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 15.w,
                                      right: 15.w,
                                      top: 8.h,
                                      bottom: 8.h),
                                  decoration: clickedOption == "Rejected"
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(color: KOrange),
                                          color: KOrange)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border:
                                              Border.all(color: Ktextcolor)),
                                  child: Text(
                                    "Rejected",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: clickedOption == "Rejected"
                                            ? kFW700
                                            : kFW500,
                                        color: clickedOption == "Rejected"
                                            ? Kwhite
                                            : null),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        claimController.claimsData.isEmpty
                            ? Container(
                                margin: EdgeInsets.only(top: 50.h),
                                alignment: Alignment.center,
                                child: Center(
                                    child: Column(
                                  children: [
                                    SvgPicture.asset(
                                        "assets/images/oopsNoData.svg",
                                        // color: KOrange,
                                        fit: BoxFit.fill,
                                        semanticsLabel: 'No Data'),
                                    SizedBox(
                                      height: 40.h,
                                    ),
                                    Text(
                                      "No Claims Available",
                                      style: TextStyle(
                                          fontWeight: kFW700,
                                          fontSize: kTwentyFont),
                                    )
                                  ],
                                )))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: claimController.claimsData.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      claimController.viewSingleClaim(
                                          claimController.claimsData[index],
                                          claimController.peoplesdata["rows"]
                                                  .where((element) =>
                                                      element["emp_id"] ==
                                                      claimController
                                                              .claimsData[index]
                                                          ["emp_id"])
                                                  .toList()
                                                  .isNotEmpty
                                              ? claimController
                                                  .peoplesdata["rows"]
                                                  .where((element) =>
                                                      element["emp_id"] ==
                                                      claimController
                                                              .claimsData[index]
                                                          ["emp_id"])
                                                  .toList()[0]["username"]
                                              : "Self");
                                      var x = await Get.toNamed(
                                          KClaimsApproval_view
                                          // ,arguments: {"data":claimController.claimsData[index],"name" :
                                          //  claimController.peoplesdata["rows"].where((element) => element["emp_id"]==leavesData[index]["emp_id"]).toList().isNotEmpty?  claimController.peoplesdata["rows"].where((element) => element["emp_id"]==8).toList()[0]["username"]:
                                          // "Slef" }
                                          );
                                      setState(() {
                                        getData();
                                      });
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(top: 10.h),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: selectedTheme == "Lighttheme"
                                                ? clickedOption == "Pending"
                                                    ? Kwhite
                                                    : clickedOption ==
                                                            "Approved"
                                                        ? Kgreen.withOpacity(
                                                            0.1)
                                                        : KRed.withOpacity(0.1)
                                                : Kthemeblack
                                            //  selectedTheme == "Lighttheme"
                                            //     ? Kwhite
                                            //     : Kthemeblack
                                            ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(10.r),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          claimController
                                                                      .peoplesdata[
                                                                          "rows"]
                                                                      .where((element) =>
                                                                          element[
                                                                              "emp_id"] ==
                                                                          claimController.claimsData[index]
                                                                              [
                                                                              "emp_id"])
                                                                      .toList()[0]["Employee"]["gender"] ==
                                                                  "Male"
                                                              ? Image.asset(
                                                                  "assets/images/man.png",
                                                                  height: 35.h,
                                                                  width: 35.h,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                )
                                                              : Image.asset(
                                                                  "assets/images/girl.png",
                                                                  height: 35.h,
                                                                  width: 35.h,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    claimController
                                                                            .peoplesdata[
                                                                                "rows"]
                                                                            .where((element) =>
                                                                                element["emp_id"] ==
                                                                                claimController.claimsData[index][
                                                                                    "emp_id"])
                                                                            .toList()
                                                                            .isNotEmpty
                                                                        ? claimController
                                                                            .peoplesdata[
                                                                                "rows"]
                                                                            .where((element) =>
                                                                                element["emp_id"] ==
                                                                                claimController.claimsData[index]["emp_id"])
                                                                            .toList()[0]["Employee"]["fname"]
                                                                        : "Self",
                                                                    // "-",
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            kFW700,
                                                                        color: selectedTheme ==
                                                                                "Lighttheme"
                                                                            ? kblack
                                                                            : Kwhite),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  Text(
                                                                    claimController
                                                                            .peoplesdata[
                                                                                "rows"]
                                                                            .where((element) =>
                                                                                element["emp_id"] ==
                                                                                claimController.claimsData[index][
                                                                                    "emp_id"])
                                                                            .toList()
                                                                            .isNotEmpty
                                                                        ? claimController
                                                                            .peoplesdata[
                                                                                "rows"]
                                                                            .where((element) =>
                                                                                element["emp_id"] ==
                                                                                claimController.claimsData[index]["emp_id"])
                                                                            .toList()[0]["Employee"]["lname"]
                                                                        : "Self",
                                                                    // "-",
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            kFW700,
                                                                        color: selectedTheme ==
                                                                                "Lighttheme"
                                                                            ? kblack
                                                                            : Kwhite),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                "Claim Date : ${DateFormat("MMM dd, yyyy").format(DateTime.parse(claimController.claimsData[index]["date"]))}",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        kTenFont,
                                                                    fontWeight:
                                                                        kFW600,
                                                                    color:
                                                                        Klightblack),
                                                              ),
                                                              Text(
                                                                "Claim Amount : ${claimController.claimsData[index]["amount"]}",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize: 11
                                                                        .spMax,
                                                                    fontWeight:
                                                                        kFW600,
                                                                    color: kblack
                                                                        .withOpacity(
                                                                            0.6)),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const Icon(Icons
                                                          .keyboard_arrow_right_outlined)
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  ReadMoreText(
                                                    "\u2022 ${claimController.claimsData[index]["comments"].toString().capitalizeFirst!}",

                                                    // trimLines: 1,
                                                    colorClickableText: KOrange,
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontWeight: kFW700,
                                                        color: selectedTheme ==
                                                                "Lighttheme"
                                                            ? kblack
                                                                .withOpacity(
                                                                    0.9)
                                                            : Kwhite),
                                                    trimMode: TrimMode.Line,
                                                    trimCollapsedText:
                                                        'See more',
                                                    trimExpandedText:
                                                        '...See less',
                                                    moreStyle: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontWeight: kFW700,
                                                        color: selectedTheme ==
                                                                "Lighttheme"
                                                            ? KOrange
                                                            : Kwhite),
                                                    lessStyle: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontWeight: kFW700,
                                                        color: selectedTheme ==
                                                                "Lighttheme"
                                                            ? KOrange
                                                            : Kwhite),
                                                  ),

                                                  // SizedBox(
                                                  //   height: 25.h,
                                                  // ),
                                                  // clickedOption == "Pending"
                                                  //     ? Align(
                                                  //         alignment: Alignment
                                                  //             .bottomRight,
                                                  //         child:
                                                  //             Custom_OutlineButton(
                                                  //                 height: 28.h,
                                                  //                 width: 105.w,
                                                  //                 textColor:
                                                  //                     KOrange,
                                                  //                 borderRadius:
                                                  //                     BorderRadius
                                                  //                         .circular(8
                                                  //                             .r),
                                                  //                 Color: KOrange,
                                                  //                 fontSize:
                                                  //                     kTenFont,
                                                  //                 fontWeight:
                                                  //                     kFW600,
                                                  //                 label:
                                                  //                     "View More",
                                                  //                 isLoading:
                                                  //                     false,
                                                  //                 onTap:
                                                  //                     () async {
                                                  //                   claimController.viewSingleClaim(
                                                  //                       claimController
                                                  //                               .claimsData[
                                                  //                           index],
                                                  //                       claimController
                                                  //                               .peoplesdata["rows"]
                                                  //                               .where((element) => element["emp_id"] == claimController.claimsData[index]["emp_id"])
                                                  //                               .toList()
                                                  //                               .isNotEmpty
                                                  //                           ? claimController.peoplesdata["rows"].where((element) => element["emp_id"] == claimController.claimsData[index]["emp_id"]).toList()[0]["username"]
                                                  //                           : "Self");
                                                  //                   var x = await Get.toNamed(
                                                  //                       KClaimsApproval_view
                                                  //                       // ,arguments: {"data":claimController.claimsData[index],"name" :
                                                  //                       //  claimController.peoplesdata["rows"].where((element) => element["emp_id"]==leavesData[index]["emp_id"]).toList().isNotEmpty?  claimController.peoplesdata["rows"].where((element) => element["emp_id"]==8).toList()[0]["username"]:
                                                  //                       // "Slef" }
                                                  //                       );
                                                  //                   setState(() {
                                                  //                     getData();
                                                  //                   });
                                                  //                 }
                                                  //                 ),
                                                  //       )
                                                  //     : SizedBox(),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  );
                                })
                      ],
                    ),
                  ),
                )));
  }
}
