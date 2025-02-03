// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../untils/export_file.dart';

class BirthdayCard extends StatefulWidget {
  const BirthdayCard({super.key});

  @override
  State<BirthdayCard> createState() => _BirthdayCardState();
}

class _BirthdayCardState extends State<BirthdayCard> {
  DashboardController dashboardController = Get.find<DashboardController>();
  bool isLoading = false;
  List<dynamic> BirthdayData = [];
  List<dynamic> BirthdayDatafilter = [];
  List<dynamic> originalBirthdayData = [];
  // Map BirthdayData = {};

  getBirthdayList() async {
    setState(() {
      isLoading = true;
    });

    var data = await Services.getUpcommingBirthdaysList();
    if (data != null) {
      BirthdayData = data;
      originalBirthdayData = data;
      getUpCommingBirthDays(originalBirthdayData);
      // for (int i = 0; i < originalBirthdayData.length; i++) {
      //   if (DateTime.parse(originalBirthdayData[i]["dob"]).month >=
      //       DateTime.now().month)

      //   //(DateTime.parse(originalBirthdayData[i]["dob"]).month.isAfter(DateTime.now().month))
      //   {
      //     BirthdayDatafilter = originalBirthdayData[i].toList();
      //   }
      // }
    } else {
      //  BirthdayData = data;
      //  getFinalData();
    }
    setState(() {
      isLoading = false;
    });
  }

  getUpCommingBirthDays(List originalBirthdayData) {
    setState(() {
      BirthdayDatafilter = originalBirthdayData
          .where((element) =>
              DateTime.parse(element["dob"]).month >= DateTime.now().month)
          // &&
          // DateTime.parse(element["dob"]).month >= DateTime.now().month)
          // DateTime.parse(element["dob"]).isAfter(DateTime.now()))
          // DateTime.parse(element["date"]).month >= DateTime.now().month &&
          //     DateTime.parse(element["date"]).day >= DateTime.now().day)
          //.isAfter(now)
          // &&
          // DateTime.parse(element["date"]).isBefore(after)
          /////////////////////
          ///
          // now.isBetween(from: before, to: after)
          // DateTime.parse(element["date"]).month == after.month
          // DateTime.now().month + 1
          /////////////////////  print(startDate.isBefore(now));
          // DateTime.parse(element["date"])
          //     .isBefore((DateTime.now().month + 11) as DateTime)

          // DateTime.parse(element["date"]).isAfter(DateTime.now()
          // )

          // DateTime.parse(element["date"]).month ==
          //     DateTime.now().month + 1 ||
          // DateTime.parse(element["date"]).month >= DateTime.now().month &&
          //     DateTime.parse(element["date"]).day >= DateTime.now().day)

          .toList();
      dashboardController.birthdayDatafilter.value = BirthdayDatafilter;
      getUpCommingList(dashboardController.birthdayDatafilter);
    });
  }

  getUpCommingList(bdayAllList) {
    dashboardController.upCommingbirthdayDataList.clear();
    if (bdayAllList.isNotEmpty) {
      for (int i = 0; i < bdayAllList.value.length; i++) {
        if (DateTime.parse(bdayAllList[0]["dob"]).day ==
                DateTime.parse(bdayAllList[i]["dob"]).day &&
            DateTime.parse(bdayAllList[0]["dob"]).month ==
                DateTime.parse(bdayAllList[i]["dob"]).month) {
          dashboardController.upCommingbirthdayDataList.add(bdayAllList[i]);
        }
      }
    }
  }
  // bool isLoading = false;
  // List<dynamic> BirthdaysData = [];
  // // Map BirthdayData = {};

  // getBirthdayList() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   var data = await Services.getUpcommingBirthdaysList();
  //   if (data != null) {
  //     BirthdaysData = data;
  //   } else {
  //     //  BirthdayData = data;
  //     //  getFinalData();
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getBirthdayList();
  }

  @override
  Widget build(BuildContext context) {
    return BirthdayDatafilter.isNotEmpty
        ?
        // DateTime.parse("1999-01-29").day==DateTime.now().day? Lottie.asset("assets/images/loadinNew.json"):
        Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Birthdays",
                    style: TextStyle(
                        fontSize: kSixteenFont,
                        fontWeight: kFW700,
                        color:
                            selectedTheme == "Lighttheme" ? KdarkText : Kwhite),
                  ),
                  isLoading == true
                      ? const Center(
                          child: SpinKitFadingCircle(
                          color: KOrange,
                          size: 15,
                        ))
                      : Container(
                          margin: EdgeInsets.only(top: 10.h),
                          // padding: EdgeInsets.all(10.r),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: KOrange.withOpacity(0.3),
                                width: 1,
                              ),
                              // borderRadius: BorderRadius.circular(13.r),
                              // color: KOrange.withOpacity(0.1),
                              color: selectedTheme == "Lighttheme"
                                  ? Kwhite
                                  : Kthemeblack
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Ktextcolor.withOpacity(0.1),
                              //     blurRadius: 10,
                              //     offset: const Offset(0, 0),
                              //     spreadRadius: 2, //New
                              //   )
                              // ],
                              ),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(KBirthdays);
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  KOrange.withOpacity(0.5),
                                              child: const Icon(Icons.cake,
                                                  color: Kwhite),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "Upcoming Birthdays",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 14.sp,
                                                  fontWeight: kFW600,
                                                  color: selectedTheme ==
                                                          "Lighttheme"
                                                      ? KdarkText
                                                      : Kwhite),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20.sp,
                                          color: selectedTheme == "Lighttheme"
                                              ? KdarkText
                                              : Kwhite,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(color: KOrange.withOpacity(0.3)),
                                Container(
                                  // height: 100,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: dashboardController
                                          .upCommingbirthdayDataList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              // Container(
                                              //     margin: const EdgeInsets.all(5),
                                              //     height: 50.h,
                                              //     width: 50.h,
                                              //     decoration: BoxDecoration(
                                              //       // boxShadow: [
                                              //       //   BoxShadow(
                                              //       //     color: Ktextcolor.withOpacity(0.3),
                                              //       //     blurRadius: 10,
                                              //       //     offset: const Offset(0, 0),
                                              //       //     spreadRadius: 3, //New
                                              //       //   )
                                              //       // ],
                                              //       borderRadius: BorderRadius.circular(40.r),
                                              //       color: Kwhite,
                                              //     ),
                                              //     child: ClipRRect(
                                              //         borderRadius:
                                              //             BorderRadius.circular(40.r), // Image border
                                              //         child: Image.asset(
                                              //           "assets/images/man.png",
                                              //           fit: BoxFit.contain,
                                              //         ))),
                                              Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  height: 50.h,
                                                  width: 50.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80.r),
                                                    // boxShadow: [
                                                    //   BoxShadow(
                                                    //     spreadRadius: 2,
                                                    //     blurRadius: 10,
                                                    //     offset: Offset(0, 6),
                                                    //     color: Ktextcolor.withOpacity(0.5),
                                                    //   )
                                                    // ],
                                                    //border: Border.all(color: Ktextcolor)
                                                    //color: Kwhite,
                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              80.r),
                                                      // Image border
                                                      child: originalBirthdayData[
                                                                          index]
                                                                      [
                                                                      "profile_pic"] !=
                                                                  null &&
                                                              originalBirthdayData[
                                                                          index]
                                                                      [
                                                                      "profile_pic"] !=
                                                                  ""
                                                          ? Image.network(
                                                              // KProfileimage +
                                                              originalBirthdayData[
                                                                      index][
                                                                  "profile_pic"],
                                                              errorBuilder: (BuildContext
                                                                      context,
                                                                  Object
                                                                      exception,
                                                                  StackTrace?
                                                                      stackTrace) {
                                                                return Image
                                                                    .asset(
                                                                  "assets/images/man.png",
                                                                  fit: BoxFit
                                                                      .contain,
                                                                );
                                                              },
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.asset(
                                                              "assets/images/man.png",
                                                              fit: BoxFit
                                                                  .contain,
                                                            ))),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              SizedBox(
                                                width: 230.w,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    dashboardController
                                                                    .profiledata[
                                                                "emp_code"] ==
                                                            originalBirthdayData[
                                                                        index]
                                                                    ["emp_code"]
                                                                .toString()
                                                        ? Text(
                                                            "Yours Birthday",
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  kFW600,
                                                              color: selectedTheme ==
                                                                      "Lighttheme"
                                                                  ? KdarkText
                                                                  : Kwhite,
                                                            ),
                                                          )
                                                        : Text(
                                                            "${originalBirthdayData[index]["fname"]} ${originalBirthdayData[index]["lname"]}"
                                                                .capitalize!,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    kFW600,
                                                                color: selectedTheme ==
                                                                        "Lighttheme"
                                                                    ? KdarkText
                                                                    : Kwhite),
                                                          ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                      originalBirthdayData[
                                                              index]["emp_code"]
                                                          .toString(),
                                                      //  "VTIN24",
                                                      style: TextStyle(
                                                          fontSize: kTenFont,
                                                          fontWeight: kFW700,
                                                          color: Klightblack),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                      //  BirthdayData[index]["dob"].toString(),
                                                      DateTime.parse(originalBirthdayData[index]["dob"])
                                                                      .day ==
                                                                  DateTime.now()
                                                                      .day &&
                                                              DateTime.parse(originalBirthdayData[
                                                                              index]
                                                                          [
                                                                          "dob"])
                                                                      .month ==
                                                                  DateTime.now()
                                                                      .month
                                                          ? "Today"
                                                          : DateFormat.MMMd()
                                                              .format(DateTime.parse(
                                                                  originalBirthdayData[
                                                                          index]
                                                                      ["dob"]))
                                                              .toString(),

                                                      //   "Dec 25",
                                                      style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight: kFW700,
                                                          color: selectedTheme ==
                                                                  "Lighttheme"
                                                              ? KdarkText
                                                              : Kwhite),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          // Row(
                                          //   children: [
                                          //     Container(
                                          //         //   margin: const EdgeInsets.all(5),
                                          //         height: 50.h,
                                          //         width: 50.h,
                                          //         decoration: BoxDecoration(
                                          //           // boxShadow: [
                                          //           //   BoxShadow(
                                          //           //     color: Ktextcolor.withOpacity(0.3),
                                          //           //     blurRadius: 10,
                                          //           //     offset: const Offset(0, 0),
                                          //           //     spreadRadius: 3, //New
                                          //           //   )
                                          //           // ],
                                          //           borderRadius: BorderRadius.circular(40.r),
                                          //           color: Kwhite,
                                          //         ),
                                          //         child: ClipRRect(
                                          //             borderRadius:
                                          //                 BorderRadius.circular(40.r), // Image border
                                          //             child: Image.asset(
                                          //               "assets/images/man.png",
                                          //               fit: BoxFit.contain,
                                          //             ))),
                                          //     SizedBox(
                                          //       width: 5.w,
                                          //     ),
                                          //     SizedBox(
                                          //       width: 220.w,
                                          //       child: Column(
                                          //         crossAxisAlignment: CrossAxisAlignment.start,
                                          //         children: [
                                          //           Row(
                                          //             crossAxisAlignment: CrossAxisAlignment.center,
                                          //             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //             children: [
                                          //               Text(
                                          //                 "Ram Nayak",
                                          //                 style: TextStyle(
                                          //                     overflow: TextOverflow.ellipsis,
                                          //                     fontSize: kFourteenFont,
                                          //                     fontWeight: kFW600,
                                          //                     color: KdarkText),
                                          //               ),
                                          //               Text(
                                          //                 " - ",
                                          //                 style: TextStyle(
                                          //                     fontSize: kTwelveFont,
                                          //                     fontWeight: kFW700,
                                          //                     color: KdarkText),
                                          //               ),
                                          //               Text(
                                          //                 "VTIN24",
                                          //                 style: TextStyle(
                                          //                     fontSize: kTwelveFont,
                                          //                     fontWeight: kFW700,
                                          //                     color: Klightblack),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //           Row(
                                          //             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //             children: [
                                          //               Text(
                                          //                 "Dec 25",
                                          //                 style: TextStyle(
                                          //                     fontSize: 11.sp,
                                          //                     fontWeight: kFW700,
                                          //                     color: KdarkText),
                                          //               ),
                                          //               SizedBox(
                                          //                   height: 10.h,
                                          //                   child: VerticalDivider(color: KdarkText)),
                                          //               Text(
                                          //                 "Birthday 🧁",
                                          //                 style: TextStyle(
                                          //                     fontSize: kFourteenFont,
                                          //                     fontWeight: kFW700,
                                          //                     color: KOrange),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        )
                ],
              ),
              DateTime.parse(BirthdayDatafilter[0]["dob"]).day ==
                      DateTime.now().day
                  ? Center(
                      child: Lottie.asset("assets/images/celebrations.json",
                          height: 150.h))
                  : const SizedBox(),
            ],
          )
        : const SizedBox();
  }
}
