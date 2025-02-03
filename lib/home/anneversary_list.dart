// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:intl/intl.dart';

import '../untils/export_file.dart';

class Anneversarylist extends StatefulWidget {
  const Anneversarylist({super.key});

  @override
  State<Anneversarylist> createState() => _AnneversarylistState();
}

class _AnneversarylistState extends State<Anneversarylist> {
  bool isLoading = false;
  List<dynamic> AnniversaryData = [];
  // Map BirthdayData = {};

  getAnniversaryList() async {
    setState(() {
      isLoading = true;
    });

    var data = await Services.getAnneversaryList();
    if (data != null) {
      AnniversaryData = data;
    } else {
      //  BirthdayData = data;
      //  getFinalData();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAnniversaryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        appBar: VibhoAppBar(
          title: "Anniversaries",
          bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(13.r),
            child: isLoading == true
                ? const Center(
                    child: SpinKitFadingCircle(
                    color: KOrange,
                    size: 50,
                  ))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: AnniversaryData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showGeneralDialog(
                            barrierDismissible: true,
                            barrierLabel: '',
                            barrierColor: Colors.black38,
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            pageBuilder: (ctx, anim1, anim2) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0))),
                              backgroundColor: selectedTheme == "Lighttheme"
                                  ? Color.fromRGBO(255, 255, 255, 0.9)
                                  : Kthemeblack,
                              title: Container(
                                  // margin: const EdgeInsets.all(5),
                                  height: 42.h,
                                  width: 42.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.r),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80.r),
                                      // Image border
                                      child: AnniversaryData[index]
                                                      ["profile_pic"] !=
                                                  null &&
                                              AnniversaryData[index]
                                                      ["profile_pic"] !=
                                                  ""
                                          ? Image.network(
                                              // KProfileimage +
                                              AnniversaryData[index]
                                                  ["profile_pic"],
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Image.asset(
                                                  "assets/images/man.png",
                                                  fit: BoxFit.contain,
                                                );
                                              },
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "assets/images/man.png",
                                              fit: BoxFit.contain,
                                            ))),
                              content: Text(
                                "${AnniversaryData[index]["fname"]} ${AnniversaryData[index]["lname"]}"
                                    .capitalize!,

                                //   "Ram Nayak",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16.sp,
                                    fontWeight: kFW600,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite),
                              ),
                              elevation: 2,
                              actions: [
                                GestureDetector(
                                  onTap: () async {
                                    var url = Uri.parse(
                                        "tel:${AnniversaryData[index]["phone_no"]}");
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: SizedBox(
                                    // width: 180.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${AnniversaryData[index]["phone_no"]}",

                                          //   $.rows.[]Employee.phone_no
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: kFW800,
                                              color: selectedTheme ==
                                                      "Lighttheme"
                                                  ? KdarkText.withOpacity(0.5)
                                                  : Kwhite),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Icon(
                                          Icons.phone,
                                          size: kSixteenFont,
                                          color: Kgreen,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            transitionBuilder: (ctx, anim1, anim2, child) =>
                                BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 4 * anim1.value,
                                  sigmaY: 4 * anim1.value),
                              child: FadeTransition(
                                child: child,
                                opacity: anim1,
                              ),
                            ),
                            context: context,
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15.h),
                          padding: EdgeInsets.all(10.r),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.r),
                            color: Klightgreen.withOpacity(0.1),
                            //  color: Kwhite,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Ktextcolor.withOpacity(0.1),
                            //     blurRadius: 10,
                            //     offset: const Offset(0, 0),
                            //     spreadRadius: 2, //New
                            //   )
                            // ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                  // margin: const EdgeInsets.all(5),
                                  height: 45.h,
                                  width: 45.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.r),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80.r),
                                      // Image border
                                      child: AnniversaryData[index]
                                                      ["profile_pic"] !=
                                                  null &&
                                              AnniversaryData[index]
                                                      ["profile_pic"] !=
                                                  ""
                                          ? Image.network(
                                              AnniversaryData[index]
                                                  ["profile_pic"],
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Image.asset(
                                                  "assets/images/man.png",
                                                  fit: BoxFit.contain,
                                                );
                                              },
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              "assets/images/man.png",
                                              fit: BoxFit.contain,
                                            ))),
                              // SizedBox(
                              //   width: 5.w,
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${AnniversaryData[index]["fname"]} ${AnniversaryData[index]["lname"]}"
                                          .capitalize!,

                                      //   "Ram Nayak",
                                      maxLines: 2,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 12.sp,
                                          fontWeight: kFW600,
                                          color: selectedTheme == "Lighttheme"
                                              ? KdarkText
                                              : Kwhite),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      AnniversaryData[index]["emp_code"]
                                              .toString() ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: kFW600,
                                          color: Klightblack),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          //  BirthdayData[index]["dob"].toString(),

                                          "${AnniversaryData[index]["years"].toString()} Years | ",
                                          //   "Dec 25",
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: kFW700,
                                              color:
                                                  selectedTheme == "Lighttheme"
                                                      ? KdarkText
                                                      : Kwhite),
                                        ),
                                        Text(
                                          //  BirthdayData[index]["dob"].toString(),

                                          "${DateFormat.MMM().format(DateTime.parse(AnniversaryData[index]["date_of_joining"])).toString() ?? ""} - ${DateFormat.d().format(DateTime.parse(AnniversaryData[index]["date_of_joining"])).toString() ?? ""} | ",

                                          //   "Dec 25",
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: kFW700,
                                              color:
                                                  selectedTheme == "Lighttheme"
                                                      ? KdarkText
                                                      : Kwhite),
                                        ),
                                        Text(
                                          "Work Anniversary",
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: kFW600,
                                              color: Klightgreen),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ));
  }
}
