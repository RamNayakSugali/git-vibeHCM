// ignore_for_file: non_constant_identifier_names

// import 'dart:js_interop';

import 'package:intl/intl.dart';

import '../../untils/export_file.dart';

class Leavebalance extends StatefulWidget {
  const Leavebalance({super.key});

  @override
  State<Leavebalance> createState() => _LeavebalanceState();
}

class _LeavebalanceState extends State<Leavebalance> {
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
    return Scaffold(
      backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      bottomNavigationBar: CustomButton(
          margin: EdgeInsets.all(10.r),
          borderRadius: BorderRadius.circular(20.r),
          Color: KOrange,
          height: 40.h,
          label: "Apply for Leave",
          textColor: Kwhite,
          fontWeight: kFW900,
          fontSize: 13.sp,
          isLoading: false,
          onTap: () {
            // GetCurrentLocationHandlerHandler();
            Get.toNamed(Kleaves);
          }),
      appBar: VibhoAppBar(
        bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        title: 'Leave Balance',
        dontHaveBackAsLeading: false,
      ),
      body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              margin: EdgeInsets.all(13.r),
              child: isLoading == true
                  ?  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 150.h,),
                      const SpinKitFadingCircle(
                      color: KOrange,
                      size: 15,
                    )
                    ],
                  )
                  :

                  // Wrap(
                  //     crossAxisAlignment: WrapCrossAlignment.center,
                  //     // spacing: 20.w,

                  //     // crossAxisAlignment = WrapCrossAlignment.start,
                  //     children: [
                  //       for (int index = 0;
                  //           index < balances.length; // take this
                  //           index++)
                  ListView.builder(
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
                                  "${DateFormat('yyyy-MMM-dd').format(DateTime.parse(leavebalancefilters[index][0]["period_from"]))} to ${DateFormat('yyyy-MMM-dd').format(DateTime.parse(leavebalancefilters[index][0]["period_to"]))}",
                                  style: TextStyle(
                                    fontSize: kTwelveFont,
                                    fontWeight: kFW700,
                                    color: KCustomDarktwo,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                            Wrap(
                              children: [
                                for (int j = 0;
                                    //  i < interests.length;
                                    // index < balances.first.length;
                                    j <
                                        // balances
                                        //     .toList()[index]
                                        //     .toList()
                                        leavebalancefilters[index].length;
                                    j++)
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 12.w, top: 15.h),
                                    padding: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                      color: selectedTheme == "Lighttheme"
                                          ? Kwhite
                                          : Kthemeblack,
                                      borderRadius: BorderRadius.circular(15.r),
                                      boxShadow: [
                                        BoxShadow(
                                          spreadRadius: 1.5,
                                          blurRadius: 3,
                                          offset: const Offset(0, 2),
                                          color: Ktextcolor.withOpacity(0.25),
                                        )
                                      ],
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Ktextcolor.withOpacity(0.2),
                                      //     blurRadius: 5,
                                      //     offset: const Offset(0, 0),
                                      //     spreadRadius: 1, //New
                                      //   )
                                      // ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          leavebalancefilters[index][j]
                                                      ["leaves"]
                                                  ["leave_type_name"] ??
                                              "no leave type",
                                          style: TextStyle(
                                            fontSize: kTwelveFont,
                                            fontWeight: kFW900,
                                            color: Klightblack,

                                            /// Color(0xFF7E91AE),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          leavebalancefilters[index][j]
                                                  ["leaves"]
                                              ["no_of_every_months_name"],
                                          style: TextStyle(
                                            fontSize: kTwelveFont,
                                            fontWeight: kFW500,
                                            color: KCustomDarktwo,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "${leavebalancefilters[index][j]["leaves"]["applied"]["respdata"]["pending"].toString()} / ${leavebalancefilters[index][j]["leaves"]["leaves_count"].toString()} Days",
                                          //     "${balances.toList()[index].toList()[j]["leaves"]["applied"]["respdata"]["pending"].toString()} / ${balances.toList()[index].toList()[j]["leaves"]["leaves_count"].toString()} Days",
                                          // "${balances.toList()[index].toList()[j]["leaves"]["leaves_count"] - balances.toList()[index].toList()[j]["leaves"]["applied"]["respdata"]["leaves_applied"]} / ${balances.toList()[index].toList()[j]["leaves"]["leaves_count"].toString()} Days",

                                          //   "28 / 30 Days",
                                          style: TextStyle(
                                            fontSize: kSixteenFont,
                                            fontWeight: kFW600,
                                            color: Klight,

                                            /// Color(0xFF7E91AE),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Text(
                                          "Utilized:${leavebalancefilters[index][j]["leaves"]["applied"]["respdata"]["leaves_applied"].toString()}",
                                          //       "Utilized:${balances.toList()[index].toList()[j]["leaves"]["applied"]["respdata"]["leaves_applied"].toString()}",
                                          style: TextStyle(
                                            fontSize: kTwelveFont,
                                            fontWeight: kFW500,
                                            color: Klightblack,

                                            /// Color(0xFF7E91AE),
                                          ),
                                        ),
                                      ],
                                    ),

                                    //     Column(  // org
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       leavebalancefilters[index][j]  // 1st
                                    //                   ["leaves"]
                                    //               ["leave_type_name"] ??
                                    //           "no",

                                    //       // balances.toList()[index].toList()[j]
                                    //       //     ["leaves"]["leave_type_name"],

                                    //       // balances.first[index]["leaves"]
                                    //       //     ["leave_type_name"],
                                    //       // "Casual Leave",
                                    //       style: TextStyle(
                                    //         fontSize: kTwelveFont,
                                    //         fontWeight: kFW500,
                                    //         color: Klightblack,

                                    //         /// Color(0xFF7E91AE),
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       height: 5.h,
                                    //     Text(
                                    //       "data",
                                    //       // balances.toList()[index].toList()[j]
                                    //       //         ["leaves"]
                                    //       //     ["no_of_every_months_name"],
                                    //       // balances.first[index]["leaves"]
                                    //       //     ["no_of_every_months_name"],

                                    //       // "Yearly",
                                    //       style: TextStyle(
                                    //         fontSize: kTwelveFont,
                                    //         fontWeight: kFW500,
                                    //         color: KCustomDarktwo,
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       height: 5.h,
                                    //     ),
                                    //     Text(
                                    //       "data",
                                    //       //     "${balances.toList()[index].toList()[j]["leaves"]["applied"]["respdata"]["pending"].toString()} / ${balances.toList()[index].toList()[j]["leaves"]["leaves_count"].toString()} Days",
                                    //       // "${balances.toList()[index].toList()[j]["leaves"]["leaves_count"] - balances.toList()[index].toList()[j]["leaves"]["applied"]["respdata"]["leaves_applied"]} / ${balances.toList()[index].toList()[j]["leaves"]["leaves_count"].toString()} Days",

                                    //       //   "28 / 30 Days",
                                    //       style: TextStyle(
                                    //         fontSize: kSixteenFont,
                                    //         fontWeight: kFW600,
                                    //         color: Klight,

                                    //         /// Color(0xFF7E91AE),
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       height: 15.h,
                                    //     ),
                                    //     Text(
                                    //       "data",
                                    //       //       "Utilized:${balances.toList()[index].toList()[j]["leaves"]["applied"]["respdata"]["leaves_applied"].toString()}",
                                    //       style: TextStyle(
                                    //         fontSize: kTwelveFont,
                                    //         fontWeight: kFW500,
                                    //         color: Klightblack,

                                    //         /// Color(0xFF7E91AE),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ),
                              ],
                            )
                            ////////////////////upto here
                          ],
                        );
                      }),

              /////////////////////////////////////
              // Container(
              //   margin:
              //       EdgeInsets.only(left: 25.w, top: 15.h),
              //   padding: EdgeInsets.all(10.r),
              //   decoration: BoxDecoration(
              //     color: selectedTheme == "Lighttheme"
              //         ? Kwhite
              //         : Kthemeblack,
              //     borderRadius: BorderRadius.circular(15.r),
              //     boxShadow: [
              //       BoxShadow(
              //         spreadRadius: 1.5,
              //         blurRadius: 3,
              //         offset: const Offset(0, 2),
              //         color: Ktextcolor.withOpacity(0.25),
              //       )
              //     ],
              //     // boxShadow: [
              //     //   BoxShadow(
              //     //     color: Ktextcolor.withOpacity(0.2),
              //     //     blurRadius: 5,
              //     //     offset: const Offset(0, 0),
              //     //     spreadRadius: 1, //New
              //     //   )
              //     // ],
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment:
              //         CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         balances.first[index]["leaves"]
              //             ["leave_type_name"],
              //         // "Casual Leave",
              //         style: TextStyle(
              //           fontSize: kTwelveFont,
              //           fontWeight: kFW500,
              //           color: Klightblack,

              //           /// Color(0xFF7E91AE),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 5.h,
              //       ),
              //       Text(
              //         balances.first[index]["leaves"]
              //             ["no_of_every_months_name"],

              //         //   "Yearly",
              //         style: TextStyle(
              //           fontSize: kTwelveFont,
              //           fontWeight: kFW500,
              //           color: KCustomDarktwo,
              //         ),
              //       ),
              //       SizedBox(
              //         height: 5.h,
              //       ),
              //       Text(
              //         "${balances.first[index]["leaves"]["leaves_count"] - balances.first[index]["leaves"]["applied"]["respdata"]["leaves_applied"]} / ${balances.first[index]["leaves"]["leaves_count"].toString()} Days",

              //         //  "28 / 30 Days",
              //         style: TextStyle(
              //           fontSize: kSixteenFont,
              //           fontWeight: kFW600,
              //           color: Klight,

              //           /// Color(0xFF7E91AE),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 15.h,
              //       ),
              //       Text(
              //         "Utilized:${balances.first[index]["leaves"]["applied"]["respdata"]["leaves_applied"].toString()}",
              //         style: TextStyle(
              //           fontSize: kTwelveFont,
              //           fontWeight: kFW500,
              //           color: Klightblack,

              //           /// Color(0xFF7E91AE),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

//                     ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: balances.first.length,
//                         // itemCount: balances.length,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: 20.h,
//                               ),
//                               Text(
//                                 "${balances.first[0]["period_from"].toString()} to ${balances.first[0]["period_to"].toString()}",
//                                 // balances.first[index].toString(),
//                                 //        [{1}, {2}, {3}], [{4}, {period_from: 2022-12-01, period_to: 2023-11-30}, {period_from: 2022-12-01, period_to: 2023-11-30}], [{period_from: 2022-12-01, period_to: 2022-11-30}, {period_from: 2022-12-01, period_to: 2022-11-30}, {period_from: 2022-12-01, period_to: 2022-11-30}], [{period_from: 2022-12-01, period_to: 2022-11-30}, {period_from: 2022-12-01, period_to: 2022-11-30}, {period_from: 2022-12-01, period_to: 2022-11-30}]
//                                 //balances.first.length.toString(),
//                                 // "data",
// // _Partition((balances.iterator))
//                                 ///  "${leavebalancesfilter[0]["period_from"] ?? "no data"} to ${leavebalancesfilter[0]["period_to"] ?? ""}",

//                                 // "Dec 01’23 - Nov 30’24",
//                                 style: TextStyle(
//                                   fontSize: kTwelveFont,
//                                   fontWeight: kFW700,
//                                   color: KCustomDarktwo,
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 20.h,
//                               ),
//                               Container(
//                                 padding: EdgeInsets.all(10.r),
//                                 decoration: BoxDecoration(
//                                   color: selectedTheme == "Lighttheme"
//                                       ? Kwhite
//                                       : Kthemeblack,
//                                   borderRadius: BorderRadius.circular(15.r),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       spreadRadius: 1.5,
//                                       blurRadius: 3,
//                                       offset: const Offset(0, 2),
//                                       color: Ktextcolor.withOpacity(0.25),
//                                     )
//                                   ],
//                                   // boxShadow: [
//                                   //   BoxShadow(
//                                   //     color: Ktextcolor.withOpacity(0.2),
//                                   //     blurRadius: 5,
//                                   //     offset: const Offset(0, 0),
//                                   //     spreadRadius: 1, //New
//                                   //   )
//                                   // ],
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       balances.first[index]["leaves"]
//                                           ["leave_type_name"],
//                                       // "Casual Leave",
//                                       style: TextStyle(
//                                         fontSize: kTwelveFont,
//                                         fontWeight: kFW500,
//                                         color: Klightblack,

//                                         /// Color(0xFF7E91AE),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 5.h,
//                                     ),
//                                     Text(
//                                       balances.first[index]["leaves"]
//                                           ["no_of_every_months_name"],

//                                       //   "Yearly",
//                                       style: TextStyle(
//                                         fontSize: kTwelveFont,
//                                         fontWeight: kFW500,
//                                         color: KCustomDarktwo,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 5.h,
//                                     ),
//                                     Text(
//                                       "${balances.first[index]["leaves"]["leaves_count"] - balances.first[index]["leaves"]["applied"]["respdata"]["leaves_applied"]} / ${balances.first[index]["leaves"]["leaves_count"].toString()} Days",

//                                       //  "28 / 30 Days",
//                                       style: TextStyle(
//                                         fontSize: kSixteenFont,
//                                         fontWeight: kFW600,
//                                         color: Klight,

//                                         /// Color(0xFF7E91AE),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15.h,
//                                     ),
//                                     Text(
//                                       "Utilized:${balances.first[index]["leaves"]["applied"]["respdata"]["leaves_applied"].toString()}",
//                                       style: TextStyle(
//                                         fontSize: kTwelveFont,
//                                         fontWeight: kFW500,
//                                         color: Klightblack,

//                                         /// Color(0xFF7E91AE),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               // Row(
//                               //   mainAxisAlignment:
//                               //       MainAxisAlignment.spaceAround,
//                               //   children: [
//                               //     Container(
//                               //       padding: EdgeInsets.all(10.r),
//                               //       decoration: BoxDecoration(
//                               //         color: selectedTheme == "Lighttheme"
//                               //             ? Kwhite
//                               //             : Kthemeblack,
//                               //         borderRadius: BorderRadius.circular(15.r),
//                               //         boxShadow: [
//                               //           BoxShadow(
//                               //             spreadRadius: 1.5,
//                               //             blurRadius: 3,
//                               //             offset: const Offset(0, 2),
//                               //             color: Ktextcolor.withOpacity(0.25),
//                               //           )
//                               //         ],
//                               //         // boxShadow: [
//                               //         //   BoxShadow(
//                               //         //     color: Ktextcolor.withOpacity(0.2),
//                               //         //     blurRadius: 5,
//                               //         //     offset: const Offset(0, 0),
//                               //         //     spreadRadius: 1, //New
//                               //         //   )
//                               //         // ],
//                               //       ),
//                               //       child: Column(
//                               //         mainAxisAlignment:
//                               //             MainAxisAlignment.start,
//                               //         crossAxisAlignment:
//                               //             CrossAxisAlignment.start,
//                               //         children: [
//                               //           Text(
//                               //             "Casual Leave",
//                               //             style: TextStyle(
//                               //               fontSize: kTwelveFont,
//                               //               fontWeight: kFW500,
//                               //               color: Klightblack,

//                               //               /// Color(0xFF7E91AE),
//                               //             ),
//                               //           ),
//                               //           SizedBox(
//                               //             height: 5.h,
//                               //           ),
//                               //           Text(
//                               //             "Yearly",
//                               //             style: TextStyle(
//                               //               fontSize: kTwelveFont,
//                               //               fontWeight: kFW500,
//                               //               color: KCustomDarktwo,
//                               //             ),
//                               //           ),
//                               //           SizedBox(
//                               //             height: 5.h,
//                               //           ),
//                               //           Text(
//                               //             "28 / 30 Days",
//                               //             style: TextStyle(
//                               //               fontSize: kSixteenFont,
//                               //               fontWeight: kFW600,
//                               //               color: Klight,

//                               //               /// Color(0xFF7E91AE),
//                               //             ),
//                               //           ),
//                               //           SizedBox(
//                               //             height: 15.h,
//                               //           ),
//                               //           Text(
//                               //             "Utilized: 02",
//                               //             style: TextStyle(
//                               //               fontSize: kTwelveFont,
//                               //               fontWeight: kFW500,
//                               //               color: Klightblack,

//                               //               /// Color(0xFF7E91AE),
//                               //             ),
//                               //           ),
//                               //         ],
//                               //       ),
//                               //     ),
//                               //     Container(
//                               //       padding: EdgeInsets.all(10.r),
//                               //       decoration: BoxDecoration(
//                               //         color: selectedTheme == "Lighttheme"
//                               //             ? Kwhite
//                               //             : Kthemeblack,
//                               //         borderRadius: BorderRadius.circular(15.r),
//                               //         boxShadow: [
//                               //           BoxShadow(
//                               //             spreadRadius: 1.5,
//                               //             blurRadius: 3,
//                               //             offset: const Offset(0, 2),
//                               //             color: Ktextcolor.withOpacity(0.25),
//                               //           )
//                               //         ],
//                               //         // boxShadow: [
//                               //         //   BoxShadow(
//                               //         //     color: Ktextcolor.withOpacity(0.2),
//                               //         //     blurRadius: 5,
//                               //         //     offset: const Offset(0, 0),
//                               //         //     spreadRadius: 1, //New
//                               //         //   )
//                               //         // ],
//                               //       ),
//                               //       child: Column(
//                               //         mainAxisAlignment:
//                               //             MainAxisAlignment.start,
//                               //         crossAxisAlignment:
//                               //             CrossAxisAlignment.start,
//                               //         children: [
//                               //           Text(
//                               //             "Casual Leave",
//                               //             style: TextStyle(
//                               //               fontSize: kTwelveFont,
//                               //               fontWeight: kFW500,
//                               //               color: Klightblack,

//                               //               /// Color(0xFF7E91AE),
//                               //             ),
//                               //           ),
//                               //           SizedBox(
//                               //             height: 5.h,
//                               //           ),
//                               //           Text(
//                               //             "Yearly",
//                               //             style: TextStyle(
//                               //               fontSize: kTwelveFont,
//                               //               fontWeight: kFW500,
//                               //               color: KCustomDarktwo,
//                               //             ),
//                               //           ),
//                               //           SizedBox(
//                               //             height: 5.h,
//                               //           ),
//                               //           Text(
//                               //             "28 / 30 Days",
//                               //             style: TextStyle(
//                               //               fontSize: kSixteenFont,
//                               //               fontWeight: kFW600,
//                               //               color: Klight,

//                               //               /// Color(0xFF7E91AE),
//                               //             ),
//                               //           ),
//                               //           SizedBox(
//                               //             height: 15.h,
//                               //           ),
//                               //           Text(
//                               //             "Utilized: 02",
//                               //             style: TextStyle(
//                               //               fontSize: kTwelveFont,
//                               //               fontWeight: kFW500,
//                               //               color: Klightblack,

//                               //               /// Color(0xFF7E91AE),
//                               //             ),
//                               //           ),
//                               //         ],
//                               //       ),
//                               //     ),
//                               //   ],
//                               // ),
//                               // SizedBox(
//                               //   height: 20.h,
//                               // ),
//                               // Container(
//                               //   margin: EdgeInsets.only(left: 18.w),
//                               //   padding: EdgeInsets.all(10.r),
//                               //   decoration: BoxDecoration(
//                               //     color: selectedTheme == "Lighttheme"
//                               //         ? Kwhite
//                               //         : Kthemeblack,
//                               //     borderRadius: BorderRadius.circular(15.r),
//                               //     boxShadow: [
//                               //       BoxShadow(
//                               //         spreadRadius: 1.5,
//                               //         blurRadius: 3,
//                               //         offset: const Offset(0, 2),
//                               //         color: Ktextcolor.withOpacity(0.25),
//                               //       )
//                               //     ],
//                               //     // boxShadow: [
//                               //     //   BoxShadow(
//                               //     //     color: Ktextcolor.withOpacity(0.2),
//                               //     //     blurRadius: 5,
//                               //     //     offset: const Offset(0, 0),
//                               //     //     spreadRadius: 1, //New
//                               //     //   )
//                               //     // ],
//                               //   ),
//                               //   child: Column(
//                               //     mainAxisAlignment: MainAxisAlignment.start,
//                               //     crossAxisAlignment: CrossAxisAlignment.start,
//                               //     children: [
//                               //       Text(
//                               //         "Casual Leave",
//                               //         style: TextStyle(
//                               //           fontSize: kTwelveFont,
//                               //           fontWeight: kFW500,
//                               //           color: Klightblack,

//                               //           /// Color(0xFF7E91AE),
//                               //         ),
//                               //       ),
//                               //       SizedBox(
//                               //         height: 5.h,
//                               //       ),
//                               //       Text(
//                               //         "Yearly",
//                               //         style: TextStyle(
//                               //           fontSize: kTwelveFont,
//                               //           fontWeight: kFW500,
//                               //           color: KCustomDarktwo,
//                               //         ),
//                               //       ),
//                               //       SizedBox(
//                               //         height: 5.h,
//                               //       ),
//                               //       Text(
//                               //         "28 / 30 Days",
//                               //         style: TextStyle(
//                               //           fontSize: kSixteenFont,
//                               //           fontWeight: kFW600,
//                               //           color: Klight,

//                               //           /// Color(0xFF7E91AE),
//                               //         ),
//                               //       ),
//                               //       SizedBox(
//                               //         height: 15.h,
//                               //       ),
//                               //       Text(
//                               //         "Utilized: 02",
//                               //         style: TextStyle(
//                               //           fontSize: kTwelveFont,
//                               //           fontWeight: kFW500,
//                               //           color: Klightblack,

//                               //           /// Color(0xFF7E91AE),
//                               //         ),
//                               //       ),
//                               //     ],
//                               //   ),
//                               // ),
//                             ],
//                           );
//                         })

//                 Column(children: [
//                     ////////Anual Leaves

//                     Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(13.r)),
//                         child: Card(
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(13.r)),
//                             color: KlightRed.withOpacity(0.8),
//                             child: Theme(
//                                 data: Theme.of(context)
//                                     .copyWith(dividerColor: Colors.transparent),
//                                 child: ExpansionTile(
//                                   title: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(
//                                         height: 5.h,
//                                       ),
//                                       Text(
//                                         "Total  ${leavebalances[0]["LeaveType"]["leave_type_name"]}s" ??
//                                             "",
//                                         style: TextStyle(
//                                           fontSize: kTwelveFont,
//                                           fontWeight: kFW600,
//                                           color: Kwhite,
//                                           letterSpacing: 0.5,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 5.h,
//                                       ),
//                                       Text(
//                                         leavebalances[0]["leaves_count"]
//                                                 .toString() ??
//                                             "",

//                                         // leavesController.myLeaveBalance["anual_eaves"]
//                                         //         ["anual_applied"]
//                                         //     .toString(),
//                                         style: TextStyle(
//                                           fontSize: kFourteenFont,
//                                           fontWeight: kFW900,
//                                           color: Kwhite,
//                                           letterSpacing: 0.5,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   children: [
//                                     SizedBox(
//                                       height: 5.h,
//                                     ),
//                                     const Divider(),
//                                     SizedBox(
//                                       height: 5.h,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.all(8.r),
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Utilized Leaves",
//                                                 //  "Approved Annual Leaves",
//                                                 style: TextStyle(
//                                                   fontSize: 11.sp,
//                                                   fontWeight: kFW600,
//                                                   color: Kwhite,
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 leavebalances[0][
//                                                             "utilized_LeaveDays"]
//                                                         .toString() ??
//                                                     "",
//                                                 // leavesController
//                                                 //     .myLeaveBalance["anual_eaves"]
//                                                 //         ["anual_approved"]
//                                                 //     .toString(),
//                                                 style: TextStyle(
//                                                   fontSize: kTwelveFont,
//                                                   fontWeight: kFW600,
//                                                   color: Kwhite,
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 5.h,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Inprogress Leaves",
//                                                 //   "Pending Annual Leaves",
//                                                 style: TextStyle(
//                                                   fontSize: 11.sp,
//                                                   fontWeight: kFW600,
//                                                   color: Kwhite,
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 leavebalances[0][
//                                                             "Inprogress_LeaveDays"]
//                                                         .toString() ??
//                                                     "",
//                                                 // leavesController
//                                                 //     .myLeaveBalance["anual_eaves"]
//                                                 //         ["anual_pending"]
//                                                 //     .toString(),
//                                                 style: TextStyle(
//                                                   fontSize: kTwelveFont,
//                                                   fontWeight: kFW600,
//                                                   color: Kwhite,
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 5.h,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Rejected Leaves",
//                                                 //    "Rejected Annual Leaves",
//                                                 style: TextStyle(
//                                                   fontSize: 11.sp,
//                                                   fontWeight: kFW600,
//                                                   color: Kwhite,
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 leavebalances[0][
//                                                             "Rejected_LeaveDays"]
//                                                         .toString() ??
//                                                     "",
//                                                 // leavesController
//                                                 //     .myLeaveBalance["anual_eaves"]
//                                                 //         ["anual_rejected"]
//                                                 //     .toString(),
//                                                 style: TextStyle(
//                                                   fontSize: kTwelveFont,
//                                                   fontWeight: kFW600,
//                                                   color: Kwhite,
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           // SizedBox(
//                                           //   height: 5.h,
//                                           // ),
//                                           // Row(
//                                           //   mainAxisAlignment:
//                                           //       MainAxisAlignment.spaceBetween,
//                                           //   children: [
//                                           //     Text(
//                                           //       "Cancelled Annual Leaves",
//                                           //       style: TextStyle(
//                                           //         fontSize: 11.sp,
//                                           //         fontWeight: kFW600,
//                                           //         color: Kwhite,
//                                           //         letterSpacing: 0.5,
//                                           //       ),
//                                           //     ),
//                                           //     Text(
//                                           //       leavesController
//                                           //           .myLeaveBalance["anual_eaves"]
//                                           //               ["anual_cancelled"]
//                                           //           .toString(),
//                                           //       style: TextStyle(
//                                           //         fontSize: kTwelveFont,
//                                           //         fontWeight: kFW600,
//                                           //         color: Kwhite,
//                                           //         letterSpacing: 0.5,
//                                           //       ),
//                                           //     )
//                                           //   ],
//                                           // ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 )))),

// ////Sick leaves
//                     Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(13.r)),
//                         child: Card(
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(13.r)),
//                             color: Klightpuple.withOpacity(0.8),
//                             child: Theme(
//                                 data: Theme.of(context)
//                                     .copyWith(dividerColor: Colors.transparent),
//                                 child: ExpansionTile(
//                                   title: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(
//                                         height: 5.h,
//                                       ),
//                                       Text(
//                                         "Total  ${leavebalances[1]["LeaveType"]["leave_type_name"]}s" ??
//                                             "",
//                                         //   "Total Applied Sick Leaves ",
//                                         style: TextStyle(
//                                           fontSize: kTwelveFont,
//                                           fontWeight: kFW600,
//                                           color: Kwhite,
//                                           letterSpacing: 0.5,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 5.h,
//                                       ),
//                                       Text(
//                                         leavebalances[1]["leaves_count"]
//                                                 .toString() ??
//                                             "",
//                                         // leavesController.myLeaveBalance["sick_leaves"]
//                                         //         ["sick_applied"]
//                                         //     .toString(),
//                                         style: TextStyle(
//                                           fontSize: kFourteenFont,
//                                           fontWeight: kFW900,
//                                           color: Kwhite.withOpacity(0.8),
//                                           letterSpacing: 0.5,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   children: [
//                                     SizedBox(
//                                       height: 5.h,
//                                     ),
//                                     const Divider(),
//                                     SizedBox(
//                                       height: 5.h,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.all(8.r),
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Utilized Leaves",
//                                                 //  "Approved Sick Leaves",
//                                                 style: TextStyle(
//                                                   fontSize: 11.sp,
//                                                   fontWeight: kFW600,
//                                                   color: Kwhite,
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 leavebalances[1][
//                                                             "utilized_LeaveDays"]
//                                                         .toString() ??
//                                                     "",
//                                                 // leavesController
//                                                 //     .myLeaveBalance["sick_leaves"]
//                                                 //         ["sick_approved"]
//                                                 //     .toString(),
//                                                 style: TextStyle(
//                                                   fontSize: kTwelveFont,
//                                                   fontWeight: kFW600,
//                                                   color: Kwhite,
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 5.h,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Inprogress Leaves",
//                                                 //   "Pending Sick Leaves",
//                                                 style: TextStyle(
//                                                   fontSize: 11.sp,
//                                                   fontWeight: kFW600,
//                                                   color: Kwhite,
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 leavebalances[1][
//                                                             "Inprogress_LeaveDays"]
//                                                         .toString() ??
//                                                     "",
//                                                 // leavesController
//                                                 //     .myLeaveBalance["sick_leaves"]
//                                                 //         ["sick_pending"]
//                                                 //     .toString(),
//                                                 style: TextStyle(
//                                                   fontSize: kTwelveFont,
//                                                   fontWeight: kFW600,
//                                                   color: Kwhite,
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 5.h,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Rejected Leaves",
//                                                 //  "Rejected Sick Leaves",
//                                                 style: TextStyle(
//                                                   fontSize: 11.sp,
//                                                   fontWeight: kFW600,
//                                                   color: Kwhite,
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 leavebalances[1][
//                                                             "Rejected_LeaveDays"]
//                                                         .toString() ??
//                                                     "",
//                                                 // leavesController
//                                                 //     .myLeaveBalance["sick_leaves"]
//                                                 //         ["sick_rejected"]
//                                                 //     .toString(),
//                                                 style: TextStyle(
//                                                   fontSize: kTwelveFont,
//                                                   fontWeight: kFW600,
//                                                   color: Kwhite,
//                                                   letterSpacing: 0.5,
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           // SizedBox(
//                                           //   height: 5.h,
//                                           // ),
//                                           // Row(
//                                           //   mainAxisAlignment:
//                                           //       MainAxisAlignment.spaceBetween,
//                                           //   children: [
//                                           //     Text(
//                                           //       "Cancelled Sick Leaves",
//                                           //       style: TextStyle(
//                                           //         fontSize: 11.sp,
//                                           //         fontWeight: kFW600,
//                                           //         color: Kwhite,
//                                           //         letterSpacing: 0.5,
//                                           //       ),
//                                           //     ),
//                                           //     Text(
//                                           //       leavesController
//                                           //           .myLeaveBalance["sick_leaves"]
//                                           //               ["sick_cancelled"]
//                                           //           .toString(),
//                                           //       style: TextStyle(
//                                           //         fontSize: kTwelveFont,
//                                           //         fontWeight: kFW600,
//                                           //         color: Kwhite,
//                                           //         letterSpacing: 0.5,
//                                           //       ),
//                                           //     )
//                                           //   ],
//                                           // ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 )))),
//                     // casual leaves
//                     leavebalances.length <= 2
//                         ? SizedBox()
//                         : Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(13.r)),
//                             child: Card(
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(13.r)),
//                                 color: Kgreen.withOpacity(0.8),
//                                 child: Theme(
//                                     data: Theme.of(context).copyWith(
//                                         dividerColor: Colors.transparent),
//                                     child: ExpansionTile(
//                                       title: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                             height: 5.h,
//                                           ),
//                                           Text(
//                                             "Total  ${leavebalances[2]["LeaveType"]["leave_type_name"]}s" ??
//                                                 "",
//                                             //   "Total Applied Sick Leaves ",
//                                             style: TextStyle(
//                                               fontSize: kTwelveFont,
//                                               fontWeight: kFW600,
//                                               color: Kwhite,
//                                               letterSpacing: 0.5,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 5.h,
//                                           ),
//                                           Text(
//                                             leavebalances[2]["leaves_count"]
//                                                     .toString() ??
//                                                 "",
//                                             // leavesController.myLeaveBalance["sick_leaves"]
//                                             //         ["sick_applied"]
//                                             //     .toString(),
//                                             style: TextStyle(
//                                               fontSize: kFourteenFont,
//                                               fontWeight: kFW900,
//                                               color: Kwhite.withOpacity(0.8),
//                                               letterSpacing: 0.5,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       children: [
//                                         SizedBox(
//                                           height: 5.h,
//                                         ),
//                                         const Divider(),
//                                         SizedBox(
//                                           height: 5.h,
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.all(8.r),
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "Utilized Leaves",
//                                                     //  "Approved Sick Leaves",
//                                                     style: TextStyle(
//                                                       fontSize: 11.sp,
//                                                       fontWeight: kFW600,
//                                                       color: Kwhite,
//                                                       letterSpacing: 0.5,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     leavebalances[2][
//                                                                 "utilized_LeaveDays"]
//                                                             .toString() ??
//                                                         "",
//                                                     // leavesController
//                                                     //     .myLeaveBalance["sick_leaves"]
//                                                     //         ["sick_approved"]
//                                                     //     .toString(),
//                                                     style: TextStyle(
//                                                       fontSize: kTwelveFont,
//                                                       fontWeight: kFW600,
//                                                       color: Kwhite,
//                                                       letterSpacing: 0.5,
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 5.h,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "Inprogress Leaves",
//                                                     //   "Pending Sick Leaves",
//                                                     style: TextStyle(
//                                                       fontSize: 11.sp,
//                                                       fontWeight: kFW600,
//                                                       color: Kwhite,
//                                                       letterSpacing: 0.5,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     leavebalances[2][
//                                                                 "Inprogress_LeaveDays"]
//                                                             .toString() ??
//                                                         "",
//                                                     // leavesController
//                                                     //     .myLeaveBalance["sick_leaves"]
//                                                     //         ["sick_pending"]
//                                                     //     .toString(),
//                                                     style: TextStyle(
//                                                       fontSize: kTwelveFont,
//                                                       fontWeight: kFW600,
//                                                       color: Kwhite,
//                                                       letterSpacing: 0.5,
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 5.h,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "Rejected Leaves",
//                                                     //  "Rejected Sick Leaves",
//                                                     style: TextStyle(
//                                                       fontSize: 11.sp,
//                                                       fontWeight: kFW600,
//                                                       color: Kwhite,
//                                                       letterSpacing: 0.5,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     leavebalances[2][
//                                                                 "Rejected_LeaveDays"]
//                                                             .toString() ??
//                                                         "",
//                                                     // leavesController
//                                                     //     .myLeaveBalance["sick_leaves"]
//                                                     //         ["sick_rejected"]
//                                                     //     .toString(),
//                                                     style: TextStyle(
//                                                       fontSize: kTwelveFont,
//                                                       fontWeight: kFW600,
//                                                       color: Kwhite,
//                                                       letterSpacing: 0.5,
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                               // SizedBox(
//                                               //   height: 5.h,
//                                               // ),
//                                               // Row(
//                                               //   mainAxisAlignment:
//                                               //       MainAxisAlignment.spaceBetween,
//                                               //   children: [
//                                               //     Text(
//                                               //       "Cancelled Sick Leaves",
//                                               //       style: TextStyle(
//                                               //         fontSize: 11.sp,
//                                               //         fontWeight: kFW600,
//                                               //         color: Kwhite,
//                                               //         letterSpacing: 0.5,
//                                               //       ),
//                                               //     ),
//                                               //     Text(
//                                               //       leavesController
//                                               //           .myLeaveBalance["sick_leaves"]
//                                               //               ["sick_cancelled"]
//                                               //           .toString(),
//                                               //       style: TextStyle(
//                                               //         fontSize: kTwelveFont,
//                                               //         fontWeight: kFW600,
//                                               //         color: Kwhite,
//                                               //         letterSpacing: 0.5,
//                                               //       ),
//                                               //     )
//                                               //   ],
//                                               // ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     )))),
//                   ]),
            ),
          )),
    );
  }
}
