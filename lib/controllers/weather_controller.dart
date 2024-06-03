import 'package:weather/models/weather.dart';
import 'package:weather/services/weather_http_service.dart';

class WeatherController {
  final weatherServices = WeatherServices();

  Future<dynamic> getCategories(String city) async {
    List<Weather> weather = await weatherServices.getInfotmation(city);

    return weather;
  }
}