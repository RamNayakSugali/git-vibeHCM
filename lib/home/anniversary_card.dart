// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

import '../untils/export_file.dart';

class AnneversaryCard extends StatefulWidget {
  const AnneversaryCard({super.key});

  @override
  State<AnneversaryCard> createState() => _AnneversaryCardState();
}

class _AnneversaryCardState extends State<AnneversaryCard> {
  bool isLoading = false;
  List<dynamic> AnniversaryCardData = [];
  // Map BirthdayData = {};

  getAnniversaryList() async {
    setState(() {
      isLoading = true;
    });

    var data = await Services.getAnneversaryList();
    if (data != null) {
      AnniversaryCardData = data;
      getUpCommingList(AnniversaryCardData);
    } else {
      //  BirthdayData = data;
      //  getFinalData();
    }
    setState(() {
      isLoading = false;
    });
  }

  getUpCommingList(allList) {
    dashboardController.upCommingAnniversaryList.clear();
    if (allList.isNotEmpty) {
      for (int i = 0; i < allList.length; i++) {
        if (DateTime.parse(allList[0]["date_of_joining"]).day ==
                DateTime.parse(allList[i]["date_of_joining"]).day &&
            DateTime.parse(allList[0]["date_of_joining"]).month ==
                DateTime.parse(allList[i]["date_of_joining"]).month) {
          dashboardController.upCommingAnniversaryList.add(allList[i]);
        }
      }
    }
    debugPrint("Got Upcomming List");
  }

  @override
  void initState() {
    super.initState();
    getAnniversaryList();
  }

  @override
  Widget build(BuildContext context) {
    return AnniversaryCardData.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Anniversaries",
                style: TextStyle(
                    fontSize: kSixteenFont,
                    fontWeight: kFW700,
                    color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite),
              ),
              isLoading == true
                  ? const Center(
                      child: SpinKitFadingCircle(
                      color: KOrange,
                      size: 15,
                    ))
                  : Container(
                      margin: EdgeInsets.only(top: 10.h),
                      // padding: EdgeInsets.all(10.r),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Klightgreen.withOpacity(0.3),
                            width: 1,
                          ),
                          // borderRadius: BorderRadius.circular(13.r),
                          // color: KOrange.withOpacity(0.1),
                          color: selectedTheme == "Lighttheme"
                              ? Kwhite
                              : Kthemeblack
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
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(KAnneversary);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Klightgreen.withOpacity(0.5),
                                        child: Icon(Icons.cake, color: Kwhite),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        "Work Anniversaries",
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
                          Divider(color: Klightgreen.withOpacity(0.3)),
                          AnniversaryCardData.isNotEmpty
                              ? Container(
                                  // height: 100,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: dashboardController
                                          .upCommingAnniversaryList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
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
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  height: 50.h,
                                                  width: 50.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80.r),
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              80.r),
                                                      // Image border
                                                      child: dashboardController
                                                                              .upCommingAnniversaryList[
                                                                          index]
                                                                      [
                                                                      "profile_pic"] !=
                                                                  null &&
                                                              dashboardController
                                                                              .upCommingAnniversaryList[
                                                                          index]
                                                                      [
                                                                      "profile_pic"] !=
                                                                  ""
                                                          ? Image.network(
                                                              // KProfileimage +
                                                              dashboardController
                                                                          .upCommingAnniversaryList[
                                                                      index][
                                                                  "profile_pic"],
                                                              errorBuilder: (BuildContext
                                                                      context,
                                                                  Object
                                                                      exception,
                                                                  StackTrace?
                                                                      stackTrace) {
                                                                return Image
                                                                    .asset(
                                                                  "assets/images/man.png",
                                                                  fit: BoxFit
                                                                      .contain,
                                                                );
                                                              },
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.asset(
                                                              "assets/images/man.png",
                                                              fit: BoxFit
                                                                  .contain,
                                                            ))),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              SizedBox(
                                                width: 230.w,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${dashboardController.upCommingAnniversaryList[index]["fname"]} ${dashboardController.upCommingAnniversaryList[index]["lname"]}"
                                                          .capitalize!,
                                                      // BirthdayData[index]["fname"] ??
                                                      //     "" +
                                                      //  BirthdayData[index]["lname"] ?? "",
                                                      //   "Ram Nayak",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13.sp,
                                                          fontWeight: kFW600,
                                                          color: selectedTheme ==
                                                                  "Lighttheme"
                                                              ? KdarkText
                                                              : Kwhite
                                                          // KdarkText
                                                          ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      dashboardController
                                                          .upCommingAnniversaryList[
                                                              index]["emp_code"]
                                                          .toString(),
                                                      //  "VTIN24",
                                                      style: TextStyle(
                                                          fontSize: kTenFont,
                                                          fontWeight: kFW700,
                                                          color: Klightblack),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          //  BirthdayData[index]["dob"].toString(),
                                                          DateFormat.MMMd()
                                                              .format(DateTime.parse(
                                                                  dashboardController
                                                                              .upCommingAnniversaryList[
                                                                          index]
                                                                      [
                                                                      "date_of_joining"]))
                                                              .toString(),

                                                          //   "Dec 25",
                                                          style: TextStyle(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  kFW700,
                                                              color: selectedTheme ==
                                                                      "Lighttheme"
                                                                  ? KdarkText
                                                                  : Kwhite
                                                              //KdarkText
                                                              ),
                                                        ),
                                                        SizedBox(
                                                            height: 10.h,
                                                            child: const VerticalDivider(
                                                                color:
                                                                    KdarkText)),
                                                        Text(
                                                          "Work Anniversary 🎇",
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  kFW600,
                                                              color:
                                                                  Klightgreen),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }))
                              : const SizedBox(),
                        ],
                      ),
                    )
            ],
          )
        : const SizedBox();
  }
}
