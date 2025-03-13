import 'package:flutter/material.dart';


class select_profile_page extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background SVG Image
          Image.asset(
            "assets/backgrounds/login_page.jpg",
            fit: BoxFit.cover,
          ),
          Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(), // Makes it circular
        padding: EdgeInsets.all(16),
      ),
      onPressed: () {
        print("Button Pressed");
      },
      child: Icon(Icons.home, size: 40),
    ),
    SizedBox(height: 4),
    Text(
      "Home",
      style: TextStyle(fontSize: 16),
    ),
  ],
),
        ],
      ),
    );
  }

} 