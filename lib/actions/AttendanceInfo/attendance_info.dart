// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../untils/export_file.dart';

class Attendances extends StatefulWidget {
  const Attendances({super.key});

  @override
  State<Attendances> createState() => _AttendancesState();
}

class _AttendancesState extends State<Attendances> {
  final DateTime _chosenDate = DateTime.now();
  // try{
  // AttendanceController attendanceController = Get.find<AttendanceController>();
  // }catch(e){
  AttendanceController attendanceController = Get.find<AttendanceController>();
  DashboardController dashboardController = Get.find<DashboardController>();

  // }
  // final DateRangePickerController _controller = DateRangePickerController();

  // bool isLoading = false;
  // Map attendanceInfoData = {};
  // DateTime? selectedDate;
  // getCalenderInfo(DateTime date) async {
  //   setState(() {
  //     isLoading = true;
  //     _controller.view = DateRangePickerView.month;
  //   });

  //   Map value = await Services.attendanceinfo(date);
  //   if (value["message"] != null) {
  //     Fluttertoast.showToast(msg: value["message"]);
  //   } else {
  //     attendanceInfoData = value;
  //     getDatesList(attendanceInfoData);
  //   }
  //   print(value);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // List<DateTime> absentdates = [];
  // List<DateRangePickerCellDetails> listofAllDates = [];
  // List<DateTime> presentdates = [];
  // List<DateTime> holydaysdates = [];
  // List<DateTime> restDaysdates = [];
  // List<DateTime> allDaysdates = [];
  // getDatesList(Map getDatesList) {
  //   absentdates.clear();
  //   presentdates.clear();
  //   holydaysdates.clear();
  //   restDaysdates.clear();
  //   allDaysdates.clear();
  //   for (int i = 0; i < getDatesList["rows"].length; i++) {
  //     allDaysdates.add(DateTime.parse(
  //         getCorrectDateFormat(getDatesList["rows"][i]["date"])));
  //     // listofAllDates.add(DateRangePickerCellDetails(bounds: ,date: DateTime.parse(
  //     //         getCorrectDateFormat(getDatesList["rows"][i]["date"]))));
  //     if (getDatesList["rows"][i]["status"] == "O" ||
  //         getDatesList["rows"][i]["status"] == "o") {
  //       setState(() {
  //         if (DateTime.parse(
  //                     getCorrectDateFormat(getDatesList["rows"][i]["date"]))
  //                 .day <
  //             DateTime.now().day)
  //           absentdates.add(DateTime.parse(
  //               getCorrectDateFormat(getDatesList["rows"][i]["date"])));
  //       });
  //     }
  //     if (getDatesList["rows"][i]["status"] == "P" ||
  //         getDatesList["rows"][i]["status"] == "p") {
  //       setState(() {
  //         presentdates.add(DateTime.parse(
  //             getCorrectDateFormat(getDatesList["rows"][i]["date"])));
  //       });
  //     }
  //     if (getDatesList["rows"][i]["status"] == "H" ||
  //         getDatesList["rows"][i]["status"] == "h") {
  //       setState(() {
  //         holydaysdates.add(DateTime.parse(
  //             getCorrectDateFormat(getDatesList["rows"][i]["date"])));
  //       });
  //     }
  //     if (getDatesList["rows"][i]["status"] == "R" ||
  //         getDatesList["rows"][i]["status"] == "r") {
  //       setState(() {
  //         restDaysdates.add(DateTime.parse(
  //             getCorrectDateFormat(getDatesList["rows"][i]["date"])));
  //       });
  //     }
  //   }
  // }

  bool isSpecialDay(DateTime date) {
    if (date.day == 20 || date.day == 21 || date.day == 24 || date.day == 25) {
      return true;
    }
    return false;
  }

  bool isHolyDate(DateTime date) {
    return attendanceController.holydaysdates
            .where((element) => element == date)
            .toList()
            .isNotEmpty
        ? true
        : false;
  }

  bool isWorkingDay(DateTime date) {
    return attendanceController.presentdates
            .where((element) => element == date)
            .toList()
            .isNotEmpty
        ? true
        : false;
  }

  // bool isWorkFromHOmeDay(DateTime date) {
  //   return attendanceController.wfhdates
  //           .where((element) => element == date)
  //           .toList()
  //           .isNotEmpty
  //       ? true
  //       : false;
  // }

  // String getCorrectDateFormat(String dateformat) {
  //   List<String> date = dateformat.split('-');
  //   date[1] = int.parse(date[1]) > 9 ? date[1].toString() : "0${date[1]}";
  //   String newDate = "${date[0]}-${date[1]}-${date[2]}";
  //   return newDate;
  // }

  final String CALENDERS = 'assets/images/calenders.svg';
  @override
  void initState() {
    setState(() {
      attendanceController.controller.selectedDate = DateTime.now();
      attendanceController.controller.displayDate = DateTime.now();
      attendanceController.selectedDate.value = DateTime.now();
      attendanceController.getCalenderInfo(DateTime.now());
    });
    setState(() {
      attendanceController.controller.selectedDate = null;
    });

    // attendanceController.getCalenderInfo(DateTime.now());
    // attendanceController.controller.selectedDate = null;
    // selectedDate = DateTime.now();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      appBar: VibhoAppBar(
        bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        title: 'Attendance Info',
        dontHaveBackAsLeading: false,
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(13.r),
        child: Column(
          children: [
            //  Text(dashboardController.profiledata["date_of_joining"]),
            GestureDetector(
              onTap: () async {
                showMonthPicker(
                  // dismissible: false,
                  backgroundColor: Kwhite,
                  selectedMonthBackgroundColor: KOrange.withOpacity(0.5),
                  roundedCornersRadius: 10,
                  headerColor: KOrange,
                  unselectedMonthTextColor: Ktextcolor,
                  context: context,
                  firstDate: DateTime.parse(
                      dashboardController.profiledata["date_of_joining"]),
                  initialDate: DateTime.now(),
                  lastDate: DateTime.now(),
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
                          msg: "Upcomming Months can't be selected");
                    } else {
                      setState(() {
                        attendanceController.controller.selectedDate = date;
                        attendanceController.controller.displayDate = date;
                        attendanceController.selectedDate.value = date;
                        attendanceController.getCalenderInfo(date);
                      });
                    }
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.all(13.r),
                margin: EdgeInsets.all(13.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                      color: Ktextcolor.withOpacity(0.2),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      attendanceController.controller.selectedDate != null
                          ? DateFormat.yMMM().format(
                              attendanceController.controller.selectedDate!)
                          : "Select Month & Year",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: KOrange.withOpacity(0.7),
                      ),
                    ),

                    // SizedBox(
                    //   width: 50.w,
                    // ),

                    SvgPicture.asset(CALENDERS, semanticsLabel: 'Acme Logo')
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(() => attendanceController.selectedDate.value != null
                ? attendanceController.isAttendanceLoading.value == false
                    ? Container(
                        padding: EdgeInsets.only(bottom: 5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Kwhite,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 6),
                              color: Ktextcolor.withOpacity(0.2),
                            )
                          ],
                        ),
                        child: Stack(
                          children: [
                            SfDateRangePicker(
                              //  DateTime (dashboardController.profiledata["date_of_joining"])
                              // minDate: DateTime.parse(dashboardController
                              //     .profiledata["date_of_joining"]),
                              // DateFormat('yyyy-MMM-dd hh :mm aaa')
                              //           .format(DateTime.parse(
                              //              dashboardController.profiledata["date_of_joining"]
                              //                   ))
                              //  minDate: dashboardController.profiledata["date_of_joining"],
                              rangeTextStyle: const TextStyle(
                                color: KOrange,
                              ),
                              controller: attendanceController.controller,
                              navigationDirection:
                                  DateRangePickerNavigationDirection.horizontal,
                              enablePastDates: false,
                              allowViewNavigation: false,
                              startRangeSelectionColor: KOrange,
                              selectionColor: KOrange,
                              initialSelectedDates:
                                  attendanceController.allDaysdates,
                              initialDisplayDate:
                                  attendanceController.selectedDate.value,
                              monthViewSettings:
                                  DateRangePickerMonthViewSettings(
                                      //  weekendDays: attendanceController.wfhdate,
                                      blackoutDates:
                                          attendanceController.absentdates,
                                      // weekendDays: const [7, 6],
                                      specialDates:
                                          attendanceController.leaveDates),
                              monthCellStyle: DateRangePickerMonthCellStyle(
                                // weekendTextStyle:
                                //     TextStyle(color: Colors.transparent),
                                // weekendDatesDecoration: BoxDecoration(
                                //     color: Colors.transparent,
                                //     shape: BoxShape.circle),
                                blackoutDatesDecoration: BoxDecoration(
                                    color: KRed.withOpacity(0.12),
                                    shape: BoxShape.circle),
                                blackoutDateTextStyle: const TextStyle(
                                    color: KRed, fontWeight: FontWeight.bold),
                                textStyle: const TextStyle(
                                  color: Klightgray,
                                ),
                                specialDatesTextStyle: const TextStyle(
                                    color: KlightYelow,
                                    fontWeight: FontWeight.bold),
                                specialDatesDecoration: BoxDecoration(
                                    color: KlightYelow.withOpacity(0.15),
                                    shape: BoxShape.circle),
                              ),
                            ),
                            SfDateRangePicker(
                              rangeTextStyle: const TextStyle(
                                color: KOrange,
                              ),
                              controller: attendanceController.controller,
                              navigationDirection:
                                  DateRangePickerNavigationDirection.horizontal,
                              enablePastDates: false,
                              allowViewNavigation: false,
                              startRangeSelectionColor: KOrange,
                              selectionColor: KOrange,
                              initialSelectedDates:
                                  attendanceController.allDaysdates,
                              initialDisplayDate:
                                  attendanceController.selectedDate.value,
                              monthViewSettings:
                                  DateRangePickerMonthViewSettings(
                                      blackoutDates:
                                          attendanceController.presentdates,

                                      // weekendDays: const [7, 6],
                                      specialDates:
                                          attendanceController.holydaysdates),
                              monthCellStyle: DateRangePickerMonthCellStyle(
                                  weekendTextStyle: TextStyle(),
                                  weekendDatesDecoration: BoxDecoration(
                                      color: KBlue.withOpacity(0.2),
                                      shape: BoxShape.circle),
                                  // weekendTextStyle:
                                  //     const TextStyle(color: Color(0xFFB6B6B6)),
                                  // weekendDatesDecoration:
                                  // BoxDecoration(
                                  //     //color: Klightgray,
                                  //     border:
                                  //         Border.all(color: const Color(0xFFB6B6B6), width: 1),
                                  //     shape: BoxShape.circle),
                                  blackoutDatesDecoration: BoxDecoration(
                                      color: Kgreen.withOpacity(0.1),
                                      shape: BoxShape.circle),
                                  specialDatesDecoration: BoxDecoration(
                                      color: Kbluedark.withOpacity(0.1),
                                      shape: BoxShape.circle),
                                  blackoutDateTextStyle: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: kFW700,
                                      color: Kgreen),
                                  textStyle: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: kFW700,
                                      color: Klightgray),
                                  specialDatesTextStyle: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: kFW700,
                                      color: Kbluedark)),
                            ),
                            Container(
                              color: Colors.transparent,
                              height: MediaQuery.of(context).size.height / 4,
                              //  height: 250.h,
                            )
                          ],
                        ))
                    : const Center(
                        child: SpinKitFadingCircle(
                          color: KOrange,
                          size: 40,
                        ),
                      )
                : const SizedBox()),
            SizedBox(
              height: 15.h,
            ),
            Container(
              padding: EdgeInsets.all(15.r),
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                      color: Ktextcolor.withOpacity(0.2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10.r),
                  color: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 5.r,
                                backgroundColor: KRed,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Absent",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: kFW700,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Obx(() => Text(
                                    "-  ${attendanceController.absentdates.length}",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: kFW900,
                                        color: selectedTheme == "Lighttheme"
                                            ? KdarkText
                                            : Kwhite),
                                  ))
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 5.r,
                                backgroundColor: Kbluedark,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Holidays",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: kFW700,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Obx(() => Text(
                                    "-  ${attendanceController.holydaysdates.length}",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: kFW900,
                                        color: selectedTheme == "Lighttheme"
                                            ? KdarkText
                                            : Kwhite),
                                  ))
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 5.r,
                                  backgroundColor: Klightgray.withOpacity(0.5)
                                  //KdarkText.withOpacity(0.5),
                                  ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Work From Home",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: kFW700,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Obx(() => Text(
                                    "-  ${attendanceController.wfhdates.length}",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: kFW900,
                                        color: selectedTheme == "Lighttheme"
                                            ? KdarkText
                                            : Kwhite),
                                  ))
                            ],
                          )
                          // Row(
                          //   children: [
                          //     CircleAvatar(
                          //       radius: 5.r,
                          //       backgroundColor: Ktextcolor,
                          //     ),
                          //     SizedBox(
                          //       width: 10.w,
                          //     ),
                          //     Text(
                          //       "Rest Day",
                          //       style: TextStyle(
                          //           fontSize: 13.sp,
                          //           color: KdarkText,
                          //           fontWeight: kFW500),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 5.r,
                                backgroundColor: Kgreen,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Present",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: kFW700,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Obx(() => Text(
                                    "-  ${attendanceController.presentdates.length}",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: kFW900,
                                        color: selectedTheme == "Lighttheme"
                                            ? KdarkText
                                            : Kwhite),
                                  ))
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 5.r,
                                backgroundColor: KlightYelow,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Leave",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: kFW700,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Obx(() => Text(
                                    "-  ${attendanceController.leaveDates.length}",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: kFW900,
                                        color: selectedTheme == "Lighttheme"
                                            ? KdarkText
                                            : Kwhite),
                                  ))
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 5.r, backgroundColor: Kdarkblue),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "Rest",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: kFW700,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Obx(() => Text(
                                    "-  ${attendanceController.restDaysdates.length}",
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: kFW900,
                                        color: selectedTheme == "Lighttheme"
                                            ? KdarkText
                                            : Kwhite),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 15.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [

                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 5.h,
                  // ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
