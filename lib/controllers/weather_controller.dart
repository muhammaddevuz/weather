
import 'package:weather/services/weather_http_service.dart';

class WeatherController {
  final weatherServices = WeatherServices();

  Future<dynamic> getInformation(dynamic box) async {
    dynamic weather = await weatherServices.getInfotmation(box);

    return weather;
  }
}