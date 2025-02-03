// ignore_for_file: camel_case_types

import '../untils/export_file.dart';

class Security_view extends StatefulWidget {
  const Security_view({super.key});

  @override
  State<Security_view> createState() => _Security_viewState();
}

class _Security_viewState extends State<Security_view> {
  @override
  void initState() {
    super.initState();
    selectedTheme;
  }

  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) async {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
    UserSimplePreferences().setBioMetricSTatuc(isSwitched);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
        appBar: VibhoAppBar(
          bColor: selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
          title: 'Security',
          dontHaveBackAsLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(left: 20.w),
                    padding: EdgeInsets.only(
                        left: 10.w, right: 10.w, top: 15.h, bottom: 5.h),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Ktextcolor.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 0),
                            spreadRadius: 2, //New
                          )
                        ],
                        borderRadius: BorderRadius.circular(12.r),
                        gradient: const LinearGradient(
                            colors: [KdarkText, Klightgray],
                            begin: Alignment.bottomCenter,
                            end: Alignment.center)),
                    child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/finger.png",
                          height: 28.h,
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: 125.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                // width: 125.w,
                                child: Text(
                                  "Biometric",
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: kFW900,
                                      color: Kwhite),
                                ),
                              ),
                              Switch(
                                onChanged: toggleSwitch,
                                value: UserSimplePreferences.getBioMetricStatic()??false,
                                activeColor: Kwhite,
                                activeTrackColor: Kgreen.withOpacity(0.7),
                                inactiveThumbColor: Klightgray,
                                inactiveTrackColor: KRed.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SvgPicture.asset("assets/images/arrow.svg",
                            color: KOrange,
                            alignment: Alignment.bottomLeft,
                            fit: BoxFit.fill,
                            semanticsLabel: 'Acme Logo')
                        // Image.asset(
                        //   "assets/images/arrow.png",
                        //   height: 30.h,
                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Padding(
                //   padding: EdgeInsets.only(left: 15.w),
                //   child: Text(
                //     "Mode",
                //     style: TextStyle(
                //       fontSize: 16.sp,
                //       fontWeight: kFW800,
                //       color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
                //       letterSpacing: 0.5,
                //     ),
                //   ),
                // ),
                SizedBox(height: 10.h),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       selectedTheme == "Lighttheme"
                //           ? selectedTheme = "Dark theme"
                //           : selectedTheme = "Lighttheme";
                //     });
                //   },
                //   child: Container(
                //     margin: EdgeInsets.only(left: 25.w),
                //     padding: EdgeInsets.only(
                //         left: 10.w, right: 10.w, top: 15.h, bottom: 5.h),
                //     decoration: selectedTheme == "Lighttheme"
                //         ? BoxDecoration(
                //             boxShadow: [
                //                 BoxShadow(
                //                   color: Ktextcolor.withOpacity(0.1),
                //                   blurRadius: 20,
                //                   offset: const Offset(0, 0),
                //                   spreadRadius: 2, //New
                //                 )
                //               ],
                //             borderRadius: BorderRadius.circular(12.r),
                //             color: Kwhite)
                //         : BoxDecoration(
                //             boxShadow: [
                //                 BoxShadow(
                //                   color: Ktextcolor.withOpacity(0.1),
                //                   blurRadius: 20,
                //                   offset: const Offset(0, 0),
                //                   spreadRadius: 2, //New
                //                 )
                //               ],
                //             borderRadius: BorderRadius.circular(12.r),
                //             gradient: const LinearGradient(
                //                 colors: [KdarkText, Klightgray],
                //                 begin: Alignment.bottomCenter,
                //                 end: Alignment.center)),
                //     child: Column(
                //       //   mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Image.asset(
                //           // "assets/images/bulb_off.png",
                //           selectedTheme == "Lighttheme"
                //               ? "assets/images/bulb_off.png"
                //               : "assets/images/bulb_on.png",
                //           height: 28.h,
                //         ),
                //         SizedBox(height: 10.h),
                //         SizedBox(
                //           width: 125.w,
                //           child: Text(
                //             selectedTheme == "Lighttheme"
                //                 ? "Light Mode"
                //                 : "Dark Mode",
                //             maxLines: 1,
                //             textAlign: TextAlign.left,
                //             overflow: TextOverflow.ellipsis,
                //             style: TextStyle(
                //                 fontSize: 11.sp,
                //                 fontWeight: kFW600,
                //                 color: KdarkText),
                //           ),
                //         ),
                //         // SizedBox(
                //         //   height: 5.h,
                //         // ),
                //         // SizedBox(
                //         //   width: 105.w,
                //         //   child: Text(
                //         //     selectedTheme == "Lighttheme"
                //         //         ? "In-Active"
                //         //         : "Active",
                //         //     maxLines: 2,
                //         //     textAlign: TextAlign.left,
                //         //     overflow: TextOverflow.ellipsis,
                //         //     style: TextStyle(
                //         //         fontSize: kTenFont,
                //         //         fontWeight: kFW800,
                //         //         color: selectedTheme == "Lighttheme"
                //         //             ? KRed
                //         //             : Kgreen),
                //         //   ),
                //         // ),
                //         SizedBox(
                //           height: 5.h,
                //         ),
                //         // SvgPicture.asset("assets/images/arrow.svg",
                //         //     color: KOrange,
                //         //     alignment: Alignment.bottomLeft,
                //         //     fit: BoxFit.fill,
                //         //     semanticsLabel: 'Acme Logo')
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ));
  }
}
