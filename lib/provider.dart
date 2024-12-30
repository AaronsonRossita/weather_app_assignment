import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_assignment/weather_model.dart';


Future<WeatherModel> fetchWeatherForCity(String city) async {

  final apiKey = dotenv.env['API_KEY'];
  final baseUrl = dotenv.env['BASE_URL'];


  final url = Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric');

  try {
    final response = await http.get(url);  // Make a GET request

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherModel.fromJSON(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  } catch (e) {
    throw Exception('Error fetching weather data: $e');
  }
}
