import 'dart:convert';
import 'dart:io';

import 'package:vibeshr/untils/export_file.dart';

class Edit_Profile extends StatefulWidget {
  Edit_Profile({super.key});

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController comments = TextEditingController();
  ServiceController controller = Get.put(ServiceController());
  String firtsnameData = "";
  String lastNameData = "";
  String commentsData = "";

  File? selectedImage;
  String selectedFilePath = "";
  String base64Image = "";
  final _formKey = GlobalKey<FormState>();

//////Iamge
  Future<void> chooseImage(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 6);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 6);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
      var value1 = await Services.profileimage(File(image.path));
      var value = await Services.updateprofile({"profile_pic": value1["msg"]});
      if (jsonDecode(value["msg"]) != null) {
        Fluttertoast.showToast(msg: value["msg"]);
      } else {
        // Get.toNamed(Kapply_leaves);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileHandler();
  }

  String? imageUrl;
  bool isLoading = false;
  Map profileData = {};

  Future getProfileHandler() async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.employeeprofile();
    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      setState(() {
        firstName.text = data["Employee"]["fname"];
        firtsnameData = data["Employee"]["fname"];

        lastNameData = data["Employee"]["lname"];

        commentsData = data["Employee"]["comments"];
        lastName.text = data["Employee"]["lname"];
        comments.text = data["Employee"]["comments"];
      });

      await UserSimplePreferences.setUserdata(userData: json.encode(data));
      profileData = data;
    }
    setState(() {
      isLoading = false;
    });
  }

  Future updateProfile() async {
    setState(() {
      isLoading = true;
    });
    Map payload = {
      "fname": firtsnameData,
      "lname": lastNameData,
      "comments": commentsData,
      "profile_pic": controller.profileImageData
    };
    //  "profile_pic": "https://testvenkatvibho.s3.amazonaws.com/https%3A//in.dev.vibhohcm.com/1707830396949%23%23%23sodexo.png"
    if (selectedFilePath != "") {
      Map uploadedFile = await Services.updateprofile(selectedFilePath);
      if (uploadedFile["message"] != null) {
        Fluttertoast.showToast(msg: "Error while uploading image");
        setState(() {
          isLoading = false;
        });
        return;
      } else {
        payload = {...payload, "profile_pic": uploadedFile};
      }
    }

    Map data = await Services.updateprofile(payload);
    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      Fluttertoast.showToast(
        msg: "profile updated successfully",
      );
      await getProfileHandler();
      Get.toNamed(KBottom_navigation);
    }
    setState(() {
      isLoading = false;
    });
  }

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
    _hideKeyboard();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTapOutside,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
          appBar: VibhoAppBar(
            title: "Edit Profile",
            dontHaveBackAsLeading: false,
            bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
          ),
          body: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(20.r),
              child: Column(
                children: [
                  const Profile_image(),
                  SizedBox(
                    height: 18.h,
                  ),
                  CustomFormField(
                    focusNode: _focusNode,
                    onTap: () {
                      _showKeyboard(_focusNode);
                    },
                    maxLines: 1,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.0),
                    readOnly: false,
                    labelText: "First Name",
                    hintText:
                        firtsnameData != "" ? firtsnameData : "First Name",
                    controller: firstName,
                    //hintText: firtsnameData != "" ? firtsnameData : "First Name",
                    //  hintText: "First Name",
                    onChanged: (value) {
                      setState(() {
                        firtsnameData = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  CustomFormField(
                    focusNode: _focustwoNode,
                    onTap: () {
                      _showKeyboard(_focustwoNode);
                    },
                    maxLines: 1,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.0),
                    readOnly: false,
                    // hintText: lastNameData != "" ? lastNameData : "Last Name",
                    hintText: lastNameData != "" ? lastNameData : "Last Name",

                    controller: lastName,
                    labelText: "Last Name",
                    //    hintText: "Last Name",
                    onChanged: (value) {
                      setState(() {
                        lastNameData = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  CustomFormField(
                    focusNode: _focusthreeNode,
                    onTap: () {
                      _showKeyboard(_focusthreeNode);
                    },
                    maxLines: 8,
                    readOnly: false,
                    hintText: commentsData != "" ? commentsData : "About",
                    //  labelText: commentsData != "" ? commentsData : "About",
                    controller: comments,
                    labelText: "About",
                    //    hintText: "About",
                    onChanged: (value) {
                      setState(() {
                        commentsData = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  CustomButton(
                      Color: KOrange,
                      width: double.infinity,
                      height: 38.h,
                      borderRadius: BorderRadius.circular(30.r),
                      textColor: Kwhite,
                      fontSize: kFourteenFont,
                      fontWeight: kFW800,
                      label: "Update",
                      isLoading: false,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          updateProfile();
                        }
                      })
                ],
              ),
            ),
          ))
          // Container(
          //   height: double.infinity,
          //   color: Kwhite,
          //   child: SingleChildScrollView(
          //     child: Form(
          //       key: _formKey,
          //       child: Column(
          //         children: [
          //           Stack(
          //             children: [
          //               Container(
          //                 height: 180.h,
          //                 width: double.infinity,
          //                 decoration: const BoxDecoration(
          //                   image: DecorationImage(
          //                     image: AssetImage("assets/images/hill.png"),
          //                     fit: BoxFit.cover,
          //                   ),
          //                 ),
          //                 child: BackdropFilter(
          //                   filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
          //                   child: Container(
          //                     decoration:
          //                         BoxDecoration(color: Kwhite.withOpacity(0.0)),
          //                   ),
          //                 ),
          //               ),
          //               Container(
          //                 padding: EdgeInsets.all(10.r),
          //                 width: MediaQuery.of(context).size.width - 40,
          //                 margin:
          //                     EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h),
          //                 decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(13.r),
          //                     color: Kwhite,
          //                     boxShadow: [
          //                       BoxShadow(
          //                         color: Colors.black.withOpacity(0.1),
          //                         blurRadius: 20,
          //                         spreadRadius: 2,
          //                       ),
          //                     ]),
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Row(
          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         const Profile_image(),
          //                         Image.asset(
          //                           "assets/images/arrow.png",
          //                           height: 40.h,
          //                         ),
          //                         SizedBox(
          //                           height: 10.h,
          //                         )
          //                       ],
          //                     ),
          //                     SizedBox(
          //                       height: 10.h,
          //                     ),
          // CustomFormField(
          //   maxLines: 1,
          //   contentPadding: EdgeInsets.symmetric(
          //       vertical: 10.h, horizontal: 10.0),
          //   readOnly: false,
          //   labelText: firtsnameData!=""?firtsnameData:"First Name",
          //   controller: firstName,
          //   hintText: "First Name",
          //   onChanged: (value) {
          //     setState(() {
          //       firtsnameData = value;
          //     });
          //   },
          // ),
          //                     SizedBox(
          //                       height: 15.h,
          //                     ),
          // CustomFormField(
          //   maxLines: 1,
          //   contentPadding: EdgeInsets.symmetric(
          //       vertical: 10.h, horizontal: 10.0),
          //   readOnly: false,
          //   labelText: lastNameData!=""?lastNameData:"Last Name",
          //   controller: lastName,
          //   hintText: "Last Name",
          //   onChanged: (value) {
          //     setState(() {
          //       lastNameData = value;
          //     });
          //   },
          // ),
          //                     SizedBox(
          //                       height: 15.h,
          //                     ),
          // CustomFormField(
          //   maxLines: 5,
          //   readOnly: false,
          //   labelText:commentsData!=""?commentsData:"About",
          //   controller: comments,
          //   hintText: "About",
          //   onChanged: (value) {
          //     setState(() {
          //       commentsData = value;
          //     });
          //   },
          // ),
          //                     SizedBox(
          //                       height: 15.h,
          //                     ),
          //                     // Row(
          //                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     //   children: [
          //                     //     Text(
          //                     //       "My Location",
          //                     //       style: TextStyle(
          //                     //           fontSize: 13.sp,
          //                     //           fontWeight: kFW900,
          //                     //           color: KdarkText),
          //                     //     ),
          //                     //     Text(
          //                     //       "Kukatpally Hyderabad... ",
          //                     //       style: TextStyle(
          //                     //           fontSize: 10.sp,
          //                     //           fontWeight: kFW500,
          //                     //           color: KdarkText),
          //                     //     ),
          //                     //   ],
          //                     // ),
          //                     // SizedBox(
          //                     //   height: 15.h,
          //                     // ),
          //                     // Row(
          //                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     //   children: [
          //                     //     Text(
          //                     //       "Show Location",
          //                     //       style: TextStyle(
          //                     //           fontSize: 13.sp,
          //                     //           fontWeight: kFW900,
          //                     //           color: KdarkText),
          //                     //     ),
          //                     //     Switch(
          //                     //       onChanged: toggleSwitch,
          //                     //       value: isSwitched,
          //                     //       activeColor: KOrange,
          //                     //       activeTrackColor: KOrange.withOpacity(0.7),
          //                     //       inactiveThumbColor: Klightgray,
          //                     //       inactiveTrackColor: Klightgray.withOpacity(0.5),
          //                     //     )
          //                     //   ],
          //                     // ),
          //                     SizedBox(
          //                       height: 15.h,
          //                     ),
          //                     CustomButton(
          //                         Color: KOrange,
          //                         width: double.infinity,
          //                         height: 38.h,
          //                         borderRadius: BorderRadius.circular(15.r),
          //                         textColor: Kwhite,
          //                         fontSize: kFourteenFont,
          //                         fontWeight: kFW800,
          //                         label: "Save",
          //                         isLoading: false,
          //                         onTap: () {
          //                           if (_formKey.currentState!.validate()) {
          //                             updateProfile();
          //                           }
          //                         })
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
