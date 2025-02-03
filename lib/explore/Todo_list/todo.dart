// ignore_for_file: camel_case_types

import '../../untils/export_file.dart';

class Todo_List extends StatefulWidget {
  const Todo_List({super.key});

  @override
  State<Todo_List> createState() => _Todo_ListState();
}

class _Todo_ListState extends State<Todo_List> {
  List<String> items = [
    "Incomplete tasks",
    "New tasks",
    "Pendding tasks",
    "In Progess",
  ];
  int current = 0;
  final List<String> _task = [
    "ToDo",
    "In Progress",
    "Delayed",
    "Done",
    "Pedding"
  ];

  // the selected value
  String? _selectedStatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Kbackground,
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.toNamed(KCreate_Task);
          },
          child: Container(
            height: 38.h,
            width: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r), color: KOrange),
            child: const Icon(
              Icons.add,
              color: Kwhite,
              size: 25,
            ),
          ),
        ),
        appBar: const VibhoAppBar(
          bColor: Kbackground,
          title: "To-Do",
          dontHaveBackAsLeading: false,
        ),
        body: Container(
          margin: EdgeInsets.all(13.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ////listview
                Container(
                  alignment: Alignment.center,
                  color: Kbackground,
                  height: 60,
                  width: double.infinity,
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
                                margin: EdgeInsets.only(left: 5.w),
                                padding: EdgeInsets.only(
                                    left: 20.w,
                                    right: 20.w,
                                    top: 5.h,
                                    bottom: 5.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13.r),
                                    color: current == index ? KOrange : Kwhite,
                                    border: Border.all(
                                      color: current == index
                                          ? KOrange
                                          : Klightgray.withOpacity(0.5),
                                    )),
                                duration: const Duration(milliseconds: 300),
                                child: Text(
                                  items[index],
                                  style: TextStyle(
                                    fontSize: kTwelveFont,
                                    fontWeight:
                                        current == index ? kFW600 : kFW500,
                                    color:
                                        current == index ? Kwhite : Klightgray,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ////---------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Task name",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: kFW500,
                          color: Klightgray.withOpacity(0.7)),
                    ),
                    Text(
                      "Status",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: kFW500,
                          color: Klightgray.withOpacity(0.7)),
                    ),
                    Text(
                      "Due Date",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: kFW500,
                          color: Klightgray.withOpacity(0.7)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                ////--------------------------------------
                ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Ktask_detail);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100.w,
                                child: Text(
                                  "NodeProject is setup ",
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: kFW700,
                                      color: KdarkText),
                                ),
                              ),
                              /////DropDown button
                              Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 3),
                                width: 130.w,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(30)),
                                child: DropdownButton<String>(
                                  value: _selectedStatus,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedStatus = value;
                                    });
                                  },

                                  underline: Container(),

                                  dropdownColor: Kwhite,
                                  elevation: 0,

                                  isExpanded: true,

                                  // The list of options
                                  items: _task
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                e,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: kFourteenFont,
                                                    color: Ktextcolor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ))
                                      .toList(),

                                  // Customize the selected item
                                  selectedItemBuilder: (BuildContext context) =>
                                      _task
                                          .map((e) => Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5.w,
                                                    top: 5.h,
                                                    bottom: 5.h),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/indata.png",
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(
                                                      e,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 11.sp,
                                                          color:
                                                              Colors.lightBlue,
                                                          fontWeight: kFW500),
                                                    ),
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/time.png",
                                    width: 18.w,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "08 JUl",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Ktextcolor,
                                        fontWeight: kFW500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/info.png",
                      width: 20,
                    ),
                    Text(
                      "Tap and hold at task to assign, Attach or Deleteta",
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: Klightgray,
                          fontWeight: kFW500),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Theme(
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
                            "Do Next Week",
                            style: TextStyle(
                              fontSize: kTwelveFont,
                              fontWeight: kFW900,
                              color: Ktextcolor,
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
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: 8.r, right: 8.r, bottom: 8.r),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 100.w,
                                      child: Text(
                                        "NodeProject is setup ",
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: kFW700,
                                            color: KdarkText),
                                      ),
                                    ),
                                    /////DropDown button
                                    Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 3),
                                      width: 130.w,
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.lightBlue.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: DropdownButton<String>(
                                        value: _selectedStatus,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedStatus = value;
                                          });
                                        },

                                        underline: Container(),

                                        dropdownColor: Kwhite,
                                        elevation: 0,

                                        isExpanded: true,

                                        // The list of options
                                        items: _task
                                            .map((e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      e,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize:
                                                              kFourteenFont,
                                                          color: Ktextcolor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),

                                        // Customize the selected item
                                        selectedItemBuilder:
                                            (BuildContext context) => _task
                                                .map((e) => Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5.w,
                                                          top: 5.h,
                                                          bottom: 5.h),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/indata.png",
                                                          ),
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                          Text(
                                                            e,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                color: Colors
                                                                    .lightBlue,
                                                                fontWeight:
                                                                    kFW500),
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                                .toList(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/time.png",
                                          width: 18.w,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          "08 JUl",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Ktextcolor,
                                              fontWeight: kFW500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Theme(
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
                            "Do This Month",
                            style: TextStyle(
                              fontSize: kTwelveFont,
                              fontWeight: kFW900,
                              color: Ktextcolor,
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
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 6,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: 8.r, right: 8.r, bottom: 8.r),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 100.w,
                                      child: Text(
                                        "NodeProject is setup ",
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: kFW700,
                                            color: KdarkText),
                                      ),
                                    ),
                                    /////DropDown button
                                    Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 3),
                                      width: 130.w,
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.lightBlue.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: DropdownButton<String>(
                                        value: _selectedStatus,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedStatus = value;
                                          });
                                        },

                                        underline: Container(),

                                        dropdownColor: Kwhite,
                                        elevation: 0,

                                        isExpanded: true,

                                        // The list of options
                                        items: _task
                                            .map((e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      e,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize:
                                                              kFourteenFont,
                                                          color: Ktextcolor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),

                                        // Customize the selected item
                                        selectedItemBuilder:
                                            (BuildContext context) => _task
                                                .map((e) => Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5.w,
                                                          top: 5.h,
                                                          bottom: 5.h),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/indata.png",
                                                          ),
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                          Text(
                                                            e,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                color: Colors
                                                                    .lightBlue,
                                                                fontWeight:
                                                                    kFW500),
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                                .toList(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/time.png",
                                          width: 18.w,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          "08 JUl",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Ktextcolor,
                                              fontWeight: kFW500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    )),
                SizedBox(
                  height: 50.h,
                )
              ],
            ),
          ),
        ));
  }
}
