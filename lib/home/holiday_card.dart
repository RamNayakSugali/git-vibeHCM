// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

import '../untils/export_file.dart';

class HolidayCard extends StatefulWidget {
  const HolidayCard({super.key});

  @override
  State<HolidayCard> createState() => _HolidayCardState();
}

class _HolidayCardState extends State<HolidayCard> {
  Map Requestdata = {};
  Map permissiondata = {};
  ///////////////
  final now = DateTime.now();
  final after = DateTime.now().add(Duration(days: 365));
  final before = DateTime.now().subtract(Duration(days: 1));

  List holydaysfilter = [];
  //////////////
  List holydays = [];
  Map UpcommingHolydaysdata = {};

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
      // holydays = UpcommingHolydaysdataList["rows"]
      //     .where((element) =>
      //         DateTime.parse(element["date"]).isAfter(DateTime.now()))
      //     // DateTime.parse(element["date"]).month ==
      //     //     DateTime.now().month + 1 ||
      //     // DateTime.parse(element["date"]).month >= DateTime.now().month &&
      //     //     DateTime.parse(element["date"]).day >= DateTime.now().day)
      //     .toList();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        holydays.isNotEmpty
            ? Text(
                "Holidays",
                style: TextStyle(
                    fontSize: kSixteenFont,
                    fontWeight: kFW700,
                    color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite),
              )
            : const SizedBox(),
        isLoading == true
            ? const Center(
                child: SpinKitFadingCircle(
                color: KOrange,
                size: 15,
              ))
            : holydays.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      Get.toNamed(KHolidayLIsts);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10.h),
                      // padding: EdgeInsets.all(10.r),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Kdarkpuple.withOpacity(0.3),
                            // color: KOrange.withOpacity(0.3),
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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Kdarkpuple.withOpacity(0.5),
                                      child: const Icon(Icons.calendar_today,
                                          color: Kwhite),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      "Upcoming Holidays",
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 14.sp,
                                          fontWeight: kFW600,
                                          color: selectedTheme == "Lighttheme"
                                              ? KdarkText
                                              : Kwhite),
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios,
                                    size: 20.sp,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite)
                              ],
                            ),
                          ),
                          Divider(
                            color: Kdarkpuple.withOpacity(0.3),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  width: 35.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Kdarkpuple.withOpacity(0.5),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Text(
                                        holydays[0]["date"] != "" &&
                                                holydays[0]["date"] != null
                                            ? DateFormat.MMM()
                                                .format(DateTime.parse(
                                                    holydays[0]["date"]))
                                                .toString()
                                            : " ",
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
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5)),
                                          color: Kdarkpuple,
                                        ),
                                        child: Text(
                                          holydays[0]["date"] != "" &&
                                                  holydays[0]["date"] != null
                                              ? DateFormat.d()
                                                  .format(DateTime.parse(
                                                      holydays[0]["date"]))
                                                  .toString()
                                              : " ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: kFourteenFont,
                                              fontWeight: kFW600,
                                              color: Kwhite),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                SizedBox(
                                  width: 220.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        holydays[0]["name"]
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
                                        DateTime.parse(holydays[0]["date"])
                                                    .day ==
                                                DateTime.now().day
                                            ? "Today"
                                            : DateFormat('EEEE')
                                                .format(DateTime.parse(
                                                    holydays[0]["date"]))
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: kFW500,
                                            color: selectedTheme == "Lighttheme"
                                                ? KdarkText
                                                : Kwhite),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox()
      ],
    );
  }
}
