import 'package:flutter/material.dart';
import 'package:weather_app_assignment/weather_model.dart';
import 'city_weather_details.dart';
import 'enums/enums.dart';

class CityCard extends StatelessWidget {
  const CityCard({
    super.key,
    required this.weatherData,
    required this.onDelete,
    required this.currentLanguage,
  });

  final WeatherModel weatherData;
  final Function(String) onDelete;
  final Language currentLanguage;

  String getCityName() {
    return currentLanguage == Language.hebrew
        ? weatherData.cityNameHebrew
        : weatherData.cityNameEnglish;
  }

  BoxDecoration cityCardDecoration() {
    return BoxDecoration(
      color: Colors.deepPurple.shade200,
      borderRadius: BorderRadius.circular(10),
    );
  }

  TextStyle cityNameStyle() {
    return const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  TextStyle temperatureStyle() {
    return const TextStyle(
      fontSize: 23,
      color: Colors.black,
    );
  }

  String tempToString(double temp) {
    return '${temp.toStringAsFixed(1)} °C';
  }

  String formatTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CityWeatherDetails(
              weatherData: weatherData,
              onDelete: onDelete, isHebrew: currentLanguage == Language.hebrew,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: cityCardDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getCityName(), style: cityNameStyle()),
                    Text(tempToString(weatherData.temperature), style: temperatureStyle()),
                  ],
                ),
                weatherData.weatherCondition.icon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
