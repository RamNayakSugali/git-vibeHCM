// ignore_for_file: camel_case_types, non_constant_identifier_names

import '../untils/export_file.dart';

class Categories_Screen extends StatefulWidget {
  Map? homedir;
  Map? hrconfigs;
  Map? feedback;
  Categories_Screen(
      {super.key,
      required this.homedir,
      required this.hrconfigs,
      required this.feedback});

  @override
  State<Categories_Screen> createState() => _Categories_ScreenState();
}

class _Categories_ScreenState extends State<Categories_Screen> {
  List Categories = [
    {
      "name": "Attendance",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/attendance1.png",
      "arrowimage": "assets/images/right_corner_arrow.png",
      // "Subimage": "assets/images/attendance1.png",
      "Containercolor": Klightpuple,
      //"color": KPurple,
      "route": KAttendance,
      "isEnables": dashboardController.permissiondata["attendance"] ?? true
    },
    {
      "name": "Leaves",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/leaves.png",
      "arrowimage": "assets/images/right_corner_arrow.png",
      //  "Subimage": "assets/images/arrow.svg",
      "Containercolor": KlightRed,
      "color": KOrange,
      "route": Kapply_leaves,
      "isEnables": dashboardController.permissiondata["leaves"] ?? true
    },
    {
      "name": "Claims",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/claims1.png",
      "arrowimage": "assets/images/right_corner_arrow.png",
      //  "Subimage": "assets/images/arrow.svg",
      "Containercolor": Klightgreen,
      // "color": Kgreen,
      "route": KReimbursement,
      "isEnables": dashboardController.permissiondata["claims"] ?? true
    },
    // {
    //   "name": "Performance",
    //   "Subname": "Lorem Ipsum",
    //   "image": "assets/images/data.png",
    //   "Subimage": "assets/images/arrow.png",
    //   "color": KDarkskyblue,
    //    "route": KReimbursement
    // },
    {
      "name": "Pay Slips",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/Payslip1.png",
      "arrowimage": "assets/images/right_corner_arrow.png",
      //  "Subimage": "assets/images/arrow.svg",
      "Containercolor": Klightorange,
      "color": KDarkblue,
      "route": KPayslips,
      "isEnables": dashboardController.permissiondata["payslips"] ?? true
    },

    // {
    //   "name": "Timesheet",
    //   "Subname": "Lorem Ipsum",
    //   "image": "assets/images/sheet.png",
    //   "arrowimage": "assets/images/right_corner_arrow.png",
    //   //  "Subimage": "assets/images/arrow.svg",
    //   "Containercolor": KlightBlue,
    //   "color": KOrange,
    //   "route": KTime_sheet
    // },
    {
      "name": "People",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/prople2.png",
      "arrowimage": "assets/images/right_corner_arrow.png",
      //  "Subimage": "assets/images/arrow.svg",
      "Containercolor": Klightpuple,
      "color": Kpink,
      "route": KPeople,
      "isEnables": dashboardController.permissiondata["people"] ?? true
    },
    {
      "name": "Feedback",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/back.png",
      "arrowimage": "assets/images/right_corner_arrow.png",
      //  "Subimage": "assets/images/arrow.svg",
      "Containercolor": Kdarkpuple,
      "color": KDarkblue,
      "route": KReimbursement,
      "isEnables": dashboardController.permissiondata["feedback"] ?? true
    },
    {
      "name": "QuickApprovals",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/qucik.png",
      "arrowimage": "assets/images/right_corner_arrow.png",
      //  "Subimage": "assets/images/arrow.svg",
      "Containercolor": Klightgray,
      "color": Klightpuple.withOpacity(0.6),
      "route": KAll_approvals,
    },

    // {
    //   "name": "Calendar",
    //   "Subname": "Lorem Ipsum",
    //   "image": "assets/images/data.png",
    //   "Subimage": "assets/images/arrow.png",
    //   "color": Kpink,
    //    "route": KReimbursement
    // },
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: TextStyle(
            fontSize: kSixteenFont,
            fontWeight: kFW700,
            color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
          ),
        ),
        SizedBox(height: 10.h),
        Obx(
          () => Wrap(
            children: [
              for (int i = 0; i < Categories.length; i++)
                if (Categories[i]["name"] == "Feedback") ...[
                  Categories[i]["isEnables"] == true
                      ? widget.feedback!.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                if (Categories[i]["name"] == "Feedback") {
                                  showModalBottomSheet<void>(
                                      isScrollControlled: true,
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.r),
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return const Feedback_view();
                                      });
                                } else {
                                  Get.toNamed(Categories[i]["route"]);
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.all(10.r),
                                // padding: EdgeInsets.only(
                                //     left: 20.w, right: 22.w, top: 15.h, bottom: 10.h),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0, 6),
                                        color: Ktextcolor.withOpacity(0.2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: Categories[i]["Containercolor"]),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Image.asset(
                                          "assets/images/frame.png",
                                          fit: BoxFit.contain,
                                          width: 140.w,
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w,
                                          right: 31.w,
                                          top: 10.h,
                                          bottom: 10.h),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // SvgPicture.asset(Categories[i]["image"],
                                          //     color: Kwhite,
                                          //     fit: BoxFit.fill,
                                          //     semanticsLabel: 'Acme Logo'),
                                          Image.asset(
                                            Categories[i]["image"],
                                            height: 25.h,
                                            color: Kwhite,
                                          ),
                                          SizedBox(height: 10.h),
                                          SizedBox(
                                            width: 105.w,
                                            child: Text(
                                              Categories[i]["name"],
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 11.3.sp,
                                                  fontWeight: kFW900,
                                                  color: Kwhite),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Image.asset(
                                            Categories[i]["arrowimage"],
                                            // "assets/images/right_corner_arrow.png",
                                            width: 20.w,
                                            //width: 100.w,
                                          ),
                                          // SizedBox(
                                          //   child: Text(
                                          //     Categories[i]["Subname"],
                                          //     maxLines: 1,
                                          //     textAlign: TextAlign.left,
                                          //     overflow: TextOverflow.ellipsis,
                                          //     style: TextStyle(
                                          //         fontSize: kTenFont,
                                          //         fontWeight: kFW400,
                                          //         color: Klightgray.withOpacity(0.7)),
                                          //   ),
                                          // ),
                                          // SvgPicture.asset(Categories[i]["Subimage"],
                                          //     color: Kwhite,
                                          //     alignment: Alignment.bottomLeft,
                                          //     fit: BoxFit.fill,
                                          //     semanticsLabel: 'Acme Logo'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          : SizedBox()
                      : SizedBox()
                ] else if (Categories[i]["name"] == "QuickApprovals") ...[
                  if (widget.hrconfigs!["leaves"]["read"] == true &&
                              widget.hrconfigs!["calims"]["read"] == true ||
                          widget.hrconfigs!["leaves"]["read"] == true ||
                          widget.hrconfigs!["calims"]["read"] == true

                      // (widget.hrconfigs!["calims"]["read"] == true ||
                      //     widget.hrconfigs!["calims"]["read"] == false
                      //     )
                      ) ...[
                    GestureDetector(
                      onTap: () {
                        if (Categories[i]["name"] == "Feedback") {
                          showModalBottomSheet<void>(
                              isScrollControlled: true,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.r),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return const Feedback_view();
                              });
                        } else {
                          Get.toNamed(Categories[i]["route"],
                              arguments: widget.hrconfigs);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10.r),
                        // padding: EdgeInsets.only(
                        //     left: 20.w, right: 22.w, top: 15.h, bottom: 10.h),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                                color: Ktextcolor.withOpacity(0.2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12.r),
                            color: Categories[i]["Containercolor"]),
                        child: Stack(
                          children: [
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Image.asset(
                                  "assets/images/frame.png",
                                  fit: BoxFit.contain,
                                  width: 140.w,
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.w,
                                  right: 31.w,
                                  top: 10.h,
                                  bottom: 10.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SvgPicture.asset(Categories[i]["image"],
                                  //     color: Kwhite,
                                  //     fit: BoxFit.fill,
                                  //     semanticsLabel: 'Acme Logo'),
                                  Image.asset(
                                    Categories[i]["image"],
                                    height: 25.h,
                                    color: Kwhite,
                                  ),
                                  SizedBox(height: 10.h),
                                  SizedBox(
                                    width: 105.w,
                                    child: Text(
                                      Categories[i]["name"],
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 11.3.sp,
                                          fontWeight: kFW900,
                                          color: Kwhite),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Image.asset(
                                    Categories[i]["arrowimage"],
                                    // "assets/images/right_corner_arrow.png",
                                    width: 20.w,
                                    //width: 100.w,
                                  ),
                                  // SizedBox( leave_balance
                                  //   child: Text(
                                  //     Categories[i]["Subname"],
                                  //     maxLines: 1,
                                  //     textAlign: TextAlign.left,
                                  //     overflow: TextOverflow.ellipsis,
                                  //     style: TextStyle(
                                  //         fontSize: kTenFont,
                                  //         fontWeight: kFW400,
                                  //         color: Klightgray.withOpacity(0.7)),
                                  //   ),
                                  // ),
                                  // SvgPicture.asset(Categories[i]["Subimage"],
                                  //     color: Kwhite,
                                  //     alignment: Alignment.bottomLeft,
                                  //     fit: BoxFit.fill,
                                  //     semanticsLabel: 'Acme Logo'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]
                ] else ...[
                  GestureDetector(
                    onTap: () {
                      if (Categories[i]["name"] == "Feedback") {
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.r),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return const Feedback_view();
                            });
                      } else {
                        Get.toNamed(Categories[i]["route"]);
                      }
                    },
                    child: Categories[i]["isEnables"] == true
                        ? Container(
                            margin: EdgeInsets.all(10.r),
                            // padding: EdgeInsets.only(
                            //     left: 20.w, right: 22.w, top: 15.h, bottom: 10.h),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: const Offset(0, 6),
                                    color: Ktextcolor.withOpacity(0.2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12.r),
                                color: Categories[i]["Containercolor"]),
                            child: Stack(
                              children: [
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Image.asset(
                                      "assets/images/frame.png",
                                      fit: BoxFit.contain,
                                      width: 140.w,
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.w,
                                      right: 31.w,
                                      top: 10.h,
                                      bottom: 10.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // SvgPicture.asset(Categories[i]["image"],
                                      //     color: Kwhite,
                                      //     fit: BoxFit.fill,
                                      //     semanticsLabel: 'Acme Logo'),
                                      Image.asset(
                                        Categories[i]["image"],
                                        height: 25.h,
                                        color: Kwhite,
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        width: 105.w,
                                        child: Text(
                                          Categories[i]["name"],
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 11.3.sp,
                                              fontWeight: kFW900,
                                              color: Kwhite),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      // SizedBox(
                                      //   child: Text(
                                      //     Categories[i]["Subname"],
                                      //     maxLines: 1,
                                      //     textAlign: TextAlign.left,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     style: TextStyle(
                                      //         fontSize: kTenFont,
                                      //         fontWeight: kFW400,
                                      //         color: Klightgray.withOpacity(0.7)),
                                      //   ),
                                      // ),
                                      Image.asset(
                                        Categories[i]["arrowimage"],
                                        // "assets/images/right_corner_arrow.png",
                                        width: 20.w,
                                        //width: 100.w,
                                      ),
                                      // SvgPicture.asset(Categories[i]["Subimage"],
                                      //     color: Kwhite,
                                      //     alignment: Alignment.bottomLeft,
                                      //     fit: BoxFit.fill,
                                      //     semanticsLabel: 'Acme Logo'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                  )
                ]
            ],
          ),
        )
      ],
    );
  }
}
