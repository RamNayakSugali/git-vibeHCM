import '../untils/export_file.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(55.h), // here the desired height
      child: AppBar(
          //titleSpacing: 0,

          elevation: 0,
          automaticallyImplyLeading: false,
          title: UserSimplePreferences.getIcon() == ""
              ? Image.asset(
                  "assets/images/logo.png",
                  width: 100.w,
                )
              : CachedNetworkImage(
                  height: 40.h,
                  width: 100.w,
                  imageUrl:
                      KWebLogo + UserSimplePreferences.getIcon().toString(),
                  placeholder: (context, url) => SizedBox(
                    height: 40.h,
                    width: 40.w,
                    child: Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: Colors.white.withOpacity(0.5),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Kwhite.withOpacity(0.5),
                        ),
                        height: 40.h,
                        width: 40.w,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                  "assets/images/logo.png",
                  width: 100.w,
                ),
                  fit: BoxFit.contain,
                ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(KNotification);
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: selectedTheme == "Lighttheme"
                      ? Image.asset(
                          UserSimplePreferences.getNotifications() == "0"
                              ? "assets/images/notification_inactive.png"
                              : "assets/images/bell.png",
                          width: 25,
                        )
                      : UserSimplePreferences.getNotifications() == "0"
                          ? Icon(
                              Icons.notifications_outlined,
                              color: Kwhite,
                            )
                          : Stack(
                              children: [
                                Icon(
                                  Icons.notifications_outlined,
                                  color: Kwhite,
                                ),
                                Positioned(
                                  right: 3,
                                  top: 3,
                                  child: CircleAvatar(
                                    radius: 3.r,
                                    backgroundColor: KOrange,
                                  ),
                                )
                              ],
                            )),
              // Icon(Icons.notifications_outlined)),
            )
          ],
          backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack
          // backgroundColor: Kbackground,
          ),
    );
  }
}
