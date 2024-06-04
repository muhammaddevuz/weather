import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/services/weather_http_service.dart';
import 'package:location/location.dart';
import 'package:weather/views/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String curLocation = 'tashkant';
  WeatherServices weatherServices = WeatherServices();

  Future<void> saveChanges() async {}

  Future<void> getChanges() async {}

  Future<void> getas() async {
    await weatherServices.getInfotmation("ss");
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData _locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    if (_locationData.latitude != null) {
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ));
    }

    print("LONGITUDE:${_locationData.longitude} AND ${_locationData.latitude}");
  }

  @override
  Widget build(BuildContext context) {
    getas();
    return Scaffold(
      body: Center(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xFF1D2547),
              Color(0xFF1D2547),
              Color.fromARGB(255, 103, 63, 184),
              Color.fromARGB(255, 178, 123, 189),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/initial_image.png'),
            // SizedBox(
            //   height: 40.h,
            // ),
            Column(
              children: [
                Text(
                  'Weather',
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w600,
                      fontSize: 45.h,
                      height: 0),
                ),
                Text(
                  'ForeCast',
                  style: TextStyle(
                      color: Color(0xFFDDB130),
                      fontWeight: FontWeight.w600,
                      fontSize: 45.h,
                      height: 0),
                )
              ],
            ),
            SizedBox(height: 150.h),
          ],
        ),
      )),
    );
  }
}
