import 'package:flutter/material.dart';
import "package:flutter_app/public.dart";

class Weather extends StatefulWidget {
  Weather({Key key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  void getWeather() async {
    var response = await HttpManage.getWeatherInfo();
    print(["response========>", response]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
