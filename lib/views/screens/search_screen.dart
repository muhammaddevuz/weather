import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/controllers/weather_controller.dart';
import 'package:weather/models/citys.dart';
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
  List<String> locationHistory = [];
  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> saveLocationHistory(List<String> locationHistory) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('locationHistory', locationHistory);
  }

  _init() async {
    List<String>? box;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    box = prefs.getStringList('locationHistory');
    if (box == null) {
      locationHistory = [];
    } else {
      locationHistory = box;
    }
    setState(() {});
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      onSubmitted: (value) async {
                        enterButton();
                      },
                      controller: searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        label: const Text(
                          "Shaxar nomini ingliz tilida kiriting",
                          style: TextStyle(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        suffixIcon: searchCheck
                            ? IconButton(
                                onPressed: enterButton,
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
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        locationHistory.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Qidiruv tarixi",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        locationHistory.clear();
                                        saveLocationHistory(locationHistory);
                                        setState(() {});
                                      },
                                      child: const Text(
                                        "clear",
                                        style: TextStyle(color: Colors.grey),
                                      ))
                                ],
                              )
                            : const SizedBox(),
                        locationHistory.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0;
                                      i < locationHistory.length;
                                      i++)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Text(
                                            locationHistory[i],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              locationHistory.removeAt(i);
                                              saveLocationHistory(
                                                  locationHistory);
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.clear,
                                              color: Colors.grey,
                                            ))
                                      ],
                                    )
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  )
                ],
              ))),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 178, 123, 189),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(latLung: selectedCity),
                      ));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 80,
                )),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }

  enterButton() async {
    setState(() {
      searchCheck = false;
    });
    final box =
        await weatherController.getInformation(searchController.text.trim());
    if (box is String) {
      searchError = box;
      setState(() {
        searchCheck = true;
      });
    } else {
      locationHistory.insert(0, searchController.text.trim());
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomeScreen(latLung: searchController.text.trim()),
          ));
      saveLocationHistory(locationHistory);
    }
  }
}
