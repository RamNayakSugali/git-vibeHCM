// ignore_for_file: unnecessary_string_interpolations, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' hide Response, FormData, MultipartFile;
import 'package:http/http.dart' as http;
import 'package:vibeshr/database_helper.dart';
import 'package:vibeshr/untils/export_file.dart';

class Services {
  static Future checkDomain(payload) async {
    try {
      Dio dio = Dio();
      //dio.options.headers["url"] = "$KWebURL";

      var response;
      response = await dio.post(
        "$kDEVURL/Company/domainAccessCheck",
        data: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {"status": response.data};
      } else {
        return {"status": "Something Went Wrong"};
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future employeelogin(payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      var response;
      response = await dio.post(
        "$kDEVURL/Employee/login",
        data: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  /////////////////
  static Future changePasswordApi(payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.post(
        "$kDEVURL/Employee/changePassword",
        //  'https://in.dev-api.vibhohcm.com/api/Employee/changePassword' \
        data: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future checkin(payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.post(
        "$kDEVURL/Attendance/checkinout",
        data: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  /////////////////////////////////////////////////CheckIn
  static Future checkinV2(payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.post(
        "$kDEVURL/v2/Attendance/checkinout",
        data: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////

  static Future updatedCurrentLocation(payload) async {
    try {
      final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
      List dataList = await _databaseHelper.getDataList();
      Dio dio = Dio();
      dio.options.headers["url"] = dataList[0].name1;
      dio.options.headers["Authorization"] = dataList[0].name2;
      var response;
      response = await dio.post(
        "${dataList[0].name3}/CheckInOutTracking/create",
        // "$kDEVURL/CheckInOutTracking/create",
        data: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }
  ////////////////////////////////////////////////////////////////////////

  //////
  static Future employeehome() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Employee/home",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return KSystemerror;
        // {"message": "Something went wrong!"};
      }
    }
  }

  static Future chatWithBot({var message, String? endpoint}) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.post(endpoint!, data: {
        "domain": "$KWebURL",
        "endpoint":
            "${kDEVURL.toString().split('//')[1].split('/api')[0]}", //http://13.127.26.18:9000/api
        "authtoken": 'Bearer ${UserSimplePreferences.getToken()}', //token
        "message": message
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {
          "message": "Please Try Later, Error : ${e.response?.statusMessage} "
        };
      }
    }
  }

  static Future employeeprofile() async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      dio.options.headers["url"] = "$KWebURL";
      var response;
      response = await dio.get(
        "$kDEVURL/Employee/profile",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future leavelist() async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      dio.options.headers["url"] = "$KWebURL";
      var response;
      response = await dio.get(
        "$kDEVURL/Leave/list",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // likes list/id

  static Future likeslistbyId(post_id) async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      dio.options.headers["url"] = "$KWebURL";
      var response;
      response = await dio.get(
        "$kDEVURL/PostLike/list/${post_id}",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //

  static Future createLeave(payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.post(
        "$kDEVURL/Leave/create",
        data: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future createLeaveV2(payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "${KWebURL.toString().split('//')[1]}";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.post(
        "$kDEVURL/v2/Leave/create",
        data: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future checkAvilablity(payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "${KWebURL.toString().split('//')[1]}";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.post(
        "$kDEVURL/v2/getAvailability",
        data: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future postFeedBack(payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.post(
        "$kDEVURL/Feedback/create",
        data: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future getLeavesListTypes() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/LeaveType/list",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future getLeaveBalance() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/LeaveBalance/list?from_month=1&from_year=${DateTime.now().year}&to_month=12&to_year=${DateTime.now().year}",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ////////////////////////////////new leaves balance
  static Future getLeavebalancelists() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        // /LeaveBalance/leave_balance
        //  "$kDEVURL/LeaveBalance/leave_balance",
        "$kDEVURL/LeaveBalance/v3/leave_balance",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future payslipview(DateTime selectedDate) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Payslip/view?month=${selectedDate.month}&year=${selectedDate.year}",
        // 'http://13.127.26.18:9001/api/Payslip/list?month=10&year=2023' \
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future payslipviewsa() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Payslip/list",
        //  'http://13.127.26.18:9001/api/Payslip/list?month=10&year=2023' \
        // "$kDEVURL/Payslip/view?month=${selectedDate.month}&year=${selectedDate.year}",
        // 'http://13.127.26.18:9001/api/Payslip/view?is_payslip_download=Payslip&month=8&year=2023' \
        // 'http://13.127.26.18:9001/api/Payslip/list?month=10&year=2023' \
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future downloadpayslipview(DateTime selectedDate, String type) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Payslip/view?is_payslip_download=Payslip&month=${selectedDate.month}&year=${selectedDate.year}",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future updateprofile(payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.put(
        "$kDEVURL/Employee/update",
        data: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data == "" ? {} : response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future profileimage(File file) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$KWebURL/welcome/common_upload'));

    //for token
    request.headers.addAll(
        {"Authorization": "Bearer ${UserSimplePreferences.getToken()}"});

    //for image and videos and files

    // request.files.add(
    //     await http.MultipartFile.fromString("file_type", "emp_profile_pic"));
    request.files.add(
        await http.MultipartFile.fromString("file_type", "emp_profile_pic"));
    request.files.add(await http.MultipartFile.fromPath("file", file.path));

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    return jsonDecode(responsed.body);
  }

  static uploadFile(String selectedFilePath) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$KWebURL/welcome/common_upload'));

    //for token
    request.headers.addAll(
        {"Authorization": "Bearer ${UserSimplePreferences.getToken()}"});

    //for image and videos and files

    // request.files.add(
    //     await http.MultipartFile.fromString("file_type", "emp_profile_pic"));
    request.files.add(
        await http.MultipartFile.fromString("file_type", "emp_profile_pic"));
    request.files
        .add(await http.MultipartFile.fromPath("file", selectedFilePath));

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    return jsonDecode(responsed.body);
  }

  static uploadFileToServer(String selectedFilePath, String type) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$KWebURL/welcome/common_upload'));

    request.headers.addAll(
        {"Authorization": "Bearer ${UserSimplePreferences.getToken()}"});
    request.files.add(await http.MultipartFile.fromString("file_type", type));
    request.files
        .add(await http.MultipartFile.fromPath("file", selectedFilePath));

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    return jsonDecode(responsed.body);
  }

  var uploadingSelfee = false.obs;

  static uploadSelfeeToServer(String selectedFilePath, String type) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$kDEVURL/Common/Upload?file_type=other'));

    request.headers.addAll(
        {"Authorization": "Bearer ${UserSimplePreferences.getToken()}"});
    request.headers.addAll({"url": KWebURL});
    // request.files.add(await http.MultipartFile.fromString("file_type", type,filename: type));
    request.files
        .add(await http.MultipartFile.fromPath("file", selectedFilePath));

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    return jsonDecode(responsed.body);
  }

  static Future peopleslist() async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      dio.options.headers["url"] = "$KWebURL";
      var response;
      response = await dio.get(
        "$kDEVURL/Employee/list",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future hrRequestApprovalConfigs() async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      dio.options.headers["url"] = "$KWebURL";
      var response;
      response = await dio.get(
        "$kDEVURL/MyEmployees/checkClaimORLeaveAccess",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future getFeedback() async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      dio.options.headers["url"] = "$KWebURL";
      var response;
      response = await dio.get(
        "$kDEVURL/Feedback/view",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data == "" ? {} : response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future hrEmployeesLeaves() async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      dio.options.headers["url"] = "$KWebURL";
      var response;
      response = await dio.get(
        "$kDEVURL/MyEmployees/leaves",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future hrUpdateEmployeesLeaves(Map payload, int leaveid) async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      dio.options.headers["url"] = "$KWebURL";
      var response;
      response =
          await dio.put("$kDEVURL/MyEmployees/leaves/$leaveid", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future hrUpdateEmployeesClaim(Map payload, int claimid) async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      dio.options.headers["url"] = "$KWebURL";
      var response;
      response =
          await dio.put("$kDEVURL/MyEmployees/claims/$claimid", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future hrEmployeesClaims() async {
    try {
      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      dio.options.headers["url"] = "$KWebURL";
      var response;
      response = await dio.get(
        "$kDEVURL/MyEmployees/claims",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ////CLAIMS
  static Future getTypes() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Claim/types",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

//////////////////////
  static Future createClaim(Map payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.post("$kDEVURL/Claim/create", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      // var request =
      //     http.MultipartRequest('POST', Uri.parse('$kDEVURL/Claim/create'));
      // request.headers.addAll(
      //     {"Authorization": "Bearer ${UserSimplePreferences.getToken()}"});
      // request.headers.addAll(
      //     {"url": "$KWebURL"});

      // // request.fields["claim_type_id"] = payload["claim_type_id"];
      // request.fields["claim_type_id"] =  payload["claim_type_id"].toString();
      // request.fields["date"] = payload["date"];
      // request.fields["amount"] = payload["amount"].toString();
      // request.fields["comments"] = payload["comments"];
      // request.files
      //     .add(await http.MultipartFile.fromPath("image", payload["image"].path));
      // var response = await request.send();
      // var responsed = await http.Response.fromStream(response);
      // if (responsed.statusCode == 200) {
      //   return responsed.body;
      // }else{
      //   return jsonDecode(responsed.body);
      // }
    } catch (e) {
      return {"message": "Something went wrong!"};
    }
    // try {
    //   Dio dio = Dio();
    //   dio.options.headers["url"] = "$KWebURL";
    //   dio.options.headers["Authorization"] =
    //       'Bearer ${UserSimplePreferences.getToken()}';
    //   var response;
    //   response = await dio.post(
    //     "$kDEVURL/Claim/create",
    //     data: payload,
    //   );
    //   if (response.statusCode == 200 || response.statusCode == 201) {
    //     return response.data;
    //   }
    // } on DioError catch (e) {
    //   print(e);
    //   if (e.response?.statusCode == 404) {
    //     return e.response?.data;
    //   } else if (e.response?.statusCode == 401) {
    //     return e.response?.data;
    //   } else if (e.response?.statusCode == 400) {
    //     return e.response?.data;
    //   } else {
    //     return {"message": "Something went wrong!"};
    //   }
    // }
  }

  static Future getClaimList() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Claim/list",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // get Birthdays
  static Future getUpcommingBirthdaysList() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Upcoming/Bdays",
        // /api/Upcoming/Bdays'
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // get Permissions
  static Future getPermissions() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Permissions/app_permissions",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // get Annerversary
  static Future getAnneversaryList() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Upcoming/WorkAnniversaries",
        // /api/Upcoming/WorkAnniversaries' \
        // /api/Upcoming/Bdays'
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future viewClaim(String claimID) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Claim/view/$claimID",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future deleteStoryPost(int ID) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.delete(
        "$kDEVURL/Post/remove/$ID",
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return response.data == ""
            ? {"message": "Post Deleted"}
            : response.data;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future cancleLeave(int leaveID) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.patch(
        "$kDEVURL/Leave/update/$leaveID",
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return response.data == ""
            ? {"message": "Leave cancles"}
            : response.data;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  // Delete Notifications
  static Future deleteNotifications(int ID) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      var payloaddata = {"is_active": false};
      response =
          await dio.patch("$kDEVURL/Notification/update/$ID", data: payloaddata
              //  /Notification/update/493'
              //  "$kDEVURL/Post/remove/$ID",
              );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return response.data == ""
            ? {"message": "Notification Deleted"}
            : response.data;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future likeStoryPost(int id) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/StoryLike/LikeOrUnlike/$id",
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return response.data == ""
            ? {"message": "Post Deleted"}
            : response.data;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future deletePostComments(int ID) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.delete(
        "$kDEVURL/PostComment/remove/$ID",
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return response.data == ""
            ? {"message": "Post Comment Deleted"}
            : response.data;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  /////////////////////////////////////////////////delete Sub Comment
  static Future deleteSubComments(int ID) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.delete(
        "$kDEVURL/PostSubComment/remove/$ID",
        //  'https://in.dev-api.vibhohcm.com/api/PostSubComment/remove/%2066' \
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return response.data == ""
            ? {"message": "Post SubComment Deleted"}
            : response.data;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

////
  static Future deleteClaim(int claimID) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.delete(
        "$kDEVURL/Claim/delete/$claimID",
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return response.data == ""
            ? {"message": "Claim Deleted"}
            : response.data;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future cancelClaim(int claimID) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.patch("$kDEVURL/Claim/update/$claimID",
          data: {"is_approved": "Cancelled"});
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        return response.data == ""
            ? {"message": "Claim Cancelled"}
            : response.data;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future attendanceinfo(DateTime selectedDate) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Attendance/info?month=${selectedDate.month}&year=${selectedDate.year}",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future celebratelist() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/PostCelbrate/list",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future postlist(int pageno) async {
    debugPrint("token is Bearer ${UserSimplePreferences.getToken()}");
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Post/list?page_size=10&page=$pageno",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future postSingleView(String id) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Post/view/$id",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }
  // static Future postlist() async {
  //   try {
  //     Dio dio = Dio();
  //     dio.options.headers["url"] = "$KWebURL";
  //     dio.options.headers["Authorization"] =
  //         'Bearer ${UserSimplePreferences.getToken()}';
  //     var response;
  //     response = await dio.get(
  //       "$kDEVURL/Post/list",
  //     );
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return response.data;
  //     }
  //   } on DioError catch (e) {
  //     print(e);
  //     if (e.response?.statusCode == 404) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 401) {
  //       return e.response?.data;
  //     } else if (e.response?.statusCode == 400) {
  //       return e.response?.data;
  //     } else {
  //       return {"message": "Something went wrong!"};
  //     }
  //   }
  // }

  static Future createPost(Map payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;

      response = await dio.post("$kDEVURL/Post/create", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } catch (e) {
      return {"message": "Something went wrong!"};
    }
  }

  // static Future postimage(File file) async {

  //   var headers = {
  //     'Authorization': "Bearer ${UserSimplePreferences.getToken()}",
  //     'Cookie': 'ci_session=cqlp2i4b3c9igfuhv4eq649anu5r9tqe'
  //   };
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('https://staging.vibhohcm.in/welcome/common_upload'));
  //   request.fields.addAll({'file_type': 'post'});
  //   request.files.add(await http.MultipartFile.fromPath('file', file.path));
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     var responsed = await http.Response.fromStream(response);
  //     return jsonDecode(responsed.body);
  //   } else {
  //     return {"msg": "Something went wrong"};
  //   }
  // }

  static Future createlikes(payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.post(
        "$kDEVURL/PostLike/LikeOrUnlike",
        data: {"post_id": payload},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future createcomment(payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.post(
        "$kDEVURL/PostComment/create",
        data: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future commentlist() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/PostComment/list",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future createsubcomment(payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.post(
        "$kDEVURL/PostSubComment/create",
        data: payload,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future subcommentlist() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/PostSubComment/list",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future timesheet(DateTime selectedDate) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/TimeSheet/view?from_date=${selectedDate.toString()}&to_date=${selectedDate.toString()}",
        //month=${selectedDate.month}&year=${selectedDate.year}",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future downloadTimeSheet(String selectedDate) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$KWebURL/welcome/download_pdf_post/${selectedDate.toString().split(' - ')[0].split(' ')[0]}/${selectedDate.toString().split(' - ')[1].split(' ')[0]}/Normal/8",
        //month=${selectedDate.month}&year=${selectedDate.year}",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  //////Forgot Password
  static Future forgotPassword(String email) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      // dio.options.headers["Authorization"] =
      //     'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
          'https://in.dev-api.vibhohcm.com/api/Employee/forgotpassword/${email}'
          //  "$KWebURL/welcome/download_pdf_post/${selectedDate.toString().split(' - ')[0].split(' ')[0]}/${selectedDate.toString().split(' - ')[1].split(' ')[0]}/Normal/8",
          //month=${selectedDate.month}&year=${selectedDate.year}",
          );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future notification() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Notification/list",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  ////////
  static Future interestlist() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Interest/list",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future leaveldetail() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Leave/view/27",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future storylist() async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Story/list",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }

  static Future storyviewbyid(String empId) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;
      response = await dio.get(
        "$kDEVURL/Story/view/${empId}",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      if (e.response?.statusCode == 404) {
        return e.response?.data;
      } else if (e.response?.statusCode == 401) {
        return e.response?.data;
      } else if (e.response?.statusCode == 400) {
        return e.response?.data;
      } else {
        return {"message": "Something went wrong!"};
      }
    }
  }
  // ///////Storys
  //  static Future storyimage(File file) async {

  //   var headers = {
  //     'Authorization': "Bearer ${UserSimplePreferences.getToken()}",
  //     'Cookie': 'ci_session=cqlp2i4b3c9igfuhv4eq649anu5r9tqe'
  //   };
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('https://staging.vibhohcm.in/welcome/common_upload'));
  //   request.fields.addAll({'file_type': 'story'});
  //   request.files.add(await http.MultipartFile.fromPath('file', file.path));
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     var responsed = await http.Response.fromStream(response);
  //     return jsonDecode(responsed.body);
  //   } else {
  //     return {"msg": "Something went wrong"};
  //   }
  // }
  //////

  static Future createStory(Map payload) async {
    try {
      Dio dio = Dio();
      dio.options.headers["url"] = "$KWebURL";
      dio.options.headers["Authorization"] =
          'Bearer ${UserSimplePreferences.getToken()}';
      var response;

      response = await dio.post("$kDEVURL/Story/create", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } catch (e) {
      return {"message": "Something went wrong!"};
    }
  }
}
