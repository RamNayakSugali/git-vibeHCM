import 'package:vibeshr/untils/export_file.dart';

class ClaimController extends GetxController {
  var peoplesdata = {}.obs;
  var originalList = [].obs;
  var leaveslList = {}.obs;
  var claimsList = {}.obs;
  var leavesData = [].obs;
  var claimsData = [].obs;

  var claimSingleDataView = {}.obs;
  var claimSingleDataViewPersonName = "".obs;
  viewSingleClaim(var claimsData, var name) {
    claimSingleDataView.value = claimsData;
    claimSingleDataViewPersonName.value = name;
  }

  var leaveSingleDataView = {}.obs;
  var leaveStatusDataView = {}.obs;
  var leaveSingleDataViewPersonName = "".obs;
  viewSingleLeave(var leaveData, var name) {
    leaveSingleDataView.value = leaveData;
    leaveSingleDataViewPersonName.value = name;
  }

  updateClaimUpdatedValue(var updatedClaim) {
    for (int i = 0; i < claimsList["rows"].length; i++) {
      if (claimsList["rows"][i]["claim_id"] == updatedClaim["claim_id"]) {
        claimsList["rows"][i] = updatedClaim.value;
      }
    }
  }

  updateLeaveUpdatedValue(var updatedLeave) {
    for (int i = 0; i < leaveslList["rows"].length; i++) {
      if (leaveslList["rows"][i]["employee_leaves_lid"] ==
          updatedLeave["employee_leaves_lid"]) {
        leaveslList["rows"][i] = updatedLeave;
      }
    }
  }
}
