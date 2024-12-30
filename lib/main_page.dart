import 'package:flutter/material.dart';
import 'package:weather_app_assignment/provider.dart';
import 'package:weather_app_assignment/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'city_card.dart';
import 'loading_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<String> cities;
  late List<WeatherModel> weatherData;
  TextEditingController cityController = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCities().then((loadedCities) {
      setState(() {
        cities = loadedCities;
        isLoading = true;
      });
      initializeWeatherData();
    });
  }

  Future<List<String>> loadCities() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('cities') ?? [];
  }

  Future<void> saveCities(List<String> cities) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cities', cities);
  }

  Future<void> initializeWeatherData() async {
    isLoading = true;
    final data =
        await Future.wait(cities.map((city) => fetchWeatherForCity(city)));
    setState(() {
      weatherData = data;
      isLoading = false;
    });
  }

  addCity(String cityName) async {
    isLoading = true;
    if (cityName.isNotEmpty) {
      if (!cities.contains(cityName)) {
        try {
          final weather = await fetchWeatherForCity(cityName);
          setState(() {
            cities.add(weather.cityName);
            weatherData.add(weather);
            isLoading = false;
          });
          saveCities(cities);
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
    setState(() {
      cities.remove(cityName);
      weatherData.removeWhere((weather) => weather.cityName == cityName);
    });
    saveCities(cities);
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
            onSubmitted: (value) {
              addCity(value);
              cityController.clear();
            },
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
        child: Text(
          'Wow much empty :(',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
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
