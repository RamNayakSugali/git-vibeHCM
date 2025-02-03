// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

import '../untils/export_file.dart';

class Holiday extends StatefulWidget {
  const Holiday({super.key});

  @override
  State<Holiday> createState() => _HolidayState();
}

class _HolidayState extends State<Holiday> {
  final now = DateTime.now();
  final after = DateTime.now().add(Duration(days: 365));
  final before = DateTime.now().subtract(Duration(days: 1));
  Map Requestdata = {};
  List holydays = [];
  List holydaysfilter = [];
  Map UpcommingHolydaysdata = {};
  // List UpcommingHolydaysdata = [];

  bool isLoading = false;
  Future RequestListHandler() async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.employeehome();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      Requestdata = data["holidays"];
      UpcommingHolydaysdata = data["holidays"];

      getUpCommingHolyDays(UpcommingHolydaysdata);
    }
    setState(() {
      isLoading = false;
    });
  }
//  void nowFunvtion() {

//   // print(now.isAfterOrEqual(now)); // true
//   // print(now.isBeforeOrEqual(now)); // true

//   // print(now.isAfterOrEqual(before)); // true
//   // print(now.isAfterOrEqual(after)); // false

//   // print(now.isBeforeOrEqual(after)); // true
//   // print(now.isBeforeOrEqual(before)); // false

//   // print(now.isBetween(from: before, to: after)); // true
//   // print(now.isBetween(from: now, to: now)); // true
//   // print(now.isBetween(from: before, to: now)); // true
//   // print(now.isBetween(from: now, to: after)); // true

//   // print(now.isBetweenExclusive(from: before, to: now)); // false
//   // print(now.isBetweenExclusive(from: now, to: after)); // false
// }

  getUpCommingHolyDays(Map UpcommingHolydaysdataList) {
    setState(() {
      holydaysfilter = UpcommingHolydaysdataList["rows"].where((element) =>
          // DateTime.parse(element["date"]).isAfter(DateTime.now()))
          DateTime.parse(element["date"]).isBefore(after)).toList();
//       final startTime = DateTime(2018, 6, 23, 10, 30);
// final endTime = DateTime(2018, 6, 23, 13, 00);

      holydays = holydaysfilter
          .where((element) => DateTime.parse(element["date"]).isAfter(before)
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
              )
          // DateTime.parse(element["date"]).month ==
          //     DateTime.now().month + 1 ||
          // DateTime.parse(element["date"]).month >= DateTime.now().month &&
          //     DateTime.parse(element["date"]).day >= DateTime.now().day)

          .toList();
    });
    for (int j = 0; j < holydays.length; j++) {
      holydays.sort((a, b) {
        return DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"]));
      });
    }
    debugPrint("Upcoming Holydays COunt = ${holydays.length}");
  }

  @override
  void initState() {
    RequestListHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      appBar: VibhoAppBar(
        title: "Upcoming Holidays",
        bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(15.w),
              child: isLoading == false
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: holydays.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(top: 15.h),
                          padding: EdgeInsets.all(10.r),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.r),
                            color: Kdarkpuple.withOpacity(0.2),
                            // color: KOrange.withOpacity(0.1),
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
                              Container(
                                width: 35.w,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      holydays[index]["date"] != "" &&
                                              holydays[index]["date"] != null
                                          ? DateFormat.MMM()
                                              .format(DateTime.parse(
                                                  holydays[index]["date"]))
                                              .toString()
                                          : " ",
                                      // holydays[index]["date"] != "" &&
                                      //         holydays[index]["date"] != null
                                      //     ? DateFormat.yMMMd()
                                      //         .format(DateTime.parse(
                                      //             holydays[index]["date"]))
                                      //         .toString()
                                      //     : "jhgh",
                                      //  'AUG',
                                      style: TextStyle(
                                          fontSize: kTenFont,
                                          fontWeight: kFW500,
                                          color: Kwhite),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                          top: 2.h, bottom: 2.h),
                                      child: Text(
                                        holydays[index]["date"] != "" &&
                                                holydays[index]["date"] != null
                                            ? DateFormat.d()
                                                .format(DateTime.parse(
                                                    holydays[index]["date"]))
                                                .toString()
                                            : " ",
                                        // '11',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: kFourteenFont,
                                            fontWeight: kFW600,
                                            color: Kwhite),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5)),
                                        color: Kdarkpuple,
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Kdarkpuple.withOpacity(0.5),
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              SizedBox(
                                width: 220.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      holydays[index]["name"]
                                          .toString()
                                          .capitalize!,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: kFourteenFont,
                                          fontWeight: kFW500,
                                          color: selectedTheme == "Lighttheme"
                                              ? KdarkText
                                              : Kwhite),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      DateTime.parse(holydays[index]["date"])
                                                  .day ==
                                              DateTime.now().day
                                          ? "Today"
                                          : DateFormat('EEEE')
                                              .format(DateTime.parse(
                                                  holydays[index]["date"]))
                                              .toString(),
                                      //  "Thursday",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: kFW500,
                                          color: selectedTheme == "Lighttheme"
                                              ? KdarkText
                                              : Kwhite),
                                    ),
                                    // Text(
                                    //   holydays[index]["date"].toString(),
                                    //   //  "Thursday",
                                    //   style: TextStyle(
                                    //       fontSize: 11.sp,
                                    //       fontWeight: kFW500,
                                    //       color: selectedTheme == "Lighttheme"
                                    //           ? KdarkText
                                    //           : Kwhite),
                                    // ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: SpinKitFadingCircle(
                        color: KOrange,
                        size: 50.sp,
                      ),
                    ))),
    );
  }
}
