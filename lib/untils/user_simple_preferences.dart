import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;
  static const String isUserLoggedIn = 'isuserloggedin';
  static const String isToken = 'Token';
  static const String isSickId = 'SickId';
  static const String isNotificationCount = 'notificationCount';
  static const String userDataLocal = 'userData';
  static const String isRefreshToken = 'refresh_token';
  static const String isFingerprint = 'true';
  static const String weburl = 'weburl';
  static const String devurl = 'devurl';
  static const String currency = 'currency';
  static const String logo = 'logo';
  static const String logotwo = 'logotwo';
  static const String company = 'company';
  static const String fcmToken = 'fcmToken';
  static const String uniquecode = 'uniquecode';
  static const String notificationStatus = 'notification';
  static const String isCheckin = 'work_from';
  static const String isDisplayedPopUp = 'displayPopUP';
  static const String biometricStatus = 'isBioMetric';
  static const String showmap = 'showmap';
  static const String isSelfeeEnable = 'isSelfeeEnable';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setLoginStatus({required bool loginStatus}) async {
    await _preferences.setBool(isUserLoggedIn, loginStatus);
  }

  static bool? getLoginStatus() {
    return _preferences.getBool(isUserLoggedIn);
  }

  static Future setNotificationStatus({required bool status}) async {
    await _preferences.setBool(notificationStatus, status);
  }

  static bool? getNotificationStatus() {
    return _preferences.getBool(notificationStatus);
  }

  static Future setCheckinStatus({required bool status}) async {
    await _preferences.setBool(isCheckin, status);
  }

  static bool? getCheckinStatus({required bool status}) {
    return _preferences.getBool(isCheckin);
  }

  static Future setWebUrl({required String userData}) async {
    await _preferences.setString(weburl, userData);
  }

  static String? getWebUrl() {
    return (_preferences.getString(weburl));
  }

  static Future setDevUrl({required String userData}) async {
    await _preferences.setString(devurl, userData);
  }

  static String? getDevUrl() {
    return (_preferences.getString(devurl));
  }

  static Future setCurrency({required String money}) async {
    await _preferences.setString(currency, money);
  }

  static Future setLogo({required String imagelogo}) async {
    await _preferences.setString(logo, imagelogo);
  }

  static Future setCompanyname({required String companyname}) async {
    await _preferences.setString(company, companyname);
  }

  static String? getCompanyname() {
    return (_preferences.getString(company));
  }

  static Future setIcon({required String imagelogotwo}) async {
    await _preferences.setString(logotwo, imagelogotwo);
  }

  static String? getCurrency() {
    return (_preferences.getString(currency));
  }

  static String? getLogo() {
    return (_preferences.getString(logo));
  }

  static String? getIcon() {
    return (_preferences.getString(logotwo));
  }

  static Future setfcmToken(String? token) async {
    await _preferences.setString(fcmToken, token!);
  }

  static String? getfcmToken() {
    return (_preferences.getString(fcmToken));
  }

  static Future setPopUpStatus(int? status) async {
    await _preferences.setInt(isDisplayedPopUp, status!);
  }

  static int? getPopUpStatus() {
    return (_preferences.getInt(isDisplayedPopUp));
  }

  static Future setuniquecode(String? identifier) async {
    await _preferences.setString(uniquecode, identifier!);
  }

  static String? getuniquecode() {
    return (_preferences.getString(uniquecode));
  }

  static Future setUserdata({required String userData}) async {
    await _preferences.setString(userDataLocal, userData);
  }

  static String? getUserdata() {
    return (_preferences.getString(userDataLocal));
  }

  static Future setfingerprintdata({required String userData}) async {
    await _preferences.setString(isFingerprint, userData);
  }

  static Future setRefreshToken({required String refreshToken}) async {
    await _preferences.setString(isRefreshToken, refreshToken);
  }

  static String? getRefreshToken() {
    return _preferences.getString(isRefreshToken);
  }

  static String? getfingerprintdata() {
    return (_preferences.getString(isFingerprint));
  }

  static Future setToken({required String token}) async {
    await _preferences.setString(isToken, token);
  }

  static Future setSickLeaveID({required String sickId}) async {
    await _preferences.setString(isSickId, sickId);
  }

  static Future setNotifications({required String notificationCount}) async {
    await _preferences.setString(isNotificationCount, notificationCount);
  }

  static String? getNotifications() {
    return _preferences.getString(isNotificationCount);
  }

  static String? getToken() {
    return _preferences.getString(isToken);
  }

  static String? getSickLeaveID() {
    return _preferences.getString(isSickId);
  }

  static bool? getBioMetricStatic() {
    return _preferences.getBool(biometricStatus);
  }

  setBioMetricSTatuc(bool status) {
    return _preferences.setBool(biometricStatus, status);
  }

  static bool? getMapShowStatic() {
    return _preferences.getBool(showmap);
  }

  setMapShowSTatuc(bool status) {
    return _preferences.setBool(showmap, status);
  }

  static bool? getSelfeeEnableStatic() {
    return _preferences.getBool(isSelfeeEnable);
  }

  setSelfeeEnableSTatuc(bool status) {
    return _preferences.setBool(isSelfeeEnable, status);
  }

  static void clearAllData() {
    _preferences.clear();
  }
}
