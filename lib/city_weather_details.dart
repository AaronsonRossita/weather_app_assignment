import 'package:flutter/material.dart';
import 'package:weather_app_assignment/enum.dart';
import 'package:weather_app_assignment/weather_model.dart';

class CityWeatherDetails extends StatelessWidget {
  final WeatherModel weatherData;
  final Function(String) onDelete;

  const CityWeatherDetails({
    super.key,
    required this.weatherData,
    required this.onDelete,
  });

  TextStyle titleTextStyle() {
    return const TextStyle(
      fontSize: 50,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle regularTextStyle() {
    return const TextStyle(
      fontSize: 25,
      color: Colors.black,
      fontWeight: FontWeight.bold,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(weatherData.cityName, style: titleTextStyle()),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade200,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Temperature: ${tempToString(weatherData.temperature)}',
                  style: regularTextStyle()),
              weatherData.weatherCondition.largeIcon,
              Text('Feels Like: ${tempToString(weatherData.feelsLike)}',
                  style: regularTextStyle()),
              Text('Min Temp: ${tempToString(weatherData.tempMin)}',
                  style: regularTextStyle()),
              Text('Max Temp: ${tempToString(weatherData.tempMax)}',
                  style: regularTextStyle()),
              Text('Humidity: ${weatherData.humidity}%',
                  style: regularTextStyle()),
              Text('Pressure: ${weatherData.pressure} hPa',
                  style: regularTextStyle()),
              Text('Wind Speed: ${weatherData.windSpeed} m/s',
                  style: regularTextStyle()),
              Text('Wind Direction: ${weatherData.windDegree}°',
                  style: regularTextStyle()),
              Text('Description: ${weatherData.description}',
                  style: regularTextStyle()),
              Text('Sunrise: ${formatTime(weatherData.sunrise)}',
                  style: regularTextStyle()),
              Text('Sunset: ${formatTime(weatherData.sunset)}',
                  style: regularTextStyle()),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  onDelete(weatherData.cityName);
                  Navigator.pop(context);
                },
                child: const Text('Remove City'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
