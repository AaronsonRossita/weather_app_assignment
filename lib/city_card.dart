import 'package:flutter/material.dart';
import 'package:weather_app_assignment/weather_model.dart';
import 'enum.dart'; // Ensure you have the WeatherCondition enum and WeatherModel here

class CityCard extends StatefulWidget {
  const CityCard(
      {super.key,
        required this.weatherData, // Pass the entire WeatherModel
        required this.onDelete});

  final WeatherModel weatherData; // Use WeatherModel
  final Function(String) onDelete;

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  @override
  initState() {
    super.initState();
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

  void _showCityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.67,
            color: Colors.cyan.shade500,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.weatherData.cityName, style: cityNameStyle()),
                    Text(tempToString(widget.weatherData.temperature), style: temperatureStyle()),
                    widget.weatherData.weatherCondition.largeIcon,
                    Text('Feels Like: ${tempToString(widget.weatherData.feelsLike)}', style: temperatureStyle()),
                    Text('Min Temp: ${tempToString(widget.weatherData.tempMin)}', style: temperatureStyle()),
                    Text('Max Temp: ${tempToString(widget.weatherData.tempMax)}', style: temperatureStyle()),
                    Text('Humidity: ${widget.weatherData.humidity}%', style: temperatureStyle()),
                    Text('Pressure: ${widget.weatherData.pressure} hPa', style: temperatureStyle()),
                    Text('Wind Speed: ${widget.weatherData.windSpeed} m/s', style: temperatureStyle()),
                    Text('Wind Direction: ${widget.weatherData.windDegree}°', style: temperatureStyle()),
                    Text('Description: ${widget.weatherData.description}', style: temperatureStyle()),
                    Text('Sunrise: ${formatTime(widget.weatherData.sunrise)}', style: temperatureStyle()),
                    Text('Sunset: ${formatTime(widget.weatherData.sunset)}', style: temperatureStyle()),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                        widget.onDelete(widget.weatherData.cityName);
                      },
                      child: Text('Remove city', style: temperatureStyle()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String formatTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCityDialog(context);
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
                    Text(widget.weatherData.cityName, style: cityNameStyle()),
                    Text(tempToString(widget.weatherData.temperature), style: temperatureStyle()),
                  ],
                ),
                widget.weatherData.weatherCondition.icon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
