// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:vibeshr/untils/export_file.dart';

class NewEmployeeslist extends StatefulWidget {
  const NewEmployeeslist({super.key});

  @override
  State<NewEmployeeslist> createState() => _NewEmployeeslistState();
}

class _NewEmployeeslistState extends State<NewEmployeeslist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        appBar: VibhoAppBar(
          title: "New Employees",
          bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.w),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(top: 15.h),
                  padding: EdgeInsets.all(10.r),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.r),
                    color: Klightpuple.withOpacity(0.1),
                  ),
                  child: Row(
                    children: [
                      Container(
                          // margin: const EdgeInsets.all(5),
                          height: 45.h,
                          width: 45.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.r),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(80.r),
                              // Image border
                              child: Image.asset(
                                "assets/images/man.png",
                                fit: BoxFit.contain,
                              ))),
                      SizedBox(
                        width: 5.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ram Nayak",
                              maxLines: 2,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 13.sp,
                                  fontWeight: kFW600,
                                  color: selectedTheme == "Lighttheme"
                                      ? KdarkText
                                      : Kwhite),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "VTIN24",
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: kFW600,
                                  color: Klightblack),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Jr.Flutter Developer 🧑🏼‍💼",
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: kFW600,
                                  color: Klightpuple),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Joined on Monday,May 30",
                              //  BirthdayData[index]["dob"].toString(),
                              //KdarkText

                              //   "${DateFormat.MMM().format(DateTime.parse(AnniversaryData[index]["date_of_joining"])).toString() ?? ""} - ${DateFormat.d().format(DateTime.parse(AnniversaryData[index]["date_of_joining"])).toString() ?? ""} | ",

                              //   "Dec 25",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: kFW700,
                                  color: selectedTheme == "Lighttheme"
                                      ? KdarkText
                                      : Kwhite),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}



// class Holiday extends StatefulWidget {
//   const Holiday({super.key});

//   @override
//   State<Holiday> createState() => _HolidayState();
// }

// class _HolidayState extends State<Holiday> {
//   Map Requestdata = {};
//   List holydays = [];
//   Map UpcommingHolydaysdata = {};

//   bool isLoading = false;
//   Future RequestListHandler() async {
//     setState(() {
//       isLoading = true;
//     });
//     Map data = await Services.employeehome();

//     if (data["message"] != null) {
//       Fluttertoast.showToast(
//         msg: data["message"],
//       );
//     } else {
//       Requestdata = data["holidays"];
//       UpcommingHolydaysdata = data["holidays"];
//       getUpCommingHolyDays(UpcommingHolydaysdata);
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }

//   getUpCommingHolyDays(Map UpcommingHolydaysdataList) {
//     setState(() {
//       holydays = UpcommingHolydaysdataList["rows"]
//           .where((element) =>
//               DateTime.parse(element["date"]).month >= DateTime.now().month &&
//               DateTime.parse(element["date"]).day >= DateTime.now().day)
//           .toList();
//     });
//     for (int j = 0; j < holydays.length; j++) {
//       holydays.sort((a, b) {
//         return DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"]));
//       });
//     }
//     debugPrint("Upcomming Holydays COunt = ${holydays.length}");
//   }

//   @override
//   void initState() {
//     RequestListHandler();
//     super.initState();
//   }

  
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Holidays",
//           style: TextStyle(
//               fontSize: kSixteenFont, fontWeight: kFW700, color: KdarkText),
//         ),
//         SizedBox(
//           height: 20.h,
//         ),
//         isLoading == false
//             ? GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: holydays.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 10,
//                     childAspectRatio: 1 / 0.95.h,
//                     crossAxisSpacing: 10),
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                       // height: 90,
//                       // width: 90,
//                       //  padding: EdgeInsets.all(10.r),
//                       padding:
//                           EdgeInsets.only(left: 10.w, right: 10.w, top: 18.h),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15.r),
//                           boxShadow: [
//                             BoxShadow(
//                               spreadRadius: 2,
//                               blurRadius: 2,
//                               offset: const Offset(0, 0),
//                               color: KOrange.withOpacity(0.2),
//                             )
//                           ],
//                           color: Kwhite),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             holydays[index]["name"].toString().capitalize!,
//                             maxLines: 2,
//                             style: TextStyle(
//                                 fontSize: kFourteenFont,
//                                 fontWeight: kFW700,
//                                 color: KdarkText),
//                           ),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           holydays[index]["is_active"] == 1
//                               ? Text(
//                                   "Holiday",
//                                   style: TextStyle(
//                                       fontSize: kTwelveFont,
//                                       fontWeight: kFW700,
//                                       color: KdarkText),
//                                 )
//                               : SizedBox(),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           Text(
//                             // ignore: unnecessary_null_comparison
//                             holydays[index]["date"] != "" &&
//                                     holydays[index]["date"] != null
//                                 ? DateFormat.yMMMd()
//                                     .format(
//                                         DateTime.parse(holydays[index]["date"]))
//                                     .toString()
//                                 : "jhgh",
//                             maxLines: 1,
//                             style: TextStyle(
//                                 fontSize: 11.sp,
//                                 fontWeight: kFW700,
//                                 color: KdarkText),
//                           ),
//                           const SizedBox(
//                             height: 13,
//                           ),
//                           Align(
//                               alignment: Alignment.bottomRight,
//                               child: Image.asset(
//                                 "assets/images/leave.png",
//                                 width: 60.w,
//                               ))
//                         ],
//                       ));
//                 },
//               )
//             : const Center(
//                 child:  SpinKitFadingCircle(
//                 color: KOrange,
//                 size: 15,
//               ))
//       ],
//     );
//   }
// }
