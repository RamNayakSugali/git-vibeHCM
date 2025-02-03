// ignore_for_file: camel_case_types, file_names

import '../../../untils/export_file.dart';

class Apply_Regularization extends StatefulWidget {
  const Apply_Regularization({super.key});

  @override
  State<Apply_Regularization> createState() => _Apply_RegularizationState();
}

class _Apply_RegularizationState extends State<Apply_Regularization> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Kbackground,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Kwhite,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                size: 23.w,
                color: KdarkText,
              ),
            ),
            title: Text(
              "Regularization",
              style: TextStyle(
                fontSize: kSixteenFont,
                fontWeight: kFW700,
                color: KdarkText,
                letterSpacing: 0.5,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: TabBar(
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2, color: KOrange),
                ),
                indicatorColor: KOrange,
                labelColor: Kwhite,
                unselectedLabelColor: Kwhite,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 3,
                labelStyle: TextStyle(
                    fontSize: kTwelveFont,
                    color: KdarkText,
                    fontWeight: kFW500),
                unselectedLabelStyle: TextStyle(
                    fontSize: kTwelveFont,
                    color: Klightblack.withOpacity(0.4),
                    fontWeight: kFW500),
                //GoogleFonts.inter(color: Kwhite),
                tabs: [
                  Tab(
                    child: Text(
                      "Apply",
                      style: TextStyle(
                        fontSize: kTwelveFont,
                        fontWeight: kFW600,
                        color: KdarkText,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Pending",
                      style: TextStyle(
                        fontSize: kTwelveFont,
                        fontWeight: kFW600,
                        color: KdarkText,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "History",
                      style: TextStyle(
                        fontSize: kTwelveFont,
                        fontWeight: kFW600,
                        color: KdarkText,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.all(13.r),
            child: const TabBarView(
              children: [Apply_Regular(), Pending_Regular(), History_Regular()],
            ),
          ),
        ));
  }
}
