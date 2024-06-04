import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/controllers/weather_controller.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/views/screens/home_screen.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  WeatherController weatherController = WeatherController();
  TextEditingController searchController = TextEditingController();
  String? searchError;
  bool searchCheck = true;
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
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        label: const Text(
                          "Shaxar nomini kiriting",
                          style: TextStyle(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        suffixIcon: searchCheck
                            ? IconButton(
                                onPressed: () async {
                                  setState(() {
                                    searchCheck = false;
                                  });
                                  final box = await weatherController
                                      .getInformation(searchController.text);
                                  if (box is String) {
                                    searchError = box;
                                    setState(() {
                                      searchCheck = true;
                                    });
                                  } else {
                                    searchCheck = true;
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                              latLung: searchController.text),
                                        ));
                                  }
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ))
                            : SizedBox(
                              width: 10,
                              child: Image.asset("assets/load.gif"),
                            ),
                        errorText: searchError,
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
