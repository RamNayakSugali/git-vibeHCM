// ignore_for_file: camel_case_types, non_constant_identifier_names

import '../untils/export_file.dart';

class Explore_screen extends StatefulWidget {
  const Explore_screen({super.key});

  @override
  State<Explore_screen> createState() => _Explore_screenState();
}

class _Explore_screenState extends State<Explore_screen> {
  List Explore = [
    {
      "name": "Attendance",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/data.png",
      "Subimage": "assets/images/arrow.png",
      "color": KPurple,
      "route": KAttendance
    },
    {
      "name": "Leave",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/data.png",
      "Subimage": "assets/images/arrow.png",
      "color": KOrange,
      "route": Kapply_leaves
    },
    {
      "name": "Reimbursement",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/data.png",
      "Subimage": "assets/images/arrow.png",
      "color": Kgreen,
      "route": KReimbursement
    },
    {
      "name": "Performance",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/data.png",
      "Subimage": "assets/images/arrow.png",
      "color": KDarkskyblue,
      "route": KAttendance
    },
    {
      "name": "Feedback",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/data.png",
      "Subimage": "assets/images/arrow.png",
      "color": KDarkblue,
      // "route": KAttendance
    },
    {
      "name": "Calendar",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/data.png",
      "Subimage": "assets/images/arrow.png",
      "color": Kpink,
      "route": KAttendance
    },
    {
      "name": "people",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/data.png",
      "Subimage": "assets/images/arrow.png",
      "color": KPurple,
      "route": KPeople
    },
    {
      "name": "To Do",
      "Subname": "Lorem Ipsum",
      "image": "assets/images/data.png",
      "Subimage": "assets/images/arrow.png",
      "color": Kgreen,
      "route": KTodo_list
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: VibhoAppBar(
          bColor: Kwhite,
          title: 'Explore',
          dontHaveBackAsLeading: true,
          trailing: GestureDetector(
            onTap: () {
              Get.toNamed(KNotification);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 15.w, top: 5.h),
              child: Image.asset(
                UserSimplePreferences.getNotifications() == "0"
                    ? "assets/images/notification_inactive.png"
                    : "assets/images/bell.png",
                // "assets/images/bell.png",
                width: 25,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Wrap(
              children: [
                for (int i = 0; i < Explore.length; i++)
                  GestureDetector(
                    onTap: () {
                      if (Explore[i]["name"] == "Feedback") {
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.r),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return const Feedback_view();
                            });
                      } else {
                        Get.toNamed(Explore[i]["route"]);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.r),
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, top: 15.h, bottom: 5.h),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Ktextcolor.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 0),
                              spreadRadius: 2, //New
                            )
                          ],
                          borderRadius: BorderRadius.circular(12.r),
                          color: Kwhite),
                      child: Column(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            Explore[i]["image"],
                            height: 22.h,
                            color: Explore[i]["color"],
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: 105.w,
                            child: Text(
                              Explore[i]["name"],
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: kFW600,
                                  color: KdarkText),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            width: 105.w,
                            child: Text(
                              Explore[i]["Subname"],
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: kTenFont,
                                  fontWeight: kFW400,
                                  color: Klightgray.withOpacity(0.7)),
                            ),
                          ),
                          Image.asset(
                            Explore[i]["Subimage"],
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ));
  }
}
