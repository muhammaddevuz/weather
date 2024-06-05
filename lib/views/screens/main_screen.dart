import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/services/weather_http_service.dart';
import 'package:weather/views/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  WeatherServices weatherServices = WeatherServices();

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    await Future.delayed(Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? oldLocation = prefs.getString('location');
    oldLocation == null
        ? Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return HomeScreen(latLung: "kokand");
            },
          ))
        : Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return HomeScreen(latLung: oldLocation);
            },
          ));
  }

  Future<void> showMessageDialog(String message) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w600,
                      fontSize: 45.h,
                      height: 0),
                ),
                Text(
                  'ForeCast',
                  style: TextStyle(
                      color: const Color(0xFFDDB130),
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
