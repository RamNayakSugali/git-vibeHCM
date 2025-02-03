import '../../untils/export_file.dart';

class Task_Deatil extends StatefulWidget {
  const Task_Deatil({super.key});

  @override
  State<Task_Deatil> createState() => _Task_DeatilState();
}

class _Task_DeatilState extends State<Task_Deatil> {
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
      appBar: const VibhoAppBar(bColor: Kbackground, title: "Task Detail"),
      body: Container(
        margin: EdgeInsets.all(13.r),
        child: Column(
          children: [
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
              width: double.infinity,
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
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ))
                    .toList(),

                // Customize the selected item
                selectedItemBuilder: (BuildContext context) => _task
                    .map((e) => Padding(
                          padding:
                              EdgeInsets.only(left: 5.w, top: 5.h, bottom: 5.h),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/indata.png",
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                e,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.lightBlue,
                                    fontWeight: kFW500),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
                // margin: EdgeInsets.all(13.r),
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
                            "Project Name",
                            maxLines: 1,
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
                            "Vibho HCM",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: kFW700,
                                color: KdarkText),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "State Date",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: kTenFont,
                                        fontWeight: kFW600,
                                        color: Klightblack),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "08-07-2023",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: kFW700,
                                        color: KdarkText),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "End Date",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: kTenFont,
                                        fontWeight: kFW600,
                                        color: Klightblack),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "10-07-2023",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: kFW700,
                                        color: KdarkText),
                                  ),
                                ],
                              ),
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
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.all(10.r),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Kwhite,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description",
                      style: TextStyle(
                        fontSize: kTwelveFont,
                        fontWeight: kFW500,
                      )),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                      "Node Project is setup using information from the MySQL and mangoose database.",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: kFW700,
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text("Attachment (3)",
                      style: TextStyle(
                        fontSize: kTwelveFont,
                        fontWeight: kFW500,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
