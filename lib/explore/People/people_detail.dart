import 'dart:ui';

import '../../untils/export_file.dart';

class PeopleDetailed extends StatefulWidget {
  const PeopleDetailed({super.key});

  @override
  State<PeopleDetailed> createState() => _PeopleDetailedState();
}

class _PeopleDetailedState extends State<PeopleDetailed> {
  @override
  void initState() {
    profileListApi();
    super.initState();
  }

  Map profiledata = {};

  bool isLoading = false;
  Future profileListApi() async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.employeeprofile();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      profiledata = data["Employee"];
    }
    setState(() {
      isLoading = false;
    });
  }

  List<String> interests = [
    'Singing',
    'Exploring Places',
    'Storytelling',
    'Influencer',
  ];
  final String LOCATION = 'assets/images/location.svg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      appBar: VibhoAppBar(
        bColor: Colors.transparent,
        title: 'People View',
        trailing: Padding(
          padding: EdgeInsets.only(right: 15.w, top: 5.h),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(KNotification);
            },
            child: Image.asset(
              UserSimplePreferences.getNotifications() == "0"
                  ? "assets/images/notification_inactive.png"
                  : "assets/images/bell.png",
              //  "assets/images/bell.png",
              width: 25,
            ),
          ),
        ),
        dontHaveBackAsLeading: false,
      ),
      body: Container(
        height: double.infinity,
        color: Kwhite,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 180.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/hill.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                    child: Container(
                      decoration: BoxDecoration(color: Kwhite.withOpacity(0.0)),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.r),
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 80.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.r),
                      color: Kwhite,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              //    Get.toNamed(KEditProfile);
                            },
                            child: Container(
                                margin: const EdgeInsets.all(5),
                                height: 90.h,
                                width: 90.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.r),
                                  //border: Border.all(color: Ktextcolor)
                                  //color: Kwhite,
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        12.r), // Image border
                                    child: profiledata["profile_pic"] != null
                                        ? CachedNetworkImage(
                                            imageUrl: 
                                                                                                 // KProfileimage +
                                                profiledata["profile_pic"],
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              "assets/images/man.png",
                                              fit: BoxFit.contain,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/images/man.png",
                                            fit: BoxFit.contain,
                                          ))),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                width: 180.w,
                                child: Text(
                                  "Jane Norris",
                                  // profiledata["fname"] != null
                                  //     ? "${profiledata["fname"]} ${profiledata["lname"]}"
                                  //     : "-",
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: kFW700,
                                      color: KdarkText),
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Row(
                                children: [
                                  Text("UI Designer",
                                      // profiledata["emp_code"] != null
                                      //     ? profiledata["emp_code"]
                                      //     : "-",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: kFW700,
                                        color: Klightblack.withOpacity(0.8),
                                      )),
                                  SizedBox(
                                    height: 10.h,
                                    child: VerticalDivider(
                                      color: Klightblack.withOpacity(0.8),
                                      thickness: 1,
                                    ),
                                  ),
                                  Text(
                                    profiledata["emp_code"] != null
                                        ? profiledata["emp_code"]
                                        : "-",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: kFW700,
                                      color: KOrange,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(LOCATION,
                              color: KCustomDarktwo,
                              fit: BoxFit.fill,
                              semanticsLabel: 'Acme Logo'),
                          // Image.asset(
                          //   "assets/images/location.png",
                          //   color: KOrange,
                          //   fit: BoxFit.fill,
                          // ),
                          SizedBox(
                            width: 5.w,
                          ),
                          SizedBox(
                            width: 270.w,
                            child: Text(
                              profiledata.isNotEmpty
                                  ? profiledata["permanent_address"]
                                  : "-",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: kTwelveFont,
                                  fontWeight: kFW600,
                                  color: Klightblack.withOpacity(0.8)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 25.w, right: 15.w, bottom: 5.w),
                        child: Text(
                          "About",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: kFW700,
                              color: KdarkText),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 25.w, right: 15.w, bottom: 5.w, top: 5.w),
                        child: Text(
                          profiledata["comments"] != null
                              ? profiledata["comments"]
                              : "-",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              letterSpacing: 0.5,
                              wordSpacing: 0.5,
                              fontSize: kTwelveFont,
                              fontWeight: kFW600,
                              color: Klightblack.withOpacity(0.8)),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 25.w, right: 15.w, bottom: 5.w),
                        child: Text(
                          "Contacts",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: kFW700,
                              color: KdarkText),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          String email =
                              Uri.encodeComponent("jane@vibhotech.com");
                          String subject = Uri.encodeComponent("Hi");
                          String body =
                              Uri.encodeComponent("Hi! I'm Flutter Developer");
                          print(subject); //output: Hello%20Flutter
                          Uri mail = Uri.parse(
                              "mailto:$email?subject=$subject&body=$body");
                          if (await launchUrl(mail)) {
                            //email app opened
                          } else {
                            //email app is not opened
                          }
                        },
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20.w, top: 10.h),
                              padding: EdgeInsets.only(
                                  right: 15.w,
                                  left: 15.w,
                                  top: 5.h,
                                  bottom: 5.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Kbackground),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.mail,
                                    size: kSixteenFont,
                                    color: KOrange,
                                  ),
                                  SizedBox(width: 15.w),
                                  Text("jane@vibhotech.com",
                                      style: TextStyle(
                                          fontSize: kTwelveFont,
                                          fontWeight: kFW700,
                                          color: Klightblack.withOpacity(0.8))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        // _makingPhoneCall,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20.w, top: 10.h),
                              padding: EdgeInsets.only(
                                  right: 15.w,
                                  left: 15.w,
                                  top: 5.h,
                                  bottom: 5.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Kbackground),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: kSixteenFont,
                                    color: Kgreen,
                                  ),
                                  SizedBox(width: 15.w),
                                  Text("+91 9898424323",
                                      style: TextStyle(
                                          fontSize: kTwelveFont,
                                          fontWeight: kFW700,
                                          color: Klightblack.withOpacity(0.8))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
