import 'package:flutter/material.dart';

enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  atmosphere,
  clear,
  clouds,
  extreme,
  additional
}

extension WeatherConditionIcon on WeatherCondition {
  static double iconSize = 50;

  Icon get icon{
    switch (this) {
      case WeatherCondition.thunderstorm:
        return Icon(
          Icons.thunderstorm,
          color: Colors.blueGrey,
          size: iconSize,
        );
      case WeatherCondition.drizzle:
        return Icon(
          Icons.grain,
          color: Colors.lightBlue,
          size: iconSize,
        );
      case WeatherCondition.rain:
        return Icon(
          Icons.water_drop,
          color: Colors.blue,
          size: iconSize,
        );
      case WeatherCondition.snow:
        return Icon(
          Icons.ac_unit,
          color: Colors.white,
          size: iconSize,
        );
      case WeatherCondition.atmosphere:
        return Icon(
          Icons.foggy,
          color: Colors.grey.shade600,
          size: iconSize,
        );
      case WeatherCondition.clear:
        return Icon(
          Icons.wb_sunny,
          color: Colors.yellow,
          size: iconSize,
        );
      case WeatherCondition.clouds:
        return Icon(
          Icons.cloud,
          color: Colors.blueGrey.shade100,
          size: iconSize,
        );
      case WeatherCondition.extreme:
        return Icon(
          Icons.warning,
          color: Colors.red,
          size: iconSize,
        );
      case WeatherCondition.additional:
        return Icon(
          Icons.air,
          color: Colors.green,
          size: iconSize,
        );
    }
  }

  Icon get largeIcon{
    switch (this) {
      case WeatherCondition.thunderstorm:
        return Icon(
          Icons.thunderstorm,
          color: Colors.blueGrey.shade300,
          size: iconSize * 3,
        );
      case WeatherCondition.drizzle:
        return Icon(
          Icons.grain,
          color: Colors.lightBlue,
          size: iconSize * 3,
        );
      case WeatherCondition.rain:
        return Icon(
          Icons.water_drop,
          color: Colors.blue,
          size: iconSize * 3,
        );
      case WeatherCondition.snow:
        return Icon(
          Icons.ac_unit,
          color: Colors.white,
          size: iconSize * 3,
        );
      case WeatherCondition.atmosphere:
        return Icon(
          Icons.foggy,
          color: Colors.grey.shade600,
          size: iconSize * 3,
        );
      case WeatherCondition.clear:
        return Icon(
          Icons.wb_sunny,
          color: Colors.yellow,
          size: iconSize * 3,
        );
      case WeatherCondition.clouds:
        return Icon(
          Icons.cloud,
          color: Colors.blueGrey.shade300,
          size: iconSize * 3,
        );
      case WeatherCondition.extreme:
        return Icon(
          Icons.warning,
          color: Colors.red,
          size: iconSize * 3,
        );
      case WeatherCondition.additional:
        return Icon(
          Icons.air,
          color: Colors.green,
          size: iconSize * 3,
        );
    }
  }
}

WeatherCondition getWeatherCondition(int id) {
  if (id >= 200 && id <= 232) {
    return WeatherCondition.thunderstorm;
  } else if (id >= 300 && id <= 321) {
    return WeatherCondition.drizzle;
  } else if (id >= 500 && id <= 531) {
    return WeatherCondition.rain;
  } else if (id >= 600 && id <= 622) {
    return WeatherCondition.snow;
  } else if (id >= 701 && id <= 781) {
    return WeatherCondition.atmosphere;
  } else if (id == 800) {
    return WeatherCondition.clear;
  } else if (id >= 801 && id <= 804) {
    return WeatherCondition.clouds;
  } else if (id >= 900 && id <= 906) {
    return WeatherCondition.extreme;
  } else if (id >= 951 && id <= 962) {
    return WeatherCondition.additional;
  } else {
    throw ArgumentError("Unknown weather ID: $id");
  }
}

