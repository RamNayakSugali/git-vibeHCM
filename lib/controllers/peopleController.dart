import 'package:vibeshr/untils/export_file.dart';

class PeopleController extends GetxController {
  @override
  void onInit() {
    peoplesListHandler();
    super.onInit();
  }

  var peoplesdata = {}.obs;
  var originalList = [].obs;

  var isPeopleLoading = false.obs;
  Future peoplesListHandler() async {
    isPeopleLoading(true);
    Map data = await Services.peopleslist();

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
      peoplesdata(data);
      originalList.value = data["rows"];
    }
    isPeopleLoading(false);
  }
}
