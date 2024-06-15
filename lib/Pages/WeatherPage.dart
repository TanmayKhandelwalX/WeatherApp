// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _WeatherSercice = WeatherService('8f9ba8a19080f0bdb02a8d5f4757a501');

  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _WeatherSercice.getCurretCity();

    try {
      final weather = await _WeatherSercice.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }
  String getWeatherAnimations(String? mainCondition){
    if(mainCondition == null){
      return 'assets/Windy.json';
    }

    switch(mainCondition){
      case 'clouds': return 'assets/Sunny.json';
      case 'mist': return 'assets/Windy.json';
      case 'fog': return 'assets/Windy.json';
      case 'haze': return 'assets/Windy.json';
      case 'dust': return 'assets/Windy.json';
      case 'smoke': return 'assets/Windy.json';
      case 'rain': return 'assets/Rainy.json';
      case 'drizzle': return 'assets/Rainy.json';
      case 'shower rain': return 'assets/Rainy.json';
      case 'thunderstorm': return 'assets/Thunderstorm.json';
      case 'clear': return 'assets/Sunny.json';
      default: return 'assets/Sunny.json';



    }
  }
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading city...",textScaler: TextScaler.linear(2.5),),
            Lottie.asset(getWeatherAnimations(_weather?.mainCondition)),
            Text('${_weather?.temperature}°C',textScaler: TextScaler.linear(1.5),),
            Text('${_weather?.mainCondition}')
          ],
        ),
      ),
    );
  }
}
