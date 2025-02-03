import 'package:readmore/readmore.dart';
import 'package:vibeshr/untils/export_file.dart';

// ignore: camel_case_types
class Story_fullview extends StatefulWidget {
  const Story_fullview({super.key});

  @override
  State<Story_fullview> createState() => _Story_fullviewState();
}

class _Story_fullviewState extends State<Story_fullview> {
  final String COMMENTS = 'assets/images/comments.svg';
  final String VIEWS = 'assets/images/views.svg';
  final String SHARED = 'assets/images/shared.svg';
  Map postData = Get.arguments;
  bool isLoaded = false;
  Map likesData = {};
  Future createLike(int id) async {
    likesData = {};

    Map data = await Services.createlikes(id);

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      likesData = data;
      if (data.isEmpty) {
        setState(() {
          postData["isLikedMobileEnd"] = 0;
          postData["likesCount"] = postData["likesCount"] - 1;
        });
      } else {
        setState(() {
          postData["isLikedMobileEnd"] = 1;
          postData["likesCount"] = postData["likesCount"] + 1;
        });
      }

      // postListHandler();
    }
  }

  Map postdata = {};
  List postdataFromAPI = [];
  bool storyisLoading = false;

  Future postListHandler(String id) async {
    setState(() {
      storyisLoading = true;
    });
    Map data = await Services.postSingleView(id);

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      postData = data;
    }
    setState(() {
      storyisLoading = false;
    });
  }

  @override
  void initState() {
    if (Get.arguments["id"] != null) {
      postListHandler(Get.arguments["id"].toString());
    } else {
      storyisLoading = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      appBar: VibhoAppBar(
        bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        title: "Post View",
        dontHaveBackAsLeading: Get.arguments['id'] == null ? false : true,
      ),
      body: storyisLoading == false
          ? SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 5.h, bottom: 16.h),
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                    color: selectedTheme == "Lighttheme"
                        ? Kbackground.withOpacity(0.8)
                        : Kthemeblack,
                    //   color: Kbackground.withOpacity(0.8),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Ktextcolor.withOpacity(0.4),
                    //     blurRadius: 10,
                    //     offset: const Offset(0, 0),
                    //     spreadRadius: 1,
                    //   )
                    // ],
                    borderRadius: BorderRadius.circular(8.r)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(5),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.r),
                                  color: selectedTheme == "Lighttheme"
                                      ? Kwhite
                                      : Kthemeblack,
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        13.r), // Image border
                                    child: postData["PostedBy"]
                                                    ["profile_pic"] !=
                                                null &&
                                            postData["PostedBy"]
                                                    ["profile_pic"] !=
                                                ""
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                // KProfileimage +
                                                postData["PostedBy"]
                                                    ["profile_pic"],
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              "assets/images/man.png",
                                              height: 180.h,
                                              fit: BoxFit.cover,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            "assets/images/man.png",
                                            fit: BoxFit.contain,
                                          ))),
                            Positioned(
                                top: 4.h,
                                right: 2.w,
                                child: const CircleAvatar(
                                  backgroundColor: Kwhite,
                                  radius: 6,
                                  child: Center(
                                      child: Icon(Icons.circle_rounded,
                                          size: 10, color: Kgreen)),
                                ))
                          ],
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${postData["PostedBy"]["fname"]}${postData["PostedBy"]["lname"]}",
                              style: TextStyle(
                                fontSize: kFourteenFont,
                                fontWeight: kFW700,
                                color: selectedTheme == "Lighttheme"
                                    ? KdarkText
                                    : Kwhite,
                              ),
                            ),
                            Text(
                              postData["PostedBy"]["emp_code"].toString(),
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: kFW500,
                                  color: Klightblack.withOpacity(0.8)),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      //color: KOrange,
                      margin: EdgeInsets.all(8.h),
                      child: ReadMoreText(
                        postData["description"] ?? "-",
                        trimLines: 2,
                        colorClickableText: KOrange,
                        style: TextStyle(
                            wordSpacing: 1,
                            height: 1.4,
                            fontSize: 11.sp,
                            fontWeight: kFW600,
                            color: selectedTheme == "Lighttheme"
                                ? KdarkText
                                : Kwhite),
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'See more',
                        trimExpandedText: '...See less',
                        moreStyle: TextStyle(
                            letterSpacing: 1,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 10.sp,
                            fontWeight: kFW600,
                            color: KOrange),
                        lessStyle: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 11.sp,
                            fontWeight: kFW600,
                            color: Klightgery),
                      ),
                    ),

                    // SizedBox(
                    //   height: 15.h,
                    // ),
                    // Text(
                    //   "https://vibeshr.com/mob-application/",
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //       fontSize: kTwelveFont,
                    //       fontWeight: kFW600,
                    //       color: Kbluedark),
                    // ),

                    postData["PostFiles"].length != 0
                        ? postData["PostFiles"][0]["file"] !=
                                "Something went wrong"
                            ? Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: postData["PostFiles"].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 10.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(color: Klight)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  // KpostURL +
                                                  postData["PostFiles"][index]
                                                      ["file"],
                                              // height: 350.h,
                                              // fit: BoxFit.contain,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                "assets/images/no_image.png",
                                                height: 180.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            : const SizedBox()
                        : const SizedBox(),
                    SizedBox(
                      height: 50.h,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         InkWell(
                    //           onTap: () {
                    //             createLike(postData["post_id"]);
                    //           },
                    //           child: Row(
                    //             children: [
                    //               postData["isLikedMobileEnd"] != null &&
                    //                       postData["isLikedMobileEnd"] == 1
                    //                   ? const Icon(
                    //                       Icons.favorite,
                    //                       color: KRed,
                    //                     )
                    //                   : postData["isLiked"] == 0
                    //                       ? const Icon(
                    //                           Icons.favorite_border_outlined,
                    //                           color: KdarkText,
                    //                         )
                    //                       : const Icon(
                    //                           Icons.favorite,
                    //                           color: KRed,
                    //                         ),
                    //               SizedBox(
                    //                 width: 5.w,
                    //               ),
                    //               Text(
                    //                 postData["isLikedMobileEnd"] != null &&
                    //                         postData["isLikedMobileEnd"] == 1
                    //                     ? (int.parse(postData["likesCount"]
                    //                             .toString()))
                    //                         .toString()
                    //                     : postData["likesCount"] == null
                    //                         ? postData["PostLikes"]
                    //                             .length
                    //                             .toString()
                    //                         : postData["likesCount"].toString(),
                    //                 style: TextStyle(
                    //                     fontSize: kTwelveFont,
                    //                     fontWeight: kFW600,
                    //                     color: KdarkText),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           width: 20.w,
                    //         ),
                    //         GestureDetector(
                    //           onTap: () {
                    //             // Get.toNamed(KComments);
                    //             Get.toNamed(KComments,
                    //                 arguments: postData["post_id"]);
                    //           },
                    //           child: Row(
                    //             children: [
                    //               SvgPicture.asset(
                    //                 COMMENTS,
                    //                 color: KCustomDarktwo,
                    //               ),
                    //               // Image.asset(
                    //               //   "assets/images/chat.png",
                    //               //   width: 22.w,
                    //               // ),
                    //               SizedBox(
                    //                 width: 5.w,
                    //               ),
                    //               Text(
                    //                 postData["commentsCount"] == null
                    //                     ? postData["PostComments"]
                    //                         .length
                    //                         .toString()
                    //                     : postData["commentsCount"].toString(),
                    //                 style: TextStyle(
                    //                     fontSize: kTwelveFont,
                    //                     fontWeight: kFW600,
                    //                     color: KdarkText),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           width: 20.w,
                    //         ),
                    //         GestureDetector(
                    //           onTap: () {},
                    //           child: Row(
                    //             children: [
                    //               SvgPicture.asset(
                    //                 VIEWS,
                    //                 color: KCustomDarktwo,
                    //               ),
                    //               // Image.asset(
                    //               //   "assets/images/eye.png",
                    //               //   width: 22.w,
                    //               // ),
                    //               SizedBox(
                    //                 width: 5.w,
                    //               ),
                    //               Text(
                    //                 postData["viewsCount"] == null
                    //                     ? postData["PostViews"].length.toString()
                    //                     : postData["viewsCount"].toString(),
                    //                 style: TextStyle(
                    //                     fontSize: kTwelveFont,
                    //                     fontWeight: kFW600,
                    //                     color: KdarkText),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     Row(
                    //       children: [
                    //         // InkWell(
                    //         //   onTap: () async {
                    //         //     String link = await Get.put<DynamicLinkServices>(
                    //         //             DynamicLinkServices())
                    //         //         .createDynamicLink(
                    //         //             false, postData["post_id"]);
                    //         //     Share.share("Look at the post :$link");
                    //         //   },
                    //         //   child: SvgPicture.asset(
                    //         //     SHARED,
                    //         //     color: KCustomDarktwo,
                    //         //   ),
                    //         //   // Image.asset(
                    //         //   //   "assets/images/share.png",
                    //         //   //   width: 23.w,
                    //         //   // ),
                    //         // ),
                    //         SizedBox(
                    //           width: 10.w,
                    //         )
                    //       ],
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            )
          : const SpinKitFadingCircle(
              color: KOrange,
              size: 25,
            ),
    );
  }
}
