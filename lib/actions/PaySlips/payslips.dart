// ignore_for_file: camel_case_types, unused_local_variable

import 'dart:io' as io;

//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vibeshr/controllers/payslipController.dart';

import '../../untils/export_file.dart';

class PaySlips_view extends StatefulWidget {
  const PaySlips_view({super.key});

  @override
  State<PaySlips_view> createState() => _PaySlips_viewState();
}

class _PaySlips_viewState extends State<PaySlips_view> {
  var downloading = false.obs;
  bool isLoading = false;
  PayslipController payslipController = Get.find<PayslipController>();
  ////////////////////////
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }
  /////////////////////////

  Future<void> _refreshData() async {
    setState(() {
      payslipController.payslipListSAHandler(
          DateTime.now().subtract(const Duration(days: 30)));
    });
  }

  @override
  void initState() {
    payslipController.getData();
    super.initState();
  }

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

  // bool isLoading = false;
  Map profile = {};
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

  final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
  late Map<String, dynamic> parsedData;
  //////////////

  DateTime? selectedDate;
  final String CALENDERS = 'assets/images/calenders.svg';
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      appBar: VibhoAppBar(
        bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        title: 'Payslips',
        dontHaveBackAsLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: payslipController.isLoading.value == false
            ? SingleChildScrollView(
                child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      showMonthPicker(
                        backgroundColor: Kwhite,
                        selectedMonthBackgroundColor: KOrange.withOpacity(0.5),
                        roundedCornersRadius: 10,
                        headerColor: KOrange,
                        unselectedMonthTextColor: Ktextcolor,
                        context: context,
                        initialDate: DateTime.now(),
                        confirmWidget: Text(
                          "OK",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: KOrange.withOpacity(0.7),
                          ),
                        ),
                        cancelWidget: Text(
                          'Cancel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: KOrange.withOpacity(0.7),
                          ),
                        ),
                      ).then((date) {
                        if (date != null) {
                          if (date.isAfter(DateTime.now())) {
                            // date.isAfter(DateTime.now()
                            //  if(date.month>DateTime.now().month){
                            Fluttertoast.showToast(
                                msg: "Upcomming Months Can't be selected");
                          } else {
                            setState(() {
                              selectedDate = date;
                              if (selectedDate != null) {
                                // payslipController
                                //     .payslipListSAHandler(
                                //         selectedDate!);
                                // payslipController
                                //     .selectedMonth(selectedDate!);
                                // PayslipController.payslipListSAHandler(
                                //     selectedDate!);
                                print(selectedDate);
                              }
                            });
                          }
                        } else {
                          setState(() {
                            selectedDate = null;
                          });
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(13.r),
                      margin: EdgeInsets.all(13.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: selectedTheme == "Lighttheme"
                            ? Kwhite
                            : Kthemeblack,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 6),
                            color: Ktextcolor.withOpacity(0.2),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedDate != null
                                ? DateFormat.yMMM().format(selectedDate!)
                                //  ? DateFormat.yMMMEd().format(selectedDate!)
                                : "Select Month & Year",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KOrange.withOpacity(0.7),
                            ),
                          ),
                          SvgPicture.asset(CALENDERS,
                              semanticsLabel: 'Acme Logo'),
                        ],
                      ),
                    ),
                  ),
                  Obx(() => payslipController.isPayslipsloading.value == false
                      ? payslipController.payslipdatasa["rows"].isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              reverse: true,
                              itemCount: payslipController
                                  .payslipdatasa["rows"].length,
                              itemBuilder: (context, index) {
                                return selectedDate == null
                                    ? GestureDetector(
                                        onTap: () {
                                          Get.toNamed(KPayslips_Detail,
                                              arguments: {
                                                "payslip": payslipController
                                                        .payslipdatasa["rows"]
                                                    [index],
                                                "ctc": payslipController
                                                        .payslipdatasa["rows"]
                                                    [index],
                                                "route": "payslip"
                                              });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10.r),
                                          margin: EdgeInsets.all(13.r),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 10,
                                                offset: const Offset(0, 0),
                                                color:
                                                    Ktextcolor.withOpacity(0.2),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: Kwhite,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 150.w,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${DateFormat('MMMM').format(DateTime(0, payslipController.payslipdatasa["rows"][index]["month"]))}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  kTwelveFont,
                                                              fontWeight:
                                                                  kFW600,
                                                              color: kblack
                                                                  .withOpacity(
                                                                      0.7)),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "${payslipController.payslipdatasa["rows"][index]["year"]}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  kTwelveFont,
                                                              fontWeight:
                                                                  kFW600,
                                                              color: kblack
                                                                  .withOpacity(
                                                                      0.7)),
                                                        )
                                                      ],
                                                    ),
                                                    // Text(
                                                    //   "${payslipController.payslipdatasa["rows"][index]["Employee"]["fname"]} ${payslipController.payslipdatasa["rows"][index]["Employee"]["lname"]}",
                                                    //   //   "jhjbh kcsdkjbvkjsj nnb vjxkhbacadkbns KB JB ",
                                                    //   maxLines: 1,
                                                    //   overflow:
                                                    //       TextOverflow.ellipsis,
                                                    //   //  "${payslipController.payslipdatasa["rows"][index]["Employee"]["fname"]} ",
                                                    //   style: TextStyle(
                                                    //       fontSize: kTwelveFont,
                                                    //       fontWeight: kFW600,
                                                    //       color: Klightblack),
                                                    //   //         Text(
                                                    //   //   "hvjh khb nj lnsna c ",
                                                    //   //   // payslipController
                                                    //   //   //             .payslipdatasa[
                                                    //   //   //         "rows"][index]
                                                    //   //   //     ["Employee"]["lname"],
                                                    //   //   style: TextStyle(
                                                    //   //       fontSize: kTwelveFont,
                                                    //   //       fontWeight: kFW600,
                                                    //   //       color: Klightblack),
                                                    //   // )
                                                    // ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      payslipController.payslipdatasa["rows"]
                                                                      [index][
                                                                  "PayrollProcess"] !=
                                                              null
                                                          ? payslipController.payslipdatasa["rows"][index]
                                                                          ["PayrollProcess"][
                                                                      "totl_pay_amt"] !=
                                                                  null
                                                              ? currencyFormat.format(double.parse(payslipController
                                                                  .payslipdatasa["rows"]
                                                                      [index]
                                                                      ["PayrollProcess"]
                                                                      ["totl_pay_amt"]
                                                                  .toString()))
                                                              : "-"
                                                          : "-",
                                                      style: TextStyle(
                                                          fontSize: kTwelveFont,
                                                          fontWeight: kFW600,
                                                          color: kblack),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Obx(() => CustomButton(
                                                        height: 28.h,
                                                        width: 120.w,
                                                        textColor: Kwhite,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        Color: KOrange,
                                                        label: downloading
                                                                    .value ==
                                                                false
                                                            ? "Download"
                                                            : _selectedIndex ==
                                                                    index
                                                                ? "Downloading..."
                                                                : "Download",
                                                        fontSize: kTenFont,
                                                        fontWeight: kFW600,
                                                        isLoading: false,
                                                        onTap: () async {
                                                          _onSelected(index);
                                                          var dir =
                                                              await DownloadsPathProvider
                                                                  .downloadsDirectory;
                                                          if (dir != null) {
                                                            String savename =
                                                                "${payslipController.payslipdatasa["rows"][index]["Employee"]["emp_code"]}_${getMonth(payslipController.payslipdatasa["rows"][index]["month"])}_${payslipController.payslipdatasa["rows"][index]["year"]}";
                                                            String savePath =
                                                                "${dir.path}/(1)$savename.pdf";
                                                            print(savePath);
                                                            bool isExist =
                                                                await io.File(
                                                                        savePath)
                                                                    .exists();
                                                            int i = 0;
                                                            if (isExist) {
                                                              while (isExist) {
                                                                i = i + 1;
                                                                savePath =
                                                                    "${dir.path}/($i)$savename";
                                                                isExist = await io
                                                                        .File(
                                                                            savePath)
                                                                    .exists();
                                                                io.File(savePath)
                                                                    .existsSync();
                                                              }
                                                            }
                                                            try {
                                                              downloading(true);
                                                              await Dio().download(
                                                                  "$KWebURL/welcome/payslip_download_post/${payslipController.payslipdatasa["rows"][index]["emp_id"]}/${payslipController.payslipdatasa["rows"][index]["payslip_id"]}/${payslipController.payslipdatasa["rows"][index]["payroll_process_id"]}/pdf",
                                                                  savePath,
                                                                  onReceiveProgress:
                                                                      (received,
                                                                          total) {
                                                                if (total !=
                                                                    -1) {
                                                                  debugPrint(
                                                                      "${(received / total * 100).toStringAsFixed(0)}%");
                                                                }
                                                              });
                                                              print(
                                                                  "File is saved to download folder.");
                                                              downloading(
                                                                  false);
                                                              Fluttertoast
                                                                  .showToast(
                                                                msg:
                                                                    "Download Completed",
                                                              );

                                                              // openFileManager();
                                                            } on DioError catch (e) {
                                                              print(e.message);
                                                              Fluttertoast
                                                                  .showToast(
                                                                msg:
                                                                    "Download Failed",
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
//                                                           onTap: () async {
//                                                             var dir =
//                                                                 await DownloadsPathProvider
//                                                                     .downloadsDirectory;
//                                                             if (dir != null) {
//                                                               String savename =
//                                                                   "${payslipController.payslipdatasa["rows"][index]["Employee"]["emp_code"]}_${getMonth(payslipController.payslipdatasa["rows"][index]["month"])}_${payslipController.payslipdatasa["rows"][index]["year"]}";
//                                                               String savePath =
//                                                                   "${dir.path}/(1)$savename.pdf";
//                                                               print(savePath);
//                                                               bool isExist =
//                                                                   await io.File(
//                                                                           savePath)
//                                                                       .exists();
//                                                               int i = 0;
//                                                               if (isExist) {
//                                                                 while (
//                                                                     isExist) {
//                                                                   i = i + 1;
//                                                                   savePath =
//                                                                       "${dir.path}/($i)$savename";
//                                                                   isExist = await io
//                                                                           .File(
//                                                                               savePath)
//                                                                       .exists();
//                                                                   io.File(savePath)
//                                                                       .existsSync();
//                                                                 }
//                                                               }
//                                                               try {
//                                                                 downloading(
//                                                                     true);
//                                                                 await Dio().download(
//                                                                     "$KWebURL/welcome/payslip_download_post/${payslipController.payslipdatasa["rows"][index]["emp_id"]}/${payslipController.payslipdatasa["rows"][index]["payslip_id"]}/${payslipController.payslipdatasa["rows"][index]["payroll_process_id"]}/pdf",
//                                                                     savePath,
//                                                                     onReceiveProgress:
//                                                                         (received,
//                                                                             total) {
//                                                                   if (total !=
//                                                                       -1) {
//                                                                     debugPrint(
//                                                                         "${(received / total * 100).toStringAsFixed(0)}%");
//                                                                   }
//                                                                 });
//                                                                 print(
//                                                                     "File is saved to download folder.");
//                                                                 downloading(
//                                                                     false);
//                                                                 Fluttertoast
//                                                                     .showToast(
//                                                                   msg:
//                                                                       "Download Completed",
//                                                                 );
//                                                                 //   sendDownloadNotification();
//                                                                 // openFileManager();
//                                                               } on DioError catch (e) {
//                                                                 print(
//                                                                     e.message);
//                                                                 Fluttertoast
//                                                                     .showToast(
//                                                                   msg:
//                                                                       "File Not Saved",
//                                                                 );
//                                                               }
//                                                               downloading(
//                                                                   false);
//                                                             }
// //"$KWebURL/welcome/payslip_download_post/${payslipdata["emp_id"]}/${payslipdata["payslip_id"]}/${payslipdata["payroll_process_id"]}/pdf",

//                                                             // Get.to(TimeSheetWebView(
//                                                             //   url:
//                                                             //       "$KSubDomainURL/welcome/payslip_download_post/${payslipdata["emp_id"]}/${payslipdata["payslip_id"]}/${payslipdata["payroll_process_id"]}",
//                                                             //   name: "Payslip",
//                                                             // ));
//                                                             // downloadAPI();

//                                                             // Get.toNamed(
//                                                             //     KPayslips_Detail,
//                                                             //     arguments: {
//                                                             //       "payslip": payslipController
//                                                             //               .payslipdatasa[
//                                                             //           "rows"][index],
//                                                             //       "ctc": payslipController
//                                                             //               .payslipdatasa[
//                                                             //           "rows"][index],
//                                                             //       "route": "payslip"
//                                                             //     });
//                                                           }
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : selectedDate!.month ==
                                                payslipController
                                                        .payslipdatasa["rows"]
                                                    [index]["month"] &&
                                            selectedDate!.year ==
                                                payslipController
                                                        .payslipdatasa["rows"]
                                                    [index]["year"]
                                        ? GestureDetector(
                                            onTap: () {
                                              Get.toNamed(KPayslips_Detail,
                                                  arguments: {
                                                    "payslip": payslipController
                                                            .payslipdatasa[
                                                        "rows"][index],
                                                    "ctc": payslipController
                                                            .payslipdatasa[
                                                        "rows"][index],
                                                    "route": "payslip"
                                                  });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(10.r),
                                              margin: EdgeInsets.all(13.r),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    spreadRadius: 2,
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 0),
                                                    color:
                                                        Ktextcolor.withOpacity(
                                                            0.2),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: Kwhite,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 150.w,
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
                                                            Text(
                                                              "${DateFormat('MMMM').format(DateTime(0, payslipController.payslipdatasa["rows"][index]["month"]))}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      kTwelveFont,
                                                                  fontWeight:
                                                                      kFW600,
                                                                  color: kblack
                                                                      .withOpacity(
                                                                          0.7)),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "${payslipController.payslipdatasa["rows"][index]["year"]}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      kTwelveFont,
                                                                  fontWeight:
                                                                      kFW600,
                                                                  color: kblack
                                                                      .withOpacity(
                                                                          0.7)),
                                                            )
                                                          ],
                                                        ),
                                                        // Text(
                                                        //   "${payslipController.payslipdatasa["rows"][index]["Employee"]["fname"]} ${payslipController.payslipdatasa["rows"][index]["Employee"]["lname"]}",
                                                        //   //   "jhjbh kcsdkjbvkjsj nnb vjxkhbacadkbns KB JB ",
                                                        //   maxLines: 1,
                                                        //   overflow:
                                                        //       TextOverflow.ellipsis,
                                                        //   //  "${payslipController.payslipdatasa["rows"][index]["Employee"]["fname"]} ",
                                                        //   style: TextStyle(
                                                        //       fontSize: kTwelveFont,
                                                        //       fontWeight: kFW600,
                                                        //       color: Klightblack),
                                                        //   //         Text(
                                                        //   //   "hvjh khb nj lnsna c ",
                                                        //   //   // payslipController
                                                        //   //   //             .payslipdatasa[
                                                        //   //   //         "rows"][index]
                                                        //   //   //     ["Employee"]["lname"],
                                                        //   //   style: TextStyle(
                                                        //   //       fontSize: kTwelveFont,
                                                        //   //       fontWeight: kFW600,
                                                        //   //       color: Klightblack),
                                                        //   // )
                                                        // ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Text(
                                                          payslipController.payslipdatasa["rows"]
                                                                          [index][
                                                                      "PayrollProcess"] !=
                                                                  null
                                                              ? payslipController.payslipdatasa["rows"][index]["PayrollProcess"]
                                                                          [
                                                                          "totl_pay_amt"] !=
                                                                      null
                                                                  ? currencyFormat.format(double.parse(payslipController
                                                                      .payslipdatasa["rows"]
                                                                          [index]
                                                                          ["PayrollProcess"]
                                                                          ["totl_pay_amt"]
                                                                      .toString()))
                                                                  : "-"
                                                              : "-",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  kTwelveFont,
                                                              fontWeight:
                                                                  kFW600,
                                                              color: kblack),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Obx(() => CustomButton(
                                                            height: 28.h,
                                                            width: 120.w,
                                                            textColor: Kwhite,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r),
                                                            Color: KOrange,
                                                            label: downloading
                                                                        .value ==
                                                                    false
                                                                ? "Download"
                                                                : _selectedIndex ==
                                                                        index
                                                                    ? "Downloading..."
                                                                    : "Download",
                                                            fontSize: kTenFont,
                                                            fontWeight: kFW600,
                                                            isLoading: false,
                                                            onTap: () async {
                                                              _onSelected(
                                                                  index);
                                                              var dir =
                                                                  await DownloadsPathProvider
                                                                      .downloadsDirectory;
                                                              if (dir != null) {
                                                                String
                                                                    savename =
                                                                    "${payslipController.payslipdatasa["rows"][index]["Employee"]["emp_code"]}_${getMonth(payslipController.payslipdatasa["rows"][index]["month"])}_${payslipController.payslipdatasa["rows"][index]["year"]}";
                                                                String
                                                                    savePath =
                                                                    "${dir.path}/(1)$savename.pdf";
                                                                print(savePath);
                                                                bool isExist =
                                                                    await io.File(
                                                                            savePath)
                                                                        .exists();
                                                                int i = 0;
                                                                if (isExist) {
                                                                  while (
                                                                      isExist) {
                                                                    i = i + 1;
                                                                    savePath =
                                                                        "${dir.path}/($i)$savename";
                                                                    isExist = await io.File(
                                                                            savePath)
                                                                        .exists();
                                                                    io.File(savePath)
                                                                        .existsSync();
                                                                  }
                                                                }
                                                                try {
                                                                  downloading(
                                                                      true);
                                                                  await Dio().download(
                                                                      "$KWebURL/welcome/payslip_download_post/${payslipController.payslipdatasa["rows"][index]["emp_id"]}/${payslipController.payslipdatasa["rows"][index]["payslip_id"]}/${payslipController.payslipdatasa["rows"][index]["payroll_process_id"]}/pdf",
                                                                      savePath,
                                                                      onReceiveProgress:
                                                                          (received,
                                                                              total) {
                                                                    if (total !=
                                                                        -1) {
                                                                      debugPrint(
                                                                          "${(received / total * 100).toStringAsFixed(0)}%");
                                                                    }
                                                                  });
                                                                  print(
                                                                      "File is saved to download folder.");
                                                                  downloading(
                                                                      false);
                                                                  Fluttertoast
                                                                      .showToast(
                                                                    msg:
                                                                        "Download Completed",
                                                                  );

                                                                  // openFileManager();
                                                                } on DioError catch (e) {
                                                                  print(e
                                                                      .message);
                                                                  Fluttertoast
                                                                      .showToast(
                                                                    msg:
                                                                        "Download Failed",
                                                                  );
                                                                }
                                                                downloading(
                                                                    false);
                                                              }
//"$KWebURL/welcome/payslip_download_post/${payslipdata["emp_id"]}/${payslipdata["payslip_id"]}/${payslipdata["payroll_process_id"]}/pdf",

                                                              // Get.to(TimeSheetWebView(
                                                              //   url:
                                                              //       "$KSubDomainURL/welcome/payslip_download_post/${payslipdata["emp_id"]}/${payslipdata["payslip_id"]}/${payslipdata["payroll_process_id"]}",
                                                              //   name: "Payslip",
                                                              // ));
                                                              // downloadAPI();
                                                            },
//                                                           onTap: () async {
//                                                             var dir =
//                                                                 await DownloadsPathProvider
//                                                                     .downloadsDirectory;
//                                                             if (dir != null) {
//                                                               String savename =
//                                                                   "${payslipController.payslipdatasa["rows"][index]["Employee"]["emp_code"]}_${getMonth(payslipController.payslipdatasa["rows"][index]["month"])}_${payslipController.payslipdatasa["rows"][index]["year"]}";
//                                                               String savePath =
//                                                                   "${dir.path}/(1)$savename.pdf";
//                                                               print(savePath);
//                                                               bool isExist =
//                                                                   await io.File(
//                                                                           savePath)
//                                                                       .exists();
//                                                               int i = 0;
//                                                               if (isExist) {
//                                                                 while (
//                                                                     isExist) {
//                                                                   i = i + 1;
//                                                                   savePath =
//                                                                       "${dir.path}/($i)$savename";
//                                                                   isExist = await io
//                                                                           .File(
//                                                                               savePath)
//                                                                       .exists();
//                                                                   io.File(savePath)
//                                                                       .existsSync();
//                                                                 }
//                                                               }
//                                                               try {
//                                                                 downloading(
//                                                                     true);
//                                                                 await Dio().download(
//                                                                     "$KWebURL/welcome/payslip_download_post/${payslipController.payslipdatasa["rows"][index]["emp_id"]}/${payslipController.payslipdatasa["rows"][index]["payslip_id"]}/${payslipController.payslipdatasa["rows"][index]["payroll_process_id"]}/pdf",
//                                                                     savePath,
//                                                                     onReceiveProgress:
//                                                                         (received,
//                                                                             total) {
//                                                                   if (total !=
//                                                                       -1) {
//                                                                     debugPrint(
//                                                                         "${(received / total * 100).toStringAsFixed(0)}%");
//                                                                   }
//                                                                 });
//                                                                 print(
//                                                                     "File is saved to download folder.");
//                                                                 downloading(
//                                                                     false);
//                                                                 Fluttertoast
//                                                                     .showToast(
//                                                                   msg:
//                                                                       "Download Completed",
//                                                                 );
//                                                                 //   sendDownloadNotification();
//                                                                 // openFileManager();
//                                                               } on DioError catch (e) {
//                                                                 print(
//                                                                     e.message);
//                                                                 Fluttertoast
//                                                                     .showToast(
//                                                                   msg:
//                                                                       "File Not Saved",
//                                                                 );
//                                                               }
//                                                               downloading(
//                                                                   false);
//                                                             }
// //"$KWebURL/welcome/payslip_download_post/${payslipdata["emp_id"]}/${payslipdata["payslip_id"]}/${payslipdata["payroll_process_id"]}/pdf",

//                                                             // Get.to(TimeSheetWebView(
//                                                             //   url:
//                                                             //       "$KSubDomainURL/welcome/payslip_download_post/${payslipdata["emp_id"]}/${payslipdata["payslip_id"]}/${payslipdata["payroll_process_id"]}",
//                                                             //   name: "Payslip",
//                                                             // ));
//                                                             // downloadAPI();

//                                                             // Get.toNamed(
//                                                             //     KPayslips_Detail,
//                                                             //     arguments: {
//                                                             //       "payslip": payslipController
//                                                             //               .payslipdatasa[
//                                                             //           "rows"][index],
//                                                             //       "ctc": payslipController
//                                                             //               .payslipdatasa[
//                                                             //           "rows"][index],
//                                                             //       "route": "payslip"
//                                                             //     });
//                                                           }
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : const SizedBox();
                              })
                          : Center(
                              child: Column(
                              children: [
                                SvgPicture.asset("assets/images/oopsNoData.svg",
                                    // color: KOrange,
                                    fit: BoxFit.fill,
                                    semanticsLabel: 'No Data'),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  "Oops! No Data Found",
                                  style: TextStyle(
                                      fontWeight: kFW700,
                                      fontSize: kTwentyFont),
                                )
                              ],
                            ))
                      : Column(
                          children: [
                            SizedBox(
                              height: 100.h,
                            ),
                            const Center(
                                child: SpinKitFadingCircle(
                              color: KOrange,
                              size: 15,
                            )),
                          ],
                        )),
                ],
              ))
            : Column(
                children: [
                  SizedBox(
                    height: 100.h,
                  ),
                  const Center(
                      child: SpinKitFadingCircle(
                    color: KOrange,
                    size: 15,
                  )),
                ],
              ),
      ),

      //  Column(
      //   children: [
      //     Container(
      //       padding: EdgeInsets.all(13.r),
      //       margin: EdgeInsets.all(13.r),
      //       decoration: BoxDecoration(
      // boxShadow: [
      //   BoxShadow(
      //     spreadRadius: 2,
      //     blurRadius: 10,
      //     offset: Offset(0, 6),
      //     color: Ktextcolor.withOpacity(0.2),
      //   )
      // ],
      //         borderRadius: BorderRadius.circular(10.r),
      //         color: Kwhite,
      //       ),
      //       child: Row(
      //         // mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text(
      //             "Select Month & Year",
      //             style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //               color: KOrange.withOpacity(0.7),
      //             ),
      //           ),

      //           // Container(
      //           //   alignment: Alignment.center,
      //           //   height: 40,
      //           //   width: 260.w,
      //           //   margin: EdgeInsets.all(13.r),
      //           //   decoration: BoxDecoration(
      //           //     borderRadius: BorderRadius.circular(13.r),
      //           //     color: Kbackground,
      //           //   ),
      //           //   child: ListView.builder(
      //           //       itemCount: items.length,
      //           //       scrollDirection: Axis.horizontal,
      //           //       shrinkWrap: true,
      //           //       itemBuilder: (context, index) {
      //           //         return Column(
      //           //           mainAxisAlignment: MainAxisAlignment.center,
      //           //           children: [
      //           //             GestureDetector(
      //           //               onTap: () {
      //           //                 setState(() {
      //           //                   current = index;
      //           //                 });
      //           //               },
      //           //               child: AnimatedContainer(
      //           //                 margin: EdgeInsets.only(left: 10.w),
      //           //                 padding: EdgeInsets.only(
      //           //                     left: 10.w,
      //           //                     right: 12.w,
      //           //                     top: 5.h,
      //           //                     bottom: 5.h),
      //           //                 duration: const Duration(milliseconds: 300),
      //           //                 child: Text(
      //           //                   items[index],
      //           //                   style: TextStyle(
      //           //                     fontSize: current == index
      //           //                         ? kFourteenFont
      //           //                         : kTwelveFont,
      //           //                     fontWeight:
      //           //                         current == index ? kFW900 : kFW500,
      //           //                     color:
      //           //                         current == index ? KOrange : Klightgray,
      //           //                   ),
      //           //                 ),
      //           //               ),
      //           //             ),
      //           //           ],
      //           //         );
      //           //       }),
      //           // ),
      //           GestureDetector(
      //             onTap: () async {
      //               showMonthPicker(
      //                 backgroundColor: Kwhite,
      //                 selectedMonthBackgroundColor: KOrange.withOpacity(0.5),
      //                 roundedCornersRadius: 10,
      //                 headerColor: KOrange,
      //                 unselectedMonthTextColor: Ktextcolor,
      //                 context: context,
      //                 initialDate: DateTime.now(),
      //                 confirmWidget: Text(
      //                   "OK",
      //                   style: TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     color: KOrange.withOpacity(0.7),
      //                   ),
      //                 ),
      //                 cancelWidget: Text(
      //                   'Cancel',
      //                   style: TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     color: KOrange.withOpacity(0.7),
      //                   ),
      //                 ),
      //               ).then((date) {
      //                 if (date != null) {
      //                   //////////////////////////////////////
      //                   if (date.isAfter(DateTime.now()
      //                       .subtract(const Duration(days: 30)))) {
      //                     Fluttertoast.showToast(
      //                         msg: "Upcomming Months can't be selected");
      //                   } else {
      //                     setState(() {
      //                       selectedDate = date;
      //                       if (selectedDate != null) {
      //                         // payslipListSAHandler(selectedDate!);
      //                         payslipListHandler(selectedDate!);
      //                       }
      //                     });
      //                   }
      //                   /////////////////////////////
      //                 }
      //               });
      //               ////////////////////////////
      //               //  if (date.month > DateTime.now().month) {
      //               //       Fluttertoast.showToast(
      //               //           msg: "Upcomming Months can't be selected");
      //               //     }
      //               //     if (date.year > DateTime.now().year) {
      //               //       Fluttertoast.showToast(
      //               //           msg: "Upcomming Years can't be selected");
      //               //     }
      //               //      else {
      //               //       setState(() {
      //               //         _controller.selectedDate = date;
      //               //         _controller.displayDate = date;
      //               //         selectedDate = date;
      //               //         getCalenderInfo(date);
      //               //       });
      //               //     }
      //               //////////////////////
      //             },
      //             child: Image.asset(
      //               "assets/images/Group.png",
      //               width: 23.w,
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //     payslipdata["payslip_file_path"] != ""
      //         //payslipdata["payslip_file_path"] == ""
      //         //  payslipdata.isEmpty
      //         ? Column(
      //             children: [
      //               ////Payslip for month
      //               isLoading == false
      //                   ? payslipdata.isNotEmpty
      // ? Container(
      //     margin: EdgeInsets.all(13.r),
      //     width: double.infinity,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(10.r),
      //       color: Kwhite,
      //     ),
      //     child: Column(
      //                             children: [
      //                               Align(
      //                                 alignment: Alignment.topRight,
      //                                 child: ClipRRect(
      //                                   borderRadius: BorderRadius.only(
      //                                       topRight: Radius.circular(
      //                                           8.roundToDouble())),
      //                                   child: Image.asset(
      //                                     "assets/images/buble.png",
      //                                     width: 80.w,
      //                                   ),
      //                                 ),
      //                               ),
      //                               Padding(
      //                                 padding: EdgeInsets.only(
      //                                     left: 20.w, right: 10.w, bottom: 8.h),
      //                                 child: Column(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.start,
      //                                   crossAxisAlignment:
      //                                       CrossAxisAlignment.start,
      //                                   children: [
      //                                     Text(
      //                                       "Payslip",
      //                                       maxLines: 2,
      //                                       overflow: TextOverflow.ellipsis,
      // style: TextStyle(
      //     fontSize: kTwelveFont,
      //     fontWeight: kFW600,
      //     color: Klightblack),
      //                                     ),
      //                                     SizedBox(
      //                                       height: 8.h,
      //                                     ),
      //                                     Text(
      //                                       "Payslip Available for ${DateFormat('yyyy-MMM').format(selectedDate!)}",
      //                                       maxLines: 1,
      //                                       overflow: TextOverflow.ellipsis,
      //                                       style: TextStyle(
      //                                           fontSize: 12.sp,
      //                                           fontWeight: kFW700,
      //                                           color: KdarkText),
      //                                     ),
      //                                     SizedBox(
      //                                       height: 20.h,
      //                                     ),
      //                                     Row(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment.end,
      //                                       children: [
      //                                         payslipdata["payslip_file_path"] !=
      //                                                 ""
      //                                             // payslipdata["PayrollProcess"] !=
      //                                             //         null
      // ? Custom_OutlineButton(
      //     height: 28.h,
      //     width: 120.w,
      //     textColor: KOrange,
      //     borderRadius:
      //         BorderRadius.circular(
      //             8.r),
      //     Color: KOrange,
      //     label: "View More",
      //     fontSize: kTenFont,
      //     fontWeight: kFW600,
      //     isLoading: false,
      //     onTap: () {
      //       Get.toNamed(
      //           KPayslips_Detail,
      //           arguments: {
      //             "payslip":
      //                 payslipdata,
      //             "ctc": ctcdata,
      //             "route": "payslip"
      //           });
      //     })
      //                                             : SizedBox(),
      //                                         SizedBox(
      //                                           width: 10.w,
      //                                         ),
      //                                         // payslipdata["payslip_file_path"] !=
      //                                         //         ""
      //                                         //     // payslipdata["PayrollProcess"] !=
      //                                         //     //         null
      //                                         //     ? CustomButton(
      //                                         //         height: 28.h,
      //                                         //         width: 120.w,
      //                                         //         textColor: Kwhite,
      //                                         //         borderRadius:
      //                                         //             BorderRadius.circular(
      //                                         //                 8.r),
      //                                         //         Color: KOrange,
      //                                         //         fontSize: kTenFont,
      //                                         //         fontWeight: kFW600,
      //                                         //         label: "Download",
      //                                         //         isLoading: false,
      //                                         //         onTap: () async {
      //                                         //           // Map<Permission,
      //                                         //           //         PermissionStatus>
      //                                         //           //     statuses = await [
      //                                         //           //   Permission.storage,
      //                                         //           //   //add more permission to request here.
      //                                         //           // ].request();

      //                                         //           // if (statuses[Permission
      //                                         //           //         .storage]!
      //                                         //           //     .isGranted) {
      //                                         //           var dir =
      //                                         //               await DownloadsPathProvider
      //                                         //                   .downloadsDirectory;
      //                                         //           if (dir != null) {
      //                                         //             String savename =
      //                                         //                 "file.pdf";
      //                                         //             String savePath =
      //                                         //                 dir.path +
      //                                         //                     "/$savename";
      //                                         //             print(savePath);
      //                                         //             //output:  /storage/emulated/0/Download/banner.png

      //                                         //             try {
      //                                         //               await Dio().download(
      //                                         //                   "$KSubDomainURL/assets/payslips/${payslipdata['payslip_file_path']}",
      //                                         //                   savePath,
      //                                         //                   onReceiveProgress:
      //                                         //                       (received,
      //                                         //                           total) {
      //                                         //                 if (total != -1) {
      //                                         //                   print((received /
      //                                         //                               total *
      //                                         //                               100)
      //                                         //                           .toStringAsFixed(
      //                                         //                               0) +
      //                                         //                       "%");
      //                                         //                   //you can build progressbar feature too
      //                                         //                 }
      //                                         //               });
      //                                         //               print(
      //                                         //                   "File is saved to download folder.");
      //                                         //             } on DioError catch (e) {
      //                                         //               print(e.message);
      //                                         //             }
      //                                         //           }
      //                                         //           // } else {
      //                                         //           //   print(
      //                                         //           //       "No permission to read and write.");
      //                                         //           // }
      //                                         //           // Get.to(TimeSheetWebView(
      //                                         //           //     url:
      //                                         //           //         "$KSubDomainURL/assets/payslips/${payslipdata['payslip_file_path']}",
      //                                         //           //     // "$KSubDomainURL/welcome/payslip_download_post/${profile["emp_id"]}/${payslipdata["payslip_id"]}/${payslipdata["payroll_process_id"]}",
      //                                         //           //     name:
      //                                         //           //         "Payslip - ${payslipdata["month"]} - ${payslipdata["year"]}"
      //                                         //           //     // name:
      //                                         //           //     //     "Payslip",
      //                                         //           //     ));
      //                                         //           // //Get.toNamed(KPayslips_Detail);
      //                                         //         })
      //                                         //     : SizedBox(),
      //                                         // SizedBox(
      //                                         //   width: 10.w,
      //                                         // ),
      //                                         payslipdata["payslip_file_name"] ==
      //                                                 null
      //                                             ? SizedBox()
      //                                             : payslipdata[
      //                                                         "payslip_file_path"] !=
      //                                                     ""
      //                                                 // payslipdata["PayrollProcess"] !=
      //                                                 //         null
      //                                                 ? CustomButton(
      //                                                     height: 28.h,
      //                                                     width: 120.w,
      //                                                     textColor: Kwhite,
      //                                                     borderRadius:
      //                                                         BorderRadius
      //                                                             .circular(
      //                                                                 8.r),
      //                                                     Color: KOrange,
      //                                                     fontSize: kTenFont,
      //                                                     fontWeight: kFW600,
      //                                                     label: "Download",
      //                                                     isLoading: false,
      //                                                     onTap: () async {
      //                                                       var dir =
      //                                                           await DownloadsPathProvider
      //                                                               .downloadsDirectory;
      //                                                       if (dir != null) {
      //                                                         String savename =
      //                                                             payslipdata[
      //                                                                 "payslip_file_name"];
      //                                                         // String savePath = dir.path + "/$savename";

      //                                                         // String savename = "${widget.name}.pdf";
      //                                                         String savePath =
      //                                                             "${dir.path}/(1)$savename";
      //                                                         print(savePath);
      //                                                         bool isExist =
      //                                                             await io.File(
      //                                                                     savePath)
      //                                                                 .exists();
      //                                                         int i = 0;
      //                                                         if (isExist) {
      //                                                           while (
      //                                                               isExist) {
      //                                                             i = i + 1;
      //                                                             savePath =
      //                                                                 "${dir.path}/($i)$savename";
      //                                                             isExist = await io
      //                                                                     .File(
      //                                                                         savePath)
      //                                                                 .exists();
      //                                                             io.File(savePath)
      //                                                                 .existsSync();
      //                                                           }
      //                                                         }

      //                                                         try {
      //                                                           downloading(
      //                                                               true);
      //                                                           await Dio().download(
      //                                                               "$KWebURL/assets/payslips/${payslipdata['payslip_file_path']}",
      //                                                               savePath,
      //                                                               onReceiveProgress:
      //                                                                   (received,
      //                                                                       total) {
      //                                                             if (total !=
      //                                                                 -1) {
      //                                                               print((received /
      //                                                                           total *
      //                                                                           100)
      //                                                                       .toStringAsFixed(0) +
      //                                                                   "%");
      //                                                             }
      //                                                           });
      //                                                           print(
      //                                                               "File is saved to download folder.");
      //                                                           downloading(
      //                                                               false);
      //                                                           Fluttertoast
      //                                                               .showToast(
      //                                                             msg:
      //                                                                 "File is saved to $savePath",
      //                                                           );
      //                                                         } on DioError catch (e) {
      //                                                           print(
      //                                                               e.message);
      //                                                           Fluttertoast
      //                                                               .showToast(
      //                                                             msg:
      //                                                                 "File Not Saved",
      //                                                           );
      //                                                         }
      //                                                         downloading(
      //                                                             false);
      //                                                       }
      //                                                       // Get.to(TimeSheetWebView(
      //                                                       //   url:
      //                                                       //       "$KSubDomainURL/welcome/payslip_download_post/${payslipdata["emp_id"]}/${payslipdata["payslip_id"]}/${payslipdata["payroll_process_id"]}",
      //                                                       //   name: "Payslip",
      //                                                       // ));
      //                                                       // downloadAPI();
      //                                                     },
      //                                                   )
      //                                                 : SizedBox()
      //                                       ],
      //                                     ),
      //                                     SizedBox(
      //                                       height: 5.h,
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                             ],
      //                           ))
      // : Center(
      //     child: Column(
      //     children: [
      //       SvgPicture.asset(
      //           "assets/images/oopsNoData.svg",
      //           // color: KOrange,
      //           fit: BoxFit.fill,
      //           semanticsLabel: 'No Data'),
      //       SizedBox(
      //         height: 20.h,
      //       ),
      //       Text(
      //         "Oops! No Data Found",
      //         style: TextStyle(
      //             fontWeight: kFW700,
      //             fontSize: kTwentyFont),
      //       )
      //     ],
      //   ))
      //                   : const Center(
      //                       child: SpinKitFadingCircle(
      //                       color: KOrange,
      //                       size: 15,
      //                     )),
      //               ////Reimbursement Payslip
      //               // payslipdata!=null?
      //               // payslipdata.isNotEmpty
      // ? Container(
      //     margin: EdgeInsets.all(13.r),
      //     width: double.infinity,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(10.r),
      //       color: Kwhite,
      //     ),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Align(
      //           alignment: Alignment.topRight,
      //           child: ClipRRect(
      //             borderRadius: BorderRadius.only(
      //                 topRight: Radius.circular(8.roundToDouble())),
      //             child: Image.asset(
      //               "assets/images/buble.png",
      //               width: 80.w,
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: EdgeInsets.only(
      //               left: 20.w, right: 10.w, bottom: 15.h),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 "Reimbursement Payslip",
      //                 maxLines: 2,
      //                 overflow: TextOverflow.ellipsis,
      //                 style: TextStyle(
      //                     fontSize: kTwelveFont,
      //                     fontWeight: kFW600,
      //                     color: Klightblack),
      //               ),
      //               SizedBox(
      //                 height: 40.h,
      //               ),
      //               Text(
      //                 "No payslip found for the selected month",
      //                 maxLines: 1,
      //                 overflow: TextOverflow.ellipsis,
      //                 style: TextStyle(
      //                     fontSize: kTenFont,
      //                     fontWeight: kFW600,
      //                     color: Klightblack),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ))
      //               //     : const SizedBox():SizedBox(),
      //               /////CTC per Years
      //               ///
      //               ctcdata.isNotEmpty
      //                   ? //   ctcdata["CTC"] != null
      //                   ctcdata["payslip_file_path"] != ""
      //                       ? Container(
      //                           margin: EdgeInsets.all(13.r),
      //                           width: double.infinity,
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(10.r),
      //                             color: Kwhite,
      //                           ),
      //                           child: Column(
      //                             children: [
      //                               Align(
      //                                 alignment: Alignment.topRight,
      //                                 child: ClipRRect(
      //                                   borderRadius: BorderRadius.only(
      //                                       topRight: Radius.circular(
      //                                           8.roundToDouble())),
      //                                   child: Image.asset(
      //                                     "assets/images/buble.png",
      //                                     width: 80.w,
      //                                   ),
      //                                 ),
      //                               ),
      //                               Padding(
      //                                 padding: EdgeInsets.only(
      //                                     left: 20.w, right: 10.w, bottom: 8.h),
      //                                 child: Row(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.start,
      //                                   children: [
      //                                     Column(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment.start,
      //                                       crossAxisAlignment:
      //                                           CrossAxisAlignment.start,
      //                                       children: [
      //                                         Text(
      //                                           "CTC Payslip",
      //                                           maxLines: 2,
      //                                           overflow: TextOverflow.ellipsis,
      //                                           style: TextStyle(
      //                                               fontSize: kTwelveFont,
      //                                               fontWeight: kFW600,
      //                                               color: Klightblack),
      //                                         ),
      //                                         SizedBox(
      //                                           height: 8.h,
      //                                         ),
      //                                         Text(
      //                                           ctcdata["CTC"] != null
      //                                               ? ctcdata["CTC"].toString()
      //                                               : "No data Found",
      //                                           maxLines: 1,
      //                                           overflow: TextOverflow.ellipsis,
      //                                           style: TextStyle(
      //                                               fontSize: 15.sp,
      //                                               fontWeight: kFW700,
      //                                               color: KdarkText),
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                             ],
      //                           ))
      //                       : const SizedBox()
      //                   : const SizedBox()
      //             ],
      //           )
      //         // : SizedBox()
      //         : Center(
      //             child: Column(
      //             children: [
      //               SvgPicture.asset("assets/images/oopsNoData.svg",
      //                   // color: KOrange,
      //                   fit: BoxFit.fill,
      //                   semanticsLabel: 'No Data'),
      //               SizedBox(
      //                 height: 20.h,
      //               ),
      //               Text(
      //                 "Oops! No Data Found",
      //                 style:
      //                     TextStyle(fontWeight: kFW700, fontSize: kTwentyFont),
      //               )
      //             ],
      //           ))
      //   ],
      // ),
    );
  }
}
