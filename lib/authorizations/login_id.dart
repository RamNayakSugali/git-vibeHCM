// ignore_for_file: camel_case_types, unused_element

import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:vibeshr/untils/export_file.dart';

class Login_id extends StatefulWidget {
  const Login_id({super.key});

  @override
  State<Login_id> createState() => _Login_idState();
}

class Employeedata {
  String username = '';
  String password = '';
}

String _identifier = 'Unknown';

class _Login_idState extends State<Login_id> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool isLoading = false;

  Employeedata data = Employeedata();

  getFCMDid() async {
    String? token = await FirebaseMessaging.instance.getToken();
    UserSimplePreferences.setfcmToken(token);
  }

  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;
    UserSimplePreferences.setuniquecode(identifier);
    setState(() {
      _identifier = identifier;
    });
  }

  var errorString = "";
  Future employeeHandler() async {
    setState(() {
      errorString = "";
      isLoading = true;
    });
    Map payload = {
      "username": data.username,
      "password": data.password,
      "device_id": UserSimplePreferences.getuniquecode(),
      "fcm_token": UserSimplePreferences.getfcmToken(),
    };

    Map value = await Services.employeelogin(payload);
    if (value["message"] != null) {
      errorString = value["message"];
    } else {
      await UserSimplePreferences.setLoginStatus(loginStatus: true);
      await UserSimplePreferences.setUserdata(
          userData: json.encode(value["results"]));
      await UserSimplePreferences.setToken(token: value["Token"]);

      await UserSimplePreferences.setRefreshToken(
          refreshToken: "refresh_token");
      Get.toNamed(KBottom_navigation);
    }
    print(value);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getFCMDid();
    super.initState();
    passwordVisible = true;
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure?',
              style: TextStyle(
                  fontSize: kEighteenFont,
                  fontWeight: kFW600,
                  color: Klightgray),
            ),
            content: Text(
              'Do you want to exit an App',
              style: TextStyle(
                  fontSize: 13.sp, fontWeight: kFW600, color: Klightgray),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: TextStyle(
                      fontSize: kTwelveFont,
                      fontWeight: kFW600,
                      color: KOrange),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                // <-- SEE HERE
                child: Text(
                  'Yes',
                  style: TextStyle(
                      fontSize: kTwelveFont,
                      fontWeight: kFW600,
                      color: KOrange),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  FocusNode _focusNode = FocusNode();
  FocusNode _focustwoNode = FocusNode();

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
        // resizeToAvoidBottomInset: true,
        backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        body: !Platform.isWindows
            ? SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(15.r),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100.h,
                        ),
                        UserSimplePreferences.getLogo() == ""
                            ? Image.asset(
                                "assets/images/logo_final.png",
                                width: 150.w,
                              )
                            : CachedNetworkImage(
// =======
//                           //create lable
//                           labelText: 'Password',
//                           //lable style
//                           labelStyle: TextStyle(
//                             color: selectedTheme == "Lighttheme"
//                                 ? Klightgray
//                                 : Kwhite,
//                             fontSize: kTwelveFont,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter password';
//                           }
//                           return null;
//                         },
//                         onChanged: (String value) {
//                           data.password = value;
//                         },
//                       ),

//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       SizedBox(
//                           width: 200.w,
//                           child: Divider(
//                             color: Ktextcolor.withOpacity(0.5),
//                           )),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(errorString,
//                               textAlign: TextAlign.left,
//                               textScaleFactor: 1.2,
//                               style: TextStyle(
//                                   height: 1.0.h,
//                                   fontSize: 8.sp,
//                                   // fontWeight: kFW600,
//                                   color: KRed)),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       Align(
//                         alignment: Alignment.center,
//                         child: GestureDetector(
//                           onTap: () {
//                             Get.toNamed(KForgotPassword);
//                           },
//                           child: Text(
//                             "Forgot Password ?",
//                             textAlign: TextAlign.end,
//                             textScaleFactor: 1.2,
//                             style: TextStyle(
//                               height: 1.2.h,
//                               fontSize: 10.sp,
//                               fontWeight: kFW600,
//                               color: selectedTheme == "Lighttheme"
//                                   ? Ktextcolor.withOpacity(0.8)
//                                   : Kwhite,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       isLoading
//                           ? const Center(
//                               child:  SpinKitFadingCircle(
//                               color: KOrange,
//                               size: 15,
//                             ))
//                           : CustomButton(
//                               height: 35.h,
//                               width: double.infinity,
//                               textColor: Kwhite,
//                               borderRadius: BorderRadius.circular(20.r),
//                               Color: KOrange,
//                               fontSize: kFourteenFont,
//                               fontWeight: kFW600,
//                               label: "Login",
//                               isLoading: false,
//                               onTap: () async {
//                                 if (_formKey.currentState!.validate()) {
//                                   await employeeHandler();
//                                 }
//                               })
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           : SingleChildScrollView(
//               child: Container(
//                 margin: EdgeInsets.all(15.r),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     //mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 100.h,
//                       ),
//                       UserSimplePreferences.getLogo() == ""
//                           ? Image.asset(
//                               "assets/images/logo_final.png",
//                               width: 150.w,
//                             )
//                           : CachedNetworkImage(
//                               height: 40.h,
//                               width: 150.w,
//                               imageUrl: KWebLogo +
//                                   UserSimplePreferences.getLogo().toString(),
//                               placeholder: (context, url) => SizedBox(
// >>>>>>> master
                                height: 40.h,
                                width: 150.w,
                                imageUrl: KWebLogo +
                                    UserSimplePreferences.getLogo().toString(),
                                placeholder: (context, url) => SizedBox(
                                  height: 40.h,
                                  width: 40.w,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
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
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/logo_final.png",
                                  fit: BoxFit.contain,
                                ),
                                fit: BoxFit.contain,
                              ),

                        SizedBox(
                          height: 30.h,
                        ),
                        //   Text(UserSimplePreferences.getCompanyname().toString()),
                        UserSimplePreferences.getCompanyname() == ""
                            ? RichText(
                                textScaleFactor: 1,
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: "Welcome to Vibho",
                                  style: TextStyle(
                                    fontSize: kTwentyFont,
                                    fontWeight: FontWeight.bold,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "HCM",
                                      style: TextStyle(
                                          fontSize: kTwentyFont,
                                          fontWeight: FontWeight.bold,
                                          color: KOrange),
                                    ),
                                  ],
                                ),
                              )
                            : RichText(
                                textScaleFactor: 1,
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: "Welcome to ",
                                  style: TextStyle(
                                    fontSize: kTwentyFont,
                                    fontWeight: FontWeight.bold,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          UserSimplePreferences.getCompanyname()
                                              .toString()
                                              .capitalize!,
                                      style: TextStyle(
                                          fontSize: kTwentyFont,
                                          fontWeight: FontWeight.bold,
                                          color: KOrange),
                                    ),
                                  ],
                                ),
                              ),

                        SizedBox(
                          height: 8.h,
                        ),
                        UserSimplePreferences.getCompanyname() == ""
                            ? Text(
                                //  "Let’s start by entering your company’s ${UserSimplePreferences.getCompanyname().toString()} with Employee ID & Password",
                                "Let’s start by entering your company’s VibhoHCM with Employee ID & Password",
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                  height: 1.2.h,
                                  fontSize: 11.sp,
                                  fontWeight: kFW600,
                                  color: selectedTheme == "Lighttheme"
                                      ? Ktextcolor
                                      : Kwhite,
                                ),
                              )
                            : Text(
                                "Let's begin by entering your employee ID and password into your company's ${UserSimplePreferences.getCompanyname().toString().capitalize!}",

                                //   "Let’s start by entering your company’s ${UserSimplePreferences.getCompanyname().toString().capitalize!} with Employee ID & Password",
                                //    "Let’s start by entering your company’s VibhoHCM with Employee ID & Password",
                                textAlign: TextAlign.center,

                                textScaleFactor: 1.2,
                                style: TextStyle(
                                  height: 1.2.h,
                                  fontSize: 11.sp,
                                  fontWeight: kFW600,
                                  color: selectedTheme == "Lighttheme"
                                      ? Ktextcolor
                                      : Kwhite,
                                ),
                              ),
                        SizedBox(
                          height: 40.h,
                        ),
                        /////TextFormFields
                        TextFormField(
                          focusNode: _focusNode,
                          onTap: () {
                            _showKeyboard(_focusNode);
                          },
                          textCapitalization: TextCapitalization.characters,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: kFW600,
                            color: selectedTheme == "Lighttheme"
                                ? KdarkText
                                : Kwhite,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            contentPadding: const EdgeInsets.only(
                                left: 20.0, bottom: 6.0, top: 8.0),
                            // contentPadding: const EdgeInsets.symmetric(
                            //     vertical: 13.0, horizontal: 10.0),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Ktextcolor, width: 0.5),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Ktextcolor, width: 0.5),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Ktextcolor, width: 0.5),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Ktextcolor, width: 1),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Ktextcolor, width: 0.5),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            fillColor: Colors.grey,

                            hintText: "Employee ID",

                            //make hint text
                            hintStyle: TextStyle(
                              color: selectedTheme == "Lighttheme"
                                  ? Klightgray.withOpacity(0.5)
                                  : Kwhite,
                              fontSize: kTenFont,
                              fontWeight: FontWeight.w700,
                            ),

                            //create lable
                            labelText: 'Employee ID',
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
                            (input) => input.isValidEmail()
                                ? null
                                : "Check your Employee Id";
                            if (value!.isEmpty) {
                              return 'Please enter Employee Id';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            data.username = value;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          focusNode: _focustwoNode,
                          onTap: () {
                            _showKeyboard(_focustwoNode);
                          },
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: kFW600,
                            color: selectedTheme == "Lighttheme"
                                ? KdarkText
                                : Kwhite,
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
                              borderSide: const BorderSide(
                                  color: Ktextcolor, width: 0.5),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Ktextcolor, width: 0.5),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Ktextcolor, width: 0.5),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Ktextcolor, width: 1),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Ktextcolor, width: 0.5),
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
                            labelText: 'Password',
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
                            data.password = value;
                          },
                        ),

                        SizedBox(
                          height: 12.h,
                        ),
                        SizedBox(
                            width: 200.w,
                            child: Divider(
                              color: Ktextcolor.withOpacity(0.5),
                            )),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(errorString,
                                textAlign: TextAlign.left,
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                    height: 1.0.h,
                                    fontSize: 8.sp,
                                    // fontWeight: kFW600,
                                    color: KRed)),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(KForgotPassword);
                            },
                            child: Text(
                              "Forgot Password ?",
                              textAlign: TextAlign.end,
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                height: 1.2.h,
                                fontSize: 10.sp,
                                fontWeight: kFW600,
                                color: selectedTheme == "Lighttheme"
                                    ? Ktextcolor.withOpacity(0.8)
                                    : Kwhite,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        isLoading
                            ? const Center(
                                child: SpinKitFadingCircle(
                                color: KOrange,
                                size: 35,
                              ))
                            : CustomButton(
                                height: 35.h,
                                width: double.infinity,
                                textColor: Kwhite,
                                borderRadius: BorderRadius.circular(20.r),
                                Color: KOrange,
                                fontSize: kFourteenFont,
                                fontWeight: kFW600,
                                label: "Login",
                                isLoading: false,
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await employeeHandler();
                                  }
                                })
                      ],
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(15.r),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100.h,
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
                                    highlightColor:
                                        Colors.white.withOpacity(0.5),
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
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/man.png",
                                  fit: BoxFit.contain,
                                ),
                                fit: BoxFit.contain,
                              ),

                        SizedBox(
                          height: 30.h,
                        ),
                        //   Text(UserSimplePreferences.getCompanyname().toString()),
                        UserSimplePreferences.getCompanyname() == ""
                            ? RichText(
                                textScaleFactor: 1,
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: "Welcome to Vibho",
                                  style: TextStyle(
                                    fontSize: kTwentyFont,
                                    fontWeight: FontWeight.bold,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "HCM",
                                      style: TextStyle(
                                          fontSize: kTwentyFont,
                                          fontWeight: FontWeight.bold,
                                          color: KOrange),
                                    ),
                                  ],
                                ),
                              )
                            : RichText(
                                textScaleFactor: 1,
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: "Welcome to ",
                                  style: TextStyle(
                                    fontSize: kTwentyFont,
                                    fontWeight: FontWeight.bold,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          UserSimplePreferences.getCompanyname()
                                              .toString()
                                              .capitalize!,
                                      style: TextStyle(
                                          fontSize: kTwentyFont,
                                          fontWeight: FontWeight.bold,
                                          color: KOrange),
                                    ),
                                  ],
                                ),
                              ),

                        SizedBox(
                          height: 8.h,
                        ),
                        UserSimplePreferences.getCompanyname() == ""
                            ? SizedBox(
                                width: 160.w,
                                child: Text(
                                  //  "Let’s start by entering your company’s ${UserSimplePreferences.getCompanyname().toString()} with Employee ID & Password",
                                  "Let’s start by entering your company’s VibhoHCM with Employee ID & Password",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  textScaleFactor: 1.2,
                                  style: TextStyle(
                                    height: 1.2.h,
                                    fontSize: 11.sp,
                                    fontWeight: kFW600,
                                    color: selectedTheme == "Lighttheme"
                                        ? Ktextcolor
                                        : Kwhite,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 160.w,
                                child: Text(
                                  "Let's begin by entering your employee ID and password into your company's ${UserSimplePreferences.getCompanyname().toString().capitalize!}",

                                  //   "Let’s start by entering your company’s ${UserSimplePreferences.getCompanyname().toString().capitalize!} with Employee ID & Password",
                                  //    "Let’s start by entering your company’s VibhoHCM with Employee ID & Password",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  textScaleFactor: 1.2,
                                  style: TextStyle(
                                    height: 1.2.h,
                                    fontSize: 11.sp,
                                    fontWeight: kFW600,
                                    color: selectedTheme == "Lighttheme"
                                        ? Ktextcolor
                                        : Kwhite,
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 40.h,
                        ),
                        /////TextFormFields
                        SizedBox(
                          width: 160.w,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.characters,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: kFW600,
                              color: selectedTheme == "Lighttheme"
                                  ? KdarkText
                                  : Kwhite,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              contentPadding: const EdgeInsets.only(
                                  left: 20.0, bottom: 6.0, top: 8.0),
                              // contentPadding: const EdgeInsets.symmetric(
                              //     vertical: 13.0, horizontal: 10.0),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Ktextcolor, width: 0.5),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Ktextcolor, width: 0.5),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Ktextcolor, width: 0.5),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Ktextcolor, width: 1),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Ktextcolor, width: 0.5),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              fillColor: Colors.grey,

                              hintText: "Employee ID",

                              //make hint text
                              hintStyle: TextStyle(
                                color: selectedTheme == "Lighttheme"
                                    ? Klightgray.withOpacity(0.5)
                                    : Kwhite,
                                fontSize: kTenFont,
                                fontWeight: FontWeight.w700,
                              ),

                              //create lable
                              labelText: 'Employee ID',
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
                              (input) => input.isValidEmail()
                                  ? null
                                  : "Check your Employee Id";
                              if (value!.isEmpty) {
                                return 'Please enter Employee Id';
                              }
                              return null;
                            },
                            onChanged: (String value) {
                              data.username = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: 160.w,
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: kFW600,
                              color: selectedTheme == "Lighttheme"
                                  ? KdarkText
                                  : Kwhite,
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
                                borderSide: const BorderSide(
                                    color: Ktextcolor, width: 0.5),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Ktextcolor, width: 0.5),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Ktextcolor, width: 0.5),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Ktextcolor, width: 1),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Ktextcolor, width: 0.5),
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
                              labelText: 'Password',
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
                              data.password = value;
                            },
                          ),
                        ),

                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                            width: 160.w,
                            child: Divider(
                              color: Ktextcolor.withOpacity(0.5),
                            )),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(errorString,
                                textAlign: TextAlign.left,
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                    height: 1.0.h,
                                    fontSize: 8.sp,
                                    // fontWeight: kFW600,
                                    color: KRed)),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        isLoading
                            ? const Center(
                                child: SpinKitFadingCircle(
                                color: KOrange,
                                size: 15,
                              ))
                            : CustomButton(
                                height: 35.h,
                                width: 160.w,
                                // width: double.infinity,
                                textColor: Kwhite,
                                borderRadius: BorderRadius.circular(20.r),
                                Color: KOrange,
                                fontSize: kFourteenFont,
                                fontWeight: kFW600,
                                label: "Login",
                                isLoading: false,
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await employeeHandler();
                                  }
                                })
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
