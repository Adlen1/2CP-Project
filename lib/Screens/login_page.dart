import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Background SVG Image
          Image.asset(
            "assets/backgrounds/login_page.jpg",
            fit: BoxFit.cover, // Make it fit the screen
          ),
        ],
      ),
    );
  }
}
