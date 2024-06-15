import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;
  WeatherService(this.apiKey);
  static const Base_url =
      'https://api.openweathermap.org/data/2.5/weather?';

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('${Base_url}q=${cityName}&appid=8f9ba8a19080f0bdb02a8d5f4757a501&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
    //return Weather.fromJson(jsonDecode(response.body));
  }

  Future<String> getCurretCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;

    return city ?? "";
  }
}
