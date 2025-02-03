import 'package:lottie/lottie.dart';

import '../untils/export_file.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class Passworddatas {
  String oldpassword = '';
  String newpassword = '';
  String confirmpassword = '';
}

class _ChangePasswordState extends State<ChangePassword> {
  //
  Passworddatas datas = Passworddatas();
  bool passwordVisible = true;
  bool newpasswordVisible = true;
  bool confirmpasswordVisible = true;
  bool isLoading = false;
  Future changePasswordHandler() async {
    setState(() {
      isLoading = true;
    });
    Map payload = {
      "old_password": datas.oldpassword,
      "new_password": datas.newpassword,
      "confirm_new_password": datas.confirmpassword
    }
        // "username": data.username,
        // "password": data.password,
        // "device_id": UserSimplePreferences.getuniquecode(),
        // "fcm_token": UserSimplePreferences.getfcmToken(),
        ;

    Map value = await Services.changePasswordApi(payload);
    if (value["email_id"] == null) {
      Fluttertoast.showToast(
        msg: "Something Went wrong",
      );
    } else {
      Fluttertoast.showToast(
        msg: "Password Changed Successfully.",
      );
      Get.back();
    }
    print(value);
    setState(() {
      isLoading = false;
    });
  }

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
    _hideKeyboard();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTapOutside,
      child: Scaffold(
        backgroundColor: Kwhite,
        appBar: AppBar(
          backgroundColor: Kwhite,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: kblack,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            "Change Password",
            style: TextStyle(
                fontSize: 16, color: kblack, fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(20.r),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    UserSimplePreferences.getLogo() == ""
                        ? Image.asset(
                            "assets/images/logo_final.png",
                            width: 150.w,
                          )
                        : CachedNetworkImage(
                            height: 40.h,
                            width: 150.w,
                            imageUrl: KWebLogo +
                                UserSimplePreferences.getLogo().toString(),
                            placeholder: (context, url) => SizedBox(
                              height: 40.h,
                              width: 40.w,
                              child: Shimmer.fromColors(
                                baseColor: Colors.black12,
                                highlightColor: Colors.white.withOpacity(0.5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Kwhite.withOpacity(0.5),
                                  ),
                                  height: 40.h,
                                  width: 40.w,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/logo_final.png",
                              fit: BoxFit.contain,
                            ),
                            fit: BoxFit.contain,
                          ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Change  Password",
                        textAlign: TextAlign.left,
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 10.sp,
                          fontWeight: kFW600,
                          color: KHeadingText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // Text(
                    //   "Enter your email and instructions will be sent to you!",
                    //   textScaleFactor: 1.2,
                    //   style: TextStyle(
                    //     height: 1.2.h,
                    //     fontSize: 11.sp,
                    //     fontWeight: kFW600,
                    //     color: selectedTheme == "Lighttheme" ? Ktextcolor : Kwhite,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 50.h,
                    // ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      focusNode: _focusNode,
                      onTap: () {
                        _showKeyboard(_focusNode);
                      },
                      //_showKeyboard(_focusNode),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: kFW600,
                        color:
                            selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.start,

                      obscuringCharacter: '●',
                      // style: TextStyle(fontSize: 20),
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        focusColor: Colors.white,

                        contentPadding: const EdgeInsets.only(
                            left: 20.0, bottom: 6.0, top: 8.0),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 0.5),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 0.5),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 0.5),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 1),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 0.5),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        fillColor: Colors.grey,

                        hintText: "**************",

                        //make hint text
                        hintStyle: TextStyle(
                          color: selectedTheme == "Lighttheme"
                              ? Klightgray.withOpacity(0.5)
                              : Kwhite,
                          fontSize: kTwelveFont,
                          fontWeight: FontWeight.w700,
                        ),

                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        ),

                        //create lable
                        labelText: 'Old Password',
                        //lable style
                        labelStyle: TextStyle(
                          color: selectedTheme == "Lighttheme"
                              ? Klightgray
                              : Kwhite,
                          fontSize: kTwelveFont,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        datas.oldpassword = value;
                      },
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    TextFormField(
                      focusNode: _focustwoNode,
                      onTap: () {
                        _showKeyboard(_focustwoNode);
                      },
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: kFW600,
                        color:
                            selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.start,

                      obscuringCharacter: '●',
                      // style: TextStyle(fontSize: 20),
                      obscureText: newpasswordVisible,
                      decoration: InputDecoration(
                        focusColor: Colors.white,

                        contentPadding: const EdgeInsets.only(
                            left: 20.0, bottom: 6.0, top: 8.0),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 0.5),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 0.5),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 0.5),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 1),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 0.5),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        fillColor: Colors.grey,

                        hintText: "**************",

                        //make hint text
                        hintStyle: TextStyle(
                          color: selectedTheme == "Lighttheme"
                              ? Klightgray.withOpacity(0.5)
                              : Kwhite,
                          fontSize: kTwelveFont,
                          fontWeight: FontWeight.w700,
                        ),

                        suffixIcon: IconButton(
                          icon: Icon(
                            newpasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                newpasswordVisible = !newpasswordVisible;
                              },
                            );
                          },
                        ),

                        //create lable
                        labelText: 'New Password',
                        //lable style
                        labelStyle: TextStyle(
                          color: selectedTheme == "Lighttheme"
                              ? Klightgray
                              : Kwhite,
                          fontSize: kTwelveFont,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter New password';
                        } else if (value.length < 5) {
                          return 'This value is too short. It should have 5 characters or more';
                        } else {
                          return null;
                        }
                        //  return null;
                      },
                      onChanged: (String value) {
                        datas.newpassword = value;
                      },
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    TextFormField(
                      focusNode: _focusthreeNode,

                      onTap: () {
                        _showKeyboard(_focusthreeNode);
                      },
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: kFW600,
                        color:
                            selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.start,

                      obscuringCharacter: '●',
                      // style: TextStyle(fontSize: 20),
                      obscureText: confirmpasswordVisible,
                      decoration: InputDecoration(
                        focusColor: Colors.white,

                        contentPadding: const EdgeInsets.only(
                            left: 20.0, bottom: 6.0, top: 8.0),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 0.5),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 0.5),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 0.5),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 1),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Ktextcolor, width: 0.5),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        fillColor: Colors.grey,

                        hintText: "**************",

                        //make hint text
                        hintStyle: TextStyle(
                          color: selectedTheme == "Lighttheme"
                              ? Klightgray.withOpacity(0.5)
                              : Kwhite,
                          fontSize: kTwelveFont,
                          fontWeight: FontWeight.w700,
                        ),

                        suffixIcon: IconButton(
                          icon: Icon(
                            confirmpasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                confirmpasswordVisible =
                                    !confirmpasswordVisible;
                              },
                            );
                          },
                        ),

                        //create lable
                        labelText: 'Confirm New Password',
                        //lable style
                        labelStyle: TextStyle(
                          color: selectedTheme == "Lighttheme"
                              ? Klightgray
                              : Kwhite,
                          fontSize: kTwelveFont,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Confirm password';
                        } else if (value.length < 5) {
                          return 'This value is too short. It should have 5 characters or more';
                        } else if (datas.newpassword != datas.confirmpassword) {
                          return 'New Password and Confirm Password do not match';
                        } else {
                          return null;
                        }

                        // } else {
                        //   return null;
                        // }
                        //  int length = gfg.length
                        // if (value!.isEmpty) {
                        //   return 'Please enter Confirm password';
                        // }
                        // return null;
                      },
                      onChanged: (String value) {
                        datas.confirmpassword = value;
                      },
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    CustomButton(
                        height: 35.h,
                        width: double.infinity,
                        textColor: Kwhite,
                        borderRadius: BorderRadius.circular(20.r),
                        Color: KOrange,
                        fontSize: kFourteenFont,
                        fontWeight: kFW600,
                        label: isLoading == false ? "Submit" : 'Loading...',
                        isLoading: false,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            changePasswordHandler();
                            // if (datas.newpassword == datas.confirmpassword) {
                            //   changePasswordHandler();
                            // } else {
                            //   showDialog(
                            //       context: context,
                            //       builder: (BuildContext context) {
                            //         return AlertDialog(
                            //           // title: Lottie.asset(
                            //           //   'assets/images/cancel.json',
                            //           //   width: 50.w,
                            //           //   height: 50.h,
                            //           //   fit: BoxFit.cover,
                            //           // ),
                            //           // //  Icon(
                            //           // //   Icons.cancel_outlined,
                            //           // //   color: KRed,
                            //           // //   size: 50.sp,
                            //           // // ),
                            //           content: SizedBox(
                            //             height:
                            //                 MediaQuery.of(context).size.height /
                            //                     5,
                            //             child: Column(
                            //               children: [
                            //                 Lottie.asset(
                            //                   'assets/images/cancel.json',
                            //                   width: 80.h,
                            //                   height: 80.h,
                            //                   fit: BoxFit.cover,
                            //                 ),
                            //                 SizedBox(
                            //                   height: 15.h,
                            //                 ),
                            //                 Text(
                            //                     'New Password and Confirm Password do not match',
                            //                     maxLines: 2,
                            //                     textAlign: TextAlign.center,
                            //                     style: TextStyle(
                            //                         fontSize: 14.sp,
                            //                         fontWeight: kFW700,
                            //                         color: selectedTheme ==
                            //                                 "Lighttheme"
                            //                             ? KdarkText.withOpacity(
                            //                                 0.7)
                            //                             : Kwhite)),
                            //               ],
                            //             ),
                            //           ),
                            //           actions: [
                            //             CustomButton(
                            //                 height: 32.h,
                            //                 margin: EdgeInsets.only(
                            //                     left: 30.w, right: 30.w),
                            //                 width: double.infinity,
                            //                 textColor: Kwhite,
                            //                 borderRadius:
                            //                     BorderRadius.circular(20.r),
                            //                 Color: KOrange,
                            //                 fontSize: kFourteenFont,
                            //                 fontWeight: kFW600,
                            //                 label: 'Ok',
                            //                 isLoading: false,
                            //                 onTap: () async {
                            //                   Get.back();
                            //                 }),
                            //           ],
                            //         );
                            //       });
                            //   // showDialog(
                            //   //     context: context,
                            //   //     builder: (BuildContext context) {
                            //   //       return AlertDialog(
                            //   //         title: Icon(
                            //   //           Icons.cancel_outlined,
                            //   //           color: KRed,
                            //   //         ),
                            //   //         content: Text(
                            //   //             'New Password and Confirm Password do not match',
                            //   //             maxLines: 2,
                            //   //             overflow: TextOverflow.ellipsis,
                            //   //             style: TextStyle(
                            //   //                 fontSize: 12.sp,
                            //   //                 fontWeight: kFW700,
                            //   //                 color: selectedTheme == "Lighttheme"
                            //   //                     ? KdarkText.withOpacity(0.7)
                            //   //                     : Kwhite)),
                            //   //         actions: [
                            //   //           TextButton(
                            //   //             // textColor: Color(0xFF6200EE),
                            //   //             onPressed: () async {
                            //   //               // List dataList =
                            //   //               //     await _databaseHelper.getDataList();
                            //   //               // UserSimplePreferences.clearAllData();
                            //   //               // // await _databaseHelper.deleteTask(0);
                            //   //               // await _databaseHelper.del(dataList[0].name1);
                            //   //               // _deleteCacheDir();
                            //   //               // _deleteAppDir();
                            //   //               // service.invoke("stopService");

                            //   //               ///
                            //   //               /// Delete the database at the given path.
                            //   //               ///
                            //   //               // Future<void> deleteDatabase(String path) =>
                            //   //               //     _databaseHelper.database;

                            //   //               // Get.offAllNamed(Kwebaddress_login);
                            //   //               Get.back();
                            //   //             },
                            //   //             child: Text('Ok',
                            //   //                 maxLines: 1,
                            //   //                 overflow: TextOverflow.ellipsis,
                            //   //                 style: TextStyle(
                            //   //                     fontSize: 12.sp,
                            //   //                     fontWeight: kFW700,
                            //   //                     color: selectedTheme ==
                            //   //                             "Lighttheme"
                            //   //                         ? KdarkText
                            //   //                         : Kwhite)),
                            //   //           )
                            //   //         ],
                            //   //       );
                            //   //     });

                            //   // Fluttertoast.showToast(
                            //   //   msg:
                            //   //       "New Password and Confirm Password do not match",
                            //   // );
                            // }
                          }
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
