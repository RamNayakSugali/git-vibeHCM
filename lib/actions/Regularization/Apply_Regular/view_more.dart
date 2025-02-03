// ignore_for_file: camel_case_types

import '../../../untils/export_file.dart';

class View_Details extends StatefulWidget {
  const View_Details({super.key});

  @override
  State<View_Details> createState() => _View_DetailsState();
}

class _View_DetailsState extends State<View_Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kbackground,
      appBar: const VibhoAppBar(
        bColor: Kbackground,
        title: 'View Details',
        dontHaveBackAsLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(13.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/info.png",
                    width: 25.w,
                  ),
                  Text(
                    "Lorem Epson is a dummy text to fill the sentences",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: kFW600,
                      color: Klightblack.withOpacity(0.5),
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Kwhite,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(13.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Regularized BY",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: kFW600,
                                      color: Klightblack.withOpacity(0.8),
                                    )),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text("R. Bharath",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: kFW800,
                                      color: KdarkText,
                                    )),
                              ],
                            ),
                            CustomButton(
                                height: 25.h,
                                width: 100.w,
                                fontSize: kTenFont,
                                fontWeight: kFW700,
                                Color: Kgreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5.r),
                                Padding: EdgeInsets.only(
                                    left: 8.w,
                                    right: 8.w,
                                    top: 3.h,
                                    bottom: 3.h),
                                textColor: Kgreen,
                                label: "Approved",
                                isLoading: false,
                                onTap: () {})
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Days",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: kFW600,
                                  color: Klightblack.withOpacity(0.8),
                                )),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text("03",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: kFW700,
                                  color: KdarkText,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Remarks",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: kFW600,
                                      color: Klightblack.withOpacity(0.8),
                                    )),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text("---",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: kFW700,
                                      color: KdarkText,
                                    )),
                              ],
                            ),
                            Custom_OutlineButton(
                                height: 30.h,
                                width: 110.w,
                                textColor: KOrange,
                                borderRadius: BorderRadius.circular(8.r),
                                Color: KOrange,
                                label: "View Timeline",
                                fontSize: kTenFont,
                                fontWeight: kFW600,
                                isLoading: false,
                                onTap: () {}),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 30.h,
              ),
              ///////Regularization Applied/////
              Text("Regularization Applied",
                  style: TextStyle(
                    fontSize: kFourteenFont,
                    fontWeight: kFW800,
                    color: KdarkText,
                  )),
              //////
              SizedBox(
                height: 15.h,
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Kwhite,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(13.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("24",
                                        style: TextStyle(
                                          fontSize: kSixteenFont,
                                          fontWeight: kFW600,
                                          color: KdarkText,
                                        )),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text("May 2023",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: kFW800,
                                          color: Klightgray,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 15.w,
                                      right: 15.w,
                                      top: 5.h,
                                      bottom: 5.h),
                                  decoration: BoxDecoration(
                                      color: Kbackground,
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: 
                                  RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      text: "25  ",
                                      style: TextStyle(
                                          fontSize: kSixteenFont,
                                          fontWeight: kFW600,
                                          color: KdarkText),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "26",
                                          style: TextStyle(
                                              fontSize: kSixteenFont,
                                              fontWeight: kFW600,
                                              color: KdarkText),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            CustomButton(
                                height: 25.h,
                                width: 100.w,
                                fontSize: kTenFont,
                                fontWeight: kFW700,
                                Color: Kgreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5.r),
                                Padding: EdgeInsets.only(
                                    left: 8.w,
                                    right: 8.w,
                                    top: 3.h,
                                    bottom: 3.h),
                                textColor: Kgreen,
                                label: "Approved",
                                isLoading: false,
                                onTap: () {})
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Regularized BY",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: kFW600,
                                      color: Klightblack.withOpacity(0.8),
                                    )),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text("R. Bharath",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: kFW700,
                                      color: KdarkText,
                                    )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Shifts",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: kFW600,
                                      color: Klightblack.withOpacity(0.8),
                                    )),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text("General Shifts",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: kFW700,
                                      color: KdarkText,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Reason",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: kFW600,
                                  color: Klightblack.withOpacity(0.8),
                                )),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text("I came to office",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: kFW700,
                                  color: KdarkText,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                      color: KdarkText.withOpacity(0.4))),
                              child: Text("15:59",
                                  style: TextStyle(
                                    fontSize: kTwelveFont,
                                    fontWeight: kFW600,
                                    color: KdarkText.withOpacity(0.6),
                                  )),
                            ),
                            Text("_________________",
                                style: TextStyle(
                                  fontSize: kTwelveFont,
                                  fontWeight: kFW600,
                                  color: KOrange.withOpacity(0.4),
                                )),
                            Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                      color: KdarkText.withOpacity(0.4))),
                              child: Text("10:59",
                                  style: TextStyle(
                                    fontSize: kTwelveFont,
                                    fontWeight: kFW600,
                                    color: KdarkText.withOpacity(0.6),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
