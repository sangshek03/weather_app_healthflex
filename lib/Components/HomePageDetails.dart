import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_application/Components/LocationAndSearchBar.dart';

import 'package:weather_application/Model/RealTimeWeatherDetails.dart';
import 'package:weather_application/Components/RealTimeWeather.dart';

import 'package:http/http.dart' as http;
import 'package:weather_application/Components/ForecastDetailsComponent.dart';
import 'package:weather_application/Scrrens/PopupError.dart';

class HomePageDetails extends StatefulWidget {
  const HomePageDetails({super.key});

  @override
  State<HomePageDetails> createState() {
    return _StateHomePageDetails();
  }
}

class _StateHomePageDetails extends State<HomePageDetails> {
  String typed_location = "";
  bool isLoading = true;

  RealTimeWeatherDetail? weatherDetails = RealTimeWeatherDetail(
      time: DateTime.now(),
      temperature: 0.0,
      humidity: 0,
      windSpeed: 0,
      location: 'Unknown',
      weatherCode: 0);

  @override
  void initState() {
    super.initState();
    fetchWeatherData('Bangalore');
  }

  Future<void> fetchWeatherData(String location_name) async {
    setState(() {
      isLoading = true;
    });

    try {
      String location = location_name;
      String apiKey = 'gRqAgFXNhE61KclNYT8FBHHT0K1149rB';

      final response = await http.get(Uri.parse(
          'https://api.tomorrow.io/v4/weather/realtime?location=$location&apikey=$apiKey'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        DateTime time = DateTime.parse(data['data']['time']);
        double temperature = data['data']['values']['temperature'];
        int humidity = data['data']['values']['humidity'];
        double windSpeed = data['data']['values']['windSpeed'];
        int weatherCode = data['data']['values']['weatherCode'];
        String locationName = data['location']['name'];

        setState(() {
          weatherDetails = RealTimeWeatherDetail(
              time: time,
              temperature: temperature,
              humidity: humidity,
              windSpeed: windSpeed,
              location: locationName,
              weatherCode: weatherCode);

          isLoading = false;
        });
      } else {
        showErrorDialog(context, "Failed to load weather data, Please Try Again Later");
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      showErrorDialog(context, "Error: $error. Please Try Again Later");
    }
  }

  void _onSearchSubmitted(String value) {
    fetchWeatherData(value);
    setState(() {
      typed_location = value;
    });
  }

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String extractLastFewWords(String input, {int numOfWords = 6}) {
      List<String> words = input.split(' ');
      int startIndex = words.length - numOfWords;
      if (startIndex < 0) startIndex = 0;

      return words.skip(startIndex).join(' ');
    }

    String getImageUrl(int weatherCode) {
      if (weatherCode == 4001) {
        return "assets/images/rainy.png";
      } else if (weatherCode == 1001) {
        return "assets/images/cloudy.png";
      } else {
        return "assets/images/sunny.png";
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Enter city name',
              hintStyle: TextStyle(color: Colors.white),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                onPressed: () => _onSearchSubmitted(_searchController.text),
              ),
            ),
            onSubmitted: _onSearchSubmitted,
          ),
        ),
        LocationSearchBar(
            location_name:
                extractLastFewWords(weatherDetails!.location) ?? 'Bengaluru'),
        Container(
            height: 100,
            child: Image.asset(getImageUrl(weatherDetails!.weatherCode))),
        isLoading
            ? CircularProgressIndicator()
            : weatherDetails != null
                ? RealTimeWeather(
                    humidity: weatherDetails!.humidity ?? 0,
                    wind: weatherDetails!.windSpeed ?? 0.0,
                    temp: weatherDetails!.temperature ?? 0.0,
                    dateTime: weatherDetails!.time ?? DateTime.now(),
                    weatherCode: weatherDetails!.weatherCode ?? 0,
                  )
                : Container(),
        SizedBox(
          height: 5,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ForecastDetailsScreen(location: typed_location.length == 0 ? 'bangalore' : typed_location)),
            );
          },
          child: Text(
            "Forecast Details",
            style: GoogleFonts.roboto(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            minimumSize: Size(0, 50),
          ),
        ),
      ],
    );
  }
}
