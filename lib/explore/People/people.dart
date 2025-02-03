// ignore_for_file: camel_case_types

import '../../untils/export_file.dart';

class People_list extends StatefulWidget {
  const People_list({super.key});

  @override
  State<People_list> createState() => _People_listState();
}

class _People_listState extends State<People_list> {
  PeopleController peopleController = Get.find<PeopleController>();
  FocusNode myfocus = FocusNode();
  Future<void> _refreshPeopleData() async {
    setState(() {
      peopleController.onInit();
    });
  }

  @override
  void initState() {
    peopleController.peoplesdata["rows"] = peopleController.originalList;
    super.initState();
  }

  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _showKeyboard() {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _handleTapOutside() {
    _hideKeyboard();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTapOutside,
      child: Scaffold(
          backgroundColor:
              selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
          appBar: AppBar(
            elevation: 0,
            backgroundColor:
                selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                size: 23.w,
                color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
              ),
            ),
            title: Text(
              "People",
              style: TextStyle(
                fontSize: kSixteenFont,
                fontWeight: kFW700,
                color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
                letterSpacing: 0.5,
              ),
            ),
          ),
          body: RefreshIndicator(
              onRefresh: _refreshPeopleData,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(13.r),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        focusNode: _focusNode,
                        onTap: () {
                          _showKeyboard();
                        },
                        onChanged: (value) {
                          setState(() {
                            peopleController.peoplesdata["rows"] =
                                peopleController.originalList
                                    .where((element) =>
                                        element["Employee"]["fname"]
                                            .toString()
                                            .toLowerCase()
                                            .contains(value
                                                .toString()
                                                .toLowerCase()) ||
                                        element["Employee"]["lname"]
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                value.toString().toLowerCase()))
                                    .toList();
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                              onPressed: () {
                                myfocus.requestFocus();
                              },
                              icon: Icon(
                                Icons.search,
                                color: selectedTheme == "Lighttheme"
                                    ? kSearchcolor
                                    : Kwhite,
                              )),
                          focusColor: Colors.white,

                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 10.0),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kSearchcolor.withOpacity(0.2),
                                width: 0.5),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kSearchcolor.withOpacity(0.2),
                                width: 0.5),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kSearchcolor.withOpacity(0.2),
                                width: 0.5),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kSearchcolor.withOpacity(0.2),
                                width: 0.5),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kSearchcolor.withOpacity(0.2),
                                width: 0.5),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          fillColor: kSearchcolor.withOpacity(0.15),
                          filled: true,

                          hintText: "Search Your Mates..",

                          //make hint text
                          hintStyle: TextStyle(
                            color: Klightgray.withOpacity(0.5),
                            fontSize: kTenFont,
                            fontWeight: FontWeight.w600,
                          ),
                          //create lable
                          labelText: 'Search',
                          //lable style
                          labelStyle: TextStyle(
                            color: Klightgray,
                            fontSize: kTenFont,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Obx(
                        () => peopleController.peoplesdata["rows"].length > 0
                            ? peopleController.isPeopleLoading.value == false
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: peopleController
                                        .peoplesdata["rows"].length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.all(10.r),
                                        margin: EdgeInsets.only(top: 10.h),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13.r),
                                            color: selectedTheme == "Lighttheme"
                                                ? Kwhite
                                                : Kthemeblack),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // Get.toNamed(KProfile);
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(5),
                                                        height: 55.h,
                                                        width: 55.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13.r),
                                                            color: selectedTheme ==
                                                                    "Lighttheme"
                                                                ? Kwhite
                                                                : Kthemeblack),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                          child: peopleController.peoplesdata["rows"]
                                                                              [
                                                                              index]
                                                                          [
                                                                          "Employee"]
                                                                      [
                                                                      "profile_pic"] !=
                                                                  null
                                                              ? CachedNetworkImage(
                                                                  imageUrl:
                                                                      // KProfileimage +
                                                                      peopleController.peoplesdata["rows"][index]
                                                                              [
                                                                              "Employee"]
                                                                          [
                                                                          "profile_pic"],
                                                                  height: 55.h,
                                                                  width: 55.h,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          SizedBox(
                                                                    height:
                                                                        50.h,
                                                                    width: 50.w,
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
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color:
                                                                              Kwhite.withOpacity(0.5),
                                                                        ),
                                                                        height:
                                                                            50.h,
                                                                        width:
                                                                            50.w,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      peopleController.peoplesdata["rows"][index]["Employee"]["gender"] ==
                                                                              "Male"
                                                                          ? Image
                                                                              .asset(
                                                                              "assets/images/man.png",
                                                                              height: 55.h,
                                                                              width: 55.h,
                                                                              fit: BoxFit.contain,
                                                                            )
                                                                          : Image
                                                                              .asset(
                                                                              "assets/images/girl.png",
                                                                              height: 55.h,
                                                                              width: 55.h,
                                                                              fit: BoxFit.contain,
                                                                            ),
                                                                )
                                                              : peopleController
                                                                              .peoplesdata["rows"][index]["Employee"]
                                                                          [
                                                                          "gender"] ==
                                                                      "Male"
                                                                  ? Image.asset(
                                                                      "assets/images/man.png",
                                                                      height:
                                                                          55.h,
                                                                      width:
                                                                          55.h,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    )
                                                                  : Image.asset(
                                                                      "assets/images/girl.png",
                                                                      height:
                                                                          55.h,
                                                                      width:
                                                                          55.h,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                        ),
                                                      ),
                                                      // Positioned(
                                                      //   right: 10,
                                                      //   top: 10,
                                                      //   child: CircleAvatar(
                                                      //     backgroundColor: Kgreen,
                                                      //     radius: 4.r,
                                                      //   ),
                                                      // )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 220.w,
                                                      child: Text(
                                                        peopleController.peoplesdata[
                                                                    "rows"] !=
                                                                null
                                                            ? "${peopleController.peoplesdata["rows"][index]["Employee"]["fname"]} ${peopleController.peoplesdata["rows"][index]["Employee"]["lname"]}"
                                                            : "",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: kFW800,
                                                            color: selectedTheme ==
                                                                    "Lighttheme"
                                                                ? KdarkText
                                                                : Kwhite),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),
                                                    peopleController.peoplesdata[
                                                                        "rows"]
                                                                    [index]
                                                                ["Role"] !=
                                                            null
                                                        ? Text(
                                                            "Employee",
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    kFW600,
                                                                color: selectedTheme ==
                                                                        "Lighttheme"
                                                                    ? Ktextcolor
                                                                    : Kwhite),
                                                          )
                                                        : SizedBox(),
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),

                                                    SizedBox(
                                                      width: 220.w,
                                                      child: RichText(
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 1,
                                                        text: TextSpan(
                                                          text: peopleController.peoplesdata["rows"]
                                                                          [index][
                                                                      "Role"] !=
                                                                  null
                                                              ? peopleController.peoplesdata["rows"][index]["role_id"] ==
                                                                      "Employee"
                                                                  ? peopleController.peoplesdata["rows"]
                                                                          [index][
                                                                      "role_id"]
                                                                  : peopleController.peoplesdata["rows"]
                                                                          [index]["Role"][
                                                                      "role_name"]
                                                              : peopleController.peoplesdata["rows"]
                                                                          [index]
                                                                      ["role_id"] ??
                                                                  "",
                                                          style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  kFW500,
                                                              color: selectedTheme ==
                                                                      "Lighttheme"
                                                                  ? Ktextcolor
                                                                  : Kwhite),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: peopleController
                                                                              .peoplesdata[
                                                                          "rows"] !=
                                                                      null
                                                                  ? " | ${peopleController.peoplesdata["rows"][index]["Employee"]["emp_code"]}"
                                                                  : "",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      kTwelveFont,
                                                                  fontWeight:
                                                                      kFW900,
                                                                  color: selectedTheme ==
                                                                          "Lighttheme"
                                                                      ? KdarkText
                                                                          .withOpacity(
                                                                              0.6)
                                                                      : Kwhite),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    // SizedBox(
                                                    //   height: 10.h,
                                                    // ),
                                                    // Row(
                                                    //   children: [
                                                    //     GestureDetector(
                                                    //       onTap: () async {
                                                    //         String email = Uri.encodeComponent(
                                                    //             "${peoplesdata["rows"][index]["email"]} "
                                                    //             // "jane@vibhotech.com"
                                                    //             );
                                                    //         String subject =
                                                    //             Uri.encodeComponent("Hi");
                                                    //         String body = Uri.encodeComponent(
                                                    //             "Hi! I'm Flutter Developer");
                                                    //         print(
                                                    //             subject); //output: Hello%20Flutter
                                                    //         Uri mail = Uri.parse(
                                                    //             "mailto:$email?subject=$subject&body=$body");
                                                    //         if (await launchUrl(mail)) {
                                                    //           //email app opened
                                                    //         } else {
                                                    //           //email app is not opened
                                                    //         }
                                                    //       },
                                                    //       child: Text(
                                                    //         peoplesdata["rows"] != null
                                                    //             ? "${peoplesdata["rows"][index]["email"]} "
                                                    //             : "",
                                                    //         style: TextStyle(
                                                    //             fontSize: 11.sp,
                                                    //             fontWeight: kFW800,
                                                    //             color: KdarkText
                                                    //                 .withOpacity(0.5)),
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        String email = Uri.encodeComponent(
                                                            "${peopleController.peoplesdata["rows"][index]["Employee"]["email_id"]
                                                            //  peopleController.peoplesdata["rows"][index]["email"]
                                                            } "
                                                            // "jane@vibhotech.com"
                                                            );
                                                        String subject =
                                                            Uri.encodeComponent(
                                                                "Hello");
                                                        String body =
                                                            Uri.encodeComponent(
                                                                "Hello! ${peopleController.peoplesdata["rows"][index]["Employee"]["fname"]} ${peopleController.peoplesdata["rows"][index]["Employee"]["lname"]}");
                                                        print(
                                                            subject); //output: Hello%20Flutter
                                                        Uri mail = Uri.parse(
                                                            "mailto:$email?subject=$subject&body=$body");
                                                        if (await launchUrl(
                                                            mail)) {
                                                          //email app opened
                                                        } else {
                                                          //email app is not opened
                                                        }
                                                      },
                                                      child: SizedBox(
                                                        width: 230.w,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            // SizedBox(
                                                            //   width: 15.w,
                                                            // ),
                                                            SizedBox(
                                                              width: 150.w,
                                                              child: Text(
                                                                peopleController
                                                                            .peoplesdata["rows"] !=
                                                                        null
                                                                    ? "${peopleController.peoplesdata["rows"][index]["Employee"]["email_id"]
                                                                        // peopleController.peoplesdata["rows"][index]["email"]
                                                                        } "
                                                                    : "",
                                                                maxLines: 2,
                                                                // peoplesdata["rows"] != null
                                                                //     ? "${peoplesdata["rows"][index]["email"]} "
                                                                //     : "",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontWeight:
                                                                        kFW800,
                                                                    color: selectedTheme ==
                                                                            "Lighttheme"
                                                                        ? KdarkText.withOpacity(
                                                                            0.5)
                                                                        : Kwhite),
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons.mail,
                                                              size:
                                                                  kSixteenFont,
                                                              color: KOrange,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        var url = Uri.parse(
                                                            "tel:${peopleController.peoplesdata["rows"][index]["Employee"]["phone_no"]}");
                                                        if (await canLaunchUrl(
                                                            url)) {
                                                          await launchUrl(url);
                                                        } else {
                                                          throw 'Could not launch $url';
                                                        }
                                                      },
                                                      child: SizedBox(
                                                        width: 230.w,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              peopleController.peoplesdata[
                                                                          "rows"] !=
                                                                      null
                                                                  ? "${peopleController.peoplesdata["rows"][index]["Employee"]["phone_no_code"]} ${peopleController.peoplesdata["rows"][index]["Employee"]["phone_no"]}"
                                                                  : "",

                                                              //   $.rows.[]Employee.phone_no
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                  fontWeight:
                                                                      kFW800,
                                                                  color: selectedTheme ==
                                                                          "Lighttheme"
                                                                      ? KdarkText
                                                                          .withOpacity(
                                                                              0.5)
                                                                      : Kwhite),
                                                            ),
                                                            Icon(
                                                              Icons.phone,
                                                              size:
                                                                  kSixteenFont,
                                                              color: Kgreen,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                      // : const SizedBox();
                                    },
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 70.h,
                                              width: 70.w,
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.black12,
                                                highlightColor: Colors.white
                                                    .withOpacity(0.5),
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
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 15.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 70.h,
                                              width: 70.w,
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.black12,
                                                highlightColor: Colors.white
                                                    .withOpacity(0.5),
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
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 15.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 70.h,
                                              width: 70.w,
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.black12,
                                                highlightColor: Colors.white
                                                    .withOpacity(0.5),
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
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 15.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 70.h,
                                              width: 70.w,
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.black12,
                                                highlightColor: Colors.white
                                                    .withOpacity(0.5),
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
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 15.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 70.h,
                                              width: 70.w,
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.black12,
                                                highlightColor: Colors.white
                                                    .withOpacity(0.5),
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
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 15.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 70.h,
                                              width: 70.w,
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.black12,
                                                highlightColor: Colors.white
                                                    .withOpacity(0.5),
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
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 15.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                  width: 230.w,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor: Colors.white
                                                        .withOpacity(0.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        color:
                                                            Kwhite.withOpacity(
                                                                0.5),
                                                      ),
                                                      height: 50.h,
                                                      width: 250.w,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                            : Column(children: [
                                SizedBox(
                                  height: 180.h,
                                ),
                                Text(
                                    "We couldn't find any people associated with this search",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Klightblack,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700)),
                              ]),

                        //  const  SpinKitFadingCircle(
                        //     color: KOrange,
                        //     size: 25,
                        //   ),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
