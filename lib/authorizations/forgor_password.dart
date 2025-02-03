import 'package:vibeshr/untils/export_file.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class Employeedatas {
  String email = '';
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // Forgotdata datas = Forgotdata();
  Employeedatas datas = Employeedatas();
  List newNotificationsPacks = [];
  Map notifiydata = {};
  bool isLoading = false;
  Future ForgotPasswordApi() async {
    setState(() {
      isLoading = true;
    });

    Map data = await Services.forgotPassword(datas.email);

    if (data["email_id"] == null) {
      Fluttertoast.showToast(
        msg: "Something Went wrong",
      );
    } else {
      Fluttertoast.showToast(
        msg: "Successfull",
      );
      Get.back();
    }
    setState(() {
      isLoading = false;
    });
  }

  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();

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
        appBar: VibhoAppBar(
          title: '',
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
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Reset  Password",
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        fontSize: kEighteenFont,
                        fontWeight: kFW700,
                        color: KHeadingText,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Enter your email and instructions will be sent to you!",
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      height: 1.2.h,
                      fontSize: 11.sp,
                      fontWeight: kFW600,
                      color:
                          selectedTheme == "Lighttheme" ? Ktextcolor : Kwhite,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  TextFormField(
                    focusNode: _focusNode,
                    onTap: () {
                      _showKeyboard(_focusNode);
                    },
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: kFW600,
                      color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
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

                      hintText: "Email",

                      //make hint text
                      hintStyle: TextStyle(
                        color: selectedTheme == "Lighttheme"
                            ? Klightgray.withOpacity(0.5)
                            : Kwhite,
                        fontSize: kTenFont,
                        fontWeight: FontWeight.w700,
                      ),

                      //create lable
                      labelText: 'Email',
                      //lable style
                      labelStyle: TextStyle(
                        color:
                            selectedTheme == "Lighttheme" ? Klightgray : Kwhite,
                        fontSize: kTwelveFont,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Email';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      datas.email = value;
                      //  data.email = value;
                    },
                    // onChanged: (String value) {},
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
                      label: "Reset",
                      isLoading: false,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          ForgotPasswordApi();
                        }
                      }),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    "Or",
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      height: 1.2.h,
                      fontSize: 11.sp,
                      fontWeight: kFW600,
                      color:
                          selectedTheme == "Lighttheme" ? Ktextcolor : Kwhite,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: RichText(
                      textScaleFactor: 1,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: "Remember It?",

                        style: TextStyle(
                          fontSize: kSixteenFont,
                          fontWeight: kFW600,
                          color: KHeadingText,
                        ),
                        // TextStyle(
                        //   fontSize: kTwentyFont,
                        //   fontWeight: FontWeight.bold,
                        //   color: selectedTheme == "Lighttheme"
                        //       ? KdarkText
                        //       : Kwhite,
                        // ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "  Login Here",
                            style: TextStyle(
                              fontSize: kSixteenFont,
                              fontWeight: kFW600,
                              color: KHeadingText.withOpacity(0.8),
                            ),
                            // style: TextStyle(
                            //     fontSize: kTwentyFont,
                            //     fontWeight: FontWeight.bold,
                            //     color: KOrange),
                          ),
                        ],
                      ),
                    ),
                  )
                  // Text(
                  //   "Login",
                  //   textAlign: TextAlign.center,
                  //   textScaleFactor: 1.2,
                  //   style: TextStyle(
                  //     fontSize: kTwelveFont,
                  //     fontWeight: kFW600,
                  //     color: KHeadingText.withOpacity(0.8),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
