import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_assignment/provider.dart';
import 'package:weather_app_assignment/weather_model.dart';

import 'city_card.dart';
import 'enums/enums.dart';
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
  Language currentLanguage = Language.english;

  @override
  void initState() {
    super.initState();
    loadCities().then((loadedCities) {
      setState(() {
        cities = loadedCities;
        isLoading = true;
      });
      loadLanguagePreference().then((_) => initializeWeatherData());
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

  Future<void> loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentLanguage =
          Language.values[prefs.getInt('language') ?? 0];
    });
  }

  Future<void> saveLanguagePreference(Language language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('language', language.index);
  }

  Future<void> initializeWeatherData() async {
    isLoading = true;
    final data = await Future.wait(cities.map(
        (city) => fetchWeatherForCity(city, currentLanguage.languageCode)));
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
          final weather =
              await fetchWeatherForCity(cityName, currentLanguage.languageCode);
          setState(() {
            cities
                .add(weather.cityNameEnglish);
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
      weatherData.removeWhere((weather) => weather.cityNameEnglish == cityName);
    });

    saveCities(cities);

    initializeWeatherData();
  }

  Widget buildLanguageSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(currentLanguage.label),
        Switch(
          value: currentLanguage == Language.hebrew,
          onChanged: (value) {
            setState(() {
              currentLanguage = value ? Language.hebrew : Language.english;
            });
            saveLanguagePreference(currentLanguage);
            initializeWeatherData();
          },
          activeColor: Colors.grey,
          inactiveThumbColor: Colors.grey,
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.white,
        )
      ],
    );
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
            textDirection: currentLanguage == Language.hebrew
                ? TextDirection.rtl
                : TextDirection.ltr,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: currentLanguage.hintText,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            onSubmitted: (value) {
              addCity(value);
              print('value: $value');
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
            currentLanguage: currentLanguage,
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

    return Directionality(
      textDirection: currentLanguage == Language.hebrew
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple.shade200,
          actions: [
            buildLanguageSwitch(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              buildAddCityRow(),
              buildCityList(),
            ],
          ),
        ),
      ),
    );
  }
}
