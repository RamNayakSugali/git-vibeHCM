import 'package:vibeshr/untils/export_file.dart';

class AttendanceController extends GetxController {
  @override
  void onInit() {
    selectedDate.value = DateTime.now();
    getCalenderInfo(DateTime.now());
    super.onInit();
  }

  Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final DateRangePickerController controller = DateRangePickerController();
  var attendanceInfoData = {}.obs;
  var isAttendanceLoading = false.obs;
  getCalenderInfo(DateTime date) async {
    isAttendanceLoading.value = true;
    controller.view = DateRangePickerView.month;

    Map value = await Services.attendanceinfo(date);
    if (value["message"] != null) {
      Fluttertoast.showToast(msg: value["message"]);
    } else {
      attendanceInfoData.value = value;
      getDatesList(attendanceInfoData);
    }
    isAttendanceLoading.value = false;
  }

  var wfhdates = <DateTime>[].obs;
  var absentdates = <DateTime>[].obs;
  var listofAllDates = <DateRangePickerCellDetails>[].obs;
  var presentdates = <DateTime>[].obs;
  var holydaysdates = <DateTime>[].obs;
  var leaveDates = <DateTime>[].obs;
  var restDaysdates = <DateTime>[].obs;
  var allDaysdates = <DateTime>[].obs;
  getDatesList(Map getDatesList) {
    wfhdates.clear();
    absentdates.clear();
    presentdates.clear();
    holydaysdates.clear();
    leaveDates.clear();
    restDaysdates.clear();
    allDaysdates.clear();
    for (int i = 0; i < getDatesList["rows"].length; i++) {
      allDaysdates.add(DateTime.parse(
          getCorrectDateFormat(getDatesList["rows"][i]["date"])));
      // listofAllDates.add(DateRangePickerCellDetails(bounds: ,date: DateTime.parse(
      //         getCorrectDateFormat(getDatesList["rows"][i]["date"]))));
      if (getDatesList["rows"][i]["status"] == "O" ||
          getDatesList["rows"][i]["status"] == "o") {
        if (DateTime.parse(
                    getCorrectDateFormat(getDatesList["rows"][i]["date"]))
                .isBefore(DateTime.now())

            // DateTime.parse(
            //           getCorrectDateFormat(getDatesList["rows"][i]["date"]))
            //       .day <
            //   DateTime.now().day
            ) {
          absentdates.add(DateTime.parse(
              getCorrectDateFormat(getDatesList["rows"][i]["date"])));
        }
      }
      if (getDatesList["rows"][i]["status"] == "WFH") {
        wfhdates.add(DateTime.parse(
            getCorrectDateFormat(getDatesList["rows"][i]["date"])));
      }
      if (getDatesList["rows"][i]["status"] == "P" ||
          getDatesList["rows"][i]["status"] == "p") {
        presentdates.add(DateTime.parse(
            getCorrectDateFormat(getDatesList["rows"][i]["date"])));
      }
      if (getDatesList["rows"][i]["status"] == "H" ||
          getDatesList["rows"][i]["status"] == "h") {
        holydaysdates.add(DateTime.parse(
            getCorrectDateFormat(getDatesList["rows"][i]["date"])));
      }
      if (getDatesList["rows"][i]["status"] == "L" ||
          getDatesList["rows"][i]["status"] == "l") {
        leaveDates.add(DateTime.parse(
            getCorrectDateFormat(getDatesList["rows"][i]["date"])));
      }
      if (getDatesList["rows"][i]["status"] == "R" ||
          getDatesList["rows"][i]["status"] == "r") {
        restDaysdates.add(DateTime.parse(
            getCorrectDateFormat(getDatesList["rows"][i]["date"])));
      }
    }
  }

  String getCorrectDateFormat(String dateformat) {
    List<String> date = dateformat.split('-');
    date[1] = int.parse(date[1]) > 9 ? date[1].toString() : "0${date[1]}";
    String newDate = "${date[0]}-${date[1]}-${date[2]}";
    return newDate;
  }
}
