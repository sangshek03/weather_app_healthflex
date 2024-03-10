import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_application/Scrrens/PopupError.dart';

class ForecastDetails extends StatefulWidget {
  const ForecastDetails({super.key, required this.location});
  final String location;

  @override
  State<ForecastDetails> createState() => _ForecastDetailsState();
}

class _ForecastDetailsState extends State<ForecastDetails> {
  late List<dynamic>? dailyData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchForecastData();
  }

  Future<void> fetchForecastData() async {
    setState(() {
      isLoading = true;
    });

    String location_name = widget.location;
    String apiKey = 'gRqAgFXNhE61KclNYT8FBHHT0K1149rB';

    final response = await http.get(
        Uri.parse(
            'https://api.tomorrow.io/v4/weather/forecast?location=$location_name&apikey=$apiKey'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        dailyData = data['timelines']['daily'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      showErrorDialog(context, "Failed to load weather data, Please Try Again Later");
      throw Exception('Failed to load forecast data');
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate(String date) {
      DateTime dateTime = DateTime.parse(date);
      String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
      return formattedDate;
    }

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Forecast Details of 5 Days",
                style: GoogleFonts.overpass(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              isLoading
                  ? const Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ))
                  : Container(
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: ListView.builder(
                          itemCount: dailyData == null ? 0 : 5,
                          itemBuilder: (context, idx) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 110,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Date',
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          formattedDate(
                                              dailyData![idx]['time']),
                                          style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    // humidityAvg,
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Humidity',
                                          style: GoogleFonts.roboto(
                                              fontSize: 18,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${dailyData![idx]['values']['humidityAvg']}',
                                          style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Temperature',
                                          style: GoogleFonts.roboto(
                                              color: Colors.blue,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${dailyData![idx]['values']['temperatureAvg']}\u00B0',
                                          style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
