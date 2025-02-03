// ignore_for_file: camel_case_types, unused_local_variable
import 'dart:convert';
import 'dart:io' as io;

//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../untils/export_file.dart';

class PaySlips_details extends StatefulWidget {
  const PaySlips_details({super.key});

  @override
  State<PaySlips_details> createState() => _PaySlips_detailsState();
}

class _PaySlips_detailsState extends State<PaySlips_details> {
  String fileurl = "https://fluttercampus.com/sample.pdf";
  DateTime? selectedDate;
  Map profile = {};
  var payslipdata = Get.arguments["payslip"];
  var ctcdata = Get.arguments["ctc"];
  bool clciked = Get.arguments["route"] == "payslip" ? true : false;
  ///////////////////////////download notification
  void sendDownloadNotification() async {
    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //         // displayOnForeground: true,
    //         // displayOnBackground: true,
    //         id: 11,
    //         channelKey: 'call_channel',
    //         /* same name */
    //         title: 'SMS Alert ',
    //         body: "PaySlip Downloaded" ?? ""),
    //     actionButtons: [
    //       NotificationActionButton(
    //           key: "open", label: "View", actionType: ActionType.SilentAction),
    //     ]);
    // AwesomeNotifications().setListeners(
    //   onActionReceivedMethod:
    //       DownloadNotificationController.onActionReceivedMethod,
    //   // onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
    //   // onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
    //   // onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    // );
    /////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////
//      AwesomeNotifications().setListeners(

// );

    // AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //   id: 1,
    //   channelKey: 'basic channel',
    //   actionType: ActionType.Default,
    //   title: 'Hello World',
    //   body: 'This is my first notification',
    //   icon: 'assets/images/accept.png', // Use the default app icon
    // ));
    // await AwesomeNotifications().createNotification(
    //   content: NotificationContent(
    //     id: 1,
    //     channelKey: 'basic_channel',
    //     title: 'Hello',
    //     body: 'This is an awesome notification!',
    //     icon: "assets/images/accept",

    //     bigPicture: "assets/images/accept", // Replace with your image path
    //     notificationLayout: NotificationLayout.BigPicture,
    //   ),
    //   // Set a valid small icon
    // );
  }
  ///////////////////////////////////////////////

  String getdecuctionPrices(List priceCal, String type) {
    num price = 0;
    for (int i = 0; i < priceCal.length; i++) {
      if (type == "D") {
        if (priceCal[i]["type"] == "Deductions") {
          price = price + priceCal[i]["amount"];
        }
      } else {
        if (priceCal[i]["type"] == "Earnings") {
          price = price + priceCal[i]["amount"];
        }
      }
    }

    return price.toString();
  }

  bool isLoading = false;
  downloadAPI() async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.downloadpayslipview(
        DateTime.parse("2024-05-01"), "Payslip");
    profile = await Services.employeeprofile();

    download(data);

    setState(() {
      isLoading = false;
    });
  }

  download(Map data) {
    getApplicationSupportDirectory().then((value) {});
  }

  getMonth(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
    }
  }

  var downloading = false.obs;
  final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
  late Map<String, dynamic> parsedData;
  @override
  Widget build(BuildContext context) {
    if (
        //payslipdata["PayrollProcess"]["emp_details"].isNotEmpty ||
        payslipdata["PayrollProcess"]["emp_details"] != null) {
      String jsonData = payslipdata["PayrollProcess"]["emp_details"];

      parsedData = jsonDecode(jsonData);
    }

    return Scaffold(
      bottomNavigationBar:
          // payslipdata["payslip_file_name"] == null
          //     ? const SizedBox()
          //     // payslipdata
          //     : clciked == false
          //         ? const SizedBox()
          //         :
          Obx(() => CustomButton(
                margin: EdgeInsets.all(10.r),
                borderRadius: BorderRadius.circular(20.r),
                Color: KOrange,
                height: 40.h,
                label: downloading.value == false
                    ? "Download Payslip"
                    : "Downloading...",
                textColor: Kwhite,
                fontWeight: kFW900,
                fontSize: 13.sp,
                isLoading: false,
                onTap: () async {
                  var dir = await DownloadsPathProvider.downloadsDirectory;
                  if (dir != null) {
                    String savename =
                        "${payslipdata["Employee"]["emp_code"]}_${getMonth(payslipdata["month"])}_${payslipdata["year"]}";
                    String savePath = "${dir.path}/(1)$savename.pdf";
                    print(savePath);
                    bool isExist = await io.File(savePath).exists();
                    int i = 0;
                    if (isExist) {
                      while (isExist) {
                        i = i + 1;
                        savePath = "${dir.path}/($i)$savename";
                        isExist = await io.File(savePath).exists();
                        io.File(savePath).existsSync();
                      }
                    }
                    try {
                      downloading(true);
                      await Dio().download(
                          "$KWebURL/welcome/payslip_download_post/${payslipdata["emp_id"]}/${payslipdata["payslip_id"]}/${payslipdata["payroll_process_id"]}/pdf",
                          savePath, onReceiveProgress: (received, total) {
                        if (total != -1) {
                          debugPrint(
                              "${(received / total * 100).toStringAsFixed(0)}%");
                        }
                      });
                      print("File is saved to download folder.");
                      downloading(false);
                      Fluttertoast.showToast(
                        msg: "Download Completed",
                      );
                      sendDownloadNotification();
                      // openFileManager();
                    } on DioError catch (e) {
                      print(e.message);
                      Fluttertoast.showToast(
                        msg: "Download Failed",
                      );
                    }
                    downloading(false);
                  }
//"$KWebURL/welcome/payslip_download_post/${payslipdata["emp_id"]}/${payslipdata["payslip_id"]}/${payslipdata["payroll_process_id"]}/pdf",

                  // Get.to(TimeSheetWebView(
                  //   url:
                  //       "$KSubDomainURL/welcome/payslip_download_post/${payslipdata["emp_id"]}/${payslipdata["payslip_id"]}/${payslipdata["payroll_process_id"]}",
                  //   name: "Payslip",
                  // ));
                  // downloadAPI();
                },
              )),
      backgroundColor:
          selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
      appBar: VibhoAppBar(
        bColor: selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
        //  Kbackground,
        title: 'Payslips',
        dontHaveBackAsLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(13.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                          padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     spreadRadius: 2,
                  //     blurRadius: 20,
                  //     offset: const Offset(0, 0),
                  //     color: Ktextcolor.withOpacity(0.08),
                  //   )
                  // ],
                  borderRadius: BorderRadius.circular(10.r),
                  color: Kwhite,
                ),
                child: Column(
                  children: [
                    ///Earing
                    payslipdata["PayrollProcessEarningsDeductions"].length > 0
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.r)),
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.r)),
                              color: selectedTheme == "Lighttheme"
                                  ? Kgreen.withOpacity(0.15)
                                  : Kgreen,
                              child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "Earnings",
                                          style: TextStyle(
                                            fontSize: kTwelveFont,
                                            fontWeight: kFW600,
                                            color: selectedTheme == "Lighttheme"
                                                ? Klightblack
                                                : Kwhite,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          UserSimplePreferences.getCurrency() ==
                                                  "INR"
                                              ? "${currencyFormat.format(double.parse(getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "E")))}"
                                              //  ? '₹ $pendingAmount'
                                              : UserSimplePreferences
                                                          .getCurrency() ==
                                                      "ZAR"
                                                  ? "R ${getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "E")}"
                                                  // ? 'R $pendingAmount'
                                                  : "${currencyFormat.format(double.parse(getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "E")))}",
                                          //   : pendingAmount.toString(),
                                          //  "₹ ${getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "E")}",
                                          style: TextStyle(
                                            fontSize: kFourteenFont,
                                            fontWeight: kFW900,
                                            color: KdarkText,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      const Divider(),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                          margin: EdgeInsets.all(8.r),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: payslipdata[
                                                      "PayrollProcessEarningsDeductions"]
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return payslipdata[
                                                                "PayrollProcessEarningsDeductions"]
                                                            [index]["type"] ==
                                                        "Earnings"
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            payslipdata["PayrollProcessEarningsDeductions"]
                                                                        [index][
                                                                    "EarningsAndDeduction"]
                                                                [
                                                                "earnings_and_deduction_name"],
                                                            style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  kFW600,
                                                              color: Klightgray,
                                                              letterSpacing:
                                                                  0.5,
                                                            ),
                                                          ),
                                                          Text(
                                                            currencyFormat.format(double.parse(
                                                                payslipdata["PayrollProcessEarningsDeductions"]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "amount"]
                                                                    .toString())),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  kTwelveFont,
                                                              fontWeight:
                                                                  kFW600,
                                                              color: Klightgray,
                                                              letterSpacing:
                                                                  0.5,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    : SizedBox();
                                              })),
                                    ],
                                  )),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 15.h,
                    ),
                    /////////////Deductions
                    payslipdata["PayrollProcessEarningsDeductions"].length > 0
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.r)),
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.r)),
                              color: selectedTheme == "Lighttheme"
                                  ? KRed.withOpacity(0.15)
                                  : KRed,
                              child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "Deductions",
                                          style: TextStyle(
                                            fontSize: kTwelveFont,
                                            fontWeight: kFW600,
                                            color: selectedTheme == "Lighttheme"
                                                ? Klightblack
                                                : Kwhite,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          UserSimplePreferences.getCurrency() ==
                                                  "INR"
                                              ? " ${currencyFormat.format(double.parse(getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "D")))}"
                                              //  ? '₹ $pendingAmount'
                                              : UserSimplePreferences
                                                          .getCurrency() ==
                                                      "ZAR"
                                                  ? "R ${getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "D")}"
                                                  : "${currencyFormat.format(double.parse(getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "D")))}",
                                          //'R $pendingAmount'
                                          //  : pendingAmount.toString(),
                                          //   "₹ ${getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "D")}",
                                          style: TextStyle(
                                            fontSize: kFourteenFont,
                                            fontWeight: kFW900,
                                            color: KdarkText,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      const Divider(),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                          margin: EdgeInsets.all(8.r),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: payslipdata[
                                                      "PayrollProcessEarningsDeductions"]
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return payslipdata[
                                                                "PayrollProcessEarningsDeductions"]
                                                            [index]["type"] ==
                                                        "Deductions"
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            payslipdata["PayrollProcessEarningsDeductions"]
                                                                        [index][
                                                                    "EarningsAndDeduction"]
                                                                [
                                                                "earnings_and_deduction_name"],
                                                            style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  kFW600,
                                                              color: Klightgray,
                                                              letterSpacing:
                                                                  0.5,
                                                            ),
                                                          ),
                                                          Text(
                                                            currencyFormat.format(double.parse(
                                                                payslipdata["PayrollProcessEarningsDeductions"]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "amount"]
                                                                    .toString())),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  kTwelveFont,
                                                              fontWeight:
                                                                  kFW600,
                                                              color: Klightgray,
                                                              letterSpacing:
                                                                  0.5,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    : SizedBox();
                                              })),
                                    ],
                                  )),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 15.h,
                    ),
                    payslipdata["PayrollProcess"]["ot_one_totl_amt"] > 0
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.r)),
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.r)),
                              color: KBrown.withOpacity(0.15),
                              child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "Over Time",
                                          style: TextStyle(
                                            fontSize: kTwelveFont,
                                            fontWeight: kFW600,
                                            color: Klightblack,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          UserSimplePreferences.getCurrency() ==
                                                  "INR"
                                              ? "${currencyFormat.format(double.parse(payslipdata["PayrollProcess"]["ot_one_totl_amt"].toString()))}"
                                              //  ? '₹ $pendingAmount'
                                              : UserSimplePreferences
                                                          .getCurrency() ==
                                                      "ZAR"
                                                  ? "R ${payslipdata["PayrollProcess"]["ot_one_totl_amt"]}"
                                                  : "${currencyFormat.format(double.parse(payslipdata["PayrollProcess"]["ot_one_totl_amt"]))}",
                                          //'R $pendingAmount'
                                          //  : pendingAmount.toString(),
                                          //   "₹ ${getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "D")}",
                                          style: TextStyle(
                                            fontSize: kFourteenFont,
                                            fontWeight: kFW900,
                                            color: KdarkText,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      const Divider(),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10.r),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                //                                              "totl_pay_amt": 48500,
                                                // "ot_one": 2,
                                                // "ot_one_hrs": 5,
                                                // "hourly_rate": 500,
                                                // "ot_one_totl_amt": 5000,
                                                Text(
                                                  "Total Days",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: kFW600,
                                                    color: Klightgray,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                                Text(
                                                  payslipdata["PayrollProcess"]
                                                          ["ot_one"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: kTwelveFont,
                                                    fontWeight: kFW600,
                                                    color: Klightgray,
                                                    letterSpacing: 0.5,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                //                                              "totl_pay_amt": 48500,
                                                // "ot_one": 2,
                                                // "ot_one_hrs": 5,
                                                // "hourly_rate": 500,
                                                // "ot_one_totl_amt": 5000,
                                                Text(
                                                  "OT Hours",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: kFW600,
                                                    color: Klightgray,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                                Text(
                                                  payslipdata["PayrollProcess"]
                                                          ["ot_one_hrs"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: kTwelveFont,
                                                    fontWeight: kFW600,
                                                    color: Klightgray,
                                                    letterSpacing: 0.5,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                //                                              "totl_pay_amt": 48500,
                                                // "ot_one": 2,
                                                // "ot_one_hrs": 5,
                                                // "hourly_rate": 500,
                                                // "ot_one_totl_amt": 5000,
                                                Text(
                                                  "Hourly Rate",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: kFW600,
                                                    color: Klightgray,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                                Text(
                                                  "₹ ${payslipdata["PayrollProcess"]["hourly_rate"].toString()}",
                                                  style: TextStyle(
                                                    fontSize: kTwelveFont,
                                                    fontWeight: kFW600,
                                                    color: Klightgray,
                                                    letterSpacing: 0.5,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                      // Container(
                                      //     margin: EdgeInsets.all(8.r),
                                      //     child: ListView.builder(
                                      //         shrinkWrap: true,
                                      //         physics:
                                      //             const NeverScrollableScrollPhysics(),
                                      //         itemCount: payslipdata[
                                      //                 "PayrollProcessEarningsDeductions"]
                                      //             .length,
                                      //         itemBuilder: (context, index) {
                                      //           return payslipdata[
                                      //                           "PayrollProcessEarningsDeductions"]
                                      //                       [index]["type"] ==
                                      //                   "Deductions"
                                      //               ?
                                      //               Row(
                                      //                   mainAxisAlignment:
                                      //                       MainAxisAlignment
                                      //                           .spaceBetween,
                                      //                   children: [
                                      //                     Text(
                                      //                       payslipdata["PayrollProcessEarningsDeductions"]
                                      //                                   [index][
                                      //                               "EarningsAndDeduction"]
                                      //                           [
                                      //                           "earnings_and_deduction_name"],
                                      //                       style: TextStyle(
                                      //                         fontSize: 11.sp,
                                      //                         fontWeight: kFW600,
                                      //                         color: Klightgray,
                                      //                         letterSpacing: 0.5,
                                      //                       ),
                                      //                     ),
                                      //                     Text(
                                      //                       payslipdata["PayrollProcessEarningsDeductions"]
                                      //                               [index]["amount"]
                                      //                           .toString(),
                                      //                       style: TextStyle(
                                      //                         fontSize: kTwelveFont,
                                      //                         fontWeight: kFW600,
                                      //                         color: Klightgray,
                                      //                         letterSpacing: 0.5,
                                      //                       ),
                                      //                     )
                                      //                   ],
                                      //                 )

                                      //               : SizedBox();
                                      //         })),
                                    ],
                                  )),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 15.h,
                    ),
                    ////Payslip for month
                    payslipdata["PayrollProcessEarningsDeductions"].length > 0
                        ? 
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.w,
                              right: 10.w,
                              bottom: 8.h,
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Net Pay : ",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: kFW600,
                                    color: Klightblack),
                              ),
                              
                              Text(
                                payslipdata["PayrollProcess"] != null
                                    ? payslipdata["PayrollProcess"]
                                                ["totl_pay_amt"] !=
                                            null
                                        ? currencyFormat.format(
                                            double.parse(payslipdata[
                                                        "PayrollProcess"]
                                                    ["totl_pay_amt"]
                                                .toString()))
                                        : "-"
                                    : "-",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
                              // Text(
                              //     payslipdata["PayrollProcess"] != null?
                              //   NumberToWordsEnglish.convert(payslipdata["PayrollProcess"]
                              //               ["totl_pay_amt"]
                              //           ):"-",
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              //   style: TextStyle(
                              //       fontSize: kTenFont,
                              //       fontWeight: kFW700,
                              //       color: Klightgray),
                              // ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          ),
                        )
                        : const SizedBox(),
                  ],
                ),
              ),

              // ///Earing
              // payslipdata["PayrollProcessEarningsDeductions"].length > 0
              //     ? Container(
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(13.r)),
              //         child: Card(
              //           elevation: 0,
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(13.r)),
              //           color: selectedTheme == "Lighttheme"
              //               ? Kgreen.withOpacity(0.15)
              //               : Kgreen,
              //           child: Theme(
              //               data: Theme.of(context)
              //                   .copyWith(dividerColor: Colors.transparent),
              //               child: ExpansionTile(
              //                 title: Column(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceAround,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     SizedBox(
              //                       height: 5.h,
              //                     ),
              //                     Text(
              //                       "Earnings",
              //                       style: TextStyle(
              //                         fontSize: kTwelveFont,
              //                         fontWeight: kFW600,
              //                         color: selectedTheme == "Lighttheme"
              //                             ? Klightblack
              //                             : Kwhite,
              //                         letterSpacing: 0.5,
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 5.h,
              //                     ),
              //                     Text(
              //                       UserSimplePreferences.getCurrency() == "INR"
              //                           ? "${currencyFormat.format(double.parse(getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "E")))}"
              //                           //  ? '₹ $pendingAmount'
              //                           : UserSimplePreferences.getCurrency() ==
              //                                   "ZAR"
              //                               ? "R ${getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "E")}"
              //                               // ? 'R $pendingAmount'
              //                               : "${currencyFormat.format(double.parse(getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "E")))}",
              //                       //   : pendingAmount.toString(),
              //                       //  "₹ ${getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "E")}",
              //                       style: TextStyle(
              //                         fontSize: kFourteenFont,
              //                         fontWeight: kFW900,
              //                         color: KdarkText,
              //                         letterSpacing: 0.5,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 children: [
              //                   SizedBox(
              //                     height: 5.h,
              //                   ),
              //                   const Divider(),
              //                   SizedBox(
              //                     height: 5.h,
              //                   ),
              //                   Container(
              //                       margin: EdgeInsets.all(8.r),
              //                       child: ListView.builder(
              //                           shrinkWrap: true,
              //                           physics:
              //                               const NeverScrollableScrollPhysics(),
              //                           itemCount: payslipdata[
              //                                   "PayrollProcessEarningsDeductions"]
              //                               .length,
              //                           itemBuilder: (context, index) {
              //                             return payslipdata[
              //                                             "PayrollProcessEarningsDeductions"]
              //                                         [index]["type"] ==
              //                                     "Earnings"
              //                                 ? Row(
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment
              //                                             .spaceBetween,
              //                                     children: [
              //                                       Text(
              //                                         payslipdata["PayrollProcessEarningsDeductions"]
              //                                                     [index][
              //                                                 "EarningsAndDeduction"]
              //                                             [
              //                                             "earnings_and_deduction_name"],
              //                                         style: TextStyle(
              //                                           fontSize: 11.sp,
              //                                           fontWeight: kFW600,
              //                                           color: Klightgray,
              //                                           letterSpacing: 0.5,
              //                                         ),
              //                                       ),
              //                                       Text(
              //                                         currencyFormat.format(
              //                                             double.parse(
              //                                                 payslipdata["PayrollProcessEarningsDeductions"]
              //                                                             [
              //                                                             index]
              //                                                         ["amount"]
              //                                                     .toString())),
              //                                         style: TextStyle(
              //                                           fontSize: kTwelveFont,
              //                                           fontWeight: kFW600,
              //                                           color: Klightgray,
              //                                           letterSpacing: 0.5,
              //                                         ),
              //                                       )
              //                                     ],
              //                                   )
              //                                 : SizedBox();
              //                           })),
              //                 ],
              //               )),
              //         ),
              //       )
              //     : const SizedBox(),
              // SizedBox(
              //   height: 15.h,
              // ),
              // /////////////Deductions
              // payslipdata["PayrollProcessEarningsDeductions"].length > 0
              //     ? Container(
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(13.r)),
              //         child: Card(
              //           elevation: 0,
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(13.r)),
              //           color: selectedTheme == "Lighttheme"
              //               ? KRed.withOpacity(0.15)
              //               : KRed,
              //           child: Theme(
              //               data: Theme.of(context)
              //                   .copyWith(dividerColor: Colors.transparent),
              //               child: ExpansionTile(
              //                 title: Column(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceAround,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     SizedBox(
              //                       height: 5.h,
              //                     ),
              //                     Text(
              //                       "Deductions",
              //                       style: TextStyle(
              //                         fontSize: kTwelveFont,
              //                         fontWeight: kFW600,
              //                         color: selectedTheme == "Lighttheme"
              //                             ? Klightblack
              //                             : Kwhite,
              //                         letterSpacing: 0.5,
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 5.h,
              //                     ),
              //                     Text(
              //                       UserSimplePreferences.getCurrency() == "INR"
              //                           ? " ${currencyFormat.format(double.parse(getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "D")))}"
              //                           //  ? '₹ $pendingAmount'
              //                           : UserSimplePreferences.getCurrency() ==
              //                                   "ZAR"
              //                               ? "R ${getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "D")}"
              //                               : "${currencyFormat.format(double.parse(getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "D")))}",
              //                       //'R $pendingAmount'
              //                       //  : pendingAmount.toString(),
              //                       //   "₹ ${getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "D")}",
              //                       style: TextStyle(
              //                         fontSize: kFourteenFont,
              //                         fontWeight: kFW900,
              //                         color: KdarkText,
              //                         letterSpacing: 0.5,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 children: [
              //                   SizedBox(
              //                     height: 5.h,
              //                   ),
              //                   const Divider(),
              //                   SizedBox(
              //                     height: 5.h,
              //                   ),
              //                   Container(
              //                       margin: EdgeInsets.all(8.r),
              //                       child: ListView.builder(
              //                           shrinkWrap: true,
              //                           physics:
              //                               const NeverScrollableScrollPhysics(),
              //                           itemCount: payslipdata[
              //                                   "PayrollProcessEarningsDeductions"]
              //                               .length,
              //                           itemBuilder: (context, index) {
              //                             return payslipdata[
              //                                             "PayrollProcessEarningsDeductions"]
              //                                         [index]["type"] ==
              //                                     "Deductions"
              //                                 ? Row(
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment
              //                                             .spaceBetween,
              //                                     children: [
              //                                       Text(
              //                                         payslipdata["PayrollProcessEarningsDeductions"]
              //                                                     [index][
              //                                                 "EarningsAndDeduction"]
              //                                             [
              //                                             "earnings_and_deduction_name"],
              //                                         style: TextStyle(
              //                                           fontSize: 11.sp,
              //                                           fontWeight: kFW600,
              //                                           color: Klightgray,
              //                                           letterSpacing: 0.5,
              //                                         ),
              //                                       ),
              //                                       Text(
              //                                         currencyFormat.format(
              //                                             double.parse(
              //                                                 payslipdata["PayrollProcessEarningsDeductions"]
              //                                                             [
              //                                                             index]
              //                                                         ["amount"]
              //                                                     .toString())),
              //                                         style: TextStyle(
              //                                           fontSize: kTwelveFont,
              //                                           fontWeight: kFW600,
              //                                           color: Klightgray,
              //                                           letterSpacing: 0.5,
              //                                         ),
              //                                       )
              //                                     ],
              //                                   )
              //                                 : SizedBox();
              //                           })),
              //                 ],
              //               )),
              //         ),
              //       )
              //     : const SizedBox(),
              // SizedBox(
              //   height: 15.h,
              // ),
              // payslipdata["PayrollProcess"]["ot_one_totl_amt"] > 0
              //     ? Container(
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(13.r)),
              //         child: Card(
              //           elevation: 0,
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(13.r)),
              //           color: KBrown.withOpacity(0.15),
              //           child: Theme(
              //               data: Theme.of(context)
              //                   .copyWith(dividerColor: Colors.transparent),
              //               child: ExpansionTile(
              //                 title: Column(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceAround,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     SizedBox(
              //                       height: 5.h,
              //                     ),
              //                     Text(
              //                       "Over Time",
              //                       style: TextStyle(
              //                         fontSize: kTwelveFont,
              //                         fontWeight: kFW600,
              //                         color: Klightblack,
              //                         letterSpacing: 0.5,
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 5.h,
              //                     ),
              //                     Text(
              //                       UserSimplePreferences.getCurrency() == "INR"
              //                           ? "${currencyFormat.format(double.parse(payslipdata["PayrollProcess"]["ot_one_totl_amt"].toString()))}"
              //                           //  ? '₹ $pendingAmount'
              //                           : UserSimplePreferences.getCurrency() ==
              //                                   "ZAR"
              //                               ? "R ${payslipdata["PayrollProcess"]["ot_one_totl_amt"]}"
              //                               : "${currencyFormat.format(double.parse(payslipdata["PayrollProcess"]["ot_one_totl_amt"]))}",
              //                       //'R $pendingAmount'
              //                       //  : pendingAmount.toString(),
              //                       //   "₹ ${getdecuctionPrices(payslipdata["PayrollProcessEarningsDeductions"], "D")}",
              //                       style: TextStyle(
              //                         fontSize: kFourteenFont,
              //                         fontWeight: kFW900,
              //                         color: KdarkText,
              //                         letterSpacing: 0.5,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 children: [
              //                   SizedBox(
              //                     height: 5.h,
              //                   ),
              //                   const Divider(),
              //                   SizedBox(
              //                     height: 5.h,
              //                   ),
              //                   Container(
              //                     margin: EdgeInsets.all(10.r),
              //                     child: Column(
              //                       children: [
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             //                                              "totl_pay_amt": 48500,
              //                             // "ot_one": 2,
              //                             // "ot_one_hrs": 5,
              //                             // "hourly_rate": 500,
              //                             // "ot_one_totl_amt": 5000,
              //                             Text(
              //                               "Total Days",
              //                               style: TextStyle(
              //                                 fontSize: 11.sp,
              //                                 fontWeight: kFW600,
              //                                 color: Klightgray,
              //                                 letterSpacing: 0.5,
              //                               ),
              //                             ),
              //                             Text(
              //                               payslipdata["PayrollProcess"]
              //                                       ["ot_one"]
              //                                   .toString(),
              //                               style: TextStyle(
              //                                 fontSize: kTwelveFont,
              //                                 fontWeight: kFW600,
              //                                 color: Klightgray,
              //                                 letterSpacing: 0.5,
              //                               ),
              //                             )
              //                           ],
              //                         ),
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             //                                              "totl_pay_amt": 48500,
              //                             // "ot_one": 2,
              //                             // "ot_one_hrs": 5,
              //                             // "hourly_rate": 500,
              //                             // "ot_one_totl_amt": 5000,
              //                             Text(
              //                               "OT Hours",
              //                               style: TextStyle(
              //                                 fontSize: 11.sp,
              //                                 fontWeight: kFW600,
              //                                 color: Klightgray,
              //                                 letterSpacing: 0.5,
              //                               ),
              //                             ),
              //                             Text(
              //                               payslipdata["PayrollProcess"]
              //                                       ["ot_one_hrs"]
              //                                   .toString(),
              //                               style: TextStyle(
              //                                 fontSize: kTwelveFont,
              //                                 fontWeight: kFW600,
              //                                 color: Klightgray,
              //                                 letterSpacing: 0.5,
              //                               ),
              //                             )
              //                           ],
              //                         ),
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             //                                              "totl_pay_amt": 48500,
              //                             // "ot_one": 2,
              //                             // "ot_one_hrs": 5,
              //                             // "hourly_rate": 500,
              //                             // "ot_one_totl_amt": 5000,
              //                             Text(
              //                               "Hourly Rate",
              //                               style: TextStyle(
              //                                 fontSize: 11.sp,
              //                                 fontWeight: kFW600,
              //                                 color: Klightgray,
              //                                 letterSpacing: 0.5,
              //                               ),
              //                             ),
              //                             Text(
              //                               "₹ ${payslipdata["PayrollProcess"]["hourly_rate"].toString()}",
              //                               style: TextStyle(
              //                                 fontSize: kTwelveFont,
              //                                 fontWeight: kFW600,
              //                                 color: Klightgray,
              //                                 letterSpacing: 0.5,
              //                               ),
              //                             )
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   )
              //                   // Container(
              //                   //     margin: EdgeInsets.all(8.r),
              //                   //     child: ListView.builder(
              //                   //         shrinkWrap: true,
              //                   //         physics:
              //                   //             const NeverScrollableScrollPhysics(),
              //                   //         itemCount: payslipdata[
              //                   //                 "PayrollProcessEarningsDeductions"]
              //                   //             .length,
              //                   //         itemBuilder: (context, index) {
              //                   //           return payslipdata[
              //                   //                           "PayrollProcessEarningsDeductions"]
              //                   //                       [index]["type"] ==
              //                   //                   "Deductions"
              //                   //               ?
              //                   //               Row(
              //                   //                   mainAxisAlignment:
              //                   //                       MainAxisAlignment
              //                   //                           .spaceBetween,
              //                   //                   children: [
              //                   //                     Text(
              //                   //                       payslipdata["PayrollProcessEarningsDeductions"]
              //                   //                                   [index][
              //                   //                               "EarningsAndDeduction"]
              //                   //                           [
              //                   //                           "earnings_and_deduction_name"],
              //                   //                       style: TextStyle(
              //                   //                         fontSize: 11.sp,
              //                   //                         fontWeight: kFW600,
              //                   //                         color: Klightgray,
              //                   //                         letterSpacing: 0.5,
              //                   //                       ),
              //                   //                     ),
              //                   //                     Text(
              //                   //                       payslipdata["PayrollProcessEarningsDeductions"]
              //                   //                               [index]["amount"]
              //                   //                           .toString(),
              //                   //                       style: TextStyle(
              //                   //                         fontSize: kTwelveFont,
              //                   //                         fontWeight: kFW600,
              //                   //                         color: Klightgray,
              //                   //                         letterSpacing: 0.5,
              //                   //                       ),
              //                   //                     )
              //                   //                   ],
              //                   //                 )

              //                   //               : SizedBox();
              //                   //         })),
              //                 ],
              //               )),
              //         ),
              //       )
              //     : const SizedBox(),
              // SizedBox(
              //   height: 15.h,
              // ),
              // ////Payslip for month
              // payslipdata["PayrollProcessEarningsDeductions"].length > 0
              //     ? Container(
              //         width: double.infinity,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10.r),
              //             color: selectedTheme == "Lighttheme"
              //                 ? Kwhite
              //                 : Kthemeblack),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             // Align(
              //             //   alignment: Alignment.topRight,
              //             //   child: ClipRRect(
              //             //     borderRadius: BorderRadius.only(
              //             //         topRight: Radius.circular(8.roundToDouble())),
              //             //     child: Image.asset(
              //             //       "assets/images/buble.png",
              //             //       width: 80.w,
              //             //     ),
              //             //   ),
              //             // ),
              //             Padding(
              //               padding: EdgeInsets.only(
              //                   left: 20.w, right: 10.w, bottom: 8.h,top: 10.h),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     "Net Pay",
              //                     maxLines: 2,
              //                     overflow: TextOverflow.ellipsis,
              //                     style: TextStyle(
              //                         fontSize: kTwelveFont,
              //                         fontWeight: kFW600,
              //                         color: Klightblack),
              //                   ),
              //                   SizedBox(
              //                     height: 5.h,
              //                   ),
              //                   Text(
              //                     payslipdata["PayrollProcess"] != null
              //                         ? payslipdata["PayrollProcess"]
              //                                     ["totl_pay_amt"] !=
              //                                 null
              //                             ? currencyFormat.format(double.parse(
              //                                 payslipdata["PayrollProcess"]
              //                                         ["totl_pay_amt"]
              //                                     .toString()))
              //                             : "-"
              //                         : "-",
              //                     maxLines: 1,
              //                     overflow: TextOverflow.ellipsis,
              //                     style: TextStyle(
              //                         fontSize: 15.sp,
              //                         fontWeight: kFW700,
              //                         color: selectedTheme == "Lighttheme"
              //                             ? KdarkText
              //                             : Kwhite),
              //                   ),
              //                   SizedBox(
              //                     height: 10.h,
              //                   ),
              //                   // Text(
              //                   //     payslipdata["PayrollProcess"] != null?
              //                   //   NumberToWordsEnglish.convert(payslipdata["PayrollProcess"]
              //                   //               ["totl_pay_amt"]
              //                   //           ):"-",
              //                   //   maxLines: 1,
              //                   //   overflow: TextOverflow.ellipsis,
              //                   //   style: TextStyle(
              //                   //       fontSize: kTenFont,
              //                   //       fontWeight: kFW700,
              //                   //       color: Klightgray),
              //                   // ),
              //                   SizedBox(
              //                     height: 5.h,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ))
              //     : const SizedBox(),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Employee Details",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: kFourteenFont,
                    fontWeight: kFW600,
                    color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite
                    // color:
                    //  KdarkText
                    ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                  padding: EdgeInsets.all(10.r),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color:
                          selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack
                      //   Kwhite
                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: kFW600,
                                    color: Klightblack),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                payslipdata["Employee"] != null
                                    ? "${payslipdata["Employee"]!["fname"]} ${payslipdata["Employee"]!["lname"]}"
                                    : "-",
                                // payslipdata["Employee"] != null
                                //     ? "${payslipdata["Employee"]!["lname"]}. ${payslipdata["Employee"]!["fname"]}"
                                //     : "-",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: kTwelveFont,
                                    fontWeight: kFW700,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite
                                    // KdarkText
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Employee Code",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: kFW600,
                                    color: Klightblack),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                payslipdata["Employee"] != null
                                    ? payslipdata["Employee"]!["emp_code"]
                                    : "-",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: kTwelveFont,
                                    fontWeight: kFW700,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite
                                    //  KdarkText
                                    ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Joining Date",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: kFW600,
                                color: Klightblack),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            payslipdata["Employee"] != null
                                ? DateFormat.yMMMd().format(DateTime.parse(
                                    payslipdata["Employee"]!["date_of_joining"]
                                        .toString()))
                                : "-",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: kTwelveFont,
                                fontWeight: kFW700,
                                color: selectedTheme == "Lighttheme"
                                    ? KdarkText
                                    : Kwhite
                                // KdarkText
                                ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "PF No",
                      //       maxLines: 2,
                      //       overflow: TextOverflow.ellipsis,
                      //       style: TextStyle(
                      //           fontSize: 11.sp,
                      //           fontWeight: kFW600,
                      //           color: Klightblack),
                      //     ),
                      //     SizedBox(
                      //       height: 5.h,
                      //     ),
                      //     Text(
                      //       "GR/GNT/1806702/000/00120121",
                      //       maxLines: 1,
                      //       overflow: TextOverflow.ellipsis,
                      //       style: TextStyle(
                      //           fontSize: kTwelveFont,
                      //           fontWeight: kFW700,
                      //           color: KdarkText),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Bank Name",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: kFW600,
                                color: Klightblack),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            payslipdata["Employee"] != null
                                ? payslipdata["Employee"]!["bank_name"]
                                : "-",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: kTwelveFont,
                                fontWeight: kFW700,
                                color: selectedTheme == "Lighttheme"
                                    ? KdarkText
                                    : Kwhite
                                // KdarkText
                                ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Account number",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: kFW600,
                                color: Klightblack),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            // payslipdata["PayrollProcess"]["emp_details"]
                            //             .isNotEmpty ||
                            payslipdata["PayrollProcess"]["emp_details"] != null
                                ? parsedData["account_number"].toString()
                                :
                                //  payslipdata["PayrollProcess"]["ot_one"].toString(),

                                payslipdata["Employee"] != null
                                    ? payslipdata["Employee"]!["account_number"]
                                        .toString()
                                    : "-",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: kTwelveFont,
                                fontWeight: kFW700,
                                color: selectedTheme == "Lighttheme"
                                    ? KdarkText
                                    : Kwhite
                                //  KdarkText
                                ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
  ////////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////
}

///////////////////////
// class DownloadNotificationController extends GetxController {
//   /// Use this method to detect when a new notification or a schedule is created
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     print("nee amm xcnlndlns ldn");
//     // Your code goes here
//   }

//   /// Use this method to detect every time that a new notification is displayed
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }

//   /// Use this method to detect if the user dismissed a notification
//   @pragma("vm:entry-point")
//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     // Your code goes here
//   }

//   /// Use this method to detect when the user taps on a notification or action button
//   @pragma("vm:entry-point")
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     print(receivedAction.actionType.toString());
//     if (receivedAction.actionType.toString() == "ActionType.SilentAction") {
//       openFileManager();
//       // var type = "in".obs;

//       // if (dashboardController.homedata!["checkin_checkout"]["check_in"]
//       //         ["status"] ==
//       //     true) {
//       //   type.value = "out";
//       // }
//       // ;

//       // Map payload = {"type": type.value, "work_from": "office"};

//       // Map value = await Services.checkin(payload);
//       // if (value["message"] != null) {
//       //   Fluttertoast.showToast(msg: value["message"]);
//       // } else {}

//       // print("jkhbhk scsk----------------------------------");
//     }
//     ////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     // if (receivedAction.actionType.toString() == "ActionType.SilentAction") {
//     //   // var payload = {
//     //   //   "leave_type_id": 4,
//     //   //   "leave_type": "Sick Leave",
//     //   //   "from_date": "2023-12-27",
//     //   //   "to_date": "2023-12-27",
//     //   //   "reason": "Suffering Fever"
//     //   // };

//     //   // Map value = await Services.createLeaveV2(payload);
//     //   // print(value);
//     //   Map payload = {"type": "out", "work_from": "office"};
//     //   //  {"type": type};

//     //   Map value = await Services.checkin(payload);
//     //   if (value["message"] != null) {
//     //     Fluttertoast.showToast(msg: value["message"]);
//     //   } else {}

//     //   // dashboardController.homedata!["checkin_checkout"]["check_out"]["status"] != true
//     //   //     ?dashboardController.homedata!["checkin_checkout"]["check_in"]["status"] == true

//     //   //        ? attendancesHandler("out", _verticalGroupValue)
//     //   //         : attendancesHandler("in", _verticalGroupValue)
//     //   //     : null;

//     //   print("jkhbhk scsk----------------------------------");
//     //   // if(receivedAction.id == 17897583){
//     //   //   // do something...
//     //   // }
//     // }
//     ///////////////////////////////////////////////////////////////////////////////////////////////

//     // {
//     //   print(
//     //       " Clicked on else...................................----------------------------------");
//     //   // var payload = {
//     //   //   "leave_type_id": 4,
//     //   //   "leave_type": "Sick Leave",
//     //   //   "from_date": "2023-12-27",
//     //   //   "to_date": "2023-12-27",
//     //   //   "reason": "Suffering Fever"
//     //   // };

//     //   // Map value = await Services.createLeaveV2(payload);
//     //   // print(value);
//     //   // createLeaveV2(payload)
//     // }

//     print("jkhbhk scsk----------------------------------");
//     // receivedAction.actionType.toString();
//     // Your code goes here

//     // Navigate into pages, avoiding to open the notification details page over another details page already opened
//     // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
//     //         (route) => (route.settings.name != '/notification-page') || route.isFirst,
//     //     arguments: receivedAction);
//   }
// }
