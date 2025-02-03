// ignore_for_file: camel_case_types

import '../untils/export_file.dart';

class post_likes extends StatefulWidget {
  const post_likes({super.key});

  @override
  State<post_likes> createState() => _post_likesState();
}

class _post_likesState extends State<post_likes> {
  var postId = Get.arguments;
  bool isLoading = false;
  List<dynamic> likedataData = [];
  // Map BirthdayData = {};

  getPostlikes(postId) async {
    setState(() {
      isLoading = true;
    });

    var data = await Services.likeslistbyId(postId);
    if (data != null) {
      likedataData = data["rows"];
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
    getPostlikes(postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kbackground,
        appBar: const VibhoAppBar(
          title: "All Likes",
          dontHaveBackAsLeading: false,
          bColor: Kbackground,
        ),
        body: Container(
          margin: EdgeInsets.all(13.r),
          child: isLoading == true
              ? SpinKitFadingCircle(
                  color: KOrange,
                  size: 50,
                )
              : likedataData.isEmpty
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
                          "No Likes Found",
                          style: TextStyle(
                              fontWeight: kFW700, fontSize: kTwentyFont),
                        )
                      ],
                    ))
                  : ListView.builder(
                      itemCount: likedataData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(13.r),
                                  child: Image.asset(
                                    likedataData[index]["PostLikedBy"]
                                                ["gender"] ==
                                            "Male"
                                        ? "assets/images/man.png"
                                        : "assets/images/girl.png",
                                    height: 40.h,
                                    width: 40.h,
                                    fit: BoxFit.contain,
                                  )),
                              SizedBox(
                                width: 5.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    likedataData[index]["PostLikedBy"]
                                            ["fname"] ??
                                        "" +
                                            " " +
                                            likedataData[index]["PostLikedBy"]
                                                ["lname"] ??
                                        "No Name",
                                    style: TextStyle(
                                        fontSize: kFourteenFont,
                                        fontWeight: kFW700,
                                        color: KdarkText),
                                  ),
                                  SizedBox(
                                    height: 7.w,
                                  ),
                                  Text(
                                    likedataData[index]["PostLikedBy"]
                                        ["emp_code"],
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Klightblack.withOpacity(0.5)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
        ));
  }
}
