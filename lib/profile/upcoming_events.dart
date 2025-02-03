import '../untils/export_file.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
            top: 10.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Upcoming Events",
                style: TextStyle(
                    fontSize: kFourteenFont,
                    fontWeight: kFW600,
                    color: KdarkText),
              ),
              Row(
                children: [
                  Text(
                    "View all",
                    style: TextStyle(
                        fontSize: kTwelveFont,
                        fontWeight: kFW600,
                        color: KOrange),
                  ),
                  Icon(
                    Icons.arrow_outward,
                    size: 18.w,
                    color: KOrange,
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          height: 75.h,
          color: Kwhite,
          padding: const EdgeInsets.all(4),
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 6.h),
          child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(3.r),
                  padding: EdgeInsets.only(
                      left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
                  decoration: BoxDecoration(
                    color: Kwhite,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Ktextcolor.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                        spreadRadius: 1, //New
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "AR VR Design Webinar",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: kFourteenFont,
                                fontWeight: kFW600,
                                color: KdarkText),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomButton(
                              fontSize: 11.sp,
                              fontWeight: kFW700,
                              Color: Kgreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5.r),
                              Padding: EdgeInsets.only(
                                  left: 8.w, right: 8.w, top: 3.h, bottom: 3.h),
                              textColor: Kgreen,
                              label: "Register",
                              isLoading: false,
                              onTap: () {})
                        ],
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: "9 July’ 2023",
                          style: TextStyle(
                              fontSize: kFourteenFont,
                              fontWeight: kFW400,
                              color: Klightgray),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' - ',
                              style: TextStyle(
                                  fontSize: kFourteenFont,
                                  fontWeight: kFW700,
                                  color: KdarkText),
                            ),
                            TextSpan(
                              text: '10:30 Am',
                              style: TextStyle(
                                  fontSize: kFourteenFont,
                                  fontWeight: kFW700,
                                  color: Klightgray),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
