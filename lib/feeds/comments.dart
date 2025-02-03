// ignore_for_file: prefer_const_constructors, sort_child_properties_last, camel_case_types

import 'package:comment_tree/comment_tree.dart';
import 'package:intl/intl.dart';
import 'package:vibeshr/controllers/feedsController.dart';

import '../untils/export_file.dart';

class Comments_view extends StatefulWidget {
  final String count;
  const Comments_view({super.key, required this.count});

  @override
  State<Comments_view> createState() => _Comments_viewState();
}

class commontdata {
  String postid = '';
  String comment = '';
}

class Subcommontdata {
  int postCommentid = -1;
  String comment = '';
  String nameOfPerson = '';
}

class _Comments_viewState extends State<Comments_view> {
  TextEditingController commentController = TextEditingController();
  FeedController feedController = Get.find<FeedController>();

  int subCommentid = -1;
  bool isLoading = false;
  commontdata data = commontdata();
  Subcommontdata subCommentData = Subcommontdata();
  /////getcomments
  List commentdata = [];
  Future commentListHandler() async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.commentlist();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      commentdata = data["rows"];
    }
    setState(() {
      isLoading = false;
    });
  }

////////////////////////////DeletePostComments
  bool isLoadingDeleted = false;
  deletePostComment(int id) async {
    setState(() {
      isLoadingDeleted = true;
    });

    Map value = await Services.deletePostComments(id);
    if (value["message"] != null) {
      Fluttertoast.showToast(msg: value["message"]);
      for (int i = 0; i < commentdata.length; i++) {
        if (id == commentdata[i]["post_comment_id"]) {
          setState(() {
            commentdata.remove(commentdata[i]);
          });
        }
      }
    } else {}
    setState(() {
      isLoadingDeleted = false;
    });
  }

  //
  bool isLoadingDelete = false;
  deletePostSubComment(int id) async {
    setState(() {
      isLoadingDelete = true;
    });

    Map value = await Services.deleteSubComments(id);
    if (value["message"] != null) {
      Fluttertoast.showToast(msg: value["message"]);
      commentListHandler();
      // for (int i = 0; i < commentdata.length; i++) {
      // //   if (id == commentdata[i]["post_comment_id"]) {
      // //     setState(() {
      // //       commentdata.remove(commentdata[i]);
      // //     });
      // //   }
      // // }
    } else {}
    setState(() {
      isLoadingDelete = false;
    });
  }

/////post comments
  Future createcommentHandler() async {
    setState(() {
      isLoading = true;
    });
    Map payload = {
      "post_id": feedController.postidtoCreateComment["post_id"],
      "description": data.comment,
    };

    Map value = await Services.createcomment(payload);
    if (value["message"] != null) {
      Fluttertoast.showToast(msg: value["message"]);
    } else {
      Get.back(result: "refresh");
    }
    setState(() {
      isLoading = false;
    });
  }

  ///.////Sub comments
  Future createsubcommentHandler() async {
    setState(() {
      isLoading = true;
    });
    Map payload = {
      "post_comment_id": subCommentData.postCommentid,
      "post_id": feedController.postidtoCreateComment["post_id"],
      "description": subCommentData.comment,
    };

    Map value = await Services.createsubcomment(payload);
    if (value["message"] != null) {
      Fluttertoast.showToast(msg: value["message"]);
    } else {
      Get.back();
    }
    print(value);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    commentListHandler();
    super.initState();
  }

  FocusNode myfocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedTheme == "Lighttheme" ? Kbackground : kblack,
      bottomSheet: Container(
        margin: EdgeInsets.all(13.r),
        child: CustomFormField(
            maxLines: 1,
            readOnly: false,
            labelText: "Comment",
            focusNode: myfocus,
            controller: commentController,
            hintText: "comment",
            onChanged: (value) {
              subCommentData.postCommentid == -1
                  ? data.comment = value
                  : subCommentData.comment = value;
            },
            prefix: Padding(
              padding: EdgeInsets.only(top: 17.h, left: 5),
              child: Text(
                subCommentData.nameOfPerson == ""
                    ? subCommentData.nameOfPerson
                    : "@${subCommentData.nameOfPerson}",
                style: TextStyle(fontSize: 10.sp),
              ),
            ),
            suffix: InkWell(
              onTap: () {
                subCommentData.postCommentid == -1
                    ? {
                        createcommentHandler(),
                        feedController.incrementCommentCount(
                            feedController.postidtoCreateComment["post_id"]),
                      }
                    : createsubcommentHandler();
              },
              child: Icon(
                Icons.send,
                color: KOrange,
              ),
            )),
      ),
      appBar: VibhoAppBar(
        title: "Comments",
        bColor: selectedTheme == "Lighttheme" ? Kbackground : kblack,
        dashboard: false,
      ),
      body: isLoading == false
          ? SingleChildScrollView(
              child: widget.count == "0"
                  ? Center(
                      child: Column(
                      children: [
                        SvgPicture.asset("assets/images/oopsNoData.svg",
                            // color: KOrange,
                            fit: BoxFit.fill,
                            semanticsLabel: 'No Data'),
                        SizedBox(
                          height: 40.h,
                        ),
                        Text(
                          "No Comments Found",
                          style: TextStyle(
                              fontWeight: kFW700, fontSize: kTwentyFont),
                        )
                      ],
                    ))
                  : Column(
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: commentdata.length,
                            itemBuilder: (context, index) {
                              return commentdata[index]["post_id"] ==
                                      feedController
                                          .postidtoCreateComment["post_id"]
                                  ? Container(
                                      child:
                                          CommentTreeWidget<Comment, Comment>(
                                        Comment(
                                            avatar: 'assets/images/man.png',
                                            userName: 'null',
                                            content: "main"),
                                        [
                                          for (int i = 0;
                                              i <
                                                  commentdata[index]
                                                          ["PostSubComments"]
                                                      .length;
                                              i++) ...[
                                            Comment(
                                                avatar: 'assets/images/man.png',
                                                userName: 'null',
                                                content: commentdata[index]
                                                            ["PostSubComments"]
                                                        [i]["description"]
                                                    .toString())
                                          ]
                                        ],
                                        treeThemeData: TreeThemeData(
                                            lineColor: Ktextcolor,
                                            lineWidth: 1),
                                        avatarRoot: (context, data) =>
                                            PreferredSize(
                                          child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: KOrange,
                                            // backgroundImage:
                                            //     AssetImage('assets/images/man.png'),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              child: commentdata[index][
                                                                  'PostCommentedBy']
                                                              ["profile_pic"] !=
                                                          null &&
                                                      commentdata[index][
                                                                  'PostCommentedBy']
                                                              ["profile_pic"] !=
                                                          ""
                                                  ? CachedNetworkImage(
                                                      imageUrl:
                                                          // KProfileimage +
                                                          commentdata[index][
                                                                  'PostCommentedBy']
                                                              ["profile_pic"],
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                            "assets/images/man.png",
                                                            fit: BoxFit.cover,
                                                          ))
                                                  : Image.asset(
                                                      "assets/images/man.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          preferredSize: Size.fromRadius(18),
                                        ),
                                        avatarChild: (context, data) =>
                                            PreferredSize(
                                          child: CircleAvatar(
                                            radius: 20,
                                            // backgroundColor: KOrange.withOpacity(0.5),
                                            // backgroundImage: ,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: commentdata[index][
                                                                  'PostCommentedBy']
                                                              ["profile_pic"] !=
                                                          null &&
                                                      commentdata[index][
                                                                  'PostCommentedBy']
                                                              ["profile_pic"] !=
                                                          ""
                                                  ? CachedNetworkImage(
                                                      imageUrl:
                                                          // KProfileimage +
                                                          commentdata[index][
                                                                  'PostCommentedBy']
                                                              ["profile_pic"],
                                                      fit: BoxFit.fill,
                                                      height: 40,
                                                      width: 40,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                            "assets/images/man.png",
                                                            fit: BoxFit.cover,
                                                          )
                                                      // errorBuilder: (BuildContext context,
                                                      //     Object exception, StackTrace? stackTrace) {
                                                      //   return Image.asset(
                                                      //     "assets/images/pic.png",
                                                      //      height: 180.h,
                                                      // fit: BoxFit.cover,
                                                      //   );
                                                      // },
                                                      )
                                                  : Image.asset(
                                                      "assets/images/man.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          preferredSize: Size.fromRadius(12),
                                        ),
                                        contentChild: (context, data) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 8),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: 140.w,
                                                          child: Text(
                                                            "${commentdata[index]['PostSubComments'][0]['PostSubCommentBy']["fname"]} ${commentdata[index]['PostSubComments'][0]['PostSubCommentBy']["lname"]}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: KdarkText
                                                                        .withOpacity(
                                                                            0.8)),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.h,
                                                        ),
                                                        Text(
                                                          //'yyyy-MM-dd HH:mm:ss'
                                                          DateFormat(
                                                                  'yyyy-MMM-dd')
                                                              .format(DateTime.parse(commentdata[
                                                                          index]
                                                                      [
                                                                      'PostSubComments'][0]
                                                                  [
                                                                  "updatedAt"])),

                                                          //  'Reminder for Interview in next 30 min',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .caption
                                                              ?.copyWith(
                                                                  fontSize:
                                                                      kTenFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: KdarkText
                                                                      .withOpacity(
                                                                          0.8)),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    // Text(
                                                    //  "${commentdata[index]['PostSubComments'][0]["updatedAt"]}",
                                                    //   style: Theme.of(context)
                                                    //       .textTheme
                                                    //       .caption
                                                    //       ?.copyWith(
                                                    //           fontWeight:
                                                    //               FontWeight.w600,
                                                    //           color: KdarkText
                                                    //               .withOpacity(0.8)),
                                                    // ),

                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      '${data.content}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color:
                                                                  Ktextcolor),
                                                    ),
                                                    DefaultTextStyle(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                              color: Colors
                                                                  .grey[700],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 4),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 30.w,
                                                            ),
                                                            // feedController.empProfile[
                                                            //             "username"] ==
                                                            //         commentdata[index]
                                                            //                 [
                                                            //                 'PostCommentedBy']
                                                            //             [
                                                            //             "emp_code"]
                                                            //     ?
                                                            GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          // title: Text(
                                                                          //     'Are You Sure',
                                                                          //     maxLines: 1,
                                                                          //     overflow: TextOverflow.ellipsis,
                                                                          //     style: TextStyle(fontSize: 12.sp, fontWeight: kFW700, color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite)),
                                                                          title: Text(
                                                                              'You want to Delete SubComment ?',
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(fontSize: 12.sp, fontWeight: kFW700, color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite)),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Get.back();
                                                                              },
                                                                              child: Text('No', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.sp, fontWeight: kFW700, color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite)),
                                                                            ),
                                                                            TextButton(
                                                                              // textColor: Color(0xFF6200EE),
                                                                              onPressed: () async {
                                                                                //   feedController.decreementCommentCount(feedController.postidtoCreateComment["post_id"]);

                                                                                await deletePostSubComment(commentdata[index]['PostSubComments'][0]["post_sub_comment_id"]);
                                                                                // deletePostComment(commentdata[index]['post_comment_id']
                                                                                //     //claimData["claim_id"],
                                                                                //     )
                                                                                Get.back();
                                                                              },
                                                                              child: Text('Yes', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.sp, fontWeight: kFW700, color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite)),
                                                                            )
                                                                          ],
                                                                        );
                                                                      });
                                                                  // Get.toNamed(
                                                                  //     KBottom_navigation);
                                                                },
                                                                //                     onTap: (value) async {
                                                                //   await deleteStoryPost(
                                                                //       postdataPageNation[0][index]["post_id"]);
                                                                // },
                                                                // onTap: () {},
                                                                child: Text(
                                                                  'Delete',
                                                                  style: TextStyle(
                                                                      color:
                                                                          KRed),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        contentRoot: (context, data) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 8),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: 180.w,
                                                          child: Text(
                                                            //"bkhjlbl lkl kjkjl jkn;kll;hlbkj;jkn jb l;pkj ",
                                                            maxLines: 2,

                                                            "${commentdata[index]['PostCommentedBy']['fname']}${commentdata[index]['PostCommentedBy']['lname']}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption!
                                                                .copyWith(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color:
                                                                        KOrange),
                                                          ),
                                                        ),
                                                        // Text(
                                                        //   "${commentdata[index]['PostCommentedBy']['fname']}${commentdata[index]['PostCommentedBy']['lname']}",
                                                        //   style: Theme.of(
                                                        //           context)
                                                        //       .textTheme
                                                        //       .caption!
                                                        //       .copyWith(
                                                        //           fontSize:
                                                        //               12.sp,
                                                        //           fontWeight:
                                                        //               FontWeight
                                                        //                   .w600,
                                                        //           color:
                                                        //               KOrange),
                                                        // ),
                                                        Text(
                                                          //'yyyy-MM-dd HH:mm:ss'
                                                          DateFormat(
                                                                  'yyyy-MMM-dd')
                                                              .format(DateTime.parse(
                                                                  commentdata[
                                                                          index]
                                                                      [
                                                                      "updatedAt"])),

                                                          //  'Reminder for Interview in next 30 min',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .caption
                                                              ?.copyWith(
                                                                  fontSize:
                                                                      kTenFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: KdarkText
                                                                      .withOpacity(
                                                                          0.8)),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      commentdata[index] != null
                                                          ? '${commentdata[index]['description']}'
                                                          : "-",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              DefaultTextStyle(
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                        color: Colors.grey[700],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 4),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              subCommentData
                                                                      .postCommentid =
                                                                  commentdata[
                                                                          index]
                                                                      [
                                                                      "post_comment_id"];
                                                              subCommentData
                                                                      .nameOfPerson =
                                                                  commentdata[index]
                                                                          [
                                                                          "PostCommentedBy"]
                                                                      ["fname"];
                                                            });
                                                            setState(() {
                                                              myfocus
                                                                  .requestFocus();
                                                            });
                                                          },
                                                          child: Text('Reply')),
                                                      SizedBox(
                                                        width: 24,
                                                      ),
                                                      feedController.empProfile[
                                                                  "username"] ==
                                                              commentdata[index]
                                                                      [
                                                                      'PostCommentedBy']
                                                                  ["emp_code"]
                                                          ? GestureDetector(
                                                              onTap: () async {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        // title: Text(
                                                                        //     'Are You Sure',
                                                                        //     maxLines:
                                                                        //         1,
                                                                        //     overflow: TextOverflow
                                                                        //         .ellipsis,
                                                                        //     style: TextStyle(
                                                                        //         fontSize: 12.sp,
                                                                        //         fontWeight: kFW700,
                                                                        //         color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite)),
                                                                        title: Text(
                                                                            'You want to Delete Comment ?',
                                                                            maxLines:
                                                                                2,
                                                                            overflow: TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize: 12.sp,
                                                                                fontWeight: kFW700,
                                                                                color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite)),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Get.back();
                                                                            },
                                                                            child: Text('No',
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontSize: 12.sp, fontWeight: kFW700, color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite)),
                                                                          ),
                                                                          TextButton(
                                                                            // textColor: Color(0xFF6200EE),
                                                                            onPressed:
                                                                                () async {
                                                                              feedController.decreementCommentCount(feedController.postidtoCreateComment["post_id"]);

                                                                              await deletePostComment(commentdata[index]['post_comment_id']
                                                                                  //claimData["claim_id"],
                                                                                  );
                                                                              Get.back();
                                                                            },
                                                                            child: Text('Yes',
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontSize: 12.sp, fontWeight: kFW700, color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite)),
                                                                          )
                                                                        ],
                                                                      );
                                                                    });
                                                                // Get.toNamed(
                                                                //     KBottom_navigation);
                                                              },
                                                              //                     onTap: (value) async {
                                                              //   await deleteStoryPost(
                                                              //       postdataPageNation[0][index]["post_id"]);
                                                              // },
                                                              // onTap: () {},
                                                              child: Text(
                                                                'Delete',
                                                                style: TextStyle(
                                                                    color:
                                                                        KRed),
                                                              ))
                                                          : SizedBox()
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                    )
                                  : SizedBox();
                            }),
                        SizedBox(
                          height: 70.h,
                        ),
                      ],
                    ),
            )
          : const Center(
              child: SpinKitFadingCircle(
              color: KOrange,
              size: 50,
            )),
    );
  }
}
