// ignore_for_file: camel_case_types

import '../../../untils/export_file.dart';

class Pending_Regular extends StatefulWidget {
  const Pending_Regular({super.key});

  @override
  State<Pending_Regular> createState() => _Pending_RegularState();
}

class _Pending_RegularState extends State<Pending_Regular> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                      CustomButton(
                          height: 25.h,
                          width: 100.w,
                          fontSize: kTenFont,
                          fontWeight: kFW700,
                          Color: Kgreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5.r),
                          Padding: EdgeInsets.only(
                              left: 8.w, right: 8.w, top: 3.h, bottom: 3.h),
                          textColor: Kgreen,
                          label: "Pending",
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
                      Text("Applied Date(s)",
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: kFW600,
                            color: Klightblack.withOpacity(0.8),
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text("24-26 May 2023",
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
                          Text("Regularized No",
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: kFW600,
                                color: Klightblack.withOpacity(0.8),
                              )),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text("22 May 2023",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: kFW700,
                                color: KdarkText,
                              )),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text("03 Days",
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: kFW600,
                                color: KOrange,
                              )),
                        ],
                      ),
                      Custom_OutlineButton(
                          height: 30.h,
                          width: 110.w,
                          textColor: KOrange,
                          borderRadius: BorderRadius.circular(8.r),
                          Color: KOrange,
                          label: "View more",
                          fontSize: kTenFont,
                          fontWeight: kFW600,
                          isLoading: false,
                          onTap: () {}),
                    ],
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
