// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:intl/intl.dart';

import '../untils/export_file.dart';

class Birthdays extends StatefulWidget {
  const Birthdays({super.key});

  @override
  State<Birthdays> createState() => _BirthdaysState();
}

class _BirthdaysState extends State<Birthdays> {
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
    });
  }

  @override
  void initState() {
    super.initState();
    getBirthdayList();
    // getUpCommingBirthDays(originalBirthdayData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        appBar: VibhoAppBar(
          title: "Birthdays",
          bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.w),
            child: isLoading == true
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: SpinKitFadingCircle(
                      color: KOrange,
                      size: 50.sp,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: BirthdayDatafilter.length,
                    // BirthdayData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showGeneralDialog(
                            barrierDismissible: true,
                            barrierLabel: '',
                            barrierColor: Colors.black38,
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            pageBuilder: (ctx, anim1, anim2) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0))),
                              backgroundColor: selectedTheme == "Lighttheme"
                                  ? Color.fromRGBO(255, 255, 255, 0.9)
                                  : Kthemeblack,
                              title: Container(
                                  // margin: const EdgeInsets.all(5),
                                  height: 45.h,
                                  width: 45.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.r),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80.r),
                                      // Image border
                                      child: BirthdayDatafilter[index]
                                                      ["profile_pic"] !=
                                                  null &&
                                              BirthdayDatafilter[index]
                                                      ["profile_pic"] !=
                                                  ""
                                          ? Image.network(
                                              // KProfileimage +
                                              BirthdayDatafilter[index]
                                                  ["profile_pic"],
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Image.asset(
                                                  "assets/images/man.png",
                                                  fit: BoxFit.contain,
                                                );
                                              },
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "assets/images/man.png",
                                              fit: BoxFit.contain,
                                            ))),
                              content: Text(
                                "${BirthdayDatafilter[index]["fname"]} ${BirthdayDatafilter[index]["lname"]}"
                                    .capitalize!,

                                //   "Ram Nayak",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 18.sp,
                                    fontWeight: kFW600,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite),
                              ),
                              elevation: 2,
                              actions: [
                                GestureDetector(
                                  onTap: () async {
                                    var url = Uri.parse(
                                        "tel:${BirthdayDatafilter[index]["phone_no"]}");
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: SizedBox(
                                    // width: 180.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${BirthdayDatafilter[index]["phone_no"]}",

                                          //   $.rows.[]Employee.phone_no
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: kFW800,
                                              color: selectedTheme ==
                                                      "Lighttheme"
                                                  ? KdarkText.withOpacity(0.5)
                                                  : Kwhite),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Icon(
                                          Icons.phone,
                                          size: kSixteenFont,
                                          color: Kgreen,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            transitionBuilder: (ctx, anim1, anim2, child) =>
                                BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 4 * anim1.value,
                                  sigmaY: 4 * anim1.value),
                              child: FadeTransition(
                                child: child,
                                opacity: anim1,
                              ),
                            ),
                            context: context,
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15.h),
                          padding: EdgeInsets.all(10.r),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.r),
                            color: KOrange.withOpacity(0.1),
                            //  color: Kwhite,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Ktextcolor.withOpacity(0.1),
                            //     blurRadius: 10,
                            //     offset: const Offset(0, 0),
                            //     spreadRadius: 2, //New
                            //   )
                            // ],
                          ),
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
                                  margin: const EdgeInsets.all(5),
                                  height: 50.h,
                                  width: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.r),
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
                                      borderRadius: BorderRadius.circular(80.r),
                                      // Image border
                                      child: BirthdayDatafilter[index]
                                                      ["profile_pic"] !=
                                                  null &&
                                              BirthdayDatafilter[index]
                                                      ["profile_pic"] !=
                                                  ""
                                          ? Image.network(
                                              //KProfileimage +
                                              BirthdayDatafilter[index]
                                                  ["profile_pic"],
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Image.asset(
                                                  "assets/images/man.png",
                                                  fit: BoxFit.contain,
                                                );
                                              },
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "assets/images/man.png",
                                              fit: BoxFit.contain,
                                            ))),
                              SizedBox(
                                width: 5.w,
                              ),
                              SizedBox(
                                width: 220.w,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      dashboardController
                                                  .profiledata["emp_code"] ==
                                              BirthdayDatafilter[index]
                                                      ["emp_code"]
                                                  .toString()
                                          ? Text(
                                              "Yours Birthday",
                                              maxLines: 2,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13,
                                                fontWeight: kFW600,
                                                color: selectedTheme ==
                                                        "Lighttheme"
                                                    ? KdarkText
                                                    : Kwhite,
                                              ),
                                            )
                                          : Text(
                                              "${BirthdayDatafilter[index]["fname"]} ${BirthdayDatafilter[index]["lname"]}",
                                              maxLines: 2,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13,
                                                fontWeight: kFW600,
                                                color: selectedTheme ==
                                                        "Lighttheme"
                                                    ? KdarkText
                                                    : Kwhite,
                                              ),
                                            ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        BirthdayDatafilter[index]["emp_code"]
                                            .toString(),
                                        //  "VTIN24",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: kFW700,
                                            color: Klightblack),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                     
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            //  BirthdayData[index]["dob"].toString(),
                                            DateTime.parse(BirthdayDatafilter[
                                                                index]["dob"])
                                                            .day ==
                                                        //  DateTime.now().day
                                                        DateTime.now().day &&
                                                    DateTime.parse(
                                                                BirthdayDatafilter[
                                                                        index]
                                                                    ["dob"])
                                                            .month ==
                                                        DateTime.now().month
                                                ? "Today"
                                                : DateFormat.MMMd()
                                                    .format(DateTime.parse(
                                                        BirthdayDatafilter[
                                                            index]["dob"]))
                                                    .toString(),
                                            // DateFormat.MMMd()
                                            //     .format(DateTime.parse(
                                            //         BirthdayDatafilter[index]
                                            //             ["dob"]))
                                            //     .toString(),

                                            //   "Dec 25",
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: kFW700,
                                                color: selectedTheme ==
                                                        "Lighttheme"
                                                    ? KdarkText
                                                    : Kwhite),
                                          ),

                                          // SizedBox(
                                          //     height: 10.h,
                                          //     child: const VerticalDivider(
                                          //         color: KdarkText)),
                                          // Text(
                                          //   "Birthday 🧁",
                                          //   style: TextStyle(
                                          //       fontSize: 13.sp,
                                          //       fontWeight: kFW600,
                                          //       color: KOrange),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ));
  }
}
