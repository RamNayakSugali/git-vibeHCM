import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geocoding/geocoding.dart';
import 'package:vibeshr/database_helper.dart';
import 'package:vibeshr/untils/export_file.dart';

ServiceController serviceController = Get.put(ServiceController());
DashboardController dashboardController = Get.find<DashboardController>();
final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
// LocationService locationService = LocationService();
////////////////////////////////////////////////////////////////////////new
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      androidConfiguration: AndroidConfiguration(
        // onStart: onStart,
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        // isForegroundMode: true,
        // autoStart: true,
        // notificationChannelId: 'my_foreground',
        // initialNotificationTitle: 'AWESOME SERVICE',
        // initialNotificationContent: 'Initializing',
        // foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
          autoStart: true,
          onForeground: onStart,
          onBackground: onIosBackground));
}

double lat = 37.42796133580664;
double lon = -122.085749655962;

String? _currentAddress;

var isLoading = "none";
void _getCurrentLocation() async {
  isLoading = "started";
  Position position = await _determinePosition();
  serviceController.position = position;
  serviceController.latittude = serviceController.position!.latitude;
  serviceController.longitude = serviceController.position!.longitude;

  Map payload = {
    "latitude": serviceController.latittude.toString(),
    "longitude": serviceController.longitude.toString(),
    "location": serviceController.address.value
  };
  try {
    Map value = await Services.updatedCurrentLocation(payload);
    if (value["id"] == null) {
      debugPrint("Something went wrong");
      // Fluttertoast.showToast(
      //   msg: "Something went wrong",
      // );
    } else {
      debugPrint("Successfull ${value["id"]}");
      // Fluttertoast.showToast(
      //   msg: "Successfull ${value["id"]}",
      // );
    }
  } catch (e) {
    debugPrint("Backgroud API hitting failed");
  }
  ////////////////////////////////
  _getAddressFromLatLng(position);
}

Future<Position> _determinePosition() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else {
      // await _showMyDialog();
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
    isPermissionGiven = true;
  }
  isLoading = "ended";

  return await Geolocator.getCurrentPosition();
}

bool isPermissionGiven = false;

Future<void> _getAddressFromLatLng(Position position) async {
  await placemarkFromCoordinates(serviceController.position!.latitude,
          serviceController.position!.longitude)
      .then((List<Placemark> placemarks) {
    Placemark place = placemarks[0];
    _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},${place.postalCode}';
    serviceController.address.value = _currentAddress.toString();
    serviceController.addressLatitude.value =
        serviceController.position!.latitude.toString();
    serviceController.addressLongitude.value =
        serviceController.position!.longitude.toString();
  }).catchError((e) {
    debugPrint(e);
  });
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // void _addData(String location, String latitude, String longitude) async {
  //   Data newData = Data(name1: "ram", name2: "nayak", name3: "nayaka");
  //   // Data newData = Data(
  //   //   lat: location,
  //   //   lon: latitude,
  //   //   address: longitude,
  //   // );
  //   await _databaseHelper.insertData(newData);
  // }

  // void _addTask(String location, String latitude, String longitude) async {
  //   Task newTask =
  //       Task(location: location, latitude: latitude, longitude: longitude);
  //   await _databaseHelper.insertTask(newTask);
  //   //  _refreshTaskList();
  // }
  /// new code
  Timer.periodic(const Duration(minutes: 20), (timer) async {
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
          title: "Vibho HCM", content: "App is running in background");
      // _addTask("Hyderabad");
      _getCurrentLocation();
    }
    debugPrint("background service running");
    //   Fluttertoast.showToast(msg: "Ram Nayak");
  });

  // Timer.periodic(const Duration(seconds: 50), (timer) async {
  //   if (service is AndroidServiceInstance) {
  //     if (await service.isForegroundService()) {
  //       service.setForegroundNotificationInfo(
  //           title: "Vibho HCM", content: "App is running in background");
  //       // _addTask("Hyderabad");
  //       _getCurrentLocation();
  //       // _addData(
  //       //     serviceController.address.value,
  //       //     serviceController.addressLatitude.value,
  //       //     serviceController.addressLongitude.value
  //       //     // serviceController.latittude.toString(),
  //       //     // serviceController.longitude.toString()
  //       //     );
  //       // double.parse(serviceController.position!.latitude as String)
  //       //     .toString(),
  //       // double.parse(serviceController.position!.longitude as String)
  //       //     .toString());
  //       // serviceController.position!.longitude.toString());
  //       // Fluttertoast.showToast(msg: serviceController.address.value);
  //       // Fluttertoast.showToast(msg: "Added to Data Base Successfully");
  //     }
  //   }
  //   debugPrint("background service running");
  //   //   Fluttertoast.showToast(msg: "Ram Nayak");
  // });

  // if (service is AndroidServiceForegroundType) {
  //   service.on('setAsForeground').listen
  // }
  // Fluttertoast.showToast(msg: "Ram Nayak");
}

// void onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();

//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });

//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }

//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });

//   // void _addData(String location, String latitude, String longitude) async {
//   //   Data newData = Data(name1: "ram", name2: "nayak", name3: "nayaka");
//   //   // Data newData = Data(
//   //   //   lat: location,
//   //   //   lon: latitude,
//   //   //   address: longitude,
//   //   // );
//   //   await _databaseHelper.insertData(newData);
//   // }

//   // void _addTask(String location, String latitude, String longitude) async {
//   //   Task newTask =
//   //       Task(location: location, latitude: latitude, longitude: longitude);
//   //   await _databaseHelper.insertTask(newTask);
//   //   //  _refreshTaskList();
//   // }
//   /// new code
//   Timer.periodic(const Duration(minutes: 20), (timer) async {
//     if (service is AndroidServiceInstance) {
//       service.setForegroundNotificationInfo(
//           title: "Vibho HCM", content: "App is running in background");
//       // _addTask("Hyderabad");
//       _getCurrentLocation();
//     }
//     debugPrint("background service running");
//     //   Fluttertoast.showToast(msg: "Ram Nayak");
//   });

//   // Timer.periodic(const Duration(seconds: 50), (timer) async {
//   //   if (service is AndroidServiceInstance) {
//   //     if (await service.isForegroundService()) {
//   //       service.setForegroundNotificationInfo(
//   //           title: "Vibho HCM", content: "App is running in background");
//   //       // _addTask("Hyderabad");
//   //       _getCurrentLocation();
//   //       // _addData(
//   //       //     serviceController.address.value,
//   //       //     serviceController.addressLatitude.value,
//   //       //     serviceController.addressLongitude.value
//   //       //     // serviceController.latittude.toString(),
//   //       //     // serviceController.longitude.toString()
//   //       //     );
//   //       // double.parse(serviceController.position!.latitude as String)
//   //       //     .toString(),
//   //       // double.parse(serviceController.position!.longitude as String)
//   //       //     .toString());
//   //       // serviceController.position!.longitude.toString());
//   //       // Fluttertoast.showToast(msg: serviceController.address.value);
//   //       // Fluttertoast.showToast(msg: "Added to Data Base Successfully");
//   //     }
//   //   }
//   //   debugPrint("background service running");
//   //   //   Fluttertoast.showToast(msg: "Ram Nayak");
//   // });

//   // if (service is AndroidServiceForegroundType) {
//   //   service.on('setAsForeground').listen
//   // }
// }
