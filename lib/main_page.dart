import 'package:flutter/material.dart';
import 'package:weather_app_assignment/provider.dart';
import 'package:weather_app_assignment/weather_model.dart';

import 'city_card.dart';
import 'loading_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> cities = ['London', 'New York', 'Berlin'];
  late List<WeatherModel> weatherData;
  TextEditingController cityController = TextEditingController();

  bool isLoading = true;

  @override
  initState() {
    super.initState();
    initializeWeatherData();
  }

  Future<void> initializeWeatherData() async {
    final data =
        await Future.wait(cities.map((city) => fetchWeatherForCity(city)));
    setState(() {
      weatherData = data;
      isLoading = false;
    });
  }

  addCity(String cityName) async {
    if (cityName.isNotEmpty) {
      if (!cities.contains(cityName)) {
        isLoading = true;
        try {
          final weather = await fetchWeatherForCity(cityName);
          setState(() {
            cities.add(weather.cityName);
            weatherData.add(weather);
            isLoading = false;
          });
          cityController.clear();
        } catch (error) {
          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("City not found. Please check the name."),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("City already exists!"),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  removeCity(String cityName) {
    print('cities before removal: $cities');
    setState(() {
      cities.remove(cityName);
      weatherData.removeWhere((weather) => weather.cityName == cityName);
    });
    print('cities after removal: $cities');
  }

  Row buildAddCityRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(
              fontSize: 20,
            ),
            controller: cityController,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hintText: 'Enter city name',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            addCity(cityController.text);
            cityController.clear();
          },
          icon: const Icon(
            Icons.add_rounded,
            size: 35,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget buildCityList() {
    if (weatherData.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return CityCard(
            weatherData: weatherData[index],
            onDelete: (cityName) {
              removeCity(cityName);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: LoadingScreen(),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            buildAddCityRow(),
            buildCityList(),
          ],
        ),
      ),
    );
  }
}
