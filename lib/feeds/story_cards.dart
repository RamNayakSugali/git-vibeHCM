// ignore_for_file: camel_case_types, depend_on_referenced_packages

import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
//import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:vibeshr/controllers/feedsController.dart';

import '../untils/export_file.dart';

class Story_card extends StatefulWidget {
  Story_card({Key? key}) : super(key: key);

  @override
  State<Story_card> createState() => _StorycardState();
}

class _StorycardState extends State<Story_card> {
  FeedController feedController = Get.find<FeedController>();

  // List postdataPageNation = [];
  Map likesData = {};
  int likingIndex = 0;
  bool isLoading = false;
  bool likeing = false;
  Future createLike(int id, int index) async {
    likesData = {};
    setState(() {
      likeing = true;
    });
    Map data = await Services.createlikes(id);

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      likesData = data;
      if (data.isNotEmpty) {
        setState(() {
          feedController.postdataPageNation[0][index]["isLiked"] = 1;
          feedController.postdataPageNation[0][index]["likesCount"] =
              feedController.postdataPageNation[0][index]["likesCount"] + 1;
        });
      } else {
        setState(() {
          feedController.postdataPageNation[0][index]["isLiked"] = 0;
          if (feedController.postdataPageNation[0][index]["likesCount"] > 0) {
            feedController.postdataPageNation[0][index]["likesCount"] =
                feedController.postdataPageNation[0][index]["likesCount"] - 1;
          } else {
            feedController.postdataPageNation[0][index]["likesCount"] = 0;
          }
        });
      }
      // if (data.isEmpty) {
      //   setState(() {
      //     feedController.postdataPageNation[0][index]["isLikedMobileEnd"] = 0;
      //     feedController.postdataPageNation[0][index]["likesCount"] =
      //         feedController.postdataPageNation[0][index]["likesCount"] - 1;
      //   });
      // } else {
      //   setState(() {
      //     feedController.postdataPageNation[0][index]["isLikedMobileEnd"] = 1;
      //     feedController.postdataPageNation[0][index]["likesCount"] =
      //         feedController.postdataPageNation[0][index]["likesCount"] + 1;
      //   });
      // }
      setState(() {
        likeing = false;
      });
      // postListHandler();
    }
  }

  Future postListHandler(int pageNo) async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.postlist(pageNo);

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      feedController.postdataPageNation.add(data["rows"]);
    }
    setState(() {
      isLoading = false;
    });
  }

  ///////////////////////
  var isLoadingDeleted = false.obs;
  deleteStoryPost(int id) async {
    setState(() {
      isLoadingDeleted.value = true;
    });

    Map value = await Services.deleteStoryPost(id);
    if (value["message"] != null) {
      Fluttertoast.showToast(msg: value["message"]);
      for (int i = 0; i < feedController.postdataPageNation[0].length; i++) {
        if (id == feedController.postdataPageNation[0][i]["post_id"]) {
          setState(() {
            feedController.postdataPageNation[0]
                .remove(feedController.postdataPageNation[0][i]);
          });
        }
      }
    } else {}
    setState(() {
      isLoadingDeleted.value = false;
    });
  }
  ////////////////////////

  callLikesHander() {
    for (int i = 0; i < feedController.postdataPageNation[0].length; i++) {
      feedController.postdataPageNation[0][i]["isLikedMobileEnd"] =
          feedController.postdataPageNation[0][i]["isLiked"];
    }
  }

  final String COMMENTS = 'assets/images/comments.svg';
  final String VIEWS = 'assets/images/views.svg';
  final String SHARED = 'assets/images/shared.svg';
  bool isLoaded = false;
  int pageNumber = 0;

  PopupMenuItem _buildPopupMenuItem(String title, IconData iconData) {
    return PopupMenuItem(
      value: "1",
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: kTwelveFont, fontWeight: kFW600, color: KdarkText),
          ),
        ],
      ),
    );
  }

  late final AnimationController _controller;

  bool _isPlaying = true;

  //late CarouselSliderController _sliderController;

  @override
  void initState() {
    callLikesHander();

    // _sliderController = CarouselSliderController();
    super.initState();
    // _controller = AnimationController(vsync: this);
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? x;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DynMouseScroll(
          durationMS: 500,
          scrollSpeed: 8,
          builder: (context, controller, physics) => ListView.builder(
              shrinkWrap: true,
              controller: controller,
              // controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: feedController.postdataPageNation[0].length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 5.h, bottom: 10.h),
                  padding: EdgeInsets.only(top: 5.h),
                  decoration: BoxDecoration(
                    color: selectedTheme == "Lighttheme"
                        ? Kbackground.withOpacity(0.8)
                        : Kthemeblack,
                    boxShadow: [
                      BoxShadow(
                        color: Ktextcolor.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                        spreadRadius: 2, //New
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  margin: EdgeInsets.all(7.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(23.r),
                                    color: Kwhite,
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          40.r), // Image border
                                      child: feedController.postdataPageNation[
                                                          0][index]["PostedBy"]
                                                      ["profile_pic"] !=
                                                  null &&
                                              feedController.postdataPageNation[
                                                          0][index]["PostedBy"]
                                                      ["profile_pic"] !=
                                                  ""
                                          ? CachedNetworkImage(
                                              imageUrl:
                                                  // KProfileimage +
                                                  feedController
                                                              .postdataPageNation[
                                                          0][index]["PostedBy"]
                                                      ["profile_pic"],
                                              placeholder: (context, url) =>
                                                  SizedBox(
                                                height: 50.h,
                                                width: 50.w,
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.black12,
                                                  highlightColor: Colors.white
                                                      .withOpacity(0.5),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Kwhite.withOpacity(
                                                          0.5),
                                                    ),
                                                    height: 50.h,
                                                    width: 50.w,
                                                  ),
                                                ),
                                              ),
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
                              // Positioned(
                              //     top: 8.h,
                              //     right: 6.w,
                              //     child: const CircleAvatar(
                              //       backgroundColor: Kgreen,
                              //       radius: 5,
                              //       child: Center(
                              //           child: Icon(Icons.circle_rounded,
                              //               size: 10, color: Kgreen)),
                              //     ))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 260.w,
                                    child: Text(
                                      "${feedController.postdataPageNation[0][index]["PostedBy"]["fname"]} ${feedController.postdataPageNation[0][index]["PostedBy"]["lname"]}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: kFW700,
                                          color: selectedTheme == "Lighttheme"
                                              ? KdarkText
                                              : Kwhite),
                                    ),
                                  ),
                                  feedController.empProfile["emp_id"] ==
                                          feedController.postdataPageNation[0]
                                              [index]["emp_id"]
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            PopupMenuButton(
                                                onSelected: (value) async {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          // title: Text(
                                                          //     'Are You Sure?',
                                                          //     maxLines: 1,
                                                          //     overflow:
                                                          //         TextOverflow
                                                          //             .ellipsis,
                                                          //     style: TextStyle(
                                                          //         fontSize:
                                                          //             12.sp,
                                                          //         fontWeight:
                                                          //             kFW700,
                                                          //         color: selectedTheme ==
                                                          //                 "Lighttheme"
                                                          //             ? KdarkText
                                                          //             : Kwhite)),
                                                          title: Text(
                                                              'You want to delete this Post?',
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      kFW700,
                                                                  color: selectedTheme ==
                                                                          "Lighttheme"
                                                                      ? KdarkText
                                                                      : Kwhite)),
                                                          actions: [
                                                            Obx(() => isLoadingDeleted
                                                                        .value ==
                                                                    false
                                                                ? TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                    },
                                                                    child: Text(
                                                                        'CANCEL',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize: 12
                                                                                .sp,
                                                                            fontWeight:
                                                                                kFW700,
                                                                            color: selectedTheme == "Lighttheme"
                                                                                ? KdarkText
                                                                                : Kwhite)),
                                                                  )
                                                                : const SizedBox()),
                                                            Obx(() => isLoadingDeleted
                                                                        .value ==
                                                                    false
                                                                ? TextButton(
                                                                    // textColor: Color(0xFF6200EE),
                                                                    onPressed:
                                                                        () async {
                                                                      await deleteStoryPost(feedController.postdataPageNation[0]
                                                                              [
                                                                              index]
                                                                          [
                                                                          "post_id"]);
                                                                      Get.back();
                                                                    },
                                                                    child: Text(
                                                                        'ACCEPT',
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize: 12
                                                                                .sp,
                                                                            fontWeight:
                                                                                kFW700,
                                                                            color: selectedTheme == "Lighttheme"
                                                                                ? KOrange
                                                                                : Kwhite)),
                                                                  )
                                                                : const SpinKitFadingCircle(
                                                                    color:
                                                                        KOrange,
                                                                    size: 25,
                                                                  )),
                                                          ],
                                                        );
                                                      });
                                                },
                                                offset: const Offset(0, 20),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: GestureDetector(
                                                  child: const Icon(
                                                    Icons.more_vert,
                                                    size: 25,
                                                  ),
                                                ),
                                                itemBuilder: (ctx) => [
                                                      _buildPopupMenuItem(
                                                          'Delete',
                                                          Icons.delete),
                                                    ]
                                                //  itemBuilder
                                                ),
                                          ],
                                        )
                                      : const SizedBox()
                                ],
                              ),
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: feedController.postdataPageNation[0]
                                      [index]["PostedBy"]["emp_code"],
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: kFW600,
                                      color: Klightblack.withOpacity(0.9)),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: " | ",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: kFW600,
                                          color: Klightblack.withOpacity(0.8)),
                                    ),
                                    TextSpan(
                                      text: DateFormat.MMMd().format(
                                          DateTime.parse(feedController
                                                  .postdataPageNation[0][index]
                                              ["createdAt"])),
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: kFW600,
                                          color: Klightblack.withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        //color: KOrange,
                        margin: EdgeInsets.all(8.h),
                        child: ReadMoreText(
                          feedController.postdataPageNation[0][index]
                                  ["description"] ??
                              "-",
                          trimLines: 2,
                          colorClickableText: KOrange,
                          style: TextStyle(
                              wordSpacing: 1,
                              height: 1.4,
                              fontSize: 11.sp,
                              fontWeight: kFW500,
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
                              color: selectedTheme == "Lighttheme"
                                  ? Klightgery
                                  : Kwhite),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      feedController.postdataPageNation[0][index]
                                  ["PostFiles"] ==
                              null
                          ? SpinKitFadingCircle(
                              color: KOrange,
                              size: 15,
                            )
                          : feedController
                                      .postdataPageNation[0][index]["PostFiles"]
                                      .length !=
                                  0
                              ? feedController.postdataPageNation[0][index]
                                          ["PostFiles"][0]["file"] !=
                                      "Something went wrong"
                                  ? GestureDetector(
                                      onDoubleTap: () {
                                        createLike(
                                            feedController.postdataPageNation[0]
                                                [index]["post_id"],
                                            index);
                                        setState(() {
                                          likingIndex = index;
                                        });
                                      },
                                      onTap: () {
                                        Get.toNamed(KStory_fullview,
                                            arguments: feedController
                                                .postdataPageNation[0][index]);
                                      },
                                      child:
                                          //  CarouselSlider.builder(
                                          //   options: CarouselOptions(
                                          //     autoPlay: false,
                                          //     enlargeCenterPage: false,
                                          //     enableInfiniteScroll: false,
                                          //     initialPage: 1,
                                          //     viewportFraction: 1.1,
                                          //   ),
                                          //   itemCount: feedController
                                          //       .postdataPageNation[0][index]
                                          //           ["PostFiles"]
                                          //       .length,
                                          //   itemBuilder:
                                          //       (context, itemIndex, realIndex) {
                                          //     return
                                          Stack(
                                        children: [
                                          Container(
                                            height: 200.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Klight.withOpacity(
                                                        0.2))),
                                            child:
                                                feedController
                                                            .postdataPageNation[0]
                                                                [index]
                                                                ["PostFiles"]
                                                            .length ==
                                                        1
                                                    ? Container(
                                                        // color: kblack,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: feedController.postdataPageNation[0]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "PostFiles"]
                                                                    [
                                                                    0]["file"] ==
                                                                null
                                                            ? SpinKitFadingCircle(
                                                                color: KOrange,
                                                                size: 10,
                                                              )
                                                            : CachedNetworkImage(
                                                                imageUrl:
                                                                    // KpostURL +
                                                                    feedController.postdataPageNation[0][index]
                                                                            [
                                                                            "PostFiles"][0]
                                                                        [
                                                                        "file"],
                                                                height: 180.h,
                                                                fit: BoxFit
                                                                    .cover,
                                                                placeholder:
                                                                    (context,
                                                                            url) =>
                                                                        SizedBox(
                                                                  height: 180.h,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Shimmer
                                                                      .fromColors(
                                                                    baseColor:
                                                                        Colors
                                                                            .black12,
                                                                    highlightColor: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.5),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          180.h,
                                                                      color: Kwhite
                                                                          .withOpacity(
                                                                              0.5),
                                                                    ),
                                                                  ),
                                                                ),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Image.asset(
                                                                  "assets/images/no_image.png",
                                                                  height: 180.h,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                      )
                                                    : feedController
                                                                .postdataPageNation[
                                                                    0][index][
                                                                    "PostFiles"]
                                                                .length ==
                                                            2
                                                        ? Container(
                                                            // color: kblack,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: feedController.postdataPageNation[0][index]["PostFiles"][0]
                                                                              [
                                                                              "file"] ==
                                                                          null
                                                                      ? SpinKitFadingCircle(
                                                                          color:
                                                                              KOrange,
                                                                          size:
                                                                              10,
                                                                        )
                                                                      : CachedNetworkImage(
                                                                          imageUrl:
                                                                              // KpostURL +
                                                                              feedController.postdataPageNation[0][index]["PostFiles"][0]["file"],
                                                                          height:
                                                                              180.h,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          placeholder: (context, url) =>
                                                                              SizedBox(
                                                                            height:
                                                                                180.h,
                                                                            width:
                                                                                double.infinity,
                                                                            child:
                                                                                Shimmer.fromColors(
                                                                              baseColor: Colors.black12,
                                                                              highlightColor: Colors.white.withOpacity(0.5),
                                                                              child: Container(
                                                                                height: 180.h,
                                                                                color: Kwhite.withOpacity(0.5),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          // Container(
                                                                          //     alignment: Alignment.center,
                                                                          //     child:  SpinKitFadingCircle(
                                                                          //       color: KOrange,
                                                                          //       size: 10,
                                                                          //     )),
                                                                          errorWidget: (context, url, error) =>
                                                                              Image.asset(
                                                                            "assets/images/no_image.png",
                                                                            height:
                                                                                180.h,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                Expanded(
                                                                  child: feedController.postdataPageNation[0][index]["PostFiles"][1]
                                                                              [
                                                                              "file"] ==
                                                                          null
                                                                      ? SpinKitFadingCircle(
                                                                          color:
                                                                              KOrange,
                                                                          size:
                                                                              10,
                                                                        )
                                                                      : CachedNetworkImage(
                                                                          imageUrl:
                                                                              KpostURL + feedController.postdataPageNation[0][index]["PostFiles"][1]["file"],
                                                                          height:
                                                                              180.h,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          placeholder: (context, url) =>
                                                                              SizedBox(
                                                                            height:
                                                                                180.h,
                                                                            width:
                                                                                double.infinity,
                                                                            child:
                                                                                Shimmer.fromColors(
                                                                              baseColor: Colors.black12,
                                                                              highlightColor: Colors.white.withOpacity(0.5),
                                                                              child: Container(
                                                                                height: 180.h,
                                                                                color: Kwhite.withOpacity(0.5),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          // Container(
                                                                          //     alignment: Alignment.center,
                                                                          //     child:  SpinKitFadingCircle(
                                                                          //       color: KOrange,
                                                                          //       size: 10,
                                                                          //     )),
                                                                          errorWidget: (context, url, error) =>
                                                                              Image.asset(
                                                                            "assets/images/no_image.png",
                                                                            height:
                                                                                180.h,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : feedController
                                                                    .postdataPageNation[0]
                                                                        [index][
                                                                        "PostFiles"]
                                                                    .length ==
                                                                3
                                                            ? Container(
                                                                color: kblack,
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: feedController.postdataPageNation[0][index]["PostFiles"][0]["file"] ==
                                                                              null
                                                                          ? SpinKitFadingCircle(
                                                                              color: KOrange,
                                                                              size: 10,
                                                                            )
                                                                          : CachedNetworkImage(
                                                                              imageUrl:
                                                                                  // KpostURL +
                                                                                  feedController.postdataPageNation[0][index]["PostFiles"][0]["file"],
                                                                              height: 180.h,
                                                                              fit: BoxFit.cover,
                                                                              placeholder: (context, url) => Shimmer.fromColors(
                                                                                baseColor: Colors.black12,
                                                                                highlightColor: Colors.white.withOpacity(0.5),
                                                                                child: Container(
                                                                                  color: Kwhite.withOpacity(0.5),
                                                                                ),
                                                                              ),

                                                                              // Container(
                                                                              //     alignment: Alignment.center,
                                                                              //     child:  SpinKitFadingCircle(
                                                                              //       color: KOrange,
                                                                              //       size: 10,
                                                                              //     )),
                                                                              errorWidget: (context, url, error) => Image.asset(
                                                                                "assets/images/no_image.png",
                                                                                height: 180.h,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          5.w,
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        Expanded(
                                                                          child: feedController.postdataPageNation[0][index]["PostFiles"][1]["file"] == null
                                                                              ? SpinKitFadingCircle(
                                                                                  color: KOrange,
                                                                                  size: 10,
                                                                                )
                                                                              : CachedNetworkImage(
                                                                                  imageUrl:
                                                                                      // KpostURL +
                                                                                      feedController.postdataPageNation[0][index]["PostFiles"][1]["file"],
                                                                                  height: 180.h,
                                                                                  fit: BoxFit.cover,
                                                                                  placeholder: (context, url) =>
                                                                                      //////////////////
                                                                                      SizedBox(
                                                                                    height: 80.h,
                                                                                    width: 50.w,
                                                                                    child: Shimmer.fromColors(
                                                                                      baseColor: Colors.black12,
                                                                                      highlightColor: Colors.white.withOpacity(0.5),
                                                                                      child: Container(
                                                                                        height: 80.h,
                                                                                        color: Kwhite.withOpacity(0.5),
                                                                                      ),
                                                                                    ),
                                                                                  ),

                                                                                  ////////////////////
                                                                                  // Container(
                                                                                  //     alignment: Alignment.center,
                                                                                  //     child:  SpinKitFadingCircle(
                                                                                  //       color: KOrange,
                                                                                  //       size: 10,
                                                                                  //     )),
                                                                                  errorWidget: (context, url, error) => Image.asset(
                                                                                    "assets/images/no_image.png",
                                                                                    height: 180.h,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5.h,
                                                                        ),
                                                                        Expanded(
                                                                          child: feedController.postdataPageNation[0][index]["PostFiles"][2]["file"] == null
                                                                              ? SpinKitFadingCircle(
                                                                                  color: KOrange,
                                                                                  size: 10,
                                                                                )
                                                                              : CachedNetworkImage(
                                                                                  imageUrl:
                                                                                      // KpostURL +
                                                                                      feedController.postdataPageNation[0][index]["PostFiles"][2]["file"],
                                                                                  height: double.infinity,
                                                                                  fit: BoxFit.cover,
                                                                                  placeholder: (context, url) => SizedBox(
                                                                                    height: 80.h,
                                                                                    width: 50.w,
                                                                                    child: Shimmer.fromColors(
                                                                                      baseColor: Colors.black12,
                                                                                      highlightColor: Colors.white.withOpacity(0.5),
                                                                                      child: Container(
                                                                                        height: 80.h,
                                                                                        color: Kwhite.withOpacity(0.5),
                                                                                      ),
                                                                                    ),
                                                                                  ),

                                                                                  // Container(
                                                                                  //     alignment: Alignment.center,
                                                                                  //     child:  SpinKitFadingCircle(
                                                                                  //       color: KOrange,
                                                                                  //       size: 10,
                                                                                  //     )),
                                                                                  errorWidget: (context, url, error) => Image.asset(
                                                                                    "assets/images/no_image.png",
                                                                                    height: 180.h,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            : feedController
                                                                        .postdataPageNation[0]
                                                                            [index]
                                                                            ["PostFiles"]
                                                                        .length >
                                                                    3
                                                                ? Container(
                                                                    color: kblack
                                                                        .withOpacity(
                                                                            0.1),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: feedController.postdataPageNation[0][index]["PostFiles"][0]["file"] == null
                                                                              ? SpinKitFadingCircle(
                                                                                  color: KOrange,
                                                                                  size: 10,
                                                                                )
                                                                              : CachedNetworkImage(
                                                                                  imageUrl:
                                                                                      // KpostURL +
                                                                                      feedController.postdataPageNation[0][index]["PostFiles"][0]["file"],
                                                                                  height: 180.h,
                                                                                  fit: BoxFit.cover,
                                                                                  placeholder: (context, url) => SizedBox(
                                                                                    height: 180.h,
                                                                                    width: double.infinity,
                                                                                    child: Shimmer.fromColors(
                                                                                      baseColor: Colors.black12,
                                                                                      highlightColor: Colors.white.withOpacity(0.5),
                                                                                      child: Container(
                                                                                        height: 180.h,
                                                                                        color: Kwhite.withOpacity(0.5),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  // Container(
                                                                                  //     alignment: Alignment.center,
                                                                                  //     child:  SpinKitFadingCircle(
                                                                                  //       color: KOrange,
                                                                                  //       size: 10,
                                                                                  //     )),
                                                                                  errorWidget: (context, url, error) => Image.asset(
                                                                                    "assets/images/no_image.png",
                                                                                    height: 180.h,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5.w,
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            feedController.postdataPageNation[0][index]["PostFiles"][1]["file"] == null
                                                                                ? SpinKitFadingCircle(
                                                                                    color: KOrange,
                                                                                    size: 10,
                                                                                  )
                                                                                : CachedNetworkImage(
                                                                                    imageUrl:
                                                                                        // KpostURL +
                                                                                        feedController.postdataPageNation[0][index]["PostFiles"][1]["file"],
                                                                                    height: 80.h,
                                                                                    fit: BoxFit.cover,
                                                                                    placeholder: (context, url) => SizedBox(
                                                                                      height: 80.h,
                                                                                      width: 50.w,
                                                                                      child: Shimmer.fromColors(
                                                                                        baseColor: Colors.black12,
                                                                                        highlightColor: Colors.white.withOpacity(0.5),
                                                                                        child: Container(
                                                                                          height: 80.h,
                                                                                          color: Kwhite.withOpacity(0.5),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    // Container(
                                                                                    //     alignment: Alignment.center,
                                                                                    //     child:  SpinKitFadingCircle(
                                                                                    //       color: KOrange,
                                                                                    //       size: 10,
                                                                                    //     )),
                                                                                    errorWidget: (context, url, error) => Image.asset(
                                                                                      "assets/images/no_image.png",
                                                                                      height: 180.h,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                            SizedBox(
                                                                              height: 5.h,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 100.h,
                                                                              width: 100.w,
                                                                              child: Stack(
                                                                                children: [
                                                                                  feedController.postdataPageNation[0][index]["PostFiles"][2]["file"] == null
                                                                                      ? SpinKitFadingCircle(
                                                                                          color: KOrange,
                                                                                          size: 10,
                                                                                        )
                                                                                      : ImageFiltered(
                                                                                          imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                                                                          child: CachedNetworkImage(
                                                                                            imageUrl:
                                                                                                //  KpostURL +
                                                                                                feedController.postdataPageNation[0][index]["PostFiles"][2]["file"],
                                                                                            height: 180.h,
                                                                                            width: 180.w,
                                                                                            fit: BoxFit.fitWidth,
                                                                                            placeholder: (context, url) => SizedBox(
                                                                                              height: 80.h,
                                                                                              width: 50.w,
                                                                                              child: Shimmer.fromColors(
                                                                                                baseColor: Colors.black12,
                                                                                                highlightColor: Colors.white.withOpacity(0.5),
                                                                                                child: Container(
                                                                                                  height: 80.h,
                                                                                                  color: Kwhite.withOpacity(0.5),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            // Container(
                                                                                            //     alignment: Alignment.center,
                                                                                            //     child:  SpinKitFadingCircle(
                                                                                            //       color: KOrange,
                                                                                            //       size: 10,
                                                                                            //     )),
                                                                                            errorWidget: (context, url, error) => Image.asset(
                                                                                              "assets/images/no_image.png",
                                                                                              height: 180.h,
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          )),
                                                                                  Center(
                                                                                      child: Text("+" + (feedController.postdataPageNation[0][index]["PostFiles"].length - 3).toString(),
                                                                                          style: TextStyle(
                                                                                              // fontStyle: FontStyle.italic,
                                                                                              fontSize: 14.sp,
                                                                                              fontWeight: kFW900,
                                                                                              color: selectedTheme == "Lighttheme" ? KOrange : Kwhite)))
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                : const SizedBox(),
                                          ),
                                          Positioned(
                                              top: 0,
                                              right: 0,
                                              left: 0,
                                              bottom: 0,
                                              child: likeing == true &&
                                                      index == likingIndex
                                                  // likeing == true &&
                                                  //         likingIndex == index
                                                  ? Lottie.asset(
                                                      'assets/images/activelike.json',
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.contain,
                                                    )
                                                  //  const Icon(
                                                  //     Icons.thumb_up_sharp,
                                                  //     color: KOrange,
                                                  //     size: 80,
                                                  //   )

                                                  //  Center(Lottie.asset(
                                                  //     'assets/images/activelike.json',
                                                  //     width: 200,
                                                  //     height: 200,
                                                  //     fit: BoxFit.fill,
                                                  //   ))
                                                  : Container()
                                              //  feedController.postdataPageNation[0]
                                              //             [index]["isLiked"] ==
                                              //         0
                                              //     ? Container()
                                              // : const Icon(
                                              //     Icons.thumb_up_sharp,
                                              //     color: KOrange,
                                              //   ),
                                              ),
                                        ],
                                      ))
                                  //     },
                                  //   ),
                                  // )

                                  : const SizedBox()
                              : const SizedBox(),
                      SizedBox(
                        height: 8.h,
                      ),
                      // CarouselIndicator(
                      //   count: feedController
                      //       .postdataPageNation[0][index]["PostFiles"].length,
                      //   index: feedController
                      //       .postdataPageNation[0][index],
                      // ),
                      Container(
                        margin: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(KPost_likes,
                                    arguments:
                                        (feedController.postdataPageNation[0]
                                            [index]["post_id"]));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    feedController.postdataPageNation[0][index]
                                                    ["isLikedMobileEnd"] !=
                                                null &&
                                            feedController.postdataPageNation[0]
                                                        [index]
                                                    ["isLikedMobileEnd"] ==
                                                1
                                        ? (int.parse(feedController
                                                .postdataPageNation[0][index]
                                                    ["likesCount"]
                                                .toString()))
                                            .toString()
                                        : feedController.postdataPageNation[0]
                                                [index]["likesCount"]
                                            .toString(),
                                    style: TextStyle(
                                        // fontStyle: FontStyle.italic,
                                        fontSize: 11.sp,
                                        fontWeight: kFW600,
                                        color: selectedTheme == "Lighttheme"
                                            ? KdarkText
                                            : Kwhite),
                                  ),
                                  Text(
                                      feedController.postdataPageNation[0]
                                                  [index]["likesCount"] >=
                                              2
                                          ? " Likes"
                                          : " Like",
                                      //" Like",
                                      style: TextStyle(
                                          //fontStyle: FontStyle.italic,
                                          fontSize: 10.sp,
                                          fontWeight: kFW600,
                                          color: selectedTheme == "Lighttheme"
                                              ? KdarkText.withOpacity(0.7)
                                              : Kwhite)),
                                ],
                              ),
                            ),
                            GetX<FeedController>(
                              init: FeedController(),
                              builder: (sController) => GestureDetector(
                                onTap: () async {
                                  feedController.createComment(feedController
                                      .postdataPageNation[0][index]);
                                  x = await Get.to(Comments_view(
                                      count: feedController
                                          .postdataPageNation[0][index]
                                              ["commentsCount"]
                                          .toString()));
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      sController.postdataPageNation[0][index]
                                              ["commentsCount"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          // fontStyle: FontStyle.italic,
                                          fontWeight: kFW600,
                                          color: selectedTheme == "Lighttheme"
                                              ? KdarkText
                                              : Kwhite),
                                    ),
                                    Text(
                                      " Comments",
                                      style: TextStyle(
                                        // fontStyle: FontStyle.italic,
                                        fontSize: 10.sp,
                                        fontWeight: kFW600,
                                        color: selectedTheme == "Lighttheme"
                                            ? KdarkText
                                            : Kwhite,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Container(
                        margin:
                            EdgeInsets.only(left: 30.w, right: 30.w, top: 2.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                createLike(
                                    feedController.postdataPageNation[0][index]
                                        ["post_id"],
                                    index);
                                setState(() {
                                  likingIndex = index;
                                  // feedController.postdataPageNation[0]
                                  //         [index]["isLikedMobileEnd"] =
                                  //     !feedController.postdataPageNation[0]
                                  //         [index]["isLikedMobileEnd"];
                                });
                              },
                              child: Column(
                                children: [
                                  likeing == true && index == likingIndex
                                      ? Center(
                                          child: SpinKitFadingCircle(
                                          color: KOrange,
                                          size: 10.sp,
                                        ))
                                      : feedController.postdataPageNation[0]
                                                  [index]["isLiked"] ==
                                              0
                                          ? Icon(
                                              Icons.thumb_up_off_alt_outlined,
                                              color:
                                                  selectedTheme == "Lighttheme"
                                                      ? KdarkText
                                                      : Kwhite,
                                            )
                                          : const Icon(
                                              Icons.thumb_up_sharp,
                                              color: KOrange,
                                            ),
                                  Text(
                                    feedController.postdataPageNation[0][index]
                                                ["isLiked"] ==
                                            0
                                        ? "Like"
                                        : "DisLike",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: kFW600,
                                      color: selectedTheme == "Lighttheme"
                                          ? KdarkText
                                          : Kwhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                                onTap: () async {
                                  feedController.createComment(feedController
                                      .postdataPageNation[0][index]);
                                  x = await Get.to(Comments_view(
                                      count: feedController
                                          .postdataPageNation[0][index]
                                              ["commentsCount"]
                                          .toString()));
                                  setState(() {});
                                },
                                child: Column(children: [
                                  SizedBox(
                                    height: 4.w,
                                  ),
                                  SvgPicture.asset(
                                    COMMENTS,
                                    color: selectedTheme == "Lighttheme"
                                        ? KdarkText
                                        : Kwhite,
                                    width: 23,
                                  ),
                                  // Image.asset(
                                  //   "assets/images/chat.png",
                                  //   width: 22.w,
                                  // ),

                                  Text(
                                    "Comment",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: kFW600,
                                      color: selectedTheme == "Lighttheme"
                                          ? KdarkText
                                          : Kwhite,
                                    ),
                                  ),
                                ])),
                            // Column(children: [
                            //   InkWell(
                            //     //onTap: () {},
                            //     onTap: ()async {
                            //       String link = await Get.put<DynamicLinkServices>(
                            //               DynamicLinkServices())
                            //           .createDynamicLink(
                            //               false,feedController. postdataPageNation[0][index]["post_id"]);
                            //       Share.share("Look at the post :$link");
                            //       // Share.share(
                            //       //     "Description :${postdataPageNation[0][index]["description"]}\n  ${KpostURL + postdataPageNation[0][index]["PostFiles"][0]["file"]}");
                            //     },
                            //     child: SvgPicture.asset(
                            //       SHARED,
                            //       color: KCustomDarktwo,
                            //     ),
                            //   ),
                            //   Text(
                            //     "Share",
                            //     style: TextStyle(
                            //         fontSize: 10.sp,
                            //         fontWeight: kFW600,
                            //         color: KdarkText),
                            //   ),
                            // ])

                            //               // Text(
                            //               //   sController
                            //               //       .postdataPageNation[0]
                            //               //           [index]
                            //               //           ["commentsCount"]
                            //               //       .toString(),
                            //               //   style: TextStyle(
                            //               //       fontSize: kTwelveFont,
                            //               //       fontWeight: kFW600,
                            //               //       color: KdarkText),
                            //               // ),
                            //             ],
                            //           ),
                            //         )),
                            // SizedBox(
                            //   width: 20.w,
                            // ),
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Row(
                            //     children: [
                            //       SvgPicture.asset(
                            //         VIEWS,
                            //         color: KCustomDarktwo,
                            //       ),
                            //       // Image.asset(
                            //       //   "assets/images/eye.png",
                            //       //   width: 22.w,
                            //       // ),
                            //       SizedBox(
                            //         width: 5.w,
                            //       ),
                            //       Text(
                            //         feedController.postdataPageNation[0]
                            //                 [index]["viewsCount"]
                            //             .toString(),
                            //         style: TextStyle(
                            //             fontSize: kTwelveFont,
                            //             fontWeight: kFW600,
                            //             color: KdarkText),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  void loadmore() {
    debugPrint("HI");
    setState(() {
      postListHandler(pageNumber + 1);
    });
  }
}
