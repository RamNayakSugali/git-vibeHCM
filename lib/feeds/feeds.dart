// ignore_for_file: camel_case_types, unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:lottie/lottie.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';
import 'package:vibeshr/controllers/feedsController.dart';

import '../untils/export_file.dart';

class Feeds_screen extends StatefulWidget {
  const Feeds_screen({super.key});

  @override
  State<Feeds_screen> createState() => _Feeds_screenState();
}

class _Feeds_screenState extends State<Feeds_screen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  FeedController feedController = Get.put(FeedController());

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    postListHandler(pageNumber);
    storylistHandler();

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeIn, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  int pageNumber = 0;
  bool isLoading = false;
  Map postdata = {};

  bool isCompleted = false;
  bool isPostLoading = false;
  ScrollController controller = ScrollController();
  Future postListHandler(int pageNo) async {
    feedController.postdataPageNation.clear();
    setState(() {
      isPostLoading = true;
    });
    Map data = await Services.postlist(pageNo);

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      postdata = data;
      feedController.postdataPageNation.add(data["rows"]);
    }
    setState(() {
      isPostLoading = false;
    });
  }

  Future postListHandlerAfterPost() async {
    setState(() {
      pageNumber = 0;
    });
    Map data = await Services.postlist(pageNumber);

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      postdata = data;
      feedController.postdataPageNation[0] = data["rows"];
      setState(() {});
    }
  }

  Future loadMorepostListHandler() async {
    setState(() {
      pageNumber = pageNumber + 1;
      isLoading = true;
    });
    Map data = await Services.postlist(pageNumber);

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      postdata = data;
      for (int i = 0; i < data["rows"].length; i++) {
        setState(() {
          feedController.postdataPageNation[0].add(data["rows"][i]);
        });
      }
      if (data["rows"].length == 0) {
        setState(() {
          isCompleted = true;
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Map storylistdata = {};
  bool storyisLoading = false;

  Future storylistHandler() async {
    setState(() {
      storyisLoading = true;
    });
    Map data = await Services.storylist();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      storylistdata = data; // storylistdata["rows"]
    }
    setState(() {
      storyisLoading = false;
    });
  }

  loadMore() {
    debugPrint("loadingMore");
    loadMorepostListHandler();
  }

  final String INFOS = 'assets/images/nofeed.svg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingAction(),
      ////////appbar
      appBar: VibhoAppBar(
        bColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
        //  Kwhite,
        title: 'Feeds',
        trailing: Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(KNotification);
            },
            child: selectedTheme == "Lighttheme"
                ? Image.asset(
                    UserSimplePreferences.getNotifications() == "0"
                        ? "assets/images/notification_inactive.png"
                        : "assets/images/bell.png",
                    width: 25,
                  )
                : UserSimplePreferences.getNotifications() == "0"
                    ? const Icon(
                        Icons.notifications_outlined,
                        color: Kwhite,
                      )
                    : Stack(
                        children: [
                          const Icon(
                            Icons.notifications_outlined,
                            color: Kwhite,
                          ),
                          Positioned(
                            right: 3,
                            top: 3,
                            child: CircleAvatar(
                              radius: 3.r,
                              backgroundColor: KOrange,
                            ),
                          )
                        ],
                      ),
            // Image.asset(
            //   UserSimplePreferences.getNotifications() == "0"
            //       ? "assets/images/notification_inactive.png"
            //       : "assets/images/bell.png",
            //   //  "assets/images/bell.png",
            //   width: 25,
            // ),
          ),
        ),
        dontHaveBackAsLeading: true,
      ),
      body: storyisLoading == false && isPostLoading == false
          ? RefreshLoadmore(
              onLoadmore: () async {
                return loadMore();
              },
              onRefresh: () async {
                postListHandler(0);
                storylistHandler();
              },
              scrollController: controller,
              isLastPage: isCompleted,
              child: Container(
                  child: Column(
                children: [
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  // Feed_status(
                  //   storydata: storylistdata,
                  // ),
                  feedController.postdataPageNation.isNotEmpty
                      ? feedController.postdataPageNation[0].isNotEmpty
                          ? Story_card()
                          : Column(
                              children: [
                                SizedBox(
                                  height: 120.h,
                                ),
                                SvgPicture.asset(
                                  INFOS,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text("No Post Found",
                                    style: TextStyle(
                                        color: kblack,
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w800)),
                                SizedBox(
                                  height: 20.h,
                                ),
                                SizedBox(
                                  width: 200.w,
                                  child: Text(
                                      "No One Has Posted Anything In The",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Klightblack,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400)),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                    width: 200.w,
                                    child: Text("Feeds Section",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Klightblack,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400))),
                              ],
                            )
                      : Column(
                          children: [
                            SvgPicture.asset(
                              INFOS,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text("No Post Found",
                                style: TextStyle(
                                    color: kblack,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w800)),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              width: 200.w,
                              child: Text("No One Has Posted Anything In The",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Klightblack,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400)),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            SizedBox(
                                width: 200.w,
                                child: Text("Feeds Section",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Klightblack,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400))),
                          ],
                        ),
                  isLoading == true
                      ? const SpinKitFadingCircle(
                          color: KOrange,
                          size: 25,
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: 40.h,
                  )
                ],
              )))
          : Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              child: Lottie.asset(
                'assets/images/loadinNew.json',
                width: 150.w,
                height: 150.h,
                fit: BoxFit.contain,
              )

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [

              //     Row(
              //       children: [
              //         SizedBox(
              //           height: 50.h,
              //           width: 50.w,
              //           child: Shimmer.fromColors(
              //             baseColor: Colors.black12,
              //             highlightColor: Colors.white.withOpacity(0.5),
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 color: Kwhite.withOpacity(0.5),
              //               ),
              //               height: 50.h,
              //               width: 50.w,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: 10.w,
              //         ),
              //         SizedBox(
              //           height: 50.h,
              //           width: 267.w,
              //           child: Shimmer.fromColors(
              //             baseColor: Colors.black12,
              //             highlightColor: Colors.white.withOpacity(0.5),
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 borderRadius:
              //                     BorderRadius.all(Radius.circular(10.0)),
              //                 color: Kwhite.withOpacity(0.5),
              //               ),
              //               height: 50.h,
              //               width: 250.w,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     SizedBox(
              //       height: 20.h,
              //     ),
              //     SizedBox(
              //       height: 215.h,
              //       width: 320.w,
              //       child: Shimmer.fromColors(
              //         baseColor: Colors.black12,
              //         highlightColor: Colors.white.withOpacity(0.5),
              //         child: Container(
              //           height: 215.h,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //             color: Kwhite.withOpacity(0.5),
              //           ),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       height: 10.h,
              //     ),
              //     SizedBox(
              //       height: 20.h,
              //       width: 320.w,
              //       child: Shimmer.fromColors(
              //         baseColor: Colors.black12,
              //         highlightColor: Colors.white.withOpacity(0.5),
              //         child: Container(
              //           height: 20.h,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //             color: Kwhite.withOpacity(0.5),
              //           ),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       height: 10.h,
              //     ),
              //     SizedBox(
              //       height: 30.h,
              //       width: 320.w,
              //       child: Shimmer.fromColors(
              //         baseColor: Colors.black12,
              //         highlightColor: Colors.white.withOpacity(0.5),
              //         child: Container(
              //           height: 30.h,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //             color: Kwhite.withOpacity(0.5),
              //           ),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       height: 30.h,
              //     ),
              //     Row(
              //       children: [
              //         SizedBox(
              //           height: 50.h,
              //           width: 50.w,
              //           child: Shimmer.fromColors(
              //             baseColor: Colors.black12,
              //             highlightColor: Colors.white.withOpacity(0.5),
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 color: Kwhite.withOpacity(0.5),
              //               ),
              //               height: 50.h,
              //               width: 50.w,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: 10.w,
              //         ),
              //         SizedBox(
              //           height: 50.h,
              //           width: 267.w,
              //           child: Shimmer.fromColors(
              //             baseColor: Colors.black12,
              //             highlightColor: Colors.white.withOpacity(0.5),
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 borderRadius:
              //                     BorderRadius.all(Radius.circular(10.0)),
              //                 color: Kwhite.withOpacity(0.5),
              //               ),
              //               height: 50.h,
              //               width: 250.w,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     SizedBox(
              //       height: 20.h,
              //     ),
              //     SizedBox(
              //       height: 100.h,
              //       width: 320.w,
              //       child: Shimmer.fromColors(
              //         baseColor: Colors.black12,
              //         highlightColor: Colors.white.withOpacity(0.5),
              //         child: Container(
              //           height: 100.h,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //             color: Kwhite.withOpacity(0.5),
              //           ),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       height: 10.h,
              //     ),
              //   ],
              // ),
              ),
      // const  SpinKitFadingCircle(
      //     color: KOrange,
      //     size: 25,
      //   )
    );
  }

  Widget FloatingAction() {
    return Container(
      margin: EdgeInsets.only(bottom: 110.h),
      child: FloatingActionBubble(
        // Menu items
        items: <Bubble>[
          // Bubble(
          //   title: "Lorem lpsum",
          //   iconColor: KdarkText,
          //   bubbleColor: Kwhite,
          //   icon: Icons.settings,
          //   titleStyle: TextStyle(fontSize: kTwelveFont, color: KdarkText),
          //   onPress: () {
          //     _animationController.reverse();
          //   },
          // ),
          // Floating action menu item
          // Bubble(
          //   title: "Create a Story",
          //   iconColor: KdarkText,
          //   bubbleColor: Kwhite,
          //   icon: Icons.post_add,
          //   titleStyle: TextStyle(fontSize: kTwelveFont, color: KdarkText),
          //   onPress: () {
          //     Get.toNamed(KCreate_story);
          //   },
          // ),
          //Floating action menu item
          // Bubble(
          //   title: "Create a Post",
          //   iconColor: KdarkText,
          //   bubbleColor: Kwhite,
          //   icon: Icons.post_add,
          //   titleStyle: TextStyle(fontSize: kTwelveFont, color: KdarkText),
          //   onPress: () async {
          //     var refresh = await Get.toNamed(KCreate_post);
          //     postListHandlerAfterPost();
          //   },
          // ),
        ],

        // animation controller
        animation: _animation,

        // On pressed change animation state
        // onPress: () => _animationController.isCompleted
        //     ? _animationController.reverse()
        //     : _animationController.forward(),
        onPress: () async {
          var refresh = await Get.toNamed(KCreate_post);
          postListHandlerAfterPost();
        },
        // Floating Action button Icon color
        iconColor: Kwhite,

        // Flaoting Action button Icon
        iconData: Icons.add,
        backGroundColor: KOrange,
      ),
    );
  }
}
