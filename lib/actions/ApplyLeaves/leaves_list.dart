// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../../untils/export_file.dart';

class Leaves extends StatefulWidget {
  const Leaves({super.key});

  @override
  State<Leaves> createState() => _LeavesState();
}

class _LeavesState extends State<Leaves> {
  LeavesController leavesController = Get.find<LeavesController>();

  // List leavesdata = [];
  // Map profile = {};

  // bool isLoading = false;
  //  Map peoplesdata = {};
  // List originalList = [];
  // Future peoplesListHandler() async {
  //   setState(() {
  //     peopleLoading = true;
  //   });
  //   Map data = await Services.peopleslist();

  //   if (data["message"] != null) {
  //     Fluttertoast.showToast(
  //       msg: data["message"],
  //     );
  //   } else {
  //     peoplesdata = data;
  //     originalList = data["rows"];
  //   }
  //   setState(() {
  //     peopleLoading = false;
  //   });
  // }
  // bool peopleLoading=false;
  // Future leavesListHandler() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Map data = await Services.leavelist();
  //   profile = await Services.employeeprofile();
  //   if (data["message"] != null) {
  //     Fluttertoast.showToast(
  //       msg: data["message"],
  //     );
  //   } else {
  //     leavesdata = data["rows"];
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // @override
  // void initState() {
  //   // leavesListHandler();
  //   // peoplesListHandler();
  //   super.initState();
  // }
  Future<void> _refreshLeavesData() async {
    setState(() {
      leavesController.onInit();
      dashboardController.onInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomButton(
            margin: const EdgeInsets.all(15),
            height: 40.h,
            width: double.infinity,
            textColor: Kwhite,
            borderRadius: BorderRadius.circular(20.r),
            Color: KOrange,
            fontSize: 13.sp,
            fontWeight: kFW600,
            label: "Apply Leave ",
            isLoading: false,
            onTap: () {
              Get.toNamed(Kleaves, arguments: leavesdata);
            }),
        backgroundColor:
            selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
        appBar: VibhoAppBar(
          bColor: selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
          title: 'Leaves History',
          dontHaveBackAsLeading: false,
        ),
        body: RefreshIndicator(
            onRefresh: _refreshLeavesData,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(
                    () => dashboardController.permissiondata["leave_balance"] ==
                            true
                        ? Leavebalances()
                        : SizedBox(),
                  ),
                  Obx(
                    () => leavesController.isLoading.value == false &&
                            leavesController.peopleLoading.value == false
                        ? leavesController.leavesdata.isEmpty ||
                                leavesController.leavesdata.isEmpty
                            ? Center(
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
                                    "No Leaves Found",
                                    style: TextStyle(
                                        fontWeight: kFW700,
                                        fontSize: kTwentyFont),
                                  )
                                ],
                              ))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: leavesController.leavesdata.length,
                                itemBuilder: (context, index) {
                                  return leavesController.leavesdata[index]
                                              ["emp_id"] ==
                                          leavesController.profile["emp_id"]
                                      ? GestureDetector(
                                          onTap: () {
                                            // Get.toNamed(KLeave_detail,
                                            //     arguments: leavesController
                                            //         .leavesdata[index]);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(13.r),
                                            padding: EdgeInsets.all(13.r),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: selectedTheme ==
                                                        "Lighttheme"
                                                    ? Kwhite
                                                    : Kthemeblack),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      // ignore: unnecessary_null_comparison
                                                      leavesController.leavesdata[
                                                                      index][
                                                                  "LeaveTypes"] ==
                                                              null
                                                          ? "Not Defined"
                                                          : leavesController
                                                                          .leavesdata[
                                                                      index]
                                                                  ["LeaveTypes"]
                                                              [
                                                              "leave_type_name"],
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight: kFW900,
                                                          color: selectedTheme ==
                                                                  "Lighttheme"
                                                              ? kblack
                                                              : Kwhite),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10,
                                                              left: 10,
                                                              top: 3,
                                                              bottom: 3),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: leavesController
                                                                        .leavesdata[index][
                                                                    "leave_status"] ==
                                                                0
                                                            ? KOrange.withOpacity(
                                                                0.2)
                                                            : leavesController.leavesdata[index]
                                                                        [
                                                                        "leave_status"] ==
                                                                    1
                                                                ? Kgreen.withOpacity(
                                                                    0.2)
                                                                : leavesController.leavesdata[index]
                                                                            [
                                                                            "leave_status"] ==
                                                                        2
                                                                    ? KRed.withOpacity(
                                                                        0.2)
                                                                    : leavesController.leavesdata[index]["leave_status"] ==
                                                                            0
                                                                        ? KRed.withOpacity(
                                                                            0.2)
                                                                        : Klightblack.withOpacity(0.2),
                                                      ),
                                                      child: Text(
                                                        leavesController.leavesdata[
                                                                        index][
                                                                    "leave_status"] ==
                                                                0
                                                            ? "In Progress"
                                                            : leavesController.leavesdata[
                                                                            index]
                                                                        [
                                                                        "leave_status"] ==
                                                                    1
                                                                ? "Approved"
                                                                : leavesController.leavesdata[index]
                                                                            [
                                                                            "leave_status"] ==
                                                                        2
                                                                    ? "Rejected"
                                                                    : leavesController.leavesdata[index]["leave_status"] ==
                                                                            3
                                                                        ? "Cancelled By You"
                                                                        : "-",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight: kFW600,
                                                          color: leavesController
                                                                              .leavesdata[
                                                                          index]
                                                                      [
                                                                      "leave_status"] ==
                                                                  0
                                                              ? KOrange
                                                              : leavesController
                                                                              .leavesdata[index]
                                                                          [
                                                                          "leave_status"] ==
                                                                      1
                                                                  ? Kgreen
                                                                  : leavesController.leavesdata[index]
                                                                              [
                                                                              "leave_status"] ==
                                                                          2
                                                                      ? KRed
                                                                      : leavesController.leavesdata[index]["leave_status"] ==
                                                                              0
                                                                          ? KRed
                                                                          : Klightblack,
                                                        ),
                                                      ),
                                                    ),
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
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Leave From : ",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    kFW600,
                                                                color:
                                                                    Klightblack),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                            "${DateFormat("EEE, MMM d'yy").format(DateTime.parse(leavesController.leavesdata[index]["from_date"].toString()))} - ${DateFormat("EEE, MMM d'yy").format(DateTime.parse(leavesController.leavesdata[index]["to_date"].toString()))}",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    kFW700,
                                                                color: selectedTheme ==
                                                                        "Lighttheme"
                                                                    ? kblack
                                                                    : Kwhite),
                                                          ),
                                                        ]),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),

                                                    leavesController.leavesdata[index][
                                                                "leave_status"] ==
                                                            0
                                                        ? const SizedBox()
                                                        : leavesController.leavesdata[
                                                                        index][
                                                                    "leave_status"] ==
                                                                1
                                                            ? leavesController
                                                                        .leavesdata[index][
                                                                            "LeaveAccept"]
                                                                        .length ==
                                                                    0
                                                                ? const SizedBox()
                                                                : Column(
                                                                    children: [
                                                                      Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "Accepted By : ",
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(fontSize: 11.sp, fontWeight: kFW600, color: Klightblack),
                                                                            ),
                                                                            SizedBox(
                                                                              // color: KOrange,
                                                                              width: 200.w,
                                                                              child: Text(
                                                                                leavesController.leavesdata[index]["LeaveAccept"][0]["emp_name"],
                                                                                maxLines: 2,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontSize: 12.sp, fontWeight: kFW700, color: selectedTheme == "Lighttheme" ? kblack : Kwhite),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                      SizedBox(
                                                                        height:
                                                                            3.h,
                                                                      )
                                                                    ],
                                                                  )
                                                            : leavesController
                                                                            .leavesdata[index]
                                                                        [
                                                                        "leave_status"] ==
                                                                    2
                                                                ? leavesController
                                                                            .leavesdata[index]["LeaveReject"]
                                                                            .length ==
                                                                        0
                                                                    ? const SizedBox()
                                                                    : Column(
                                                                        children: [
                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  "Rejected By : ",
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(fontSize: 11.spMax, fontWeight: kFW600, color: Klightblack),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 8.h,
                                                                                ),
                                                                                Text(
                                                                                  leavesController.leavesdata[index]["LeaveReject"][0]["emp_name"],
                                                                                  maxLines: 2,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(fontSize: 12.sp, fontWeight: kFW700, color: selectedTheme == "Lighttheme" ? kblack : Kwhite),
                                                                                ),
                                                                              ]),
                                                                          SizedBox(
                                                                            height:
                                                                                5.h,
                                                                          )
                                                                        ],
                                                                      )
                                                                : leavesController.leavesdata[index]["leave_status"] == 3
                                                                    ? const SizedBox()
                                                                    : const SizedBox(),

                                                    // Row(
                                                    //     mainAxisAlignment:
                                                    //         MainAxisAlignment
                                                    //             .start,
                                                    //     crossAxisAlignment:
                                                    //         CrossAxisAlignment
                                                    //             .start,
                                                    //     children: [
                                                    //       Text(
                                                    //         "Type : ",
                                                    //         maxLines: 1,
                                                    //         overflow:
                                                    //             TextOverflow
                                                    //                 .ellipsis,
                                                    //         style: TextStyle(
                                                    //             fontSize:
                                                    //                 kTwelveFont,
                                                    //             fontWeight:
                                                    //                 kFW600,
                                                    //             color:
                                                    //                 Klightblack),
                                                    //       ),
                                                    //       SizedBox(
                                                    //         height: 8.h,
                                                    //       ),
                                                    //       SizedBox(
                                                    //         width: 250.w,
                                                    //         child: Text(
                                                    //           leavesController.leavesdata[index]
                                                    //                       [
                                                    //                       "leave_type"] ==
                                                    //                   ""
                                                    //               ? "Applied from Web"
                                                    //               : leavesController
                                                    //                       .leavesdata[index]
                                                    //                   [
                                                    //                   "leave_type"],
                                                    //           maxLines: 2,
                                                    //           overflow:
                                                    //               TextOverflow
                                                    //                   .ellipsis,
                                                    //           style: TextStyle(
                                                    //               fontSize:
                                                    //                   13.sp,
                                                    //               fontWeight:
                                                    //                   kFW700,
                                                    //               color: selectedTheme ==
                                                    //                       "Lighttheme"
                                                    //                   ? kblack
                                                    //                   : Kwhite),
                                                    //         ),
                                                    //       ),
                                                    //     ])
                                                    ReadMoreText(
                                                      "\u2022 ${leavesController.leavesdata[index]["reason"].toString().capitalizeFirst!}",

                                                      // trimLines: 1,
                                                      colorClickableText:
                                                          KOrange,
                                                      style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight: kFW700,
                                                          color: selectedTheme ==
                                                                  "Lighttheme"
                                                              ? kblack
                                                                  .withOpacity(
                                                                      0.7)
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
                                                    leavesController.leavesdata[
                                                                    index][
                                                                "leave_status"] ==
                                                            0
                                                        ? SizedBox(height: 10.h)
                                                        : SizedBox(),
                                                    leavesController.leavesdata[
                                                                    index][
                                                                "leave_status"] ==
                                                            0
                                                        ? Custom_OutlineButton(
                                                            height: 40,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            textColor: KRed,
                                                            fontSize: 12.sp,
                                                            fontWeight: kFW600,
                                                            label:
                                                                "Cancel Leave",
                                                            isLoading: false,
                                                            onTap: () {
                                                              showDialog(
                                                                  barrierDismissible:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          'Do you want to cancel Leave?',
                                                                          maxLines:
                                                                              2,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style: TextStyle(
                                                                              fontSize: 12.sp,
                                                                              fontWeight: kFW700,
                                                                              color: selectedTheme == "Lighttheme" ? KdarkText.withOpacity(0.7) : Kwhite)),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          child: Text(
                                                                              'No',
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(fontSize: 12.sp, fontWeight: kFW700, color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite)),
                                                                        ),
                                                                        TextButton(
                                                                          // textColor: Color(0xFF6200EE),
                                                                          onPressed:
                                                                              () async {
                                                                            Get.back();
                                                                            Get.back();
                                                                          },
                                                                          child: Text(
                                                                              'Yes',
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(fontSize: 12.sp, fontWeight: kFW700, color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite)),
                                                                        )
                                                                      ],
                                                                    );
                                                                  });
                                                            })
                                                        // TextButton(

                                                        //     child: Text(
                                                        //         "Cancel Leave",
                                                        //         maxLines:
                                                        //             1,
                                                        //         overflow:
                                                        //             TextOverflow
                                                        //                 .ellipsis,
                                                        //         style:
                                                        //             TextStyle(
                                                        //           fontSize:
                                                        //               kTwelveFont,
                                                        //           fontWeight:
                                                        //               kFW600,
                                                        //           color:
                                                        //               KRed,
                                                        //           //Klightblack
                                                        //         )))
                                                        : const SizedBox()
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                })
                        : Container(
                            margin: EdgeInsets.all(15.r),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15.h,
                                  width: 150.w,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Kwhite.withOpacity(0.5),
                                      ),
                                      height: 50.h,
                                      width: 250.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                          width: 80.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
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
                                          height: 10.h,
                                          width: 100.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                color: Kwhite.withOpacity(0.5),
                                              ),
                                              height: 50.h,
                                              width: 250.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 110.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                          width: 80.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
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
                                          height: 10.h,
                                          width: 100.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                color: Kwhite.withOpacity(0.5),
                                              ),
                                              height: 50.h,
                                              width: 250.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                SizedBox(
                                  height: 7.h,
                                  width: 250.w,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Kwhite.withOpacity(0.5),
                                      ),
                                      height: 50.h,
                                      width: 250.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 7.h,
                                  width: 250.w,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Kwhite.withOpacity(0.5),
                                      ),
                                      height: 50.h,
                                      width: 250.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                SizedBox(
                                  height: 15.h,
                                  width: 150.w,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Kwhite.withOpacity(0.5),
                                      ),
                                      height: 50.h,
                                      width: 250.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                          width: 80.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
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
                                          height: 10.h,
                                          width: 100.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                color: Kwhite.withOpacity(0.5),
                                              ),
                                              height: 50.h,
                                              width: 250.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 110.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                          width: 80.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
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
                                          height: 10.h,
                                          width: 100.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                color: Kwhite.withOpacity(0.5),
                                              ),
                                              height: 50.h,
                                              width: 250.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                SizedBox(
                                  height: 7.h,
                                  width: 250.w,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Kwhite.withOpacity(0.5),
                                      ),
                                      height: 50.h,
                                      width: 250.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 7.h,
                                  width: 250.w,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Kwhite.withOpacity(0.5),
                                      ),
                                      height: 50.h,
                                      width: 250.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35.h,
                                ),
                                SizedBox(
                                  height: 15.h,
                                  width: 150.w,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Kwhite.withOpacity(0.5),
                                      ),
                                      height: 50.h,
                                      width: 250.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                          width: 80.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
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
                                          height: 10.h,
                                          width: 100.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                color: Kwhite.withOpacity(0.5),
                                              ),
                                              height: 50.h,
                                              width: 250.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 110.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                          width: 80.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
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
                                          height: 10.h,
                                          width: 100.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                color: Kwhite.withOpacity(0.5),
                                              ),
                                              height: 50.h,
                                              width: 250.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                SizedBox(
                                  height: 7.h,
                                  width: 250.w,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Kwhite.withOpacity(0.5),
                                      ),
                                      height: 50.h,
                                      width: 250.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 7.h,
                                  width: 250.w,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Kwhite.withOpacity(0.5),
                                      ),
                                      height: 50.h,
                                      width: 250.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35.h,
                                ),
                                SizedBox(
                                  height: 15.h,
                                  width: 150.w,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Kwhite.withOpacity(0.5),
                                      ),
                                      height: 50.h,
                                      width: 250.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                          width: 80.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
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
                                          height: 10.h,
                                          width: 100.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                color: Kwhite.withOpacity(0.5),
                                              ),
                                              height: 50.h,
                                              width: 250.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 110.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                          width: 80.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
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
                                          height: 10.h,
                                          width: 100.w,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                color: Kwhite.withOpacity(0.5),
                                              ),
                                              height: 50.h,
                                              width: 250.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                SizedBox(
                                  height: 7.h,
                                  width: 250.w,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Kwhite.withOpacity(0.5),
                                      ),
                                      height: 50.h,
                                      width: 250.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 7.h,
                                  width: 250.w,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: Kwhite.withOpacity(0.5),
                                      ),
                                      height: 50.h,
                                      width: 250.w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                    //  const Center(
                    //     child: SpinKitFadingCircle(
                    //     color: KOrange,
                    //     size: 15,
                    //   ))
                  ),
                  SizedBox(height: 20.h)
                ],
              ),
            )));
  }
}
///////dont delete it
///
///
// Container(
//   alignment: Alignment.center,
//   color: Kbackground,
//   height: 60,
//   width: double.infinity,
//   margin: EdgeInsets.all(13.r),
//   child: ListView.builder(
//       itemCount: items.length,
//       scrollDirection: Axis.horizontal,
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   current = index;
//                 });
//               },
//               child: AnimatedContainer(
//                 margin: EdgeInsets.only(left: 10.w),
//                 padding: EdgeInsets.only(
//                     left: 20.w, right: 20.w, top: 5.h, bottom: 5.h),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(13.r),
//                     color: current == index ? KOrange : Kwhite,
//                     border: Border.all(
//                       color: current == index
//                           ? KOrange
//                           : Klightgray.withOpacity(0.5),
//                     )),
//                 duration: const Duration(milliseconds: 300),
//                 child: Text(
//                   items[index],
//                   style: TextStyle(
//                     fontSize: kTwelveFont,
//                     fontWeight: current == index ? kFW600 : kFW500,
//                     color: current == index ? Kwhite : Klightgray,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
// ),

///////////Leave Balance
class Leavebalances extends StatefulWidget {
  const Leavebalances({super.key});

  @override
  State<Leavebalances> createState() => _LeavebalancesState();
}

class _LeavebalancesState extends State<Leavebalances> {
  LeavesController leavesController = Get.find<LeavesController>();
  List leavebalances = [];
  List filteredleavebalances = [];
  List leavebalancesfilter = [];
  List leavebalancefilters = [];
  Iterable<List> balances = [];
  // int partsnumber = 3;
  bool isLoading = false;
  getLeavebalanceshandler() async {
    setState(() {
      isLoading = true;
    });
    var data = await Services.getLeavebalancelists();

    if (data == null) {
      // Fluttertoast.showToast(
      //   msg: data["message"],
      // );
    } else {
      leavebalances = data;
      filteredLeavebalanceshandlertwo(leavebalances);
      // filteredLeavebalanceshandler(leavebalances);
    }
    setState(() {
      isLoading = false;
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////
  filteredLeavebalanceshandlertwo(leavebalances) {
    List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(leavebalances);

    Map<dynamic, List<Map<String, dynamic>>> groupedLists =
        groupBy(dataList, 'period_from');
    // groupBy(dataList, 'id');

    groupedLists.forEach((key, value) {
      print('List with id $key: $value');
    });
  }

  Map<dynamic, List<Map<String, dynamic>>> groupBy(
      List<Map<String, dynamic>> data, String property) {
    Map<dynamic, List<Map<String, dynamic>>> result = {};

    for (Map<String, dynamic> item in data) {
      var key = item[property];

      if (!result.containsKey(key)) {
        result[key] = [item];
      } else {
        result[key]!.add(item);
      }
    }
    final lists = result.values.toList();
    leavebalancefilters = lists;
    print(
        "//////////////////////////////////////////-----------------------------------------------//////////////");
    print(leavebalancefilters);
    print(
        "//////////////////////////////////////////-----------------------------------------------//////////////");
//  print(result);
    return result;
  }

  ////////////////////////////////////////////////////////////////////////////////////////////

  /////////////////////////////////////////////////////////////////////////////////////////////////
//  List letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
// final letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
//   final chunks = letters.slices(2);

  @override
  void initState() {
    super.initState();
    getLeavebalanceshandler();
    // filteredLeavebalanceshandlertwo();
    // filterLeavebalanceshandler();
  }

  Future<void> _refreshData() async {
    setState(() {
      getLeavebalanceshandler();
      // getLeavebalanceshandler();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refreshData,
        child: isLoading == true
            ? SizedBox()
            // Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       SizedBox(
            //         height: 100.h,
            //       ),
            //       const SpinKitFadingCircle(
            //         color: KOrange,
            //         size: 15,
            //       )
            //     ],
            //   )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: leavebalancefilters.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      index == 0
                          ? const SizedBox()
                          : SizedBox(
                              height: 20.h,
                            ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15.w,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${DateFormat('dd-MMM-yyyy').format(DateTime.parse(leavebalancefilters[index][0]["period_from"]))} to ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(leavebalancefilters[index][0]["period_to"]))}",
                            style: TextStyle(
                              fontSize: kTwelveFont,
                              fontWeight: kFW700,
                              color: KCustomDarktwo,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: leavebalancefilters[index].length,
                            itemBuilder: (context, leaveindex) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: 12.w, top: 5.h, right: 12.w),
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  color: leavebalancefilters[index][leaveindex]
                                              ["leaves"]["leave_type_name"] ==
                                          "Sick Leave"
                                      ? KOrange.withOpacity(0.2)
                                      : leavebalancefilters[index][leaveindex]
                                                      ["leaves"]
                                                  ["leave_type_name"] ==
                                              "Annual Leave"
                                          ? KBlue.withOpacity(0.2)
                                          : leavebalancefilters[index]
                                                          [leaveindex]["leaves"]
                                                      ["leave_type_name"] ==
                                                  "Casual Leave"
                                              ? Klightgreen.withOpacity(0.2)
                                              : leavebalancefilters[index]
                                                                  [leaveindex]
                                                              ["leaves"]
                                                          ["leave_type_name"] ==
                                                      "Work From Home"
                                                  ? Kpink.withOpacity(0.1)
                                                  : Kwhite,
                                  //  selectedTheme == "Lighttheme"
                                  //     ? Kwhite
                                  //     : Kthemeblack,
                                  borderRadius: BorderRadius.circular(15.r),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     spreadRadius: 1.5,
                                  //     blurRadius: 3,
                                  //     offset: const Offset(0, 2),
                                  //     color: Ktextcolor.withOpacity(0.25),
                                  //   )
                                  // ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      leavebalancefilters[index][leaveindex]
                                              ["leaves"]["leave_type_name"] ??
                                          "no leave type",
                                      style: TextStyle(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW900,
                                        color: kblack.withOpacity(0.5),
                                      ),
                                    ),

                                    // Text(
                                    //   leavebalancefilters[index][leaveindex]
                                    //           ["leaves"]
                                    //       ["no_of_every_months_name"],
                                    //   style: TextStyle(
                                    //     fontSize: kTwelveFont,
                                    //     fontWeight: kFW500,
                                    //     color: KCustomDarktwo,
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   height: 2.h,
                                    // ),
                                    Text(
                                      "${leavebalancefilters[index][leaveindex]["leaves"]["applied"]["respdata"]["pending"].toString()} / ${leavebalancefilters[index][leaveindex]["leaves"]["leaves_count"].toString()} Days",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: kFW600,
                                        color: Klight,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      "Utilized:${leavebalancefilters[index][leaveindex]["leaves"]["applied"]["respdata"]["leaves_applied"].toString()}",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: kFW500,
                                        color: Klightblack,

                                        /// Color(0xFF7E91AE),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  );
                }));
  }
}
