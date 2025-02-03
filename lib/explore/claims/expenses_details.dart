// ignore_for_file: camel_case_types

import 'dart:io';
import 'dart:ui';

import 'package:intl/intl.dart';

import '../../untils/export_file.dart';

class Expenses_Details extends StatefulWidget {
  const Expenses_Details({super.key});

  @override
  State<Expenses_Details> createState() => _Expenses_DetailsState();
}

class _Expenses_DetailsState extends State<Expenses_Details> {
  @override
  bool isLoadingDeleted = false;
  // deleteClaim(int id) async {
  //   setState(() {
  //     isLoadingDeleted = true;
  //   });

  //   Map value = await Services.deleteClaim(id);
  //   if (value["message"] != null) {
  //     Fluttertoast.showToast(msg: value["message"]);
  //     Get.back();
  //   } else {}
  //   setState(() {
  //     isLoadingDeleted = false;
  //   });
  // }

  cancelClaim(int id, BuildContext context) async {
    setState(() {
      isLoadingDeleted = true;
    });

    Map value = await Services.cancelClaim(id);
    if (value["message"] != null) {
      Fluttertoast.showToast(msg: value["message"]);
    } else {
      _showSuccessDialog(context);
    }
    setState(() {
      isLoadingDeleted = false;
    });
  }

  HttpClient createHttpClient(SecurityContext? context) {
    return createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

  String getIndianCurrencyInShorthand(double amount) {
    final inrShortCutFormatInstance =
        NumberFormat.compactSimpleCurrency(locale: 'en_IN', name: "");
    var inrShortCutFormat = inrShortCutFormatInstance.format(amount);
    if (inrShortCutFormat.contains('T')) {
      return inrShortCutFormat.replaceAll(RegExp(r'T'), 'k');
    }
    return inrShortCutFormat;
  }

  Map claimData = Get.arguments;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
      appBar: VibhoAppBar(
        bColor: selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
        title: "Expenses Details",
        dontHaveBackAsLeading: false,
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(13.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13.r),
                  color: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showGeneralDialog(
                        barrierDismissible: true,
                        barrierLabel: '',
                        barrierColor: Colors.black38,
                        transitionDuration: const Duration(milliseconds: 200),
                        pageBuilder: (ctx, anim1, anim2) => AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                          backgroundColor: selectedTheme == "Lighttheme"
                              ? const Color.fromRGBO(255, 255, 255, 0.9)
                              : Kthemeblack,
                          title: Container(

                              // decoration: BoxDecoration(
                              //   borderRadius:
                              //       BorderRadius.circular(80.r),
                              // ),
                              child: claimData["ClaimDocuments"][0]
                                              ["file_name_path"] !=
                                          null ||
                                      claimData["ClaimDocuments"][0]
                                              ["file_name_path"] !=
                                          ""
                                  ? InteractiveViewer(
                                      boundaryMargin: const EdgeInsets.all(
                                          20.0), // Margin around the content
                                      minScale: 0.5, // Minimum scale (zoom out)
                                      maxScale: 2.0, // Maximum scale (zoom in)
                                      child: Image.network(
                                        //  KClaimsimage +
                                        claimData["ClaimDocuments"][0]
                                            ["file_name_path"],
                                        // : (context,
                                        //         child,
                                        //         loadingProgress) =>
                                        //     SizedBox(
                                        //   height: 90.h,
                                        //   width: 90.w,
                                        //   child: Shimmer.fromColors(
                                        //     baseColor: Colors.black12,
                                        //     highlightColor: Colors
                                        //         .white
                                        //         .withOpacity(0.5),
                                        //     child: Container(
                                        //       decoration:
                                        //           BoxDecoration(
                                        //         shape:
                                        //             BoxShape.circle,
                                        //         color: Kwhite
                                        //             .withOpacity(0.5),
                                        //       ),
                                        //       height: 90.h,
                                        //       width: 90.w,
                                        //     ),
                                        //   ),
                                        // ),
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Image.asset(
                                            "assets/images/man.png",
                                            fit: BoxFit.contain,
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      ))
                                  : Image.asset(
                                      "assets/images/man.png",
                                      fit: BoxFit.contain,
                                    )),
                          elevation: 2,
                        ),
                        transitionBuilder: (ctx, anim1, anim2, child) =>
                            BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
                          child: FadeTransition(
                            opacity: anim1,
                            child: child,
                          ),
                        ),
                        context: context,
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.all(13.r),
                        height: 180.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.r),
                          //border: Border.all(color: Ktextcolor)
                          //color: Kwhite,
                        ),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(12.r), // Image border
                            child: claimData["ClaimDocuments"].length > 0
                                ? claimData["ClaimDocuments"][0] != null
                                    ?
                                    //   Image.file(
                                    //   File(claimData["ClaimDocuments"][0]["file_name_path"]),
                                    //   fit: BoxFit.cover,
                                    //   height: 100,
                                    //   width: 100,
                                    // )
                                    CachedNetworkImage(
                                        imageUrl:
                                            //  KClaimsimage +
                                            claimData["ClaimDocuments"][0]
                                                ["file_name_path"],
                                        height: 180.h,
                                        placeholder: (context, url) => SizedBox(
                                          height: 180.h,
                                          width: double.infinity,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor:
                                                Colors.white.withOpacity(0.5),
                                            child: Container(
                                              height: 180.h,
                                              color: Kwhite.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        //                   SizedBox(
                                        //   height: 50.h,
                                        //   width: 267.w,
                                        //   child: Shimmer.fromColors(
                                        //     baseColor: Colors.black12,
                                        //     highlightColor: Colors.white.withOpacity(0.5),
                                        //     child: Container(
                                        //       decoration: BoxDecoration(
                                        //         borderRadius:
                                        //             BorderRadius.all(Radius.circular(10.0)),
                                        //         color: Kwhite.withOpacity(0.5),
                                        //       ),
                                        //       height: 50.h,
                                        //       width: 250.w,
                                        //     ),
                                        //   ),
                                        // ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          "assets/images/logo.png",
                                          fit: BoxFit.contain,
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : const Center(child: Text("No Recepit"))
                                : const Center(child: Text("No Recepit")))),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Total Ammount',
                              style: TextStyle(
                                  color: selectedTheme == "Lighttheme"
                                      ? KdarkText.withOpacity(0.5)
                                      : Kwhite,
                                  //  color: KdarkText.withOpacity(0.5),
                                  fontSize: 11.sp,
                                  fontWeight: kFW900)),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                              UserSimplePreferences.getCurrency() == "INR"
                                  ? "₹ ${getIndianCurrencyInShorthand(double.parse(claimData["amount"].toString()))}" ??
                                      ""
                                  : UserSimplePreferences.getCurrency() == "ZAR"
                                      ? "R ${claimData["amount"]}" ?? ""
                                      : getIndianCurrencyInShorthand(
                                          double.parse(
                                              claimData["amount"].toString())),
                              style: TextStyle(
                                  color: selectedTheme == "Lighttheme"
                                      ? KdarkText
                                      : Kwhite,
                                  //  color: KdarkText,
                                  fontSize: 13.sp,
                                  fontWeight: kFW900)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Claim Applied date',
                              style: TextStyle(
                                  color: selectedTheme == "Lighttheme"
                                      ? KdarkText.withOpacity(0.5)
                                      : Kwhite,
                                  //   color: KdarkText.withOpacity(0.5),
                                  fontSize: 11.sp,
                                  fontWeight: kFW900)),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                              DateFormat.yMMMd()
                                      .format(DateTime.parse(
                                          claimData["createdAt"]))
                                      .toString() ??
                                  "",
                              style: TextStyle(
                                  color: selectedTheme == "Lighttheme"
                                      ? KdarkText
                                      : Kwhite,
                                  //   color: KdarkText,
                                  fontSize: 13.sp,
                                  fontWeight: kFW900)),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description',
                          style: TextStyle(
                              color: selectedTheme == "Lighttheme"
                                  ? KdarkText.withOpacity(0.5)
                                  : Kwhite,
                              //  color: KdarkText.withOpacity(0.5),
                              fontSize: 11.sp,
                              fontWeight: kFW900)),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                          claimData["comments"] != ""
                              ? claimData["comments"] ?? ""
                              : "No Comments",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: selectedTheme == "Lighttheme"
                                  ? KdarkText
                                  : Kwhite,
                              //    color: KdarkText,
                              fontSize: 13.sp,
                              fontWeight: kFW900)),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Comments',
                          style: TextStyle(
                              color: selectedTheme == "Lighttheme"
                                  ? KdarkText.withOpacity(0.5)
                                  : Kwhite,
                              //  color: KdarkText.withOpacity(0.5),
                              fontSize: 11.sp,
                              fontWeight: kFW900)),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                          claimData["accepted_rejected_comments"] != "" &&
                                  claimData["accepted_rejected_comments"] !=
                                      null
                              ? claimData["accepted_rejected_comments"] ?? ""
                              : "No Comments",
                          maxLines: 3,
                          style: TextStyle(
                              color: selectedTheme == "Lighttheme"
                                  ? KdarkText
                                  : Kwhite,
                              //  color: KdarkText,
                              fontSize: 13.sp,
                              fontWeight: kFW900)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            // Container(
            //   padding: EdgeInsets.all(10.r),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(13.r),
            //     color: Kwhite,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Ktextcolor.withOpacity(0.2),
            //         blurRadius: 10,
            //         offset: const Offset(0, 0),
            //         spreadRadius: 2, //New
            //       )
            //     ],
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Row(
            //         children: [
            //           GestureDetector(
            //             onTap: () {
            //               // Get.toNamed(KProfile);
            //             },
            //             child: Container(
            //                 margin: const EdgeInsets.all(5),
            //                 height: 50.h,
            //                 width: 50.h,
            //                 decoration: BoxDecoration(
            //                   boxShadow: [
            //                     BoxShadow(
            //                       color: Ktextcolor.withOpacity(0.3),
            //                       blurRadius: 10,
            //                       offset: const Offset(0, 0),
            //                       spreadRadius: 5, //New
            //                     )
            //                   ],
            //                   borderRadius: BorderRadius.circular(13.r),
            //                   color: Kwhite,
            //                 ),
            //                 child: ClipRRect(
            //                     borderRadius:
            //                         BorderRadius.circular(13.r), // Image border
            //                     child: Image.asset(
            //                       "assets/images/man.png",
            //                       fit: BoxFit.contain,
            //                     ))),
            //           ),
            //           SizedBox(
            //             width: 5.w,
            //           ),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 "data",
            //                 style: TextStyle(
            //                     fontSize: 13.sp,
            //                     fontWeight: FontWeight.bold,
            //                     color: KdarkText),
            //               ),
            //               SizedBox(
            //                 height: 7.w,
            //               ),
            //               Text(
            //                 claimData["comments"] != ""
            //                     ? claimData["comments"]
            //                     : "No Comments",
            //                 style: TextStyle(
            //                     fontSize: kTwelveFont,
            //                     fontWeight: FontWeight.normal,
            //                     color: Klightblack.withOpacity(0.5)),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //       Text(
            //         claimData["is_approved"],
            //         style: TextStyle(
            //             fontSize: 11.sp,
            //             fontWeight: kFW600,
            //             color: Kgreen.withOpacity(0.7)),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 60.h,
            ),
            Column(
              children: [
                CustomButton(
                    borderRadius: BorderRadius.circular(30.r),
                    margin: EdgeInsets.all(15.r),
                    width: double.infinity,
                    height: 35.h,
                    Color: KOrange,
                    textColor: Kwhite,
                    fontSize: 13.sp,
                    fontWeight: kFW700,
                    label: "Back",
                    isLoading: false,
                    onTap: () {
                      Get.back();
                    }),
                claimData["is_approved"] == "Pending"
                    ? Custom_OutlineButton(
                        borderRadius: BorderRadius.circular(30.r),
                        margin: EdgeInsets.all(15.r),
                        width: double.infinity,
                        height: 35.h,
                        Color: Kbackground,
                        textColor: KOrange,
                        fontSize: 13.sp,
                        fontWeight: kFW700,
                        label: "Cancel",
                        isLoading: false,
                        onTap: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Do you want to cancel Claim?',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: kFW700,
                                          color: selectedTheme == "Lighttheme"
                                              ? KdarkText.withOpacity(0.7)
                                              : Kwhite)),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('No',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: kFW700,
                                              color:
                                                  selectedTheme == "Lighttheme"
                                                      ? KdarkText
                                                      : Kwhite)),
                                    ),
                                    TextButton(
                                      // textColor: Color(0xFF6200EE),
                                      onPressed: () async {
                                        Get.back();
                                        Get.back();
                                      },
                                      child: Text('Yes',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: kFW700,
                                              color:
                                                  selectedTheme == "Lighttheme"
                                                      ? KdarkText
                                                      : Kwhite)),
                                    )
                                  ],
                                );
                              });
                        })
                    : const SizedBox()
              ],
            )
          ],
        ),
      )),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 250.h,
              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('Expenses Cancel',
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: 13.sp,
                          fontWeight: kFW900)),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text('Your Expenses has been Cancelled Successfully',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: kTenFont,
                          fontWeight: kFW500)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Image.asset(
                    "assets/images/bill.png",
                    width: 150.w,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                      borderRadius: BorderRadius.circular(30.r),
                      margin: EdgeInsets.all(15.r),
                      width: double.infinity,
                      height: 35.h,
                      Color: KOrange,
                      textColor: Kwhite,
                      fontSize: 13.sp,
                      fontWeight: kFW700,
                      label: "Okay",
                      isLoading: false,
                      onTap: () {
                        Get.back();
                        Get.back();
                        Get.back();
                      }),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
