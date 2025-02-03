// ignore_for_file: camel_case_types

import 'package:vibeshr/controllers/claimsController.dart';
import 'package:vibeshr/untils/export_file.dart';

class All_Apporoval extends StatefulWidget {
  const All_Apporoval({super.key});

  @override
  State<All_Apporoval> createState() => _All_ApporovalState();
}

class _All_ApporovalState extends State<All_Apporoval> {
  ClaimController claimController = Get.put(ClaimController());
  @override
  void initState() {
    getApprovalConfirmationAPI();
    peoplesListHandler();
    claimsListHandler();
    leavesListHandler();
    super.initState();
  }

  ////
  var approvalConfirm = {};

  getApprovalConfirmationAPI() async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.hrRequestApprovalConfigs();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      approvalConfirm = data;
    }
    setState(() {
      isLoading = false;
    });
  }
  //////

  bool isLoading = false;

  Map permissions = Get.arguments;

  Future peoplesListHandler() async {
    setState(() {
      isLoading = true;
    });
    Map data = await Services.peopleslist();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      claimController.peoplesdata.value = data;
      claimController.originalList.value = data["rows"];
    }
    setState(() {
      isLoading = false;
    });
  }

  bool isClaimsLoading = false;
  Future claimsListHandler() async {
    setState(() {
      isClaimsLoading = true;
    });
    Map data = await Services.hrEmployeesClaims();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      claimController.claimsList.value = data;
    }
    setState(() {
      isClaimsLoading = false;
    });
  }

  bool isLeavesLoading = false;
  Future leavesListHandler() async {
    setState(() {
      isLeavesLoading = true;
    });
    Map data = await Services.hrEmployeesLeaves();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      await loaddata(data);
    }
    setState(() {
      isLeavesLoading = false;
    });
  }

  loaddata(data) {
    claimController.leaveslList.value = data;
  }

  Future<void> _refreshQuickApplrovals() async {
    setState(() {
      claimController.onInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Kbackground,
        // backgroundColor:
        //     selectedTheme == "Lighttheme" ? Kbackground : Kthemeblack,
        appBar: AppBar(
          backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
          //  backgroundColor: Kwhite,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: KOrange,
            unselectedLabelStyle: TextStyle(
              fontSize: kFourteenFont,
              fontWeight: kFW500,
              color: kblack,
              letterSpacing: 0.5,
            ),
            unselectedLabelColor:
                selectedTheme == "Lighttheme" ? KdarkText : null,
            // KdarkText,
            labelColor: KOrange,
            labelStyle: TextStyle(
              fontSize: kFourteenFont,
              fontWeight: kFW500,
              color: KOrange,
              letterSpacing: 0.5,
            ),

            tabs: [
              if (permissions["leaves"]["read"] == true) ...[
                const Tab(
                  text: "Leaves",
                )
              ],
              if (permissions["calims"]["read"] == true) ...[
                const Tab(text: "Claims")
              ],
            ],
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_rounded,
                  size: 23.w,
                  color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite)),
          title: Text(
            'Quick Approvals',
            style: TextStyle(
              fontSize: kSixteenFont,
              fontWeight: kFW800,
              color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
              letterSpacing: 0.5,
            ),
          ),
        ),
        body: isLeavesLoading == false &&
                isClaimsLoading == false &&
                isLoading == false
            ? TabBarView(
                children: [
                  if (permissions["leaves"]["read"] == true) ...[
                    Approval_data(
                      approvalConfirmdata: approvalConfirm,
                    )
                  ],
                  if (permissions["calims"]["read"] == true) ...[
                    Claim_Approval_data()
                  ],
                ],
              )
            : const SpinKitFadingCircle(
                color: KOrange,
                size: 50,
              ),
      ),
    );
  }
}
