import '../untils/export_file.dart';

class DynamicLinkServices extends GetxService {
  String? linkMessage;
  bool isCreatingLink = false;
  final FirebaseDynamicLinks _firebaseDynamicLinks =
      FirebaseDynamicLinks.instance;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  initDynamicLink() async {
    debugPrint('DynamicLinkServices - initDynamicLink called');
    PendingDynamicLinkData? pendingDynamicLinkData =
        await _firebaseDynamicLinks.getInitialLink();
    if (pendingDynamicLinkData != null) {
      handleSuccessLinking(pendingDynamicLinkData);
      debugPrint("Link");
    } else {
      Get.toNamed(KBottom_navigation);
    }
  }

  void handleSuccessLinking(PendingDynamicLinkData? data) {
    if (data == null) return null;
    final Uri? deepLink = data.link;
    debugPrint("Dynamic link opened the app $deepLink");
    var id = deepLink.toString().split("post?")[1].trim().split('=')[1].trim();
    Get.toNamed(KStory_fullview,arguments: {"id":id});
  }

  Future<String> createDynamicLink(bool short, int id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://vibhohcm.page.link',
      link: Uri.parse(
        'https://staging.vibhohcm.in/post?id=$id',
      ),
      // link: Uri.parse(dynamicLink),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.vibeshr',
        minimumVersion: 0,
      ),
      // iosParameters: const IOSParameters(
      //   bundleId: 'com.example.vibeshr',
      //   minimumVersion: '0',
      // ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }
    linkMessage = url.toString();
    return linkMessage!;
  }
}
