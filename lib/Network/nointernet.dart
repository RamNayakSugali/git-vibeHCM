// ignore_for_file: camel_case_types

import '../untils/export_file.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class No_Internet extends StatefulWidget {
  const No_Internet({super.key});

  @override
  State<No_Internet> createState() => _No_InternetState();
}

class _No_InternetState extends State<No_Internet> {
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  bool isLoading = false;
  void performAction() async {
    setState(() {
      isLoading = true;
    });
    bool isConnected = await checkInternetConnection();

    if (isConnected) {
      Get.offAll(Bottom_navigation());
      return;
    }
    setState(() {
      isLoading = false;
    });
    //  print('Internet connection is available. Performing the action...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedTheme == "Lighttheme" ? Kwhite : Kthemeblack,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset(
                "assets/images/no_internet_image.png",
              ),
              SizedBox(
                height: 30.h,
              ),
              Text("No Internet  Connection",
                  style: TextStyle(
                      color: selectedTheme == "Lighttheme" ? kblack : Kwhite,
                      fontSize: 24.sp,
                      fontWeight: kFW700)),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 200.w,
                child: Text(
                    "No Internet Connection found, Check your Connection.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: selectedTheme == "Lighttheme"
                            ? KCustomDarktwo
                            : Kwhite,
                        fontSize: 11.sp,
                        fontWeight: kFW500)),
              ),
            ],
          ),
          isLoading == true
              ? SpinKitFadingCircle(
                  color: KOrange,
                  size: 15,
                )
              : CustomButton(
                  margin: const EdgeInsets.all(15),
                  height: 38.h,
                  width: double.infinity,
                  textColor: Kwhite,
                  borderRadius: BorderRadius.circular(20.r),
                  Color: KOrange,
                  fontSize: 13.sp,
                  fontWeight: kFW600,
                  label: "Try Again",
                  isLoading: false,
                  onTap: () {
                    performAction();
                    // Get.offAll(Bottom_navigation());
                    //   Get.offAll(KBottom_navigation);
                  }),
        ],
      ),
    );
  }
}
