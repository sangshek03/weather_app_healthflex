import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationSearchBar extends StatelessWidget {
  const LocationSearchBar({required this.location_name});
  final String location_name;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.location_on,
              size: 24, color: Color.fromARGB(255, 255, 255, 255)),
          const SizedBox(width: 5.0),
          Expanded(
            child: Text(
              location_name,
              style: GoogleFonts.overpass(color: Colors.white, fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
