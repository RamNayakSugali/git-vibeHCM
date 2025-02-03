import 'package:flutter/cupertino.dart';
import 'package:vibeshr/feeds/fullview.dart';
import 'package:vibeshr/feeds/storyForFlutter.dart';

import '../untils/export_file.dart';

class StoryCircle extends StatefulWidget {
  final List<StoryItem>? story;
  final int? selectedIndex;
  final TextStyle? storyCircleTextStyle;
  final Color? highLightColor;
  final double? circleRadius;
  final double? circlePadding;
  final double? borderThickness;
  final TextStyle? fullPagetitleStyle;
  final Color? paddingColor;

  /// Choose whether progress has to be shown
  final bool? displayProgress;

  /// Color for visited region in progress indicator
  final Color? fullpageVisitedColor;

  /// Color for non visited region in progress indicator
  final Color? fullpageUnvisitedColor;

  /// Horizontal space between stories
  final double? spaceBetweenStories;

  /// Whether image has to be show on top left of the page
  final bool? showThumbnailOnFullPage;

  /// Size of the top left image
  final double? fullpageThumbnailSize;

  /// Whether image has to be show on top left of the page
  final bool? showStoryNameOnFullPage;

  /// Status bar color in full view of story
  final Color? storyStatusBarColor;

  /// Function to run when page changes
  final Function? onPageChanged;

  /// Duration after which next story is displayed
  /// Default value is infinite.
  final Duration? autoPlayDuration;

  /// Show story name on main page
  final bool showStoryName;

  const StoryCircle({
    Key? key,
    this.story,
    this.selectedIndex,
    this.storyCircleTextStyle,
    this.highLightColor,
    this.circleRadius,
    this.circlePadding,
    this.borderThickness,
    this.fullPagetitleStyle,
    this.paddingColor,
    this.displayProgress,
    this.fullpageVisitedColor,
    this.fullpageUnvisitedColor,
    this.spaceBetweenStories,
    this.showThumbnailOnFullPage,
    this.fullpageThumbnailSize,
    this.showStoryNameOnFullPage,
    this.storyStatusBarColor,
    this.onPageChanged,
    this.autoPlayDuration,
    this.showStoryName = true,
  }) : super(key: key);

  @override
  State<StoryCircle> createState() => _StoryCircleState();
}

class _StoryCircleState extends State<StoryCircle> {
  @override
  ServiceController serviceController = Get.put(ServiceController());

  bool isLoading = false;
  Map storyData = {};
  Future getStoryData(int id) async {
    setState(() {
      isLoading = true;
      serviceController.setLoading(true);
    });
    Map data = await Services.storyviewbyid(id.toString());

    if (data["message"] != null) {
      Fluttertoast.showToast(
        msg: data["message"],
      );
    } else {
    setState(() {
      storyData = data;
      serviceController.storeStoryData(data);
    });
    }
    setState(() {
      isLoading = false;
      serviceController.setLoading(false);
    });
  }

  Widget build(BuildContext context) {
    double? altRadius = 27;
    double altPadding;
    if (widget.circleRadius != null) {
      altRadius = widget.circleRadius;
    }
    if (widget.circlePadding != null) {
      altPadding = altRadius! + widget.circlePadding!;
    } else {
      altPadding = altRadius! + 3;
    }
    return Container(
      margin: EdgeInsets.fromLTRB(
        widget.spaceBetweenStories ?? 5,
        0,
        widget.spaceBetweenStories ?? 5,
        10,
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 7),
          InkWell(
            onTap: () async {
              debugPrint("----------------${widget.selectedIndex!}");
              serviceController.setIndex(widget.story![widget.selectedIndex!].id);
              await getStoryData(widget.story![widget.selectedIndex!].id);
               serviceController.setIndex(0);

              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => FullPageView(
                    storiesMapList: widget.story,
                    storyNumber: widget.selectedIndex,
                    fullPagetitleStyle: widget.fullPagetitleStyle,
                    displayProgress: widget.displayProgress,
                    fullpageVisitedColor: widget.fullpageVisitedColor,
                    fullpageUnvisitedColor: widget.fullpageUnvisitedColor,
                    fullpageThumbnailSize: widget.fullpageThumbnailSize,
                    showStoryNameOnFullPage: widget.showStoryNameOnFullPage,
                    showThumbnailOnFullPage: widget.showThumbnailOnFullPage,
                    storyStatusBarColor: widget.storyStatusBarColor,
                    onPageChanged: widget.onPageChanged,
                    autoPlayDuration: widget.autoPlayDuration,
                  ),
                ),
              );
            },
            child: CircleAvatar(
              radius: widget.borderThickness != null
                  ? altPadding + widget.borderThickness!
                  : altPadding + 1.5,
              backgroundColor: widget.highLightColor ?? const Color(0xffcc306C),
              child: CircleAvatar(
                backgroundColor: widget.paddingColor ?? Colors.white,
                radius: altPadding,
                child: CircleAvatar(
                    radius: altRadius,
                    backgroundColor: Colors.white,
                    child: widget.story![widget.selectedIndex!].thumbnail),
              ),
            ),
          ),
          const SizedBox(height: 5),
          widget.showStoryName
              ? Text(
                  widget.story![widget.selectedIndex!].name,
                  style: widget.storyCircleTextStyle ??
                      const TextStyle(fontSize: 13),
                )
              : const Center()
        ],
      ),
    );
  }
}
