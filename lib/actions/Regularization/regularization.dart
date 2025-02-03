import 'package:vibeshr/untils/export_file.dart';

class Regularization extends StatefulWidget {
  const Regularization({super.key});

  @override
  State<Regularization> createState() => _RegularizationState();
}

class _RegularizationState extends State<Regularization> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kbackground,
      appBar: const VibhoAppBar(
        bColor: Kbackground,
        title: 'Apply Regularization',
        dontHaveBackAsLeading: false,
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.all(13.r),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Kwhite,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.roundToDouble())),
                      child: Image.asset(
                        "assets/images/buble.png",
                        width: 90.w,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 10.w, bottom: 8.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Regularization",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: kFW700,
                              color: KdarkText),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "Lorem Epson Is a dummy text to fill",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: kTenFont,
                              fontWeight: kFW600,
                              color: Klightblack),
                        ),
                        SizedBox(
                          height: 45.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Custom_OutlineButton(
                                height: 28.h,
                                width: 105.w,
                                textColor: KOrange,
                                borderRadius: BorderRadius.circular(8.r),
                                Color: KOrange,
                                label: "View Pending",
                                fontSize: kTenFont,
                                fontWeight: kFW600,
                                isLoading: false,
                                onTap: () {}),
                            SizedBox(
                              width: 10.w,
                            ),
                            CustomButton(
                                height: 28.h,
                                width: 105.w,
                                textColor: Kwhite,
                                borderRadius: BorderRadius.circular(8.r),
                                Color: KOrange,
                                fontSize: kTenFont,
                                fontWeight: kFW600,
                                label: "Apply",
                                isLoading: false,
                                onTap: () {
                                  Get.toNamed(KApply_Regularization);
                                })
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
