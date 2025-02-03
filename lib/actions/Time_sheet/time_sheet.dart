// ignore_for_file: camel_case_types, unused_field

import '../../untils/export_file.dart';

class Time_sheet extends StatefulWidget {
  const Time_sheet({super.key});

  @override
  State<Time_sheet> createState() => _Time_sheetState();
}

class _Time_sheetState extends State<Time_sheet> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  downloadTimeSheet(String selectedDateTime) async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.downloadTimeSheet(selectedDateTime);

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      timesheetdata = data["paslip"];
    }
    setState(() {
      isLoading = false;
    });
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${args.value.startDate} -'
            // ignore: lines_longer_than_80_chars
            ' ${args.value.endDate ?? args.value.startDate}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  DateTime? selectedDate;
  Map timesheetdata = {};
  Future timesheetHandler(DateTime selectedDate) async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.timesheet(selectedDate);

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      timesheetdata = data["paslip"];
    }
    setState(() {
      isLoading = false;
    });
  }

  Map profile = {};
  Future getProfile() async {
    profile = await Services.employeeprofile();
  }

  setUpFileDownload() async {}

  @override
  void initState() {
    setUpFileDownload();
    getProfile();
    super.initState();
  }

  final String INFOS = 'assets/images/info.svg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: CustomButton(
      //     margin: EdgeInsets.all(15),
      //     height: 38.h,
      //     width: double.infinity,
      //     textColor: Kwhite,
      //     borderRadius: BorderRadius.circular(20.r),
      //     Color: KOrange,
      //     fontSize: 13.sp,
      //     fontWeight: kFW600,
      //     label: "Submit Timesheet",
      //     isLoading: false,
      //     onTap: () async {
      //       if (_formKey.currentState!.validate()) {
      //         final Directory tempDir = await getTemporaryDirectory();
      //         FileDownloader.downloadFile(
      //             url:
      //                 "$KSubDomainURL/welcome/download_pdf_post/${_range.toString().split(' - ')[0].split(' ')[0]}/${_range.toString().split(' - ')[1].split(' ')[0]}/Normal/8",
      //             name: "PANDA",
      //             onDownloadCompleted: (path) {
      //               final File file = File(path);
      //               //This will be the path of the downloaded file
      //             });
      //         // Get.to(TimeSheetWebView(url: "$KSubDomainURL/welcome/download_pdf_post/${_range.toString().split(' - ')[0].split(' ')[0]}/${_range.toString().split(' - ')[1].split(' ')[0]}/Normal/8",));
      //         // downloadTimeSheet(_range);
      //         // Get.toNamed(KTimeSheet_Report, arguments: {
      //         //   "starttime": DateFormat('yyyy-MMM-dd').format(DateTime.parse(
      //         //       // ignore: unnecessary_string_interpolations
      //         //       _range.toString().split(" - ")[0])),
      //         //   "endtime":
      //         //       "${DateFormat('yyyy-MMM-dd').format(DateTime.parse(_range.toString().split(" - ")[1]))}"
      //         // });
      //       }
      //     }),
      backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      appBar: VibhoAppBar(
        bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        title: 'Timesheet',
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
                //     boxShadow: [
                //       BoxShadow(
                //         spreadRadius: 2,
                //         blurRadius: 10,
                //         offset: Offset(0, 6),
                //         color: Ktextcolor.withOpacity(0.2),
                //       )
                //     ],
                //     borderRadius: BorderRadius.circular(16.r),
                //     color: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
                //   ),
                //   // height: 40.h,
                //   // width: double.infinity,
                //   // decoration: BoxDecoration(
                //   //     borderRadius: BorderRadius.circular(10.r),
                //   //     boxShadow: [
                //   //       BoxShadow(
                //   //         color: Ktextcolor.withOpacity(0.09),
                //   //         offset: const Offset(
                //   //           1,
                //   //           1,
                //   //         ),
                //   //         blurRadius: 20.0,
                //   //         spreadRadius: 0.5,
                //   //       )
                //   //     ]),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       // Row(
                //       //   children: [
                //       //     Container(
                //       //       width: 150.w,
                //       //       // margin: EdgeInsets.only(left: 20.w, top: 10.h),
                //       //       padding: EdgeInsets.only(
                //       //           right: 10.w, left: 10.w, top: 5.h, bottom: 5.h),
                //       //       decoration: BoxDecoration(
                //       //           borderRadius: BorderRadius.circular(10.r),
                //       //           color: Kbackground),
                //       //       child: Text(
                //       //           _range.length == 0
                //       //               ? "Select Date"
                //       //               : DateFormat('yyyy-MMM-dd').format(
                //       //                   DateTime.parse(
                //       //                       _range.toString().split(" - ")[0])),
                //       //           //  _range.toString().split(" - ")[0],
                //       //           textAlign: TextAlign.center,
                //       //           style: TextStyle(
                //       //               fontSize: 13.sp,
                //       //               fontWeight:
                //       //                   _range.length == 0 ? kFW500 : kFW700,
                //       //               color: _range.length == 0
                //       //                   ? Klightblack.withOpacity(0.8)
                //       //                   : kblack)),
                //       //     ),
                //       //     SizedBox(width: 12.w),
                //       //     Container(
                //       //       width: 150.w,
                //       //       // margin: EdgeInsets.only(left: 20.w, top: 10.h),
                //       //       padding: EdgeInsets.only(
                //       //           right: 10.w, left: 10.w, top: 5.h, bottom: 5.h),
                //       //       decoration: BoxDecoration(
                //       //           borderRadius: BorderRadius.circular(10.r),
                //       //           color: Kbackground),
                //       //       child: Text(
                //       //           //"02/07/2023",
                //       //           _range.length == 0
                //       //               ? "Select Date"
                //       //               : DateFormat('yyyy-MMM-dd').format(
                //       //                   DateTime.parse(
                //       //                       _range.toString().split(" - ")[1])),
                //       //           //_range.toString().split(" - ")[1],
                //       //           textAlign: TextAlign.center,
                //       //           style: TextStyle(
                //       //               fontSize: 13.sp,
                //       //               fontWeight:
                //       //                   _range.length == 0 ? kFW500 : kFW700,
                //       //               //   color: Klightblack.withOpacity(0.8),
                //       //               color: _range.length == 0
                //       //                   ? Klightblack.withOpacity(0.8)
                //       //                   : kblack)),
                //       //     ),
                //       //   ],
                //       // ),
                //       // Image.asset(
                //       //   "assets/images/Group.png",
                //       //   width: 20.w,
                //       // ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                          color: Ktextcolor.withOpacity(0.2),
                        )
                      ],
                      color: Kwhite,
                    ),
                    child: SfDateRangePicker(
                      maxDate: DateTime.now(),
                      enablePastDates: true,

                      startRangeSelectionColor: KOrange,
                      selectionColor: KOrange,
                      rangeSelectionColor: KOrange.withOpacity(0.3),
                      endRangeSelectionColor: KOrange,
                      view: DateRangePickerView.month,
                      // initialDisplayDate:
                      onSelectionChanged: _onSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.range,
                    )),
                SizedBox(
                  height: 20.h,
                ),
                /////////////////////////////
                // Container(
                //   padding: EdgeInsets.all(10.r),
                //   // alignment: Alignment.center,
                //   decoration: BoxDecoration(
                //     boxShadow: [
                //       BoxShadow(
                //         spreadRadius: 2,
                //         blurRadius: 10,
                //         offset: Offset(0, 6),
                //         color: Ktextcolor.withOpacity(0.2),
                //       )
                //     ],
                //     borderRadius: BorderRadius.circular(16.r),
                //     color: Kwhite,
                //   ),

                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       SvgPicture.asset(
                //         INFOS,
                //         color: KBrown,
                //       ),
                //       SizedBox(
                //         width: 10.w,
                //       ),
                //       Text(
                //         //DateFormat('hh:mm a').format(DateTime.now()),

                //         "Select Start and End date to see TimeSheet",
                //         style: TextStyle(
                //             fontSize: 10.sp, fontWeight: kFW400, color: KBrown),
                //       ),
                //     ],
                //   ),
                // ),
                /////////////////////////////
                SizedBox(
                  height: 100.h,
                ),
                CustomButton(
                    //  margin: EdgeInsets.all(15),
                    height: 38.h,
                    width: double.infinity,
                    textColor: Kwhite,
                    borderRadius: BorderRadius.circular(20.r),
                    Color: KOrange,
                    fontSize: 13.sp,
                    fontWeight: kFW600,
                    label: "View Timesheet",
                    isLoading: false,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        // final Directory tempDir = await getTemporaryDirectory();
                        // FileDownloader.downloadFile(
                        //     url:
                        //         "$KSubDomainURL/welcome/download_pdf_post/${_range.toString().split(' - ')[0].split(' ')[0]}/${_range.toString().split(' - ')[1].split(' ')[0]}/Normal/8",
                        //     name: "PANDA",
                        //     onDownloadCompleted: (path) {
                        //       final File file = File(path);
                        //       //This will be the path of the downloaded file
                        //     });
                        var data = await Get.to(TimeSheetWebView(
                          url:
                              "$KWebURL/welcome/download_pdf_post/${_range.toString().split(' - ')[0].split(' ')[0]}/${_range.toString().split(' - ')[1].split(' ')[0]}/Normal/${profile["emp_id"]}",
                          name:
                              "Timesheet-${_range.toString().split(' - ')[0].toString().split(' ')[0]}",
                        ));

                        // if (data != null) {
                        //   if (data["error"] == "No Data Fount") {
                        //     _showMyDialog();
                        //   } else {
                        //     _showMyDialog();
                        //   }
                        // }
                        if (data != null) {
                          if (data["error"] == "No Data Fount") {
                            _showMyDialog();
                          }
                        }

                        // downloadTimeSheet(_range);
                        // Get.toNamed(KTimeSheet_Report, arguments: {
                        //   "starttime": DateFormat('yyyy-MMM-dd').format(DateTime.parse(
                        //       // ignore: unnecessary_string_interpolations
                        //       _range.toString().split(" - ")[0])),
                        //   "endtime":
                        //       "${DateFormat('yyyy-MMM-dd').format(DateTime.parse(_range.toString().split(" - ")[1]))}"
                        // });
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 240.h,

              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              // margin: EdgeInsets.only(left: .w,right: 20.w
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Image.asset(
                    "assets/images/sheet.png",
                    color: KOrange,
                    width: 50.w,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('TimeSheet',
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: 14.sp,
                          fontWeight: kFW900)),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                      'Timesheet is Not Availabe in between ${_range.toString().split(' - ')[0].split(' ')[0]} and ${_range.toString().split(' - ')[1].split(' ')[0]} dates',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: kTenFont,
                          fontWeight: kFW500)),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Custom_OutlineButton(
                      //     borderRadius: BorderRadius.circular(15.r),
                      //     margin: EdgeInsets.all(10.r),
                      //     width: 110.w,
                      //     height: 35.h,
                      //     Color: KOrange,
                      //     textColor: KOrange,
                      //     fontSize: 12.sp,
                      //     fontWeight: kFW700,
                      //     label: "Cancel",
                      //     isLoading: false,
                      //     onTap: () {
                      //       Navigator.of(context).pop();
                      //     }),
                      CustomButton(
                          borderRadius: BorderRadius.circular(15.r),
                          margin: EdgeInsets.all(10.r),
                          width: 110.w,
                          height: 35.h,
                          Color: KOrange,
                          textColor: Kwhite,
                          fontSize: 12.sp,
                          fontWeight: kFW700,
                          label: "Ok",
                          isLoading: false,
                          onTap: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
