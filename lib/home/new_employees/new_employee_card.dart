// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';
import 'package:vibeshr/untils/export_file.dart';

class NewEmployeeCard extends StatefulWidget {
  const NewEmployeeCard({super.key});

  @override
  State<NewEmployeeCard> createState() => _NewEmployeeCardState();
}

class _NewEmployeeCardState extends State<NewEmployeeCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Employees",
          style: TextStyle(
              fontSize: kSixteenFont,
              fontWeight: kFW700,
              color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.h),
          // padding: EdgeInsets.all(10.r),
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(
                color: Klightpuple.withOpacity(0.3),
                width: 1,
              ),
              // borderRadius: BorderRadius.circular(13.r),
              // color: KOrange.withOpacity(0.1),
              color: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack
              // boxShadow: [
              //   BoxShadow(
              //     color: Ktextcolor.withOpacity(0.1),
              //     blurRadius: 10,
              //     offset: const Offset(0, 0),
              //     spreadRadius: 2, //New
              //   )
              // ],
              ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(KNewEmployees);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Klightpuple.withOpacity(0.5),
                            child: Icon(Icons.person, color: Kwhite),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "New Employees",
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 14.sp,
                                fontWeight: kFW600,
                                color: selectedTheme == "Lighttheme"
                                    ? KdarkText
                                    : Kwhite),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 20.sp,
                          color: selectedTheme == "Lighttheme"
                              ? KdarkText
                              : Kwhite)
                    ],
                  ),
                ),
              ),
              Divider(color: Klightpuple.withOpacity(0.3)),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    // Container(
                    //     margin: const EdgeInsets.all(5),
                    //     height: 50.h,
                    //     width: 50.h,
                    //     decoration: BoxDecoration(
                    //       // boxShadow: [
                    //       //   BoxShadow(
                    //       //     color: Ktextcolor.withOpacity(0.3),
                    //       //     blurRadius: 10,
                    //       //     offset: const Offset(0, 0),
                    //       //     spreadRadius: 3, //New
                    //       //   )
                    //       // ],
                    //       borderRadius: BorderRadius.circular(40.r),
                    //       color: Kwhite,
                    //     ),
                    //     child: ClipRRect(
                    //         borderRadius:
                    //             BorderRadius.circular(40.r), // Image border
                    //         child: Image.asset(
                    //           "assets/images/man.png",
                    //           fit: BoxFit.contain,
                    //         ))),
                    Container(
                        margin:   EdgeInsets.all(5),
                        height: 50.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.r),
                          // boxShadow: [
                          //   BoxShadow(
                          //     spreadRadius: 2,
                          //     blurRadius: 10,
                          //     offset: Offset(0, 6),
                          //     color: Ktextcolor.withOpacity(0.5),
                          //   )
                          // ],
                          //border: Border.all(color: Ktextcolor)
                          //color: Kwhite,
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(80.r),
                            // Image border
                            child: Image.asset(
                              "assets/images/man.png",
                              fit: BoxFit.contain,
                            ))),
                    SizedBox(
                      width: 5.w,
                    ),
                    SizedBox(
                      width: 220.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                // width: 150.w,
                                child: Text(
                              
                                  "Ram Nayak",
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: kFourteenFont,
                                      fontWeight: kFW600,
                                      color: selectedTheme == "Lighttheme"
                                          ? KdarkText
                                          : Kwhite
                                      // KdarkText
                                      ),
                                ),
                              ),
                              Text(
                                " - ",
                                style: TextStyle(
                                    fontSize: kTenFont,
                                    fontWeight: kFW700,
                                    color: KdarkText),
                              ),
                              Text(
                                // AnniversaryCardData[0]["emp_code"]
                                //     .toString(),
                                "VTIN24",
                                style: TextStyle(
                                    fontSize: kTenFont,
                                    fontWeight: kFW700,
                                    color: Klightblack),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            "Jr.Flutter Developer 🧑🏼‍💼",
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: kFW600,
                                color: Klightpuple),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            //  BirthdayData[index]["dob"].toString(),

                            "Joined on Monday,May 30",
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: kFW700,
                                color: selectedTheme == "Lighttheme"
                                    ? KdarkText
                                    : Kwhite
                                //KdarkText
                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
