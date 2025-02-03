import 'dart:io';

import 'package:vibeshr/controllers/feedsController.dart';

import '../../untils/export_file.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

enum MediaType {
  image,
  video;
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  List<XFile>? imagefiles;

  List<XFile> selectedImages = [];
  final picker = ImagePicker();
  MediaType _mediaType = MediaType.image;
  ServiceController serviceController = Get.put(ServiceController());
  FeedController feedController = Get.find<FeedController>();

  String? imagePath;
  bool isLoading = false;
  Map createpostData = {};

  createpost() async {
    setState(() {
      isLoading = true;
    });
    var data = [];
    for (int i = 0; i < selectedImages.length; i++) {
      data.add(
          await Services.uploadFileToServer(selectedImages[i].path, "post"));
    }
    // data.add(await Services.uploadFileToServer(selectedImages[0].path, "post"));
    var filesList = [];
    for (int i = 0; i < data.length; i++) {
      filesList.add({"file": data[i]["msg"]});
    }
    Map payload = {
      "celebrate_id": serviceController.celebrateID ?? 0,
      "description": serviceController.celebrateText,
      "files": filesList
    };
    Map postData = await Services.createPost(payload);

    if (postData["message"] != null) {
      Fluttertoast.showToast(
        msg: postData["message"],
      );
    } else {
      createpostData = postData;
      Fluttertoast.showToast(
        msg: "Post Success",
      );
      Get.back();
    }
    setState(() {
      isLoading = false;
    });
  }

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
    serviceController.celebratepost.clear();
    profileListApi();
    super.initState();
  }

  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _showKeyboard(node) {
    FocusScope.of(context).requestFocus(node);
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _handleTapOutside() {
    _hideKeyboard();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTapOutside,
      child: Scaffold(
        backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
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
                    "Photos",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: kFW800,
                      color: KdarkText.withOpacity(0.8),
                      letterSpacing: 0.5,
                    ),
                  )
                ],
              ),
            )),
        appBar: VibhoAppBar(
          bColor: selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
          title: "New Post",
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
                        if (_formKey.currentState!.validate()) {
                          createpost();
                        }
                      }),
                )
              : Container(
                  width: 80.sp,
                  alignment: Alignment.center,
                  child: SpinKitFadingCircle(
                    color: KOrange,
                    size: 25,
                  ),
                ),
        ),
        body: Container(
          // margin: EdgeInsets.all(13.r),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: selectedTheme == "Lighttheme"
                            ? Kwhite
                            : Kthemeblack,
                      ),
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
                                      child: profiledata["profile_pic"] !=
                                                  null &&
                                              profiledata["profile_pic"] != ""
                                          ? CachedNetworkImage(
                                              imageUrl:
                                                  // KProfileimage +
                                                  profiledata["profile_pic"],
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                "assets/images/man.png",
                                                fit: BoxFit.contain,
                                              ),
                                              // errorBuilder: (BuildContext context,
                                              //     Object exception, StackTrace? stackTrace) {
                                              //   return
                                              // Image.asset(
                                              //     "assets/images/man.png",
                                              //     fit: BoxFit.contain,
                                              //   );
                                              // },
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
                                        ? "${profiledata["fname"]} ${profiledata["lname"]}"
                                        : "-",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: kFW700,
                                        color: KdarkText),
                                  ),
                                  Text(
                                    profiledata.isNotEmpty
                                        ? "${profiledata["Designation"]["designation_name"]}"
                                        : "-",
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Klightblack.withOpacity(0.9)),
                                  ),
                                ],
                              )
                            ],
                          ),
                          TextFormField(
                            focusNode: _focusNode,
                            onTap: () {
                              _showKeyboard(_focusNode);
                            },
                            cursorColor: KOrange,
                            controller: serviceController.celebratepost,
                            autofillHints: const [AutofillHints.email],
                            onEditingComplete: () =>
                                TextInput.finishAutofillContext(),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "What do you want to talk about?",
                                hintStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: kFW900,
                                    color: Klightgery.withOpacity(0.9))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text ';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                serviceController.celebrateText = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            height: 350.h,
                            color: Kbackground,
                            child: ListView.builder(
                                itemCount: selectedImages.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.all(10),
                                      child: Stack(
                                        children: [
                                          selectedImages[index].path != ""
                                              ? Image.file(
                                                  File(selectedImages[index]
                                                      .path),
                                                  width: 300.w,
                                                  height: 350.h,
                                                  fit: BoxFit.cover,
                                                )
                                              : Container(
                                                  width: 300,
                                                  height: 350,
                                                  color: Colors.grey[300]!,
                                                ),

                                          // (imagePath != null)
                                          //     ?
                                          //     Image.file(
                                          //         selectedImages[index],
                                          //         width: 300.w,
                                          //         height: 300.h,
                                          //         fit: BoxFit.cover,
                                          //       )
                                          //     : Container(
                                          //         width: 300,
                                          //         height: 300,
                                          //         color: Colors.grey[300]!,
                                          //       ),
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
                          SizedBox(
                            height: 20.h,
                          ),
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
                          //     SizedBox(
                          //       width: 50.w,
                          //     ),
                          //     // Custom_textButton(
                          //     //     label: "Video",
                          //     //     onTap: () {
                          //     //       setState(() {
                          //     //         _mediaType = MediaType.video;
                          //     //         pickMedia(ImageSource.gallery);
                          //     //       });
                          //     //     },
                          //     //     images: "assets/images/galley.png"),
                          //     Custom_textButton(
                          //         label: "Celebrate",
                          //         onTap: () {
                          //           Get.toNamed(KCelebrates);
                          //         },
                          //         images: "assets/images/party.png"),
                          //   ],
                          // )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void pickMedia(ImageSource source) async {
    selectedImages.clear();
    if (_mediaType == MediaType.image) {
      imagefiles = (await ImagePicker().pickMultiImage(imageQuality: 100));
    }
    if (imagefiles!.isNotEmpty) {
      setState(() {
        selectedImages.addAll(imagefiles!);
      });
    }
  }
}
