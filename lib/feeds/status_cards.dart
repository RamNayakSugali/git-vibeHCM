// ignore_for_file: camel_case_types, non_constant_identifier_names, must_be_i

import 'package:flutter/cupertino.dart';
import 'package:vibeshr/controllers/feedsController.dart';

import '../untils/export_file.dart';

class Feed_status extends StatefulWidget {
  Map storydata;
  Feed_status({super.key, required this.storydata});

  @override
  State<Feed_status> createState() => _FeedstatusState();
}

class _FeedstatusState extends State<Feed_status> {
  final PageController controller = PageController();
  FeedController feedController = Get.put(FeedController());

  bool isLoading = false;
  Map storyData = {};
  Future getStoryData(int id) async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.storyviewbyid(id.toString());
    debugPrint("DONE");
    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      setState(() {
        storyData = data;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Map likeData = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        5,
        5,
        5,
        10,
      ),
      child: widget.storydata["rows"] != null
          ? Row(
              children: [
                for (int i = 0; i < widget.storydata["rows"].length; i++) ...[
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 7),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            widget.storydata["rows"][i]["statusLoading"] = true;
                          });

                          await getStoryData(
                              widget.storydata["rows"][i]["emp_id"]);
                          setState(() {
                            widget.storydata["rows"][i]["statusLoading"] =
                                false;
                          });

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => StoryFullScreen(
                                controller: controller,
                                storyData: storyData,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 45.h,
                          width: 45.h,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: widget.storydata["rows"][i]
                                              ["statusLoading"] ==
                                          null ||
                                      widget.storydata["rows"][i]
                                              ["statusLoading"] ==
                                          false
                                  ? widget.storydata["rows"][i]["CreatedBy"]
                                                  ["profile_pic"] !=
                                              null &&
                                          widget.storydata["rows"][i]
                                                      ["CreatedBy"]
                                                  ["profile_pic"] !=
                                              ""
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              // KProfileimage +
                                              widget.storydata["rows"][i]
                                                  ["CreatedBy"]["profile_pic"],
                                          placeholder: (context, url) =>
                                              SizedBox(
                                            height: 50.h,
                                            width: 50.w,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.black12,
                                              highlightColor:
                                                  Colors.white.withOpacity(0.5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:
                                                      Kwhite.withOpacity(0.5),
                                                ),
                                                height: 50.h,
                                                width: 50.w,
                                              ),
                                            ),
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/images/man.png",
                                          fit: BoxFit.contain,
                                        )
                                  : SizedBox(
                                      height: 45.h,
                                      child: const SpinKitFadingCircle(
                                        color: KOrange,
                                        size: 25,
                                      ),
                                    )),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.storydata["rows"][i]["CreatedBy"]["fname"],
                        style: TextStyle(fontSize: 10.sp, fontWeight: kFW500),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 5.w,
                  )
                ]
              ],
            )
          : const SizedBox(),
    );
  }
}

class StoryFullScreen extends StatefulWidget {
  PageController controller;
  Map storyData;
  StoryFullScreen(
      {super.key, required this.controller, required this.storyData});

  @override
  State<StoryFullScreen> createState() => _StoryFullScreenState();
}

class _StoryFullScreenState extends State<StoryFullScreen> {
  bool isLoading = false;
  Future<bool> likeStory(int id) async {
    setState(() {
      isLoading = true;
    });
    bool value = false;
    Map data = await Services.likeStoryPost(id);
    debugPrint("Liked");
    if (data["message"] != null) {
      if (data["message"] == "Unliked successfully") {
        value = false;
      } else {
        value = true;
      }
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      Fluttertoast.showToast(
        msg: "Something Went Wrong..!!",
      );
    }
    setState(() {
      isLoading = false;
    });
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: Kwhite,
        body: PageView(
      controller: widget.controller,
      children: <Widget>[
        if (widget.storyData["rows"] != null) ...[
          for (int j = 0; j < widget.storyData["rows"].length; j++) ...[
            Scaffold(
                appBar: AppBar(backgroundColor: Kwhite, actions: [
                  j == 0
                      ? const Row(
                          children: [
                            // Text("swipe Right",style: TextStyle(color: Kwhite)),
                            Icon(Icons.arrow_right_outlined)
                          ],
                        )
                      : j == widget.storyData["rows"].length - 1
                          ? const Row(
                              children: [
                                // Text("swipe Right",style: TextStyle(color: Kwhite)),
                                Icon(Icons.arrow_left_outlined)
                              ],
                            )
                          : const Row(children: [
                              Icon(Icons.arrow_left_outlined),
                              Icon(Icons.arrow_right_outlined)
                            ])
                ]),
                backgroundColor: Kwhite,
                // floatingActionButton: FloatingActionButton(
                //   backgroundColor: KOrange,
                //   onPressed: () async {
                //     bool isLikedValue = await likeStory(
                //         widget.storyData["rows"][j]["story_id"]);
                //     if (isLikedValue) {
                //       setState(() {
                //         widget.storyData["rows"][j]["isLiked"] = 1;
                //       });
                //     } else {
                //       setState(() {
                //         widget.storyData["rows"][j]["isLiked"] = 0;
                //       });
                //     }
                //   },
                //   child: isLoading == false
                //       ? widget.storyData["rows"][j]["isLiked"] == 1
                //           ? Icon(Icons.favorite)
                //           : Icon(Icons.favorite_border)
                //       : const  SpinKitFadingCircle(
                //           color: KOrange,
                //           size: 15,
                //         ),
                // ),
                body: Container(
                  padding: EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl:
                            // KstoryURL +
                            widget.storyData["rows"][j]["file"],
                        //   placeholder: (context,loadingProgress,child) {if (loadingProgress == null) {
                        //   return child;
                        // } else {
                        //   return const Center(
                        //       child:  SpinKitFadingCircle(
                        //     color: KOrange,
                        //     size: 15,
                        //   ));
                        // }},
                        errorWidget: (context, url, error) => Text(
                          "Image Error",
                          style: TextStyle(color: Kwhite),
                        ),
                      ),
                    ),
                  ]),
                )),
          ]
        ],
      ],
    ));
  }
}
