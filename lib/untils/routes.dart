import 'export_file.dart';

class Routes {
  static List<GetPage<dynamic>> routes = [
    GetPage(
        name: KAnimated,
        transition: Transition.rightToLeft,
        page: () => AnimatedCards()),
    GetPage(
        name: kSplashPage,
        transition: Transition.rightToLeft,
        page: () => const SplashScreen()),
    GetPage(
      name: KDashboard,
      transition: Transition.leftToRight,
      page: () => const DashBoard(),
    ),
    GetPage(
      name: KOnboarding,
      transition: Transition.rightToLeft,
      page: () => const OnBoarding(),
    ),
    GetPage(
      name: Kchat,
      transition: Transition.rightToLeft,
      page: () => const ChatScreen(),
    ),
    GetPage(
      name: KBottom_navigation,
      transition: Transition.rightToLeft,
      page: () => const Bottom_navigation(),
    ),
    GetPage(
      name: Kwebaddress_login,
      transition: Transition.rightToLeft,
      page: () => const Web_Address(),
    ),
    GetPage(
      name: KLogin_id,
      transition: Transition.rightToLeft,
      page: () => const Login_id(),
    ),
    GetPage(
      name: KNotification,
      transition: Transition.rightToLeft,
      page: () => const Notification_screen(),
    ),
    GetPage(
      name: KProfile,
      transition: Transition.rightToLeft,
      page: () => const Profile_view(bACK: 0),
    ),
    GetPage(
      name: KRegularization,
      transition: Transition.rightToLeft,
      page: () => const Regularization(),
    ),
    GetPage(
      name: KApply_Regularization,
      transition: Transition.rightToLeft,
      page: () => const Apply_Regularization(),
    ),
    GetPage(
      name: KView_more,
      transition: Transition.rightToLeft,
      page: () => const View_Details(),
    ),
    GetPage(
      name: KAttendance,
      transition: Transition.rightToLeft,
      page: () => const Attendances(),
    ),
    GetPage(
      name: KEmployee_swipe,
      transition: Transition.rightToLeft,
      page: () => const Swipes(),
    ),
    GetPage(
      name: KHolidayCalender,
      transition: Transition.rightToLeft,
      page: () => const Holiday_view(),
    ),
    GetPage(
      name: Kapply_leaves,
      transition: Transition.rightToLeft,
      page: () => const Leaves(),
    ),
    GetPage(
      name: KRegsignation,
      transition: Transition.rightToLeft,
      page: () => const Regsignation_view(),
    ),
    GetPage(
      name: KPayslips,
      transition: Transition.rightToLeft,
      page: () => const PaySlips_view(),
    ),
    GetPage(
      name: KYTP_Resports,
      transition: Transition.rightToLeft,
      page: () => const YTP_resports(),
    ),
    GetPage(
      name: KPayslips_Detail,
      transition: Transition.rightToLeft,
      page: () => const PaySlips_details(),
    ),
    /////////transitionDuration
    GetPage(
      name: KSetting,
      transition: Transition.rightToLeft,
      //transitionDuration: Duration(seconds: 1),
      page: () => const Setting_view(),
    ),
    GetPage(
      name: KSecurity,
      transition: Transition.rightToLeft,
      page: () => const Security_view(),
    ),
    GetPage(
      name: KLeave_Balance,
      transition: Transition.rightToLeft,
      page: () => const Leavebalances(),
    ),
    GetPage(
      name: KEditProfile,
      transition: Transition.rightToLeft,
      page: () => Edit_Profile(),
    ),
    GetPage(
      name: KTodo_list,
      transition: Transition.rightToLeft,
      page: () => const Todo_List(),
    ),
    GetPage(
      name: KCreate_Task,
      transition: Transition.rightToLeft,
      page: () => const task(),
    ),
    GetPage(
      name: KPeople,
      transition: Transition.rightToLeft,
      page: () => const People_list(),
    ),
    GetPage(
      name: Ktask_detail,
      transition: Transition.rightToLeft,
      page: () => const Task_Deatil(),
    ),
    GetPage(
      name: KCreate_post,
      transition: Transition.rightToLeft,
      page: () => const CreatePost(),
    ),
    GetPage(
      name: KReimbursement,
      transition: Transition.rightToLeft,
      page: () => const Reimbursement_view(),
    ),
    GetPage(
      name: Kleaves,
      transition: Transition.rightToLeft,
      page: () => const Apply_leave(),
    ),
    GetPage(
      name: KClaims,
      transition: Transition.rightToLeft,
      page: () => const Claims(),
    ),
    GetPage(
      name: KExpenses_details,
      transition: Transition.rightToLeft,
      page: () => const Expenses_Details(),
    ),
    GetPage(
      name: KCelebrates,
      transition: Transition.rightToLeft,
      page: () => const Celebrates_view(),
    ),
    GetPage(
      name: KComments,
      transition: Transition.rightToLeft,
      page: () => Comments_view(
        count: '',
      ),
    ),
    GetPage(
      name: KPost_likes,
      transition: Transition.rightToLeft,
      page: () => const post_likes(),
    ),
    GetPage(
      name: KPeopledetailed,
      transition: Transition.rightToLeft,
      page: () => const PeopleDetailed(),
    ),
    GetPage(
      name: KTime_sheet,
      transition: Transition.rightToLeft,
      page: () => const Time_sheet(),
    ),
    GetPage(
      name: KTimeSheet_Report,
      transition: Transition.rightToLeft,
      page: () => const Time_sheet_report(),
    ),
    GetPage(
      name: Kpolicy,
      transition: Transition.rightToLeft,
      page: () => policy_view(),
    ),
    GetPage(
      name: Kupdates,
      transition: Transition.rightToLeft,
      page: () => const update(),
    ),
    GetPage(
      name: Kterms_services,
      transition: Transition.rightToLeft,
      page: () => const teams_services(),
    ),
    GetPage(
      name: KLeave_detail,
      transition: Transition.rightToLeft,
      page: () => const leave_detail(),
    ),
    GetPage(
      name: KStory_fullview,
      transition: Transition.rightToLeft,
      page: () => const Story_fullview(),
    ),
    GetPage(
      name: KAll_approvals,
      transition: Transition.rightToLeft,
      page: () => const All_Apporoval(),
    ),
    GetPage(
      name: KApproval_view,
      transition: Transition.rightToLeft,
      page: () => const Approval_view(),
    ),
    GetPage(
        name: KCreate_story,
        transition: Transition.rightToLeft,
        page: () => const Create_Story()),
    GetPage(
      name: KClaimsApproval_view,
      transition: Transition.rightToLeft,
      page: () => const ClaimApproval_view(),
    ),
    GetPage(
        name: KSystemerror,
        transition: Transition.rightToLeft,
        page: () => const System_Error()),
    GetPage(
      name: KNonetwork,
      transition: Transition.rightToLeft,
      page: () => const No_Internet(),
    ),
    GetPage(
      name: KBirthdays,
      transition: Transition.rightToLeft,
      page: () => Birthdays(),
    ),
    GetPage(
      name: KHelpDesk,
      transition: Transition.rightToLeft,
      page: () => HelpDesk(),
    ),
    GetPage(
      name: KHolidayLIsts,
      transition: Transition.rightToLeft,
      page: () => Holiday(),
    ),
    GetPage(
      name: KAnneversary,
      transition: Transition.rightToLeft,
      page: () => Anneversarylist(),
    ),
    GetPage(
      name: KNewEmployees,
      transition: Transition.rightToLeft,
      page: () => NewEmployeeslist(),
    ),
    GetPage(
      name: KDbTasks,
      transition: Transition.rightToLeft,
      page: () => AddressList(),
    ),

    GetPage(
      name: KForgotPassword,
      transition: Transition.rightToLeft,
      page: () => ForgotPassword(),
    ),
    // KChangePassword

    GetPage(
      name: KChangePassword,
      transition: Transition.rightToLeft,
      page: () => const ChangePassword(),
    ),
  ];
}
