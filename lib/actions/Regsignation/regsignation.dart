// ignore_for_file: camel_case_types

import '../../untils/export_file.dart';

class Regsignation_view extends StatefulWidget {
  const Regsignation_view({super.key});

  @override
  State<Regsignation_view> createState() => _Regsignation_viewState();
}

class _Regsignation_viewState extends State<Regsignation_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kbackground,
      appBar: const VibhoAppBar(
        bColor: Kbackground,
        title: 'Apply Resignation',
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
                              fontSize: 12.sp,
                              fontWeight: kFW700,
                              color: Klightgray),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "Lorem Epson to fill the Sentences",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: kFW900,
                              color: KdarkText),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "You will be in Notice Period or you can cancel anytime ",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: kTenFont,
                              fontWeight: kFW600,
                              color: Klightblack),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "84 Days Left",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: kFW700,
                              color: KdarkText.withOpacity(0.8)),
                        ),
                        SizedBox(
                          height: 30.h,
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
                                label: "Cancel",
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
