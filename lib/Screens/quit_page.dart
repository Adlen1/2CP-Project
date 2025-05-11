import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';

/// ============================================================================
/// this class simply shows a pop up
/// asking if u want to close the game
///
/// pushed by setting_page.dart
/// ============================================================================
class QuitPage extends StatefulWidget {
  @override
  _QuitPageState createState() => _QuitPageState();
}

class _QuitPageState extends State<QuitPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fennecController;
  late Animation<double> _fennecAnimation;

  @override
  void initState() {
    super.initState();
    _fennecController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _fennecAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(_fennecController);
  }

  void _onFennecTapDown(TapDownDetails details) {
    _fennecController.forward();
  }

  void _onFennecTapUp(TapUpDetails details) {
    _fennecController.reverse();
  }

  void _onFennecTapCancel() {
    _fennecController.reverse();
  }

  void _exitGame() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  @override
  void dispose() {
    _fennecController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset("assets/backgrounds/bg4.jpg", fit: BoxFit.fill),
          ),

          // **Fennec Avatar (Animated)**
          Positioned(
            left: screenWidth * 0.5, // Adjust horizontal position
            top: screenHeight * 0.17, // Adjust vertical position
            child: GestureDetector(
              onTapDown: _onFennecTapDown,
              onTapUp: _onFennecTapUp,
              onTapCancel: _onFennecTapCancel,
              child: AnimatedBuilder(
                animation: _fennecAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _fennecAnimation.value,
                    child: child,
                  );
                },
                child: Image.asset(
                  "assets/icons/fennec/sad_fennec_icon.png",
                  height: screenHeight * 0.6,
                  width: screenWidth * 0.6,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: Offset(-MediaQuery.of(context).size.width * 0.125, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255).withOpacity(1),
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: Color(0xFFFFCB7C), width: 8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Are you sure that you want to quit the game?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Fredoka",
                        color: Color(0xFF56351E),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),

          // **Yes & No Buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.3,
                right: MediaQuery.of(context).size.width * 0.25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // "Yes" Button (Red)
                  ElevatedButton(
                    onPressed: _exitGame,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.07,
                        vertical: MediaQuery.of(context).size.height * 0.02,
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: "Fredoka",
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: Color(0xFFFE6D73),
                      foregroundColor: Color(0xFF56351E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text("Yes"),
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),

                  // "No" Button (Green)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.07,
                        vertical: MediaQuery.of(context).size.height * 0.02,
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: "Fredoka",
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: Color(0xFF53C8C1),
                      foregroundColor: Color(0xFF56351E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text("No"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
