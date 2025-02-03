// ignore_for_file: unused_local_variable

import '../../untils/export_file.dart';

class Swipes extends StatefulWidget {
  const Swipes({super.key});

  @override
  State<Swipes> createState() => _SwipesState();
}

class _SwipesState extends State<Swipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kbackground,
      appBar: const VibhoAppBar(
        bColor: Kbackground,
        title: 'Swipes',
        dontHaveBackAsLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(13.r),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r), color: Kwhite),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 110.w,
                      height: 30.h,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Kbackground),
                      child: Text(
                        "Start data",
                        style: TextStyle(
                          fontSize: kTenFont,
                          fontWeight: kFW600,
                          color: Klightblack,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: 110.w,
                      height: 30.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Kbackground),
                      child: Text(
                        "End data",
                        style: TextStyle(
                          fontSize: kTenFont,
                          fontWeight: kFW600,
                          color: Klightblack,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //get today's date
                            firstDate: DateTime(
                                1998), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));
                      },
                      child: Image.asset(
                        "assets/images/Group.png",
                        width: 22.w,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 7.h, bottom: 7.h),
                      // height: 50,
                      width: double.infinity,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Kwhite,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("19:34:23",
                                    style: TextStyle(
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW800,
                                      color: Klightgray,
                                    )),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text("Out",
                                    style: TextStyle(
                                      fontSize: kTwelveFont,
                                      fontWeight: kFW800,
                                      color: KRed,
                                    )),
                              ],
                            ),
                          ),
                          Text(
                            "Biometrics",
                            style: TextStyle(
                              fontSize: kFourteenFont,
                              fontWeight: kFW800,
                              color: KdarkText,
                            ),
                          ),
                          Image.asset(
                            "assets/images/thumb.png",
                            width: 50.w,
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
