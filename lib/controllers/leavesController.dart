import 'package:vibeshr/untils/export_file.dart';

class LeavesController extends GetxController {
  @override
  void onInit() {
    leavesBalance();
    getLeavesListTypes();
    getLeavesListFromApi();
    leavesListHandler();
    peoplesListHandler();
    cnt = SingleValueDropDownController();
    cntMulti = MultiValueDropDownController();
    super.onInit();
  }

  var leavetypesloading = false.obs;
  var appliedLeaves = [].obs;
  late SingleValueDropDownController cnt;
  late MultiValueDropDownController cntMulti;
  var str = "Select Type".obs;
  List myLeavesTypes = [];
  List<String> options = [];
  getLeavesListTypes() async {
    options.clear();
    // options.add("Select Type");
    leavetypesloading(true);
    Map data = await Services.getLeavesListTypes();
    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      myLeavesTypes = data["rows"];
      for (int i = 0; i < myLeavesTypes.length; i++) {
        if (myLeavesTypes[i]["is_active"] == 1) {
          options.add(myLeavesTypes[i]["leave_type_name"]);
        }
        if (myLeavesTypes[i]["leave_type_name"] == "Sick Leave") {
          UserSimplePreferences.setSickLeaveID(
              sickId: myLeavesTypes[i]["leave_type_id"].toString());
        }
      }
    }
    leavetypesloading(false);
  }

  var leavesLoading = false.obs;
  getLeavesListFromApi() async {
    leavesLoading.value = true;
    Map data = await Services.leavelist();
    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      appliedLeaves.value = data["rows"];
      getAppliedLeaves();
    }
    leavesLoading.value = false;
  }

  var getAppliedLeavesLoading = false.obs;
  List<DateTime> appledLeavesDates = [];
  getAppliedLeaves() {
    getAppliedLeavesLoading.value = true;
    appledLeavesDates.clear();
    for (int i = 0; i < appliedLeaves.length; i++) {
      if (appliedLeaves[i]["from_date"] != "0000-00-00" &&
          appliedLeaves[i]["to_date"] != "0000-00-00") {
        if (appliedLeaves[i]["leave_status"] == 1 &&
            !(appliedLeaves[i]["leave_type"]
                    .toString()
                    .toLowerCase()
                    .contains("home") ||
                appliedLeaves[i]["leave_type"]
                    .toString()
                    .toLowerCase()
                    .contains("Wfh"))) {
          List<DateTime> betweenDates = getLeavesInBetween(
              DateTime.parse(appliedLeaves[i]["from_date"]),
              DateTime.parse(appliedLeaves[i]["to_date"]));
          for (int j = 0; j < betweenDates.length; j++) {
            appledLeavesDates.add(betweenDates[j]);
          }
        }
      }
    }
    getAppliedLeavesLoading.value = false;
  }

  getLeavesInBetween(DateTime startDate, DateTime endDate) {
    final daysToGenerate = endDate.difference(startDate).inDays + 1;
    return List.generate(
        daysToGenerate, (i) => startDate.add(Duration(days: i)));
  }

  var leavesdata = [].obs;
  var profile = {}.obs;

  var isLoading = false.obs;
  var peoplesdata = {}.obs;
  var originalList = [].obs;
  var peopleLoading = false.obs;
  Future peoplesListHandler() async {
    peopleLoading.value = true;
    Map data = await Services.peopleslist();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      peoplesdata.value = data;
      originalList.value = data["rows"];
    }
    peopleLoading.value = false;
  }

  var pendingLeavesCount = 0.obs;

  var myleavesLoading = false.obs;
  Future leavesListHandler() async {
    pendingLeavesCount.value = 0;
    myleavesLoading.value = true;
    Map data = await Services.leavelist();
    profile.value = await Services.employeeprofile();
    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      leavesdata.value = data["rows"];
      for (int i = 0; i < leavesdata.length; i++) {
        if (leavesdata[i]["leave_status"] == 0) {
          pendingLeavesCount.value = pendingLeavesCount.value + 1;
        }
      }
    }
    myleavesLoading.value = false;
  }
  ////////////////////////////////////////////////

  // Map requestdata = {};
  // var requestCount = 0.obs;

  // var leaverequest = false.obs;
  // Future requestListHandler() async {
  //   requestCount.value = 0;
  //   leaverequest.value = true;
  //   try {
  //     Map data = await Services.employeehome();

  //     if (data["message"] != null) {
  //       Fluttertoast.showToast(
  //         msg: data["message"],
  //       );
  //     } else {
  //       requestdata = data["requests"];
  //       for (int i = 0; i < requestdata["rows"].length; i++) {
  //         if (requestdata["rows"][i]["leave_status"] == 0) {
  //           requestCount.value = requestCount.value + 1;
  //         }
  //       }
  //     }
  //     leaverequest.value = false;
  //   } catch (e) {
  //     //
  //   }
  // }
  /////////////////////////////////////////

  var myleaveBalanceloading = false.obs;
  var myLeaveBalance = {}.obs;
  Future leavesBalance() async {
    myleaveBalanceloading.value = true;
    Map data = await Services.getLeaveBalance();
    myLeaveBalance.value = data;
    myleaveBalanceloading.value = false;
  }

  var isLeaveCanleLoading = false.obs;
  cancleLeave(int leaveID) async {
    isLeaveCanleLoading.value = true;
    Map data = await Services.cancleLeave(leaveID);
    if (data["leave_status"] == 3) {
      for (int i = 0; i < leavesdata.length; i++) {
        if (leavesdata[i]["employee_leaves_lid"] ==
            data["employee_leaves_lid"]) {
          leavesdata[i] = data;
        }
      }
    }
    isLeaveCanleLoading.value = false;
  }
}
