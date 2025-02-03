// ignore_for_file: camel_case_types, unused_field

import '../../untils/export_file.dart';

class Time_sheet_report extends StatefulWidget {
  const Time_sheet_report({super.key});

  @override
  State<Time_sheet_report> createState() => _Time_sheet_reportState();
}

class _Time_sheet_reportState extends State<Time_sheet_report> {
  DateTime? selectedDate;
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  var startTime = Get.arguments["starttime"];
  var endtime = Get.arguments["endtime"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomButton(
          margin: const EdgeInsets.all(15),
          height: 38.h,
          width: double.infinity,
          textColor: Kwhite,
          borderRadius: BorderRadius.circular(20.r),
          Color: KOrange,
          fontSize: 13.sp,
          fontWeight: kFW600,
          label: "Download Timesheet",
          isLoading: false,
          onTap: () {
            if (_formKey.currentState!.validate()) {
              Get.back();
            }
          }),
      backgroundColor: Kbackground,
      appBar: const VibhoAppBar(
        bColor: Kbackground,
        title: 'Timesheet Report',
        dontHaveBackAsLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.all(13.r),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Container(
                //   padding: EdgeInsets.all(10.r),
                //   // alignment: Alignment.center,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(16.r),
                //     color: Kwhite,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Ktextcolor.withOpacity(0.09),
                //         offset: const Offset(
                //           1,
                //           1,
                //         ),
                //         blurRadius: 16.r,
                //         spreadRadius: 0.5,
                //       )
                //     ],
                //   ),

                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Row(
                //         children: [
                //           Container(
                //             width: 130.w,
                //             // margin: EdgeInsets.only(left: 20.w, top: 10.h),
                //             padding: EdgeInsets.only(
                //                 right: 15.w, left: 15.w, top: 5.h, bottom: 5.h),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(10.r),
                //                 color: Kbackground),
                //             child: Text(
                //                 _range.length == 0
                //                     ? "Select Date"
                                    // : DateFormat('yyyy-MMM-dd').format(
                                    //     DateTime.parse(
                //                             _range.toString().split(" - ")[0])),
                //                 //  _range.toString().split(" - ")[0],

                //                 style: TextStyle(
                //                     fontSize: 13.sp,
                //                     fontWeight: kFW500,
                //                     color: Klightblack.withOpacity(0.8))),
                //           ),
                //           SizedBox(width: 5.w),
                //           Container(
                //             width: 130.w,
                //             // margin: EdgeInsets.only(left: 20.w, top: 10.h),
                //             padding: EdgeInsets.only(
                //                 right: 15.w, left: 15.w, top: 5.h, bottom: 5.h),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(10.r),
                //                 color: Kbackground),
                //             child: Text(
                //                 //"02/07/2023",
                //                 _range.length == 0
                //                     ? "Select Date"
                //                     : DateFormat('yyyy-MMM-dd').format(
                //                         DateTime.parse(
                //                             _range.toString().split(" - ")[1])),
                //                 //_range.toString().split(" - ")[1],

                //                 style: TextStyle(
                //                     fontSize: 13.sp,
                //                     fontWeight: kFW500,
                //                     color: Klightblack.withOpacity(0.8))),
                //           ),
                //         ],
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return AlertDialog(
                //                     title: Text(''),
                //                     content: Container(
                //                       height: 350,
                //                       child: Column(
                //                         children: <Widget>[
                //                           RangePickerDialog(),
                //                           MaterialButton(
                //                             child: Text("OK"),
                //                             onPressed: () {
                //                               Navigator.pop(context);
                //                             },
                //                           )
                //                         ],
                //                       ),
                //                     ));
                //               });
                //         },
                //         child: Image.asset(
                //           "assets/images/Group.png",
                //           width: 23.w,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Kwhite,
                    boxShadow: [
                      BoxShadow(
                        color: Ktextcolor.withOpacity(0.09),
                        offset: const Offset(
                          1,
                          1,
                        ),
                        blurRadius: 16.r,
                        spreadRadius: 0.5,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text("02",
                      //             style: TextStyle(
                      //                 fontSize: kEighteenFont,
                      //                 fontWeight: kFW700,
                      //                 color: KCustomDark)),
                      //         SizedBox(
                      //           height: 5.h,
                      //         ),
                      //         Text("Jul 2023",
                      //             style: TextStyle(
                      //                 fontSize: kFourteenFont,
                      //                 fontWeight: kFW700,
                      //                 color: KCustomDarktwo)),
                      //       ],
                      //     ),
                      //     Container(
                      //       width: 220.w,
                      //       height: 30.h,
                      //       margin: EdgeInsets.only(left: 5.w, right: 5.h),
                      //       padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(5.r),
                      //           color: Kbackground),
                      //       child: ListView.builder(
                      //           // itemCount: 1,
                      //           itemCount: 8,
                      //           scrollDirection: Axis.horizontal,
                      //           shrinkWrap: true,
                      //           physics: AlwaysScrollableScrollPhysics(),
                      //           itemBuilder: ((context, index) {
                      //             return Container(
                      //               margin: EdgeInsets.only(left: 15.w),
                      //               child: Text(" 02",
                      //                   style: TextStyle(
                      //                       fontSize: kTwelveFont,
                      //                       fontWeight: kFW600,
                      //                       color: KCustomDarktwo)),
                      //             );
                      //           })),

                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Normal Hours Worked",
                                  style: TextStyle(
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW500,
                                      color: Klightblack)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("08 Hrs",
                                  style: TextStyle(
                                      fontSize: kFourteenFont,
                                      fontWeight: kFW700,
                                      color: KdarkText)),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Over Time",
                                  style: TextStyle(
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW500,
                                      color: Klightblack)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("20 Hrs",
                                  style: TextStyle(
                                      fontSize: kFourteenFont,
                                      fontWeight: kFW700,
                                      color: KdarkText)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Others",
                                  style: TextStyle(
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW500,
                                      color: Klightblack)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("05 Hrs",
                                  style: TextStyle(
                                      fontSize: kFourteenFont,
                                      fontWeight: kFW700,
                                      color: KdarkText)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Sick Leave",
                                  style: TextStyle(
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW500,
                                      color: Klightblack)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("20 Hrs",
                                  style: TextStyle(
                                      fontSize: kFourteenFont,
                                      fontWeight: kFW700,
                                      color: Klightblack)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Public Leave",
                                  style: TextStyle(
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW500,
                                      color: Klightblack)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("05 Hrs",
                                  style: TextStyle(
                                      fontSize: kFourteenFont,
                                      fontWeight: kFW700,
                                      color: Klightblack)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Annual Leave",
                                  style: TextStyle(
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW500,
                                      color: Klightblack)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text("20 Hrs",
                                  style: TextStyle(
                                      fontSize: kFourteenFont,
                                      fontWeight: kFW700,
                                      color: Klightblack)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Remarks",
                              style: TextStyle(
                                  fontSize: kTwelveFont,
                                  fontWeight: kFW500,
                                  color: Klightblack)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text("Good",
                              style: TextStyle(
                                  fontSize: kFourteenFont,
                                  fontWeight: kFW700,
                                  color: KdarkText)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
