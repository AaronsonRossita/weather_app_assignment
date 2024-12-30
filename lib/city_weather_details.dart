import 'package:flutter/material.dart';
import 'package:weather_app_assignment/weather_model.dart';
import 'package:weather_app_assignment/enums/weather_condition_enum.dart';

class CityWeatherDetails extends StatelessWidget {
  final WeatherModel weatherData;
  final Function(String) onDelete;
  final bool isHebrew;

  const CityWeatherDetails({
    super.key,
    required this.weatherData,
    required this.onDelete,
    required this.isHebrew,
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

  String translate(String key) {
    if (isHebrew) {
      switch (key) {
        case 'Remove City':
          return 'הסר עיר';
        case 'Temperature':
          return 'חום';
        case 'Feels Like':
          return 'מרגיש כמו';
        case 'Min Temp':
          return 'מינימום טמפ';
        case 'Max Temp':
          return 'מקסימום טמפ';
        case 'Humidity':
          return 'לחות';
        case 'Pressure':
          return 'לחץ';
        case 'Wind Speed':
          return 'מהירות רוח';
        case 'Wind Direction':
          return 'כיוון רוח';
        case 'Description':
          return 'תיאור';
        case 'Sunrise':
          return 'זריחה';
        case 'Sunset':
          return 'שקיעה';
        default:
          return key;
      }
    } else {
      return key;
    }
  }

  String getCityName() {
    return isHebrew ? weatherData.cityNameHebrew : weatherData.cityNameEnglish;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getCityName(), style: titleTextStyle()),
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
              Text('${translate('Temperature')}: ${tempToString(weatherData.temperature)}',
                  style: regularTextStyle()),
              weatherData.weatherCondition.largeIcon,
              Text('${translate('Feels Like')}: ${tempToString(weatherData.feelsLike)}',
                  style: regularTextStyle()),
              Text('${translate('Min Temp')}: ${tempToString(weatherData.tempMin)}',
                  style: regularTextStyle()),
              Text('${translate('Max Temp')}: ${tempToString(weatherData.tempMax)}',
                  style: regularTextStyle()),
              Text('${translate('Humidity')}: ${weatherData.humidity}%',
                  style: regularTextStyle()),
              Text('${translate('Pressure')}: ${weatherData.pressure} hPa',
                  style: regularTextStyle()),
              Text('${translate('Wind Speed')}: ${weatherData.windSpeed} m/s',
                  style: regularTextStyle()),
              Text('${translate('Wind Direction')}: ${weatherData.windDegree}°',
                  style: regularTextStyle()),
              Text('${translate('Description')}: ${weatherData.description}',
                  style: regularTextStyle()),
              Text('${translate('Sunrise')}: ${formatTime(weatherData.sunrise)}',
                  style: regularTextStyle()),
              Text('${translate('Sunset')}: ${formatTime(weatherData.sunset)}',
                  style: regularTextStyle()),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  onDelete(weatherData.cityNameEnglish);
                  Navigator.pop(context);
                },
                child: Text(translate('Remove City')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
