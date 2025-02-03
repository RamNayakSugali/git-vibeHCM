// ignore_for_file: camel_case_types, file_names

import '../../untils/export_file.dart';

class Holiday_view extends StatefulWidget {
  const Holiday_view({super.key});

  @override
  State<Holiday_view> createState() => _Holiday_viewState();
}

class _Holiday_viewState extends State<Holiday_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kbackground,
      appBar: const VibhoAppBar(
        bColor: Kbackground,
        title: 'Calendar',
        dontHaveBackAsLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(13.r),
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      color: Kwhite,
                      child: ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250.w,
                              height: 30.h,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Kbackground),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Jun 2023",
                                    style: TextStyle(
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW600,
                                      color: Klightblack,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  Text(
                                    "May 2024",
                                    style: TextStyle(
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW600,
                                      color: Klightblack,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Kwhite),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Meeting with Kaysim",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW600,
                                        color: KdarkText,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    Text(
                                      "10:30 Am",
                                      style: TextStyle(
                                        fontSize: kTwelveFont,
                                        fontWeight: kFW600,
                                        color: KdarkText,
                                        letterSpacing: 0.5,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "Monday",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: kTenFont,
                                    fontWeight: kFW600,
                                    color: Klightblack,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "19 Jun",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: kFW900,
                                        color: KdarkText,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.more_horiz,
                                      size: 30,
                                      color: KOrange,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Kwhite),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "No Holiday",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: kTwelveFont,
                                    fontWeight: kFW600,
                                    color: KdarkText,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "Thusday",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: kTenFont,
                                    fontWeight: kFW600,
                                    color: Klightblack,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  "20 Jun",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: kFW900,
                                    color: KdarkText,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: Kwhite),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    "assets/images/mu1.png",
                                    fit: BoxFit.fill,
                                  ))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Kwhite),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "No Holiday",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: kTwelveFont,
                                    fontWeight: kFW600,
                                    color: KdarkText,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "Friday",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: kTenFont,
                                    fontWeight: kFW600,
                                    color: Klightblack,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  "30 Jun",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: kFW900,
                                    color: KdarkText,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  })
              //CustomDrop(onChanged: () {}, options: ["jan", "dec", "Fed"])
              // SizedBox(
              //     height: 42.h,
              //     width: double.infinity,
              //     child: CustomDropdownButton2(
              //       icon: const Icon(
              //         Icons.expand_more,
              //         color: KOrange,
              //         size: 25,
              //       ),
              //       hint: "Select State",
              //       dropdownItems: items,
              //       dropdownWidth: 340.w,
              //       value: selectedValue,
              //       onChanged: (value) {
              //         setState(() {
              //           selectedValue = value;
              //         });
              //         // onStateSelection(value);
              //       },
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
