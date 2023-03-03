import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class intro_screen extends StatelessWidget {
  const intro_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      body: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "WAA",
            style: GoogleFonts.abrilFatface(
              color: Colors.green.shade900,
              fontSize: 50.0,
            ),
          ),
          Text(
            "PUSHA",
            style: GoogleFonts.abrilFatface(
              color: Colors.white,
              fontSize: 50,
            ),
          ),
        ]),
      ),
    );
  }
}
