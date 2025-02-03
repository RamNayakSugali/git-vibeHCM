// ignore_for_file: constant_identifier_names, deprecated_member_use

import 'export_file.dart';

const String kSplashPage = "/splash.dart";
const String KDbTasks = '/sqlDb/sql_address.dart';

const String KDashboard = '/home/dashboard';
const String KBirthdays = '/home/upcomming_birthdays.dart';
const String KAnneversary = '/home/anneversary_list.dart';
// export 'package:vibeshr/home/anneversary_list.dart';
const String KHolidayLIsts = "/home/holiday_list.dart";
const String KNewEmployees = "/home/new_employees/new_employees_list.dart";
// export 'package:vibeshr/home/new_employees/new_employees_list.dart';
//export 'package:vibeshr/home/holiday_list.dart';
//export 'package:vibeshr/home/upcomming_birthdays.dart';
const String Kchat = '/home/chat';
const String KBottom_navigation = "/home/bottom_navigation";
const String KNotification = "/notification/notification";
const String Kwebaddress_login = "/authorizations/webaddress_login";
const String KLogin_id = "/authorizations/login_id";
const String KForgotPassword = "/authorizations/forgor_password.dart";
// export 'package:vibeshr/authorizations/forgor_password.dart';
const String KProfile = "/profile/profile.dart";
const String KRegularization = "/actions/Regularization/regularization";
const String KApply_Regularization =
    "/actions/Regularization/Apply_regularization";
const String KView_more = "/actions/Regularization/view_more";
const String KAttendance = "/actions/AttendanceInfo/attendance_info";
const String KEmployee_swipe = "/actions/EmployeeSwipe/employee_swipe";
const String KHolidayCalender = "/actions/HolidayCalender/Holiday";
const String Kapply_leaves = "/actions/ApplyLeaves/apply_leaves";
const String KPayslips = "/actions/PaySlips/payslips";
const String KYTP_Resports = "/actions/YTPreports/ytp_reports";
const String KRegsignation = "/actions/Regsignation/regsignation";
const String KPayslips_Detail = "/actions/PaySlips/payslip_detail";
const String KSetting = "/actions/settings";
const String KChangePassword = "/Settings/change_password.dart";
// export 'package:vibeshr/Settings/change_password.dart';
const String KEditProfile = "/profile/edit_profile";
const String KCreate_Task = "/explore/Todo_list/create_task";
const String KTodo_list = "/explore/Todo_list/todo";
const String KPeople = "/explore/People/people.dart";
const String KPeopledetailed = "/explore/People/people_detail.dart";
const String KTime_sheet = "/actions/Time_sheet/time_sheet.dart";
const String KTimeSheet_Report = "/actions/Time_sheet/time_sheet_report.dart";
//  export 'package:vibeshr/actions/Time_sheet/time_sheet_report.dart';
const String Ktask_detail = "/explore/Todo_list/task_detail";
const String KCreate_post = "/feeds/CreatePost/create_post";
const String KSecurity = "/Settings/security.dart";
const String KHelpDesk = "/Settings/help_desk.dart";

const String KLeave_Balance = "/LeaveBalance/leave_balance.dart";
const String KReimbursement = "/Reimbursement/reimbursement";
const String Kleaves = "/ApplyLeaves/apply_leaves";
const String KClaims = "/explore/Reimbursement/create_claim";
const String KExpenses_details = "/explore/Reimbursement/expenses_details";
const String KCelebrates = "/feeds/CreatePost/celebrates";
const String KComments = "/feeds/comments";
const String KPostlike = "/feeds/comments";
// export 'package:vibeshr/feeds/postlike_list.dart';
const String KPost_likes = "/feeds/likes_view";

const String Kpolicy = "/Settings/policy";
const String Kterms_services = "/Settings/terms_services";
const String Kupdates = "/Settings/updates";
// const String KLeave_detail="/actions/ApplyLeaves/leaves_detail";
const String KLeave_detail = "/actions/ApplyLeaves/leaves_detail";
const String KStory_fullview = "/feeds/story_fullview";
const String KAll_approvals = "/explore/approvals/all_approvals";
const String KApproval_view = "/explore/approvals/approvals_view";

const String KCreate_story = "/feeds/CreatePost/create_story";

const String KClaimsApproval_view = "/explore/approvals/Claimapprovals_view";
const String KSystemerror = "/Network/systemerror";
const String KNonetwork = "/Network/nointernet";
const String KOnboarding = "/onboarding_sceen.dart";
const String KAnimated = "/untils/animation_card.dart";

//////////
double kTenFont = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .size
            .shortestSide <
        600
    ? 10.sp
    : 6.sp;
double kTwelveFont = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .size
            .shortestSide <
        600
    ? 12.sp
    : 7.sp;

double kFourteenFont = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .size
            .shortestSide <
        600
    ? 14.sp
    : 9.sp;
double kSixteenFont = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .size
            .shortestSide <
        600
    ? 16.sp
    : 11.sp;
double kEighteenFont = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .size
            .shortestSide <
        600
    ? 18.sp
    : 13.sp;
double kTwentyFont = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .size
            .shortestSide <
        600
    ? 20.sp
    : 15.sp;
double kTwentyTwoFont =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .shortestSide <
            600
        ? 22.sp
        : 17.sp;
double kTwentyFourFont =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .shortestSide <
            600
        ? 24.sp
        : 19.sp;
double kTwentySixFont =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .shortestSide <
            600
        ? 26.sp
        : 21.sp;

///Font weights
const FontWeight kFW300 = FontWeight.w300;
const FontWeight kFW400 = FontWeight.w400;
const FontWeight kFW500 = FontWeight.w500;
const FontWeight kFW600 = FontWeight.w600;
const FontWeight kFW700 = FontWeight.w700;
const FontWeight kFW800 = FontWeight.w800;
const FontWeight kFW900 = FontWeight.w900;

///Colors
const Color kSearchcolor = Color(0xff767680);
const Color kblack = Color(0xff000000);
const Color Kthemeblack = Color(0xff121212);
//#000000
const Color Kbackground = Color(0xffF1F6FA);
const Color Ktextcolor = Color(0xffA0A0A0);
const Color Kwhite = Color(0xffffffff);
const Color KBACKGROUND = Color(0xffffffff);
const Color KBrown = Color(0xffD69423);
const Color KOrange = Color(0xffFF7A00);
const Color KRed = Color(0xffEF4938);
const Color Kgreen = Color(0xff459D53);
const Color KPurple = Color(0xff4F39D4);
const Color KDarkskyblue = Color(0xff00A3FF);
const Color KDarkblue = Color(0xff000AFF);
const Color Kbluedark = Color(0xff0066FF);
const Color Kpink = Color(0xffCC00FF);
const Color Kskyblue = Color(0xffE2F5FF);
const Color KBlue = Color(0xff405DAB);
const Color KdarkText = Color(0xff2C2C2C);
const Color KHeadingText = Color(0xff24292E);
// #24292E
const Color Klightgray = Color(0xff7C7F82);
const Color Klight = Color(0xff24292E);
const Color Klightblack = Color(0xff7E91AE);
const Color Kiconcolor = Color(0xff757575);
const Color KCustomDark = Color(0xff3E3E3E);
const Color KCustomDarktwo = Color(0xff676767);
const Color Klightpink = Color(0xffFFE4CB);
const Color Klightbackground = Color(0xfff4f4f4);

////////Containercolors
const Color Klightpuple = Color(0xff725CA0);
const Color KlightRed = Color(0xffC16E5D);
const Color Klightgreen = Color(0xff498A8F);
const Color Klightorange = Color(0xffD39B56);
const Color KlightBlue = Color(0xff6884CA);
const Color Klightgery = Color(0xff5A6777);
const Color Kdarkpuple = Color(0xff8D49A5);

const Color KlightYelow = Color(0xfff8b425);
const Color Kdarkblue = Color(0xff2C2C96);

// 2. REST - #2c2c2c96

// 1.WFH -  #f8b425

//2. REST - #2c2c2c96

///text//#459D53 //#7E91AE  //#3E3E3E //#676767//#D69423
const String Klabel = 'Lorem Epson is a word to fill the sentences';
const String KCompanyName = 'Vibho HCM';

// String kDEVURL = "http://13.127.26.18:9000/api";
// String kDEVURLSA = "http://13.127.26.18:9001/api";

//productionURL
// String kDEVURL = "https://vibhohcm-api.vibhohcm.com/api";
// String kDEVURLSA = "https://sa.prod-api.vibhohcm.com/api";
// String STAICURL = "https://vibhohcm-api.vibhohcm.com/api";

// vibhohcm-api.vibhohcm.com/api

// StagingURL
// String kDEVURL = "https://in.staging-api.vibhohcm.com/api";
// String kDEVURLSA = "https://sa.staging-api.vibhohcm.com/api";
// String STAICURL = "https://in.staging-api.vibhohcm.com/api";

//DevelopmentURL
String kDEVURL = "https://in.dev-api.vibhohcm.com/api";
String kDEVURLSA = "https://sa.dev-api.vibhohcm.com/api";
String STAICURL = "https://in.dev-api.vibhohcm.com/api";

const String KChatMessageAPIURL =
    "https://chatbot.vibhohcm.com/api/Chatbot/get-response";
const String KChatOptionsAPIURL =
    "https://chatbot.vibhohcm.com/api/Static/get-response";

String KWebURL = "";
//const String KWebURL = "http://13.127.26.18:9000";/////old web url
String KSubDomainURL = "";
String KProfileimage = "$KWebURL/assets/employee_documents/";
String KpostURL = "$KWebURL/assets/post/";
String KstoryURL = "$KWebURL/assets/story/";
String KClaimsimage = "$KWebURL/assets/claim_documents/";
String Kemp_identificationURL = "$KWebURL/assets/emp_identification_image/";
String KWebLogo = "$KWebURL/assets/admin/images/";

String fcmToken = "";

String selectedTheme = "Lighttheme";

final GlobalKey<ScaffoldState> kScaffoldKey = GlobalKey<ScaffoldState>();
