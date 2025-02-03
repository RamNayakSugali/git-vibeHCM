import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vibeshr/components/custom_button.dart';
import 'package:vibeshr/untils/export_file.dart';

class Claims extends StatefulWidget {
  const Claims({super.key});

  @override
  State<Claims> createState() => _ClaimsState();
}

class _ClaimsState extends State<Claims> {
  TextEditingController dOBController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  File? selectedImage;
  String base64Image = "";
  bool isLoading = false;
  Map typesData = {};
  List<String> options = [];
  int choosenTypeData = 0;
  String choosenOption = "";
  DateTime choosenDate = DateTime.now();
  String description = "";
  int? totalAmount;
  String? str;
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

  getTypes() async {
    setState(() {
      isLoading = true;
    });

    Map value = await Services.getTypes();
    if (value["message"] != null) {
      Fluttertoast.showToast(msg: value["message"]);
    } else {
      typesData = value;
      await getOptionsList();
    }
    setState(() {
      isLoading = false;
    });
  }

  var isLoadingExpense = false.obs;

  createClaim() async {
    setState(() {
      isLoadingExpense.value = true;
    });
    Map imageValue = await Services.uploadFileToServer(
        selectedImage!.path, "claim_document");
    String imageData = "";
    try {
      imageData = imageValue["msg"];
    } catch (e) {
      imageData = "";
    }
    Map payload = {
      "claim_type_id": choosenTypeData,
      "date": choosenDate.toString(),
      "amount": int.parse(totalAmount.toString()),
      "comments": description,
      "image": imageData
    };

    Map value = await Services.createClaim(payload);
    if (value["message"] != null) {
      Fluttertoast.showToast(msg: value["message"]);
    } else {
      typesData = value;
    }
    setState(() {
      isLoadingExpense.value = false;
    });
  }

  bool showimagenullMessage = false;
  getOptionsList() {
    options.clear();
    for (int i = 0; i < typesData["rows"].length; i++) {
      options.add(typesData["rows"][i]["name"]);
    }
  }

  var selectDate = "Select Date".obs;
  var isFormOpen = false.obs;
  TextEditingController date = TextEditingController();
  @override
  void initState() {
    getTypes();
    super.initState();
  }

  DateTime selectedDate = DateTime.now();

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;
  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();
  FocusNode _focustwoNode = FocusNode();
  FocusNode _focusthreeNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _showKeyboard(node) {
    FocusScope.of(context).requestFocus(node);
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _handleTapOutside() {
    setState(() {
      isFormOpen.value = false;
    });
    _hideKeyboard();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTapOutside,
      child: Scaffold(
        backgroundColor:
            selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
        // bottomSheet:
        appBar: VibhoAppBar(
          title: "Create Claim",
          dontHaveBackAsLeading: false,
          bColor: selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
        ),
        body: SingleChildScrollView(
          child: isLoading == false
              ? Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.all(13.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Expenses Category",
                            style: GoogleFonts.openSans(
                                fontSize: kFourteenFont,
                                color: Ktextcolor,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 5.h),
                        //                     RichText(
                        // text: TextSpan(
                        //     text: label,
                        //     style: GoogleFonts.openSans(
                        //         fontSize: kFourteenFont,
                        //         color: Ktextcolor,
                        //         fontWeight: FontWeight.w500),)
                        //       children: isMandatory
                        //           ? [
                        //               TextSpan(
                        //                 text: '*',
                        //                 style: GoogleFonts.openSans(
                        //                   fontSize: kFourteenFont,
                        //                   color: KRed,
                        //                   fontWeight: FontWeight.w500,
                        //                 ),
                        //               )
                        //             ]
                        //           : []),
                        // ),
                        // CustomDropDown(
                        //     label: "Expenses Category",
                        //     hintText: 'Claim type',
                        //     isMandatory: false,
                        //     validator: (value) {
                        //       if (value!.isEmpty) {
                        //         return 'This filed not be Empty';
                        //       }
                        //       return null;
                        //     },
                        //     onChanged: (dynamic str) {
                        //       setState(() {
                        //         choosenTypeData = typesData["rows"]
                        //             .where((element) => element["name"] == str)
                        //             .toList()[0]["claim_type_id"];
                        //         choosenOption = typesData["rows"]
                        //             .where((element) => element["name"] == str)
                        //             .toList()[0]["name"];
                        //       });
                        //     },
                        //     options: options),
                        ////////////////////////errordebug
                        DropdownButtonHideUnderline(
                          child: DropdownButtonFormField2<String>(
                            isExpanded: true,
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
                            // decoration: InputDecoration(
                            //   fillColor: Kwhite,
                            //   filled: true,
                            //   // Add Horizontal padding using menuItemStyleData.padding so it matches
                            //   // the menu padding when button's width is not specified.
                            //   contentPadding: const EdgeInsets.symmetric(
                            //       vertical: 5, horizontal: 10),

                            //   border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(10.r),
                            //       borderSide: BorderSide.none),
                            //   // Add more decoration..
                            // ),
                            // decoration: InputDecoration(
                            //   contentPadding:
                            //       const EdgeInsets.symmetric(vertical: 16),
                            // ),
                            hint: Text(
                              'Select Claim Type',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: options
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: str,
                            // items: genderItems
                            //     .map((item) => DropdownMenuItem<String>(
                            //           value: item,
                            //           child: Text(
                            //             item,
                            //             style: const TextStyle(
                            //               fontSize: 14,
                            //             ),
                            //           ),
                            //         ))
                            //     .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select Claim Type.';
                              }
                              return null;
                            },
                            onChanged: (String? value) {
                              str = value;
                              setState(() {
                                choosenTypeData = typesData["rows"]
                                    .where((element) => element["name"] == str)
                                    .toList()[0]["claim_type_id"];
                                choosenOption = typesData["rows"]
                                    .where((element) => element["name"] == str)
                                    .toList()[0]["name"];
                              });
                            },
                            // onChanged: (value) {
                            //   //Do something when selected item is changed.
                            // },
                            onSaved: (value) {
                              selectedValue = value.toString();
                            },
                            buttonStyleData: ButtonStyleData(
                              padding: EdgeInsets.only(top: 8),
                              // padding: EdgeInsets.symmetric(
                              //   horizontal: 16,
                              // ),
                              height: 40,
                              width: 140,
                            ),
                            // buttonStyleData: const ButtonStyleData(
                            //   padding: EdgeInsets.only(right: 8),
                            // ),
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
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            // menuItemStyleData: const MenuItemStyleData(
                            //   padding: EdgeInsets.symmetric(horizontal: 16),
                            // ),
                          ),
                        ),
                        ///////////////////////////// old code
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
                        //         offset: Offset(0, 6),
                        //         color: Ktextcolor.withOpacity(0.2),
                        //       )
                        //     ],
                        //   ),
                        //   child: DropdownButtonHideUnderline(
                        //     child: DropdownButton2<String>(
                        //       isExpanded: true,
                        //       hint: Text(
                        //         'Select Item',
                        //         style: TextStyle(
                        //           fontSize: 14,
                        //           color: Theme.of(context).hintColor,
                        //         ),
                        //       ),

                        //       items: options
                        //           .map((String item) => DropdownMenuItem<String>(
                        //                 value: item,
                        //                 child: Text(
                        //                   item,
                        //                   style: const TextStyle(
                        //                     fontSize: 14,
                        //                   ),
                        //                 ),
                        //               ))
                        //           .toList(),
                        //       value: str,
                        //       //     onChanged: (dynamic str) {
                        //       //   setState(() {
                        //       //     data.leavetype = str;
                        //       //     data.leavetypeid = myLeavesTypes
                        //       //         .where((element) => element["leave_type_name"] == str)
                        //       //         .toList()[0]["leave_type_id"];
                        //       //   });
                        //       // },
                        //       // onChanged: (String? value) {
                        //       //   setState(() {
                        //       //     str = value;
                        //       //     data.leavetype = str!;
                        //       //     data.leavetypeid = myLeavesTypes
                        //       //         .where((element) =>
                        //       //             element["leave_type_name"] == str)
                        //       //         .toList()[0]["leave_type_id"];
                        //       //   });
                        //       // },

                        //       onChanged: (String? value) {
                        //         str = value;
                        //         setState(() {
                        //           choosenTypeData = typesData["rows"]
                        //               .where((element) => element["name"] == str)
                        //               .toList()[0]["claim_type_id"];
                        //           choosenOption = typesData["rows"]
                        //               .where((element) => element["name"] == str)
                        //               .toList()[0]["name"];
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

                        //////////////////
                        SizedBox(
                          height: 15.h,
                        ),
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
                        //         offset: Offset(0, 6),
                        //         color: Ktextcolor.withOpacity(0.2),
                        //       )
                        //     ],
                        //   ),
                        //   child: DropdownButtonHideUnderline(
                        //     child: DropdownButton2<String>(
                        //       isExpanded: true,
                        //       hint: Text(
                        //         'Claim type',
                        //         style: TextStyle(
                        //           fontSize: 14,
                        //           color: Theme.of(context).hintColor,
                        //         ),
                        //       ),
                        //       items: options
                        //           .map((String item) => DropdownMenuItem<String>(
                        //                 value: item,
                        //                 child: Text(
                        //                   item,
                        //                   style: const TextStyle(
                        //                     fontSize: 14,
                        //                   ),
                        //                 ),
                        //               ))
                        //           .toList(),
                        //       value: str,
                        //       onChanged: (dynamic str) {
                        //         setState(() {
                        //           choosenTypeData = typesData["rows"]
                        //               .where((element) => element["name"] == str)
                        //               .toList()[0]["claim_type_id"];
                        //           choosenOption = typesData["rows"]
                        //               .where((element) => element["name"] == str)
                        //               .toList()[0]["name"];
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
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomclaimFormField(
                          onTap: () async {
                            setState(() {
                              isFormOpen.value = true;
                            });
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      // background: white,
                                      primary: KOrange,
                                      //onPrimary: white,
                                      onSurface: Colors.black,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                          // primary: Kbluedark,
                                          ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (picked != null && picked != selectedDate) {
                              if (picked.isAfter(DateTime.now())) {
                                // date.isAfter(DateTime.now()
                                //  if(date.month>DateTime.now().month){
                                Fluttertoast.showToast(
                                    msg: "Upcomming Months can't be selected");
                              } else {
                                setState(() {
                                  selectedDate = picked;
                                  choosenDate = selectedDate;
                                  selectDate.value =
                                      DateFormat.yMMMEd().format(selectedDate);
                                });
                              }
                              // setState(() {
                              //   selectedDate = picked;
                              //   choosenDate = selectedDate;
                              // }
                              // );
                            }
                          },
                          keyboardType: TextInputType.none,
                          maxLines: 1,
                          controller: dOBController,
                          hintText: selectedDate != null
                              ? DateFormat.yMMMEd().format(selectedDate)
                              : "Claim Applied Date",
                          //isMandatory: false,
                          labelText: isFormOpen.value == false
                              ? selectDate.value
                              : "Select Date",
                          // selectedDate != null
                          //     ? DateFormat.yMMMEd().format(selectedDate)
                          //     : "Claim Applied Date",
                          readOnly: true,

                          suffix: Image.asset(
                            "assets/images/Group1.png",
                          ),
                          cursor: false,
                        ),

                        // CustomFormField(
                        //  // controller: selectedDate,
                        //   keyboardType: TextInputType.none,
                        //     maxLines: 1,
                        //     readOnly: false,
                        // labelText: selectedDate != null
                        //     ? DateFormat.yMMMEd().format(selectedDate)
                        //     : "Transaction Date",
                        //     suffix: GestureDetector(
                        //       onTap: () async {
                        //         final DateTime? picked = await showDatePicker(
                        //             context: context,
                        //             initialDate: selectedDate,
                        //             firstDate: DateTime(2015, 8),
                        //             lastDate: DateTime(2101));
                        //         if (picked != null && picked != selectedDate) {
                        //           setState(() {
                        //             selectedDate = picked;
                        //             choosenDate = selectedDate;
                        //           });
                        //         }
                        //       },
                        //       child: Image.asset(
                        //         "assets/images/Group1.png",
                        //       ),
                        //     ),
                        //     hintText: "dd/mm/yyyy"),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomFormField(
                            focusNode: _focusNode,
                            onTap: () {
                              setState(() {
                                isFormOpen.value = false;
                              });
                              _showKeyboard(_focusNode);
                            },
                            prefix: Padding(
                              padding: const EdgeInsets.only(left: 20, top: 15),
                              child: Text(
                                UserSimplePreferences.getCurrency() == "INR"
                                    ? "₹"
                                    : UserSimplePreferences.getCurrency() ==
                                            "ZAR"
                                        ? "R"
                                        : "",
                                //  "\u{20B9} | ",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: kFW600,
                                    color: kblack),
                              ),
                            ),
                            maxLines: 1,
                            readOnly: false,
                            keyboardType: TextInputType.number,
                            labelText: "Total Amount",
                            validator: (value) {
                              (input) => input.isValidEmail()
                                  ? null
                                  : "Check your email";
                              if (value!.isEmpty) {
                                return 'Please Enter Amount';
                              } else if (int.parse(value) <= 0) {
                                return "Minimum Value is Accepted";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              debugPrint(value);
                              setState(() {
                                totalAmount = int.parse(value);
                              });
                            },
                            hintText: "Total Amount"),

                        SizedBox(
                          height: 5.h,
                        ),
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isFormOpen.value = false;
                            });
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
                                      "Upload Receipt",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: KOrange,
                                          fontWeight: kFW600),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        showimagenullMessage == true
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Please Upload Image",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : const SizedBox(),

                        SizedBox(
                          height: 15.h,
                        ),
                        CustomFormField(
                            focusNode: _focustwoNode,
                            onTap: () {
                              setState(() {
                                isFormOpen.value = false;
                              });
                              _showKeyboard(_focustwoNode);
                            },
                            maxLines: 5,
                            readOnly: false,
                            labelText: "Description",
                            controller: date,
                            validator: (value) {
                              (input) => input.isValidEmail()
                                  ? null
                                  : "Check your email";
                              if (value!.isEmpty) {
                                return 'Please enter some Description';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                description = value;
                              });
                            },
                            hintText: "Description"),
                        SizedBox(
                          height: 60.h,
                        ),
                        Column(
                          children: [
                            CustomButton(
                                borderRadius: BorderRadius.circular(30.r),
                                margin: EdgeInsets.all(15.r),
                                width: double.infinity,
                                height: 35.h,
                                Color: KOrange,
                                textColor: Kwhite,
                                fontSize: 13.sp,
                                fontWeight: kFW700,
                                label: "Submit",
                                isLoading: false,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (selectedImage != null) {
                                      setState(() {
                                        showimagenullMessage = false;
                                      });
                                      _showDialog(context);
                                    } else {
                                      setState(() {
                                        showimagenullMessage = true;
                                      });
                                    }
                                  }
                                }),
                            Custom_OutlineButton(
                                borderRadius: BorderRadius.circular(30.r),
                                margin: EdgeInsets.all(10.r),
                                width: double.infinity,
                                height: 35.h,
                                Color: Kbackground,
                                textColor: KOrange,
                                fontSize: 13.sp,
                                fontWeight: kFW700,
                                label: "Cancel",
                                isLoading: false,
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Do you want to cancel Claim?',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: kFW700,
                                                  color: selectedTheme ==
                                                          "Lighttheme"
                                                      ? KdarkText.withOpacity(
                                                          0.7)
                                                      : Kwhite)),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text('No',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: kFW700,
                                                      color: selectedTheme ==
                                                              "Lighttheme"
                                                          ? KdarkText
                                                          : Kwhite)),
                                            ),
                                            TextButton(
                                              // textColor: Color(0xFF6200EE),
                                              onPressed: () async {
                                                Get.back();
                                                Get.back();
                                              },
                                              child: Text('Yes',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: kFW700,
                                                      color: selectedTheme ==
                                                              "Lighttheme"
                                                          ? KdarkText
                                                          : Kwhite)),
                                            )
                                          ],
                                        );
                                      });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(height: 150.h),
                    Center(
                        child:
                            SpinKitFadingCircle(color: KOrange, size: 50.sp)),
                  ],
                ),
        ),
      ),
    );
  }

  final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 460.h,
              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('Expenses Submitted',
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: 13.sp,
                          fontWeight: kFW900)),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                      'Your Expenses has been submitted and ready to be reviewed',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: kTenFont,
                          fontWeight: kFW500)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Image.asset(
                    "assets/images/bill.png",
                    width: 150.w,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Total Ammount',
                              style: TextStyle(
                                  color: KdarkText.withOpacity(0.5),
                                  fontSize: 11.sp,
                                  fontWeight: kFW900)),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              UserSimplePreferences.getCurrency() == "INR"
                                  ? "${currencyFormat.format(double.parse(totalAmount.toString()))}"
                                  : UserSimplePreferences.getCurrency() == "ZAR"
                                      ? "R $totalAmount"
                                      : "${currencyFormat.format(double.parse(totalAmount.toString()))}",
                              style: TextStyle(
                                  color: kblack,
                                  fontSize: 13.sp,
                                  fontWeight: kFW900)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Claim Applied date',
                              style: TextStyle(
                                  color: KdarkText.withOpacity(0.5),
                                  fontSize: 11.sp,
                                  fontWeight: kFW900)),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(DateFormat.yMMMd().format(choosenDate),
                              style: TextStyle(
                                  color: KdarkText,
                                  fontSize: 13.sp,
                                  fontWeight: kFW900)),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description',
                            style: TextStyle(
                                color: KdarkText.withOpacity(0.5),
                                fontSize: 11.sp,
                                fontWeight: kFW900)),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(description != "" ? description : "-",
                            maxLines: 2,
                            style: TextStyle(
                                color: KdarkText,
                                fontSize: 13.sp,
                                fontWeight: kFW900)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            margin: const EdgeInsets.all(3),
                            height: 50.h,
                            width: 50.h,
                            decoration: BoxDecoration(
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Ktextcolor.withOpacity(0.3),
                              //     blurRadius: 10,
                              //     offset: const Offset(0, 0),
                              //     spreadRadius: 5, //New
                              //   )
                              // ],
                              borderRadius: BorderRadius.circular(13.r),
                              color: Kwhite,
                            ),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(13.r), // Image border
                                child: selectedImage != null
                                    ? Image.file(
                                        selectedImage!,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      )
                                    : const Text(
                                        "no receipt",
                                        textAlign: TextAlign.center,
                                      ))),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expenses for",
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.normal,
                                color: KdarkText.withOpacity(0.5)),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            choosenOption,
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.normal,
                                color: KdarkText),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(() => isLoadingExpense != false
                      ? const Center(
                          child: SpinKitFadingCircle(
                          color: KOrange,
                          size: 15,
                        ))
                      : CustomButton(
                          borderRadius: BorderRadius.circular(30.r),
                          margin: EdgeInsets.all(15.r),
                          width: double.infinity,
                          height: 35.h,
                          Color: KOrange,
                          textColor: Kwhite,
                          fontSize: 13.sp,
                          fontWeight: kFW700,
                          label: "Done",
                          isLoading: false,
                          onTap: () async {
                            await createClaim();
                            Get.back();
                            Get.back();
                            // _showSuccessDialog(context);
                          })),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 270.h,
              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('Expenses Submitted',
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: 13.sp,
                          fontWeight: kFW900)),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text('Your Expenses has been submitted Successfully',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: kTenFont,
                          fontWeight: kFW500)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Image.asset(
                    "assets/images/bill.png",
                    width: 150.w,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                      borderRadius: BorderRadius.circular(30.r),
                      margin: EdgeInsets.all(15.r),
                      width: double.infinity,
                      height: 35.h,
                      Color: KOrange,
                      textColor: Kwhite,
                      fontSize: 13.sp,
                      fontWeight: kFW700,
                      label: "Okay",
                      isLoading: false,
                      onTap: () {
                        Get.back();
                        Get.back();
                        Get.back();
                        // Get.toNamed(KBottom_navigation);
                      }),
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
