import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/controllers/weather_controller.dart';
import 'package:weather/models/citys.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/views/screens/more_information_screen.dart';
import 'package:location/location.dart';
import 'package:weather/views/screens/search_screen.dart';

List<String> monthNames = [
  'Yanvar',
  'Fevral',
  'Mart',
  'Aprel',
  'May',
  'Iyun',
  'Iyul',
  'Avgust',
  'Sentabr',
  'Oktabr',
  'Noyabr',
  'Dekabr'
];

Map<String, String> weatherMainMap = {
  "Clear": "Ochiq osmon",
  "Clouds": "Bulutli",
  "Rain": "Yomg'ir",
  "Drizzle": "Mayda yomg'ir",
  "Thunderstorm": "Momaqaldiroq",
  "Snow": "Qor",
  "Mist": "Tuman",
  "Smoke": "Tutun",
  "Haze": "Tutash",
  "Dust": "Chang",
  "Fog": "Tuman",
  "Sand": "Qum",
  "Ash": "Kulf",
  "Squall": "Kuchli shamol",
  "Tornado": "Tornado"
};

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  dynamic latLung;
  HomeScreen({super.key, required this.latLung});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherController weatherController = WeatherController();
  bool checkLocationGif = true;
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
              child: FutureBuilder(
                  future: weatherController.getInformation(widget.latLung),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                    final List<Weather> weathers = snapshot.data;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          Text(
                            selectedCity,
                            style: GoogleFonts.poppins(
                                fontSize: 20.h,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 140.w,
                            child: Image.asset(
                              "assets/${weathers[0].weather[0]['icon']}.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text("${(weathers[0].main['temp'] - 272) ~/ 1}°",
                              style: GoogleFonts.poppins(
                                fontSize: 55.h,
                                color: Colors.white,
                                height: -0,
                                fontWeight: FontWeight.w600,
                              )),
                          SizedBox(height: 15.h),
                          Text(
                              "${weatherMainMap[weathers[0].weather[0]['main']]}",
                              style: GoogleFonts.poppins(
                                  fontSize: 30.h,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "Max: ${(weathers[0].main['temp_max'] - 272) ~/ 1}°",
                                  style: GoogleFonts.poppins(
                                      fontSize: 27.h,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                width: 30.w,
                              ),
                              Text(
                                  "Min: ${(weathers[0].main['temp_min'] - 272) ~/ 1}°",
                                  style: GoogleFonts.poppins(
                                      fontSize: 27.h,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(color: Color.fromARGB(0, 1, 1, 60))
                                ],
                                borderRadius: BorderRadius.circular(25),
                                gradient: const LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Color(0xff3E2D8F),
                                      Color.fromARGB(157, 82, 172, 178),
                                    ])),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 15, 40, 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Bugun",
                                          style: GoogleFonts.poppins(
                                              fontSize: 23.h,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                      Text(
                                          "${monthNames[weathers[0].dt_txt.month - 1]}, ${weathers[0].dt_txt.day}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 23.h,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white))
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 2,
                                  color:
                                      const Color.fromARGB(255, 183, 167, 223),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (var i = 0; i < 9; i++)
                                          hoursInformation(weathers[i]),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }))),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 178, 123, 189),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            checkLocationGif
                ? IconButton(
                    onPressed: () async {
                      setState(() {
                        checkLocationGif = false;
                      });
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
                      if (!mounted) return;

                      _locationData = await location.getLocation();
                      if (_locationData.latitude != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen(latLung: [
                              _locationData.latitude,
                              _locationData.longitude
                            ]);
                          },
                        ));
                      }
                    },
                    icon: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                      size: 45,
                    ))
                : SizedBox(
                    width: 40,
                    child: Image.asset("assets/load.gif"),
                  ),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ));
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 45,
                )),
            IconButton(
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const MoreInformationScreen();
                    },
                  ));
                },
                icon: const Icon(
                  CupertinoIcons.line_horizontal_3,
                  color: Colors.white,
                  size: 55,
                ))
          ],
        ),
      ),
    );
  }
}

Widget hoursInformation(Weather weather) {
  return Row(
    children: [
      SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${(weather.main['temp'] - 272) ~/ 1}℃",
                style: GoogleFonts.poppins(
                    fontSize: 25.h,
                    color: Colors.white,
                    height: -0,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            SizedBox(
                width: 50.w,
                child: weather.dt_txt.hour > 5 && weather.dt_txt.hour < 21
                    ? Image.asset(
                        "${"assets/${weather.weather[0]['icon']}.png".substring(0, 9)}d${"assets/${weather.weather[0]['icon']}.png".substring(9 + 1)}",
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "${"assets/${weather.weather[0]['icon']}.png".substring(0, 9)}n${"assets/${weather.weather[0]['icon']}.png".substring(9 + 1)}",
                        fit: BoxFit.cover,
                      )),
            const SizedBox(height: 10),
            Text("${weather.dt_txt.hour}.00",
                style: GoogleFonts.poppins(
                    fontSize: 23.h,
                    color: Colors.white,
                    height: -0,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      const SizedBox(width: 40)
    ],
  );
}
