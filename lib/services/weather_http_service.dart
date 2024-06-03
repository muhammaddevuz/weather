import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/models/citys.dart';
import 'package:weather/models/weather.dart';

class WeatherServices {
  Future<dynamic> getInfotmation(String city) async {
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=353124e7e27814f76fb4c773a6a9ac82");
    List<Weather> loadedWeather = [];
    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      selectedCity = data['city']['name'];
      data['list'].forEach((value) {
        loadedWeather.add(Weather.fromJson(value));
      });
    } catch (e) {
      return "Shaxar topilmadi";
    }

    return loadedWeather;
  }
}
