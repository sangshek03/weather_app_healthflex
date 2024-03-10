import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RealTimeWeather extends StatefulWidget {
  const RealTimeWeather({
    super.key,
    required this.dateTime,
    required this.temp,
    required this.wind,
    required this.humidity,
    required this.weatherCode,
  });

  final DateTime dateTime;
  final double temp;
  final double wind;
  final num humidity;
  final int weatherCode;

  @override
  State<RealTimeWeather> createState() => _RealTimeWeatherState();
}

class _RealTimeWeatherState extends State<RealTimeWeather> {
  String determineWeather(int weatherCode) {
    if (weatherCode == 4001) {
      return "Rainy";
    } else if (weatherCode == 1001) {
      return "Cloudy";
    } else {
      return "Sunny";
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse("2024-03-10T05:35:00Z");

    // Format the date
    String formattedDate = DateFormat.yMMMMd().format(dateTime);

    return Container(
      height: MediaQuery.of(context).size.height / 3.2,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(formattedDate,
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 14)),
            Text('${widget.temp}\u00B0',
                style: GoogleFonts.overpass(color: Colors.white, fontSize: 54)),
            Text(determineWeather(102),
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Wind Speed',
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontSize: 14)),
                  Text('${widget.wind} Km',
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Humidity',
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontSize: 14)),
                  Text('${widget.humidity} Km',
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontSize: 14)),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
