import 'package:vibeshr/untils/export_file.dart';

class PayslipController extends GetxController {
  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  var payslipSortedData = [].obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  var profile = {};
  var isLoading = false.obs;
  Future getProfile() async {
    isLoading.value = true;
    profile = await Services.employeeprofile();
    selectedDate.value = DateTime.now().subtract(const Duration(days: 30));
    payslipListSAHandler(selectedDate.value);
  }

  var payslipdatasa = {}.obs;
  var ctcdatasa = {}.obs;
  var isPayslipsloading=false.obs;
  Future payslipListSAHandler(DateTime selectedDate) async {
    isPayslipsloading(true);
    payslipdatasa.value = {};
    ctcdatasa.value = {};

    Map data = await Services.payslipviewsa();

    if (data["rows"] == null) {
      payslipdatasa.value = data;
    } else {
      payslipdatasa.value = data;
      payslipData.value = data["rows"];
    }
    getData();
    isLoading.value = false;
    isPayslipsloading(false);
  }

  List dsortdates(apiData) {
    apiData.sort((element, element1) {
      debugPrint(element["year"].toString());
      debugPrint(element["month"].toString());
      // ignore: prefer_interpolation_to_compose_strings
      DateTime a = DateTime.parse("${element["year"].toString()}-${element["month"]>=10?element["month"].toString():"0"+element["month"].toString()}-01");
      DateTime b =
          DateTime.parse("${element1["year"].toString()}-${element1["month"]>=10?element1["month"].toString():"0"+element1["month"].toString()}-01");
      return a.compareTo(b);
    });
    return apiData;
  }

  getData() {
    payslipData.value = payslipdatasa["rows"];
  }

  var payslipData = [].obs;
  void selectedMonth(DateTime selectedDate) async {
    for (int i = 0; i < payslipdatasa["rows"].length; i++) {
      if (payslipdatasa["rows"][i]["month"] == selectedDate.month &&
          payslipdatasa["rows"][i]["year"] == selectedDate.year) {
        payslipData.add(payslipdatasa["rows"][i]);
      }
      debugPrint("length is ${payslipData.length}");
    }
  }

  var payslipdata = {}.obs;
  var ctcdata = {}.obs;

  Future payslipListHandler(DateTime selectedDate) async {
    payslipdata.value = {};
    ctcdata.value = {};
    isLoading.value = true;
    Map data = await Services.payslipview(selectedDate);

    if (data["message"] != null) {
    } else {
      payslipdata.value = data["paslip"];
      ctcdata.value = data["ctc"] ?? {};
    }
    isLoading.value = false;
  }
}
