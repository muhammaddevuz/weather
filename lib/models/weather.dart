import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  Map main;
  List weather;
  Map wind;
  DateTime dt_txt;
  Weather({
    required this.main,
    required this.weather,
    required this.wind,
    required this.dt_txt,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return _$WeatherFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$WeatherToJson(this);
  }
}
