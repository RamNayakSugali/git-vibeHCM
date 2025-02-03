import 'package:vibeshr/untils/export_file.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    profileListApi();
    super.onInit();
  }

  Map profiledata = {};
  Map roledata = {};
  var isProfileLoading = false.obs;
  Future profileListApi() async {
    isProfileLoading(true);
    Map data = await Services.employeeprofile();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      
      profiledata = data["Employee"]??{};
      roledata = data;
    }
    isProfileLoading(false);
  }
}
