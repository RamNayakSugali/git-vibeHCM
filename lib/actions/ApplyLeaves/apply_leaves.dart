// ignore_for_file: camel_case_types, unused_field

import 'package:dropdown_button2/dropdown_button2.dart';

import '../../untils/export_file.dart';
import 'dart:convert';
import 'dart:io';

class Apply_leave extends StatefulWidget {
  const Apply_leave({super.key});

  @override
  State<Apply_leave> createState() => _Apply_leaveState();
}

class leavesdata {
  int leavetypeid = 0;
  String leavetype = '';
  String fromdate = '';
  String todate = '';
  String reason = '';
}

class _Apply_leaveState extends State<Apply_leave> {
  //  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  LeavesController leavesController = Get.find<LeavesController>();
  DashboardController dashboardController = Get.find<DashboardController>();
  AttendanceController attendanceController = Get.find<AttendanceController>();
  // late SingleValueDropDownController _cnt;
  // late MultiValueDropDownController _cntMulti;

  // @override
  // void initState() {
  //   _cnt = SingleValueDropDownController();
  //   _cntMulti = MultiValueDropDownController();
  //   super.initState();
  // }

  @override
  void dispose() {
    leavesController.cnt.dispose();
    leavesController.cntMulti.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController reasoncontroller = TextEditingController();
  bool isLoading = false;
  String imageData = "string";
  String imageName = "string";
  // List appliedLeaves = [];
  leavesdata data = leavesdata();
  Future leavesHandler() async {
    setState(() {
      isLoading = true;
    });
    if (selectedImage != null) {
      Map imageValue = await Services.uploadFileToServer(
          selectedImage!.path, "claim_document");

      try {
        imageData = imageValue["msg"];
        imageName = imageValue["name"];
      } catch (e) {
        imageData = "string";
        imageName = "string";
      }
    }

    Map payload = {
      "leave_type_id": data.leavetypeid,
      "leave_type": data.leavetype,
      "from_date": _range.toString().split(" - ")[0].split(" ")[0],
      "to_date": _range.toString().split(" - ")[1].split(" ")[0],
      "reason": data.reason,
      "document_file_name": imageName,
      "document_file_path": imageData
    };
    Map checkAvilablityPayload = {
      "leave_type_id": data.leavetypeid,
      "from_date": _range.toString().split(" - ")[0].split(" ")[0],
      "to_date": _range.toString().split(" - ")[1].split(" ")[0],
    };

    Map value = await Services.createLeaveV2(payload);
    Map checkAvilablity =
        await Services.checkAvilablity(checkAvilablityPayload);
    dashboardController.requestListHandler();
    leavesController.str.value = "Select Type";
    leavesController.leavesListHandler();
    print(value);
    setState(() {
      isLoading = false;
    });
    _showMyDialog(value, checkAvilablity);
  }

  ///Sickleave Handler

  // List<DateTime> appledLeavesDates = [];
  // getAppliedLeaves() {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   appledLeavesDates.clear();
  //   for (int i = 0; i < appliedLeaves.length; i++) {
  //     if (appliedLeaves[i]["from_date"] != "0000-00-00" &&
  //         appliedLeaves[i]["to_date"] != "0000-00-00") {
  //       List<DateTime> betweenDates = getLeavesInBetween(
  //           DateTime.parse(appliedLeaves[i]["from_date"]),
  //           DateTime.parse(appliedLeaves[i]["to_date"]));
  //       for (int j = 0; j < betweenDates.length; j++) {
  //         setState(() {
  //           appledLeavesDates.add(betweenDates[j]);
  //         });
  //       }
  //     }
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // getLeavesInBetween(DateTime startDate, DateTime endDate) {
  //   final daysToGenerate = endDate.difference(startDate).inDays + 1;
  //   return List.generate(
  //       daysToGenerate, (i) => startDate.add(Duration(days: i)));
  // }

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

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
    debugPrint("Done");
  }

  bool validateLeaves() {
    var data = leavesController.getLeavesInBetween(
        DateTime.parse(_range.toString().split(' - ')[0].trim()),
        DateTime.parse(_range.toString().split(' - ')[1].trim()));
    if (data[0].weekday == 7 ||
        data[data.length - 1].weekday == 7 ||
        data[0].weekday == 6 ||
        data[data.length - 1].weekday == 6) {
      Fluttertoast.showToast(msg: "Leave Can't Apply On Weekends");
      return false;
    } else {
      for (int i = 0; i < data.length; i++) {
        for (int j = 0; j < leavesController.appledLeavesDates.length; j++) {
          if (data[i] == leavesController.appledLeavesDates[j]) {
            Fluttertoast.showToast(msg: "Leave Already Applied");
            return false;
          }
        }
      }
    }

    return true;
  }
  /////////////////////

  /////////////////

  // getLeavesListFromApi() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Map data = await Services.leavelist();
  //   if (data["message"] != null) {
  //     Fluttertoast.showToast(
  //       msg: data["message"],
  //     );
  //   } else {
  //     appliedLeaves = data["rows"];
  //     getAppliedLeaves();
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  // String? str;
  // List myLeavesTypes = [];
  // List<String> options = [];
  // getLeavesListTypes() async {
  //   options.clear();
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Map data = await Services.getLeavesListTypes();
  //   if (data["message"] != null) {
  //     Fluttertoast.showToast(
  //       msg: data["message"],
  //     );
  //   } else {
  //     myLeavesTypes = data["rows"];
  //     for (int i = 0; i < myLeavesTypes.length; i++) {
  //       if (myLeavesTypes[i]["is_active"] == 1) {
  //         options.add(myLeavesTypes[i]["leave_type_name"]);
  //       }
  //     }
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  Map Requestdata = {};
  List holydays = [];
  Map UpcommingHolydaysdata = {};

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
      await getListOfLeavesHolidays(UpcommingHolydaysdata);
      getListOfKeavesdates();
      // holydays =
    }
    setState(() {
      isLoading = false;
    });
  }

// DateTime.parse(
  //    holydays[index]["date"])
  List<DateTime> myLeavesHolidaysList = [];
  Future<List<DateTime>> getListOfLeavesHolidays(Map holys) async {
    myLeavesHolidaysList.clear();
    List<DateTime> myLeavesHolidays = [];
    for (int i = 0; i < holys["rows"].length; i++) {
      setState(() {
        myLeavesHolidays.add(DateTime.parse(holys["rows"][i]["date"]));
        myLeavesHolidaysList.add(DateTime.parse(holys["rows"][i]["date"]));
      });
    }
    debugPrint("Function------------------------------------------");
    return myLeavesHolidays;
  }

  List<DateTime> myLeavesList = [];
  List<DateTime> getListOfKeavesdates() {
    myLeavesList.clear();
    List<DateTime> myLeaves = [];
    for (int i = 0; i < leavesController.appliedLeaves.length; i++) {
      if (leavesController.appliedLeaves[i]["leave_status"] != 3 &&
          leavesController.appliedLeaves[i]["leave_status"] != 2 &&
          leavesController.appliedLeaves[i]["leave_status"] != 0) {
        List<DateTime> getFifference = getDaysInBetween(
            DateTime.parse(leavesController.appliedLeaves[i]["from_date"]),
            DateTime.parse(leavesController.appliedLeaves[i]["to_date"]));
        for (int j = 0; j < getFifference.length; j++) {
          myLeaves.add(getFifference[j]);
          setState(() {
            myLeavesList.add(getFifference[j]);
          });
        }
      }
    }
    return myLeaves;
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  File? selectedImage;
  String base64Image = "";
  bool showimagenullMessage = false;

  ///upload documents////////////////////////////////////
  Future<void> chooseImage(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 6,
      );
      // .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          //.pickImage(source: ImageSource.gallery);
          .pickImage(source: ImageSource.gallery, imageQuality: 6);
      //  .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        print(selectedImage!.readAsBytesSync().lengthInBytes);
        final kb = selectedImage!.readAsBytesSync().lengthInBytes / 1024;
        print(kb);
        final mb = kb / 1024;
        print(mb);
        print("ram b jk dslnkv flk dlkcdslc k");
        showimagenullMessage = false;
      });
//       Future getImageSize() async {
// // final pickedImage = await picker.getImage(source: ImageSource.gallery);
//         final bytes = selectedImage!.readAsBytesSync().lengthInBytes;
//         final kb = bytes / 1024;
//         final mb = kb / 1024;
//         print("Below kilo bytes,...........................................");
//         print(kb);
//       }
      // var value = await Services.profileimage(File(image.path));
      // if (jsonDecode(value["msg"]) != null) {
      //   Fluttertoast.showToast(msg: value["msg"]);
      // } else {
      //   // Get.toNamed(Kapply_leaves);
      // }
    }
  }

  ///

  @override
  void initState() {
    leavesController.str.value = "Select Type";
    RequestListHandler();
    // getLeavesListTypes();
    // getLeavesListFromApi();
    // _cnt = SingleValueDropDownController();
    // _cntMulti = MultiValueDropDownController();
    super.initState();
  }

  FocusNode _focusNode = FocusNode();

  void _showKeyboard(node) {
    FocusScope.of(context).requestFocus(node);
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _handleTapOutside() {
    _hideKeyboard();
  }

  //dropdown
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTapOutside,
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        bottomSheet: CustomButton(
            margin: const EdgeInsets.all(15),
            height: 38.h,
            width: double.infinity,
            textColor: Kwhite,
            borderRadius: BorderRadius.circular(20.r),
            Color: KOrange,
            fontSize: 13.sp,
            fontWeight: kFW600,
            label: "Submit",
            isLoading: false,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                if (data.leavetype.toLowerCase().contains("home") ||
                    data.leavetype.toLowerCase().contains("work") ||
                    data.leavetype.toLowerCase().contains("wfh")) {
                  leavesHandler();
                } else {
                  bool isnotalreadyApplied = validateLeaves();
                  if (isnotalreadyApplied) {
                    leavesHandler();
                  }
                }

                // value = null;
                // leavesHandler();
              }
              // setState(() {
              //   selectedValue = null;
              //   data.leavetype = "";
              //   data.leavetypeid = 0;

              //   // leavesController.str.value = "Select Type";
              // });
            }),
        backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        appBar: VibhoAppBar(
          bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
          title: 'Apply Leave',
          dontHaveBackAsLeading: false,
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(13.r),
            child: isLoading == false
                ? SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Leave type",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: kFW700,
                                  color: selectedTheme == "Lighttheme"
                                      ? KdarkText
                                      : Kwhite)),
                          SizedBox(height: 10.h),
                          // CustomDropDown(
                          //   label: 'Leave type',
                          //   hintText: 'Leave type',
                          //   isMandatory: true,
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'This filed not be Empty';
                          //     }
                          //     return null;
                          //   },
                          //   onChanged: (dynamic str) {
                          //     setState(() {
                          //       data.leavetype = str;
                          //       data.leavetypeid = myLeavesTypes
                          //           .where((element) => element["leave_type_name"] == str)
                          //           .toList()[0]["leave_type_id"];
                          //     });
                          //   },
                          //   options: options,
                          // ),
                          ////last code
                          // Container(
                          //   height: 40.h,
                          //   width: double.infinity,
                          //   decoration: BoxDecoration(
                          //     color: Kwhite,
                          //     borderRadius: BorderRadius.circular(10.r),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         spreadRadius: 2,
                          //         blurRadius: 10,
                          //         offset: const Offset(0, 6),
                          //         color: Ktextcolor.withOpacity(0.2),
                          //       )
                          //     ],
                          //   ),
                          //   child: DropdownButtonHideUnderline(
                          //     child: DropdownButtonFormField2<String>(
                          //       decoration: InputDecoration(
                          //         fillColor: Kwhite,
                          //         filled: true,
                          //         contentPadding: const EdgeInsets.symmetric(
                          //             vertical: 5, horizontal: 10),
                          //         border: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(10.r),
                          //             borderSide: BorderSide.none),
                          //       ),
                          //       isExpanded: true,
                          //       hint: Text(
                          //         'Select Type',
                          //         style: TextStyle(
                          //           fontSize: 14,
                          //           color: Theme.of(context).hintColor,
                          //         ),
                          //       ),
                          //       items: leavesController.options
                          //           .map((String item) =>
                          //               DropdownMenuItem<String>(
                          //                 value: item,
                          //                 child: Text(
                          //                   item,
                          //                   style: TextStyle(
                          //                       fontSize: 12.sp,
                          //                       fontWeight: kFW700,
                          //                       color: selectedTheme ==
                          //                               "Lighttheme"
                          //                           ? KdarkText
                          //                           : Kwhite),
                          //                 ),
                          //               ))
                          //           .toList(),
                          //       value: leavesController.str.value,
                          //       validator: (value) {
                          //         if (value == null) {
                          //           return 'Please select Type.';
                          //         }
                          //         return null;
                          //       },
                          //       //     onChanged: (dynamic str) {
                          //       //   setState(() {
                          //       //     data.leavetype = str;
                          //       //     data.leavetypeid = myLeavesTypes
                          //       //         .where((element) => element["leave_type_name"] == str)
                          //       //         .toList()[0]["leave_type_id"];
                          //       //   });
                          //       // },
                          //       onChanged: (String? value) {
                          //         setState(() {
                          //           leavesController.str.value = value!;
                          //           data.leavetype = leavesController.str.value;
                          //           data.leavetypeid = leavesController
                          //               .myLeavesTypes
                          //               .where((element) =>
                          //                   element["leave_type_name"] ==
                          //                   leavesController.str.value)
                          //               .toList()[0]["leave_type_id"];
                          //           debugPrint(
                          //               "leave Type ID = ${data.leavetypeid}");
                          //         });
                          //       },
                          //       buttonStyleData: const ButtonStyleData(
                          //         padding: EdgeInsets.symmetric(horizontal: 16),
                          //         height: 40,
                          //         width: 140,
                          //       ),
                          //       menuItemStyleData: const MenuItemStyleData(
                          //         height: 40,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          ////////////////////////////////////////////////////////////////////////////////////////
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: Kwhite,
                          //     borderRadius: BorderRadius.circular(10.r),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         spreadRadius: 2,
                          //         blurRadius: 10,
                          //         offset: const Offset(0, 6),
                          //         color: Ktextcolor.withOpacity(0.2),
                          //       )
                          //     ],
                          //   ),
                          //   child:

                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2<String>(
                              // decoration: InputDecoration(
                              //   fillColor: Kwhite,
                              //   filled: true,
                              //   contentPadding: const EdgeInsets.symmetric(
                              //       vertical: 5, horizontal: 10),
                              //   border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(10.r),
                              //       borderSide: BorderSide.none),
                              // ),
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                // const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),

                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: KdarkText, width: 0.5),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),

                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: KdarkText, width: 0.5),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: KdarkText, width: 0.5),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: KdarkText, width: 0.5),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: KdarkText, width: 0.5),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: KdarkText, width: 0.5),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                fillColor: Kwhite,

                                alignLabelWithHint: true,
                                //make hint text
                                hintStyle: TextStyle(
                                  color: selectedTheme == "Lighttheme"
                                      ? Klightgray.withOpacity(0.5)
                                      : Kwhite,
                                  fontSize: kTenFont,
                                  fontWeight: FontWeight.w600,
                                ),

                                //create lable

                                //lable style
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Select Leave Type',
                                style: TextStyle(
                                  fontSize: kFourteenFont,
                                  fontWeight: kFW500,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: leavesController.options
                                  // genderItems
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select Leave Type.';
                                }
                                return null;
                              },
                              // value: selectedValue,
                              onChanged: (String? value) {
                                setState(() {
                                  leavesController.str.value = value!;

                                  selectedValue = leavesController.str.value;
                                  data.leavetype = leavesController.str.value;
                                  data.leavetypeid = leavesController
                                      .myLeavesTypes
                                      .where((element) =>
                                          element["leave_type_name"] ==
                                          leavesController.str.value)
                                      .toList()[0]["leave_type_id"];
                                  debugPrint(
                                      "leave Type ID = ${data.leavetypeid}");
                                });
                              },
                              // onChanged: (value) {
                              //   //Do something when selected item is changed.
                              // },
                              value: selectedValue,
                              onSaved: (value) {
                                selectedValue = value.toString();
                              },

                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 24,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),

                          ////////////////////////////////////////
                          // DropDownTextField(

                          //     clearOption: false,
                          //     textFieldFocusNode: textFieldFocusNode,
                          //     searchFocusNode: searchFocusNode,
                          //     // searchAutofocus: true,
                          //     dropDownItemCount: options.length,
                          //     searchShowCursor: false,
                          //     enableSearch: false,
                          //     searchKeyboardType: TextInputType.number,
                          //     dropDownList:
                          //     DropDownValueModel(name: 'name1', value: "value1")
                          //     ,

                          //     // DropDownValueModel(name: 'name1', value: "value1"),
                          //     // DropDownValueModel(
                          //     //     name: 'name2',
                          //     //     value: "value2",
                          //     //     toolTipMsg:
                          //     //         "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                          //     // DropDownValueModel(name: 'name3', value: "value3"),
                          //     // DropDownValueModel(
                          //     //     name: 'name4',
                          //     //     value: "value4",
                          //     //     toolTipMsg:
                          //     //         "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                          //     // DropDownValueModel(name: 'name5', value: "value5"),
                          //     // DropDownValueModel(name: 'name6', value: "value6"),
                          //     // DropDownValueModel(name: 'name7', value: "value7"),
                          //     //  DropDownValueModel(name: 'name8', value: "value8"),
                          //     onChanged: (dynamic str) {
                          //       setState(() {
                          //         data.leavetype = str;
                          //         data.leavetypeid = myLeavesTypes
                          //             .where(
                          //                 (element) => element["leave_type_name"] == str)
                          //             .toList()[0]["leave_type_id"];
                          //       });
                          //     }
                          //     //  onChanged: (val) {},
                          //     ),
                          SizedBox(
                            height: 20.h,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //       children: [
                          //         Column(
                          //           children: [
                          //             Text("Annual Applied Leaves",
                          //                 style: TextStyle(
                          //                     fontSize: 12.sp,
                          //                     fontWeight: kFW700,
                          //                     color: selectedTheme == "Lighttheme"
                          //                         ? KdarkText
                          //                         : Kwhite)),
                          //             SizedBox(
                          //               height: 10.h,
                          //             ),
                          //             Text(
                          //                 leavesController.myLeaveBalance["anual_eaves"]
                          //                         ["anual_applied"]
                          //                     .toString(),
                          //                 style: TextStyle(
                          //                     fontSize: 12.sp,
                          //                     fontWeight: kFW700,
                          //                     color: selectedTheme == "Lighttheme"
                          //                         ? KdarkText
                          //                         : Kwhite))
                          //           ],
                          //         ),
                          //         Column(
                          //           children: [
                          //             Text("Sick Applied Leaves",
                          //                 style: TextStyle(
                          //                     fontSize: 12.sp,
                          //                     fontWeight: kFW700,
                          //                     color: selectedTheme == "Lighttheme"
                          //                         ? KdarkText
                          //                         : Kwhite)),
                          //             SizedBox(
                          //               height: 10.h,
                          //             ),
                          //             Text(
                          //                 leavesController.myLeaveBalance["sick_leaves"]
                          //                         ["sick_applied"]
                          //                     .toString(),
                          //                 style: TextStyle(
                          //                     fontSize: 12.sp,
                          //                     fontWeight: kFW700,
                          //                     color: selectedTheme == "Lighttheme"
                          //                         ? KdarkText
                          //                         : Kwhite))
                          //           ],
                          //         ),
                          //         // Column(children: [
                          //         //   Text("Appled Leave", style: TextStyle(
                          //         //                       fontSize: 12.sp,
                          //         //                       fontWeight: kFW700,
                          //         //                       color: selectedTheme == "Lighttheme"
                          //         //                           ? KdarkText
                          //         //                           : Kwhite))
                          //         // ],)
                          //       ]),
                          // ),
                          // SizedBox(
                          //   height: 20.h,
                          // ),
                          Container(
                              margin: EdgeInsets.all(1.r),
                              padding: EdgeInsets.only(bottom: 10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Kwhite,
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: const Offset(3, 3),
                                    color: Ktextcolor.withOpacity(0.2),
                                  )
                                ],
                              ),
                              child: SfDateRangePicker(
                                enablePastDates: true,
                                initialSelectedDates: myLeavesList,
                                monthViewSettings:
                                    DateRangePickerMonthViewSettings(
                                        blackoutDates: myLeavesHolidaysList,
                                        //  getListOfLeavesHoliday
                                        // attendanceController.holydaysdates,
                                        specialDates: myLeavesList),
                                monthCellStyle:
                                    const DateRangePickerMonthCellStyle(
                                        blackoutDateTextStyle: TextStyle(
                                            color: Kbluedark,
                                            fontWeight: FontWeight.bold),
                                        textStyle: TextStyle(
                                            color: Klightgray,
                                            fontWeight: FontWeight.bold),
                                        // specialDatesDecoration: BoxDecoration(color: KOrange),
                                        specialDatesTextStyle: TextStyle(
                                            color: KOrange,
                                            fontWeight: FontWeight.bold)),
                                startRangeSelectionColor: KOrange,
                                selectionColor: KOrange,
                                rangeSelectionColor: KOrange.withOpacity(0.3),
                                endRangeSelectionColor: KOrange,
                                view: DateRangePickerView.month,
                                onSelectionChanged: _onSelectionChanged,
                                selectionMode:
                                    DateRangePickerSelectionMode.range,
                              )),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            padding: EdgeInsets.all(15.r),
                            // =======
                            //                       ),
                            //                       SizedBox(
                            //                         height: 20.h,
                            //                       ),
                            //                       CustomFormField(
                            //                         maxLines: 8,
                            //                         readOnly: false,
                            //                         labelText: "Reason",
                            //                         controller: reasoncontroller,
                            //                         hintText: "Reason",
                            //                         validator: (value) {
                            //                           if (value!.isEmpty) {
                            //                             return 'Please enter Reason';
                            //                           }
                            //                           return null;
                            //                         },
                            //                         onChanged: (value) {
                            //                           setState(() {
                            //                             data.reason = value;
                            //                           });
                            //                         },
                            //                       ),
                            //                       SizedBox(
                            //                         height: 30.h,
                            //                       ),
                            //                       CustomButton(
                            //                           margin: const EdgeInsets.all(15),
                            //                           height: 38.h,
                            // >>>>>>> master
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
                                color: selectedTheme == "Lighttheme"
                                    ? Kwhite
                                    : Kthemeblack),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 5.r,
                                          backgroundColor: KOrange,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          "Applied Leaves",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: kFW700,
                                              color:
                                                  selectedTheme == "Lighttheme"
                                                      ? KdarkText
                                                      : Kwhite),
                                        ),
                                      ],
                                    ),
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
                                              color:
                                                  selectedTheme == "Lighttheme"
                                                      ? KdarkText
                                                      : Kwhite),
                                        ),
                                      ],
                                    )
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
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          // data.leavetype != "Sick Leave"
                          //     ? SizedBox()
                          //     :
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Ktextcolor.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: selectedImage != null
                                ? Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                    height: 130.h,
                                    width: double.infinity,
                                  )
                                : const Text(
                                    "",
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          // data.leavetype != "Sick Leave"
                          //     ? SizedBox()
                          //     :
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20)),
                                  ),
                                  backgroundColor: Kbackground,
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Kbackground,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        height: 100.h,
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                chooseImage("Gallery");
                                                Navigator.pop(context);
                                              },
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.image_outlined,
                                                    color: KOrange,
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text('Gallery',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight: kFW700,
                                                          color: selectedTheme ==
                                                                  "Lighttheme"
                                                              ? KdarkText
                                                              : Kwhite)),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                chooseImage("camera");
                                                Navigator.pop(context);
                                              },
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: KOrange,
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text('camera',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight: kFW700,
                                                          color: selectedTheme ==
                                                                  "Lighttheme"
                                                              ? KdarkText
                                                              : Kwhite)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: DottedBorder(
                                dashPattern: [8, 2],
                                strokeWidth: 1,
                                color: KOrange,
                                child: Container(
                                  height: 35.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.r),
                                    color: Kwhite,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Upload Document",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: KOrange,
                                            fontWeight: kFW600),
                                      )
                                    ],
                                  ),
                                )),
                          ),

                          SizedBox(
                            height: 20.h,
                          ),
                          CustomFormField(
                            focusNode: _focusNode,
                            onTap: () {
                              _showKeyboard(_focusNode);
                            },
                            maxLines: 8,
                            readOnly: false,
                            labelText: "Reason",
                            controller: reasoncontroller,
                            hintText: "Reason",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please Enter Reason';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                data.reason = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 4.5,
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 150.h,
                      ),
                      Center(
                          child:
                              SpinKitFadingCircle(color: KOrange, size: 50.sp)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(Map value, Map checkAvilablity) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              // height: 240.h,
              height: 245.h,

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
                    "assets/images/leaves.png",
                    color: KOrange,
                    width: 50.w,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('Leave Apply Status',
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: 14.sp,
                          fontWeight: kFW900)),
                  SizedBox(
                    height: 8.h,
                  ),
                  value["message"] != null
                      ? Text(value["message"],
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: KdarkText,
                              fontSize: 11.sp,
                              fontWeight: kFW500))
                      : value["leave_status"] != null
                          ? Text("Leave Applied Successfully",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: KdarkText,
                                  fontSize: 11.sp,
                                  fontWeight: kFW500))
                          : const SizedBox(),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // checkAvilablity["msg"] != ""
                  //     ? Text(checkAvilablity["msg"],
                  //         maxLines: 2,
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //             color: KdarkText,
                  //             fontSize: kTenFont,
                  //             fontWeight: kFW500))
                  //     : value["leave_status"] != null
                  //         ? Text("Leave Type - " + value["leave_type"],
                  //             maxLines: 2,
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //                 color: KdarkText,
                  //                 fontSize: kTenFont,
                  //                 fontWeight: kFW500))
                  //         : const SizedBox(),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                            setState(() {
                              selectedValue = null;
                              data.leavetype = "";
                              data.leavetypeid = 0;

                              // leavesController.str.value = "Select Type";
                            });
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
