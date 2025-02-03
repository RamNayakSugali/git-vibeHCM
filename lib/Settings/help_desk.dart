// ignore_for_file: camel_case_types

import '../untils/export_file.dart';

class HelpDesk extends StatefulWidget {
  const HelpDesk({super.key});

  @override
  State<HelpDesk> createState() => _HelpDeskState();
}

class _HelpDeskState extends State<HelpDesk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        appBar: VibhoAppBar(
          title: "Help Desk",
          bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
          dontHaveBackAsLeading: false,
        ),
        body: Container(
          margin: EdgeInsets.all(15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 180.w,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Hello, How Can we help you?',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: kFW500,
                  color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                " If You're experiencing issues with the process. We're here to help. Contact us now to resolve the problem. ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: kTwelveFont,
                  fontWeight: kFW400,
                  color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              // GestureDetector(
              //   onTap: () {
              //     launchUrl(
              //         Uri.parse('https://wa.me/${27}${817789040}?text=Hi '),
              //         // Uri.parse('https://wa.me/${91}${6281682528}?text=Hi '),
              //         mode: LaunchMode.externalApplication);
              //   },
              //   //               onTap: whatsapp() async{
              //   //    var contact = "+880123232333";
              //   //    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
              //   //    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

              //   //    try{
              //   //       if(Platform.isIOS){
              //   //          await launchUrl(Uri.parse(iosUrl));
              //   //       }
              //   //       else{
              //   //          await launchUrl(Uri.parse(androidUrl));
              //   //       }
              //   //    } on Exception{
              //   //      EasyLoading.showError('WhatsApp is not installed.');
              //   //   }
              //   // }
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         "Contact WhatsApp :  ",
              //         style: TextStyle(
              //             fontSize: 13.sp,
              //             fontWeight: kFW500,
              //             color: Klightgray),
              //       ),
              //       Text(
              //         "Message +27 817789040",
              //         style: TextStyle(
              //             // wordSpacing: 2,
              //             fontSize: 13.sp,
              //             fontWeight: kFW500,
              //             color: KdarkText),
              //       ),
              //     ],
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  launchUrl(
                      Uri.parse('https://wa.me/${27}${662202293}?text=Hi '),
                      mode: LaunchMode.externalApplication);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10.h),
                  decoration: BoxDecoration(
                      color:
                          selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0.5,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                          color: Ktextcolor.withOpacity(0.2),
                        )
                      ],
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Ktextcolor.withOpacity(0.01),
                      //     blurRadius: 5,
                      //     offset: const Offset(0, 0),
                      //     spreadRadius: 2,
                      //   )
                      // ],
                      borderRadius: BorderRadius.circular(10.r)),
                  //margin: EdgeInsets.all(13.r),
                  child: ListTile(
                      title: Text(
                        "Contact WhatsApp",
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: selectedTheme == "Lighttheme"
                              ? KdarkText
                              : Kwhite,
                        ),
                      ),
                      // subtitle: Text(
                      //   Setting[i]["name"],
                      // ),
                      // subtitle: Text(
                      //   //"Lorem Epson is a Dummy Text",
                      //    Setting_list[i]["Subtext"],
                      //   maxLines: 2,
                      //   textAlign: TextAlign.left,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //       fontSize: kTenFont,
                      //       fontWeight: kFW500,
                      //       color: Klight),
                      // ),
                      trailing: Image.asset(
                        "assets/images/watsapp.png",
                        width: 40.w,
                        fit: BoxFit.fill,
                      )
                      // color: KOrange,
                      // alignment: Alignment.bottomLeft,
                      // fit: BoxFit.fill,
                      // semanticsLabel: 'Acme Logo'
                      ),
                ),
              ),

              // _infoTile('App version', _packageInfo.version),
              SizedBox(
                height: 60.h,
              ),
            ],
          ),
        ));
  }
}
