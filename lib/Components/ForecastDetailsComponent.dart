import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_application/Scrrens/ForecastDetails.dart';

class ForecastDetailsScreen extends StatelessWidget {
  const ForecastDetailsScreen({super.key, required this.location});
  final String location;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, // Change this color to whatever you desire
          ),
          title: Text(
            'Back',
            style: GoogleFonts.roboto(color: Colors.white),
          ),
          backgroundColor: Color(0xFF47BBE1)),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_weather_app.png'),
                fit: BoxFit.cover)),
        child: Padding(
            padding: EdgeInsets.all(16), child: ForecastDetails(location: location,)),
      ),
    );
  }
}
