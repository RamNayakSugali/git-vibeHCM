import '../untils/export_file.dart';

class VibhoAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool dontHaveBackAsLeading;
  final bool hasNotificationAsTrailing;
  final bool centerTitle;
  final Widget? trailing;
  final Color? bColor;
  final bool? dashboard;
  final bool? dorefresh;

  const VibhoAppBar({
    Key? key,
    required this.title,
    this.bColor,
    this.dontHaveBackAsLeading = false,
    this.hasNotificationAsTrailing = false,
    this.centerTitle = false,
    this.trailing,
    this.dorefresh,
    this.dashboard = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  State<VibhoAppBar> createState() => _VibhoAppBarState();
}

class _VibhoAppBarState extends State<VibhoAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 0,
      centerTitle: widget.centerTitle,
      backgroundColor: widget.bColor,
      leadingWidth: widget.dontHaveBackAsLeading ? 15.w : 50.w,
      leading: widget.dashboard == true
          ? IconButton(
              onPressed: () {
                Get.toNamed(KBottom_navigation);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                size: 23.w,
                color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
              ),
            )
          : widget.dontHaveBackAsLeading
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    widget.dorefresh == false
                        ? Get.back()
                        : Get.back(result: "refresh");
                  },
                  icon: Icon(Icons.arrow_back_rounded,
                      size: 23.w,
                      color:
                          selectedTheme == "Lighttheme" ? KdarkText : Kwhite),
                ),
      title: Padding(
        padding: const EdgeInsets.only(top: 2.5),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: kFW800,
            color: selectedTheme == "Lighttheme" ? KdarkText : Kwhite,
            //   KdarkText,
            letterSpacing: 0.5,
          ),
        ),
      ),
      actions: [
        widget.trailing ?? const SizedBox(),
      ],
    );
  }
}
