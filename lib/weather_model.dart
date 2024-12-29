import 'enum.dart';

class WeatherModel {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final int windDegree;
  final String description;
  final int sunrise;
  final int sunset;
  final int weatherConditionId;
  final WeatherCondition weatherCondition;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDegree,
    required this.description,
    required this.sunrise,
    required this.sunset,
    required this.weatherConditionId,
  }) : weatherCondition = getWeatherCondition(weatherConditionId);

  factory WeatherModel.fromJSON(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      windSpeed: json['wind']['speed'].toDouble(),
      windDegree: json['wind']['deg'],
      description: json['weather'][0]['description'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      weatherConditionId: json['weather'][0]['id'],
    );
  }

  @override
  String toString() {
    return 'WeatherModel(cityName: $cityName, temperature: $temperature, feelsLike: $feelsLike, tempMin: $tempMin, tempMax: $tempMax, humidity: $humidity, pressure: $pressure, windSpeed: $windSpeed, windDegree: $windDegree, description: $description, sunrise: $sunrise, sunset: $sunset, weatherConditionId: $weatherConditionId, weatherCondition: $weatherCondition)';
  }
}
