// ignore_for_file: camel_case_types

import '../../untils/export_file.dart';

class Feedback_view extends StatefulWidget {
  const Feedback_view({super.key});

  @override
  State<Feedback_view> createState() => _Feedback_viewState();
}

class _Feedback_viewState extends State<Feedback_view> {
  @override
  Map feedbackResult = {};
  bool isLoading = false;
  double _rating = 0.0;
  String feedbackMessage = "";
  Future<void> sendFeedback() async {
    setState(() {
      isLoading = true;
    });
    var payload = {
      "rating": _rating,
      "subject": "FeedBack",
      "description": feedbackMessage
    };
    Map data = await Services.postFeedBack(payload);

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      feedbackResult = data;
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7.r),
      decoration: const BoxDecoration(
          color: Kwhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "How do you feel about Vibho HCM?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 13.5.sp,
                        fontWeight: kFW600,
                        color: KdarkText),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close_rounded))
                ],
              ),
              Text(
                "Pick as you’d like the Interface ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: kFW600,
                    color: Klightgray.withOpacity(0.7)),
              ),
              SizedBox(
                height: 20.h,
              ),
              RatingBar.builder(
                initialRating: 2,
                direction: Axis.horizontal,
                itemCount: 5,
                //unratedColor: Colors.,
                itemPadding: EdgeInsets.symmetric(horizontal: 10.w),
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Image.asset(
                        "assets/images/emoji1.png",
                        width: 30.w,
                      );
                    case 1:
                      return Image.asset(
                        "assets/images/emoji2.png",
                        width: 25,
                      );
                    case 2:
                      return Image.asset(
                        "assets/images/emoji3.png",
                        width: 25,
                      );
                    case 3:
                      return Image.asset(
                        "assets/images/emoji4.png",
                        width: 25,
                      );
                    case 4:
                      return Image.asset(
                        "assets/images/emoji5.png",
                        width: 25,
                      );
                    default:
                      return Container();
                  }
                },
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
                updateOnDrag: true,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Anything we could do better in Interface?",
                //textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 13.sp, fontWeight: kFW600, color: KdarkText),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Your Feedback would be appreciated!",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: kFW600,
                    color: Klightgray.withOpacity(0.7)),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 120.h,
                margin: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                      color: Klightgray,
                      width: 1,
                    )),
                child: TextFormField(
                  maxLines: 8,

                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintStyle: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey,
                    ),
                    hintText: 'Tell us What you like, or what you didn’t...',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 10, top: 10),
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Please enter some text';
                  //   }
                  //   return null;
                  // },
                  onChanged: (String value) {
                    setState(() {
                      feedbackMessage = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              isLoading == false
                  ? CustomButton(
                      height: 35.h,
                      width: double.infinity,
                      textColor: Kwhite,
                      borderRadius: BorderRadius.circular(20.r),
                      Color: KOrange,
                      fontSize: 13.sp,
                      fontWeight: kFW600,
                      label: "Send Feedback",
                      isLoading: false,
                      onTap: () async {
                        await sendFeedback();
                        Get.back();
                      })
                  : const Center(
                      child: SpinKitFadingCircle(
                      color: KOrange,
                      size: 35,
                    )),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
