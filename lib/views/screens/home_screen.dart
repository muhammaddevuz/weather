import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/controllers/weather_controller.dart';
import 'package:weather/models/citys.dart';
import 'package:weather/models/weather.dart';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherController weatherController = WeatherController();

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
                  future: weatherController.getCategories("aa"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      );
                    }
                    final List<Weather> weathers = snapshot.data;
                    return Column(
                      children: [
                        SizedBox(height: 60),
                        Text(
                          selectedCity,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 150.w,
                          child: Image.asset(
                            "assets/${weathers[0].weather[0]['icon']}.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "${(weathers[0].main['temp'] - 272) ~/ 1}°",
                          style: TextStyle(
                              fontSize: 64.sp,
                              color: Colors.white,
                              height: -0,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "${weathers[0].weather[0]['main']}",
                          style: TextStyle(
                              fontSize: 40.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Max: ${(weathers[0].main['temp_max'] - 272) ~/ 1}°",
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Text(
                              "Min: ${(weathers[0].main['temp_min'] - 272) ~/ 1}°",
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Color(0xff00000040))
                              ],
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color(0xff3E2D8F),
                                    Color(0xff9D52ACB2),
                                  ])),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Today",
                                      style: TextStyle(
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${monthNames[weathers[0].dt_txt.month - 1]}, ${weathers[0].dt_txt.day}",
                                      style: TextStyle(
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 2,
                                color: Color.fromARGB(255, 183, 167, 223),
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
                    );
                  }))),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 178, 123, 189),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 45,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 45,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
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
        height: 120.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${(weather.main['temp'] - 272) ~/ 1}℃",
              style: TextStyle(
                  fontSize: 27.sp,
                  color: Colors.white,
                  height: -0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
                width: 50.w,
                child: weather.dt_txt.hour > 5 && weather.dt_txt.hour < 21
                    ? Image.asset(
                        "assets/${weather.weather[0]['icon']}.png"
                                .substring(0, 9) +
                            "d" +
                            "assets/${weather.weather[0]['icon']}.png"
                                .substring(9 + 1),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/${weather.weather[0]['icon']}.png"
                                .substring(0, 9) +
                            "n" +
                            "assets/${weather.weather[0]['icon']}.png"
                                .substring(9 + 1),
                        fit: BoxFit.cover,
                      )),
            Text(
              "${weather.dt_txt.hour}.00",
              style: TextStyle(
                  fontSize: 25.sp,
                  color: Colors.white,
                  height: -0,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      SizedBox(width: 40)
    ],
  );
}
