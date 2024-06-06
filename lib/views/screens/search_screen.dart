import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/controllers/weather_controller.dart';
import 'package:weather/models/citys.dart';
import 'package:weather/services/weather_http_service.dart';
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
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: const EdgeInsets.all(20.0),
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
              TextField(
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
              locationHistory.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Qidiruv tarixi",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
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
              if (locationHistory.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      itemCount: locationHistory.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            locationHistory.insert(0, locationHistory[i]);
                            locationHistory.removeAt(i + 1);
                            Navigator.pushReplacement(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(latLung: locationHistory[0]),
                                ));
                            saveLocationHistory(locationHistory);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                locationHistory[i],
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              IconButton(
                                  onPressed: () {
                                    locationHistory.removeAt(i);
                                    saveLocationHistory(locationHistory);
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                        );
                      }),
                )
            ],
          )),
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
                  CupertinoIcons.back,
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
    String locationBox = searchController.text.trim();
    setState(() {
      searchCheck = false;
    });
    final box = await weatherController.getInformation(locationBox);
    if (box is String) {
      searchError = box;
      setState(() {
        searchCheck = true;
      });
    } else {
      locationHistory.insert(0,
          locationBox.substring(0, 1).toUpperCase() + locationBox.substring(1));
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(latLung: locationBox),
          ));
      saveLocationHistory(locationHistory);
    }
  }
}
