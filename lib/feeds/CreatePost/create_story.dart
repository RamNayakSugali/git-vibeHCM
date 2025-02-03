// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:video_thumbnail/video_thumbnail.dart';

import '../../untils/export_file.dart';

class Create_Story extends StatefulWidget {
  const Create_Story({super.key});

  @override
  State<Create_Story> createState() => _Create_StoryState();
}

class _Create_StoryState extends State<Create_Story> {
  List<File> selectedImages = [];
  final picker = ImagePicker();
  MediaType _mediaType = MediaType.image;
  ServiceController serviceController = Get.put(ServiceController());

  String? imagePath;
  bool isLoading = false;
  Map createStoryData = {};

  createStory() async {
    setState(() {
      isLoading = true;
    });
    var data =
        await Services.uploadFileToServer(selectedImages[0].path, "story");
    Map payload = {"file": data["msg"]};
    Map storyData = await Services.createStory(payload);

    if (storyData["message"] != null) {
      Fluttertoast.showToast(
        msg: storyData["message"],
      );
    } else {
      createStoryData = storyData;
      Fluttertoast.showToast(
        msg: "Stroy Success",
      );
      Get.back();
      //  Get.back();
      //Get.toNamed(KBottom_navigation);
    }
    setState(() {
      isLoading = false;
    });
  }
  //////////////////////////

  ////////////////////////////

////////Profile
  Map profiledata = {};

  Future profileListApi() async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.employeeprofile();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      profiledata = data["Employee"];
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    selectedImages.clear();
    profileListApi();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kwhite,
      bottomSheet: Container(
          margin: EdgeInsets.all(30.r),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _mediaType = MediaType.image;
                pickMedia(ImageSource.gallery);
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.photo,
                  color: KOrange,
                ),
                Text(
                  "Gallery",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: kFW800,
                    color: KdarkText.withOpacity(0.8),
                    letterSpacing: 0.5,
                  ),
                )
              ],
            ),
          )),
      appBar: VibhoAppBar(
        bColor: Kwhite,
        title: "Create Story",
        trailing: isLoading == false
            ? Align(
                alignment: Alignment.topRight,
                child: CustomButton(
                    borderRadius: BorderRadius.circular(30.r),
                    margin: EdgeInsets.all(10.r),
                    width: 90,
                    height: 35.h,
                    Color: KOrange,
                    textColor: Kwhite,
                    fontSize: 13.sp,
                    fontWeight: kFW700,
                    label: "Post",
                    isLoading: false,
                    onTap: () {
                      createStory();
                    }),
              )
            : const Center(
                child: SpinKitFadingCircle(
                  color: KOrange,
                  size: 15,
                ),
              ),
      ),
      body: Container(
        margin: EdgeInsets.all(13.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r), color: Kwhite),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(5),
                              height: 45.h,
                              width: 45.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13.r),
                                color: Kwhite,
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      13.r), // Image border
                                  child: profiledata["profile_pic"] != null &&
                                          profiledata["profile_pic"] != ""
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              // KProfileimage +
                                              profiledata["profile_pic"],
                                          // errorBuilder: (BuildContext context,
                                          //     Object exception, StackTrace? stackTrace) {
                                          //   return Image.asset(
                                          //     "assets/images/man.png",
                                          //     fit: BoxFit.contain,
                                          //   );
                                          // },
                                          errorWidget: (context, url, error) =>
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
                          SizedBox(
                            width: 6.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profiledata.isNotEmpty
                                    ? "${profiledata["fname"]}${profiledata["lname"]}"
                                    : "-",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: kFW700,
                                    color: KdarkText),
                              ),
                              SizedBox(
                                height: 7.w,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 350.h,
                        color: Kwhite,
                        child: ListView.builder(
                            itemCount: selectedImages.length,
                            //scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.all(10),
                                  child: Stack(
                                    children: [
                                      (imagePath != null)
                                          ? Image.file(
                                              selectedImages[index],
                                              width: 300.w,
                                              height: 300.h,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              width: 300,
                                              height: 300,
                                              color: Colors.grey[300]!,
                                            ),
                                      // Image.file(selectedImages[index],fit: BoxFit.contain,height: 200.w,),
                                      Positioned(
                                        right: 5.w,
                                        top: 3,
                                        child: InkWell(
                                          child: CircleAvatar(
                                            radius: 12.r,
                                            backgroundColor: Kwhite,
                                            child: Icon(
                                              Icons.close_rounded,
                                              size: 16.r,
                                              color: KdarkText,
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              selectedImages.replaceRange(
                                                  index, index + 1, []);
                                            });
                                          },
                                        ),
                                      )
                                    ],
                                  ));
                            }),
                      ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Custom_textButton(
                      //         label: "Photos",
                      //         onTap: () {
                      //           setState(() {
                      //             _mediaType = MediaType.image;
                      //             pickMedia(ImageSource.gallery);
                      //           });
                      //           //  getImages();
                      //         },
                      //         images: "assets/images/galley.png"),
                      //   ],
                      // )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void pickMedia(ImageSource source) async {
    // selectedImages.clear();
    XFile? file;
    if (_mediaType == MediaType.image) {
      file = await ImagePicker().pickImage(source: source, imageQuality: 100);
    } else {
      file = await ImagePicker().pickVideo(source: source);
    }
    if (file != null) {
      imagePath = file.path;
      selectedImages.add(File(file.path));
      if (_mediaType == MediaType.video) {
        imagePath = await VideoThumbnail.thumbnailFile(
            video: file.path,
            imageFormat: ImageFormat.PNG,
            quality: 100,
            maxWidth: 300,
            maxHeight: 300);
      }
      setState(() {});
    }
  }
}
