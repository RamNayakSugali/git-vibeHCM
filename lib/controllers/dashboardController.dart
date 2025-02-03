import 'package:vibeshr/controllers/profileController.dart';
import 'package:vibeshr/untils/export_file.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    callAPIs();
    super.onInit();
  }

  callAPIs() async {
    homepageApi();
    hrConfigs();
    getFeedback();
    profileListApi();
    notifiysHandler();
    checlforUpdate();
    requestListHandler();
    profileController.profileListApi();
    holydaysListHandler();
    permissionHandler();
  
    
  
  }

  var birthdayDatafilter = [].obs;
  var upCommingbirthdayDataList = [].obs;
  var upCommingAnniversaryList = [].obs;

  checlforUpdate() {}
  ProfileController profileController = Get.put(ProfileController());
  var homedata = {}.obs;
  var isHomeAPILoading = false.obs;
  Future homepageApi() async {
    isHomeAPILoading(true);
    Map data = await Services.employeehome();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
      if (data["message"] == "Unauthorized") {
        UserSimplePreferences.clearAllData();
        Get.toNamed(Kwebaddress_login);
      }
    } else {
      homedata(data);
    }
    isHomeAPILoading(false);
  }

  var isProfileLoading = false.obs;
  var isHRDataLoading = false.obs;
  var profiledata = {}.obs;
  var hrconfigs = {}.obs;
  hrConfigs() async {
    isHRDataLoading(true);
    Map data = await Services.hrRequestApprovalConfigs();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      hrconfigs(data);
    }
    isHRDataLoading(false);
  }

  var feedbackData = {}.obs;
  getFeedback() async {
    Map data = await Services.getFeedback();
    feedbackData(data);
  }

  var testRole = {}.obs;
  var role = {}.obs;
  var roleID = "".obs;
  Future profileListApi() async {
    isProfileLoading(true);
    Map data = await Services.employeeprofile();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      profiledata(data["Employee"]);
      try {
        role(data["Role"] ?? {});
        if (data["Role"] != null) {
          if (data["Role"]["is_selfie_enabled"] != null &&
              data["Role"]["is_selfie_enabled"] == true) {
            if (!UserSimplePreferences.getUserdata()
                .toString()
                .contains(data["Employee"]["emp_code"])) {
              UserSimplePreferences().setSelfeeEnableSTatuc(true);
            }
          }
        }
      } catch (e) {
        debugPrint("No role Parameter ");
      }
      try {
        roleID.value = data["role_id"];
      } catch (e) {
        debugPrint("RoleId is Missing");
      }

      UserSimplePreferences.setUserdata(userData: data.toString());
    }
    isProfileLoading(false);
  }

  var notifiydatas = {}.obs;
  // bool isLoading = false;
  var isLoading = false.obs;
  Future notifiysHandler() async {
    isLoading(true);
    Map data = await Services.notification();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      notifiydatas(data);
      await UserSimplePreferences.setNotifications(
          notificationCount: notifiydatas["rows"].length.toString());
      // notifiydatas["rows"].length
      //    await UserSimplePreferences.setToken(token: value["Token"]);
    }
    isLoading(false);
  }

  Map requestdata = {};
  var requestCount = 0.obs;

  var leaverequest = false.obs;
  Future requestListHandler() async {
    requestCount.value = 0;
    leaverequest.value = true;
    try {
      Map data = await Services.employeehome();

      if (data["message"] != null) {
        Fluttertoast.showToast(
          msg: data["message"],
        );
      } else {
        requestdata = data["requests"];
        for (int i = 0; i < requestdata["rows"].length; i++) {
          if (requestdata["rows"][i]["leave_status"] == 0) {
            requestCount.value = requestCount.value + 1;
          }
        }
      }
      leaverequest.value = false;
    } catch (e) {
      //
    }
  }

  var holydaysdata = {}.obs;
  var upcommingHolydaysdata = {}.obs;

  var isHolydaysLoading = false.obs;
  Future holydaysListHandler() async {
    isHolydaysLoading(true);
    Map data = await Services.employeehome();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      holydaysdata.value = data["holidays"];
      upcommingHolydaysdata.value = data["holidays"];
      getUpCommingHolyDays(upcommingHolydaysdata);
    }
    isHolydaysLoading(false);
  }

  var permissiondata = {}.obs;
    var ispermissionLoading = false.obs;
  Future permissionHandler() async {
    ispermissionLoading(true);
    Map data = await Services.getPermissions();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      permissiondata.value = data;
    }
    ispermissionLoading(false);
  }

  var holydays = [].obs;
  getUpCommingHolyDays(upcommingHolydaysdataList) {
    holydays.value = upcommingHolydaysdataList["rows"]
        .where((element) =>
            DateTime.parse(element["date"]).month >= DateTime.now().month &&
            DateTime.parse(element["date"]).day >= DateTime.now().day)
        .toList();
    for (int j = 0; j < holydays.length; j++) {
      holydays.sort((a, b) {
        return DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"]));
      });
    }
    debugPrint("Upcoming Holydays COunt = ${holydays.length}");
  }
}
