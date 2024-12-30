import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_assignment/weather_model.dart';

import 'enums/language_enum.dart';


Future<WeatherModel> fetchWeatherForCity(String city, String lang) async {
  final apiKey = dotenv.env['API_KEY'];
  final baseUrl = dotenv.env['BASE_URL'];

  final url = Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric&lang=$lang');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherModel.fromJSON(data, lang == 'he' ? Language.hebrew : Language.english);
    } else {
      throw Exception('Failed to load weather data');
    }
  } catch (e) {
    throw Exception('Error fetching weather data: $e');
  }
}

