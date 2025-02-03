// ignore_for_file: camel_case_types, unused_local_variable

import '../../untils/export_file.dart';

class YTP_resports extends StatefulWidget {
  const YTP_resports({super.key});

  @override
  State<YTP_resports> createState() => _YTP_resportsState();
}

class _YTP_resportsState extends State<YTP_resports> {
  List<String> items = [
    "April",
    "May 2023",
    "June",
    "July",
    "Augest",
  ];
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomButton(
          margin: EdgeInsets.all(10.r),
          borderRadius: BorderRadius.circular(20.r),
          Color: KOrange,
          height: 40.h,
          label: "Download PF YTD Statement ",
          textColor: Kwhite,
          fontWeight: kFW900,
          fontSize: 13.sp,
          isLoading: false,
          onTap: () {}),
      backgroundColor: Kbackground,
      appBar: const VibhoAppBar(
        bColor: Kbackground,
        title: 'YTD Reports',
        dontHaveBackAsLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(13.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ////NetPay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Kwhite,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(13.r),
                      alignment: Alignment.center,
                      height: 40,
                      width: 260.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.r),
                        color: Kbackground,
                      ),
                      child: ListView.builder(
                          itemCount: items.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      current = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    margin: EdgeInsets.only(left: 10.w),
                                    padding: EdgeInsets.only(
                                        left: 10.w,
                                        right: 12.w,
                                        top: 5.h,
                                        bottom: 5.h),
                                    duration: const Duration(milliseconds: 300),
                                    child: Text(
                                      items[index],
                                      style: TextStyle(
                                        fontSize: current == index
                                            ? kFourteenFont
                                            : kTwelveFont,
                                        fontWeight:
                                            current == index ? kFW900 : kFW500,
                                        color: current == index
                                            ? KOrange
                                            : Klightgray,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    ////date picker
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime(
                              1998), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101),
                        );
                      },
                      child: Image.asset(
                        "assets/images/Group.png",
                        width: 23.w,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),

              ///Earing
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(13.r)),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.r)),
                  color: Kgreen.withOpacity(0.15),
                  child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: kTwelveFont,
                                fontWeight: kFW600,
                                color: Klightblack,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "₹ 30,000.00",
                              style: TextStyle(
                                fontSize: kFourteenFont,
                                fontWeight: kFW900,
                                color: KdarkText,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          const Divider(),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            margin: EdgeInsets.all(8.r),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "BASIC",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    Text(
                                      "₹21,150.00",
                                      style: TextStyle(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "HRA",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    Text(
                                      "₹8,460.00",
                                      style: TextStyle(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "CREDITS",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    Text(
                                      "₹3,525.00",
                                      style: TextStyle(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "SPECIAL ALLOWANCE",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    Text(
                                      "₹10,890.00",
                                      style: TextStyle(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              /////////////Deductions
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(13.r)),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.r)),
                  color: KRed.withOpacity(0.15),
                  child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "Your PF Statement",
                              style: TextStyle(
                                fontSize: kTwelveFont,
                                fontWeight: kFW600,
                                color: Klightblack,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "₹ 30,000.00",
                              style: TextStyle(
                                fontSize: kFourteenFont,
                                fontWeight: kFW900,
                                color: KdarkText,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          const Divider(),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            margin: EdgeInsets.all(8.r),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "PF",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    Text(
                                      "₹1,800.00",
                                      style: TextStyle(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "PROF TAX",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    Text(
                                      "₹200.00",
                                      style: TextStyle(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "OTHER LOAN",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    Text(
                                      "₹10,000.00",
                                      style: TextStyle(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW600,
                                        color: Klightgray,
                                        letterSpacing: 0.5,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),

              SizedBox(
                height: 25.h,
              ),
              ///////////Employee Deatails
              Text(
                "Employee Details",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: kFourteenFont,
                    fontWeight: kFW600,
                    color: KdarkText),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                  padding: EdgeInsets.all(10.r),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r), color: Kwhite),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: kFW600,
                                    color: Klightblack),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "Chitikela Appalanaidu",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: kTwelveFont,
                                    fontWeight: kFW700,
                                    color: KdarkText),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Employee No",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: kFW600,
                                    color: Klightblack),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "VT052",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: kTwelveFont,
                                    fontWeight: kFW700,
                                    color: KdarkText),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Joining Date",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: kFW600,
                                color: Klightblack),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "01 Aug 2022",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: kTwelveFont,
                                fontWeight: kFW700,
                                color: KdarkText),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "PF No",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: kFW600,
                                color: Klightblack),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "GR/GNT/1806702/000/00120121",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: kTwelveFont,
                                fontWeight: kFW700,
                                color: KdarkText),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Bank Name",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: kFW600,
                                color: Klightblack),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "ICICI Bank",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: kTwelveFont,
                                fontWeight: kFW700,
                                color: KdarkText),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Bank A/C No",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: kFW600,
                                color: Klightblack),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "05881201544755",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: kTwelveFont,
                                fontWeight: kFW700,
                                color: KdarkText),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
