// ignore_for_file: camel_case_types, use_build_context_synchronously
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vibeshr/untils/export_file.dart';

class Google_map extends StatefulWidget {
  const Google_map({super.key});

  @override
  State<Google_map> createState() => _Google_mapState();
}

class _Google_mapState extends State<Google_map> {
  ServiceController serviceController = Get.put(ServiceController());
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  double lat = 37.42796133580664;
  double lon = -122.085749655962;

  String? _currentAddress;

  var isLoading = "none";
  void _getCurrentLocation() async {
    setState(() {
      isLoading = "started";
    });
    Position? position = await _determinePosition();
    setState(() {
      serviceController.position = position;
      serviceController.latittude = serviceController.position!.latitude;
      serviceController.longitude = serviceController.position!.longitude;
      _getAddressFromLatLng(position!);
    });
  }

  Future<Position?> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      } else {
        await _showMyDialog();
        if (isPermissionGiven == true) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            return Future.error('Location permissions are denied');
          }
        } else {
          Fluttertoast.showToast(
            msg: "Denined Location Will Failed To Upload Attendance",
          );
        }
      }
    } else {
      setState(() {
        isPermissionGiven = true;
      });
    }
    Position? positionData;
    try {
      positionData = await Geolocator.getCurrentPosition();
      serviceController.loacationIsEnabled(true);
      debugPrint(positionData.toString());
    } catch (e) {
      debugPrint("$e");
      serviceController.loacationIsEnabled(false);
    }
    setState(() {
      isLoading = "ended";
    });
    return positionData;
  }

  bool isPermissionGiven = false;
  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 350.h,
              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('Location Permission',
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: 14.sp,
                          fontWeight: kFW900)),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                      'VIBHOHCM APP collects Your Location Info to MarkUp your Attendance',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: KdarkText,
                          fontSize: kTenFont,
                          fontWeight: kFW500)),
                  SizedBox(
                    height: 15.h,
                  ),
                  Image.asset(
                    "assets/images/location.png",
                    width: 150.w,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Custom_OutlineButton(
                          borderRadius: BorderRadius.circular(15.r),
                          margin: EdgeInsets.all(10.r),
                          width: 110.w,
                          height: 35.h,
                          Color: KOrange,
                          textColor: KOrange,
                          fontSize: 12.sp,
                          fontWeight: kFW700,
                          label: "Cancel",
                          isLoading: false,
                          onTap: () {
                            setState(() {
                              isPermissionGiven = false;
                            });
                            Navigator.of(context).pop();
                          }),
                      CustomButton(
                          borderRadius: BorderRadius.circular(15.r),
                          margin: EdgeInsets.all(10.r),
                          width: 110.w,
                          height: 35.h,
                          Color: KOrange,
                          textColor: Kwhite,
                          fontSize: 12.sp,
                          fontWeight: kFW700,
                          label: "Accept",
                          isLoading: false,
                          onTap: () {
                            setState(() {
                              isPermissionGiven = true;
                            });
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(serviceController.position!.latitude,
            serviceController.position!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},${place.postalCode}';
        serviceController.address.value = _currentAddress.toString();
        serviceController.addressLatitude.value =
            serviceController.position!.latitude.toString();
        serviceController.addressLongitude.value =
            serviceController.position!.longitude.toString();
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    if (serviceController.address.value == "" &&
        serviceController.position == null) {
      _getCurrentLocation();
    } else if (!isPermissionGiven) {
      _getCurrentLocation();
    }
    // _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == "ended"
        ? Obx(
            () => isPermissionGiven == true &&
                    serviceController.loacationIsEnabled.value != false
                ? serviceController.position != null &&
                        serviceController.loacationIsEnabled.value != false
                    ? GoogleMap(
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        zoomControlsEnabled: true,
                        scrollGesturesEnabled: true,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(serviceController.position!.latitude,
                              serviceController.position!.longitude),
                          zoom: 15.0000,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      )
                    : const Center(
                        child: SpinKitFadingCircle(
                        color: KOrange,
                        size: 15,
                      ))
                : Image.asset(
                    "assets/images/nolocation.png",
                    fit: BoxFit.contain,
                  ),
          )
        : Stack(
            children: [
              Image.asset(
                "assets/images/locationBanner.png",
                fit: BoxFit.contain,
              ),
              Container(
                width: 150.w,
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 15.h, top: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Text("Location ",
                        style: TextStyle(
                          color: KOrange,
                          fontSize: 25.sp,
                          fontWeight: kFW900,
                        )),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text("Loading...",
                        style: TextStyle(
                            color: Klightgray,
                            fontSize: 15.sp,
                            fontWeight: kFW900)),
                    AnimatedTextKit(animatedTexts: [
                      TyperAnimatedText("Please Wait Untill It Loads...",
                          textStyle: TextStyle(
                            color: Klightgray,
                            fontSize: 10.sp,
                            fontWeight: kFW900,
                          ))
                    ]),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
