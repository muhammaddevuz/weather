import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';

class MoreInformationScreen extends StatefulWidget {
  List<Weather> weather;
   MoreInformationScreen({super.key,required this.weather});

  @override
  State<MoreInformationScreen> createState() => _MoreInformationScreenState();
}

class _MoreInformationScreenState extends State<MoreInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
