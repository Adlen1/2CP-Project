import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'dart:ui';

class DeleteProfilePage extends StatefulWidget {
  final int profileNbr;

  const DeleteProfilePage({Key? key, required this.profileNbr})
    : super(key: key);

  @override
  _DeleteProfilePageState createState() => _DeleteProfilePageState();
}

class _DeleteProfilePageState extends State<DeleteProfilePage>
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

  @override
  void dispose() {
    _fennecController.dispose();
    super.dispose();
  }

  void deleteProfile(int profileNbr, Map<String, dynamic> userData) {
    // Initialize userData

    String profileId = "Profile_$profileNbr";

    userData["Profiles"][profileId] = {
      "firstName": "",
      "lastName": "",
      "age": 0,
      "avatar": "",
      "created": false,
      "lastPlayedRegion": 0 ,
      "lastPlayedAdv" : 0 ,
      "Regions": {
        "region_north": {
          "unlocked": true,
          "unlocks": "region_east",
          "completed": false,
          "landmarks": [false, false, false, false, false, false],

          "adventures": {
            "adventure_1": {
              "alreadyStarted": false,
              "checkPoint": 0,
              "completed": false,
            },
            "adventure_2": {
              "alreadyStarted": false,
              "checkPoint": 0,
              "completed": false,
            },
          },
        },
        "region_east": {
          "unlocked": false,
          "unlocks": "region_west",
          "completed": false,
          "landmarks": [false, false, false, false, false, false],

          "adventures": {
            "adventure_1": {
              "alreadyStarted": false,
              "checkPoint": 0,
              "completed": false,
            },
            "adventure_2": {
              "alreadyStarted": false,
              "checkPoint": 0,
              "completed": false,
            },
          },
        },
        "region_west": {
          "unlocked": false,
          "unlocks": "region_south",
          "completed": false,
          "landmarks": [false, false, false, false, false, false],

          "adventures": {
            "adventure_1": {
              "alreadyStarted": false,
              "checkPoint": 0,
              "completed": false,
            },
            "adventure_2": {
              "alreadyStarted": false,
              "checkPoint": 0,
              "completed": false,
            },
          },
        },
        "region_south": {
          "unlocked": false,
          "unlocks": "",
          "completed": false,
          "landmarks": [false, false, false, false, false, false],

          "adventures": {
            "adventure_1": {
              "alreadyStarted": false,
              "checkPoint": 0,
              "completed": false,
            },
            "adventure_2": {
              "alreadyStarted": false,
              "checkPoint": 0,
              "completed": false,
            },
          },
        },
      },
      "minigames": {
        "Find": [false, false, false, false],
        "Puzzle": [false, false, false, false],
        "Match": [false, false, false, false],
        "Choose": [false, false, false, false],
        "Memory": [false, false, false, false],
        "Spot": [false, false, false, false],

        "FindStar": [0, 0, 0, 0],
        "PuzzleStar": [0, 0, 0, 0],
        "MatchStar": [0, 0, 0, 0],
        "ChooseStar": [0, 0, 0, 0],
        "MemoryStar": [0, 0, 0, 0],
        "SpotStar": [0, 0, 0, 0],
      },
      "Settings": {"masterV": true, "music": true, "narrator": true},
    };
  }

  void _showValidationDialog(BuildContext context, String message) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Deleted",
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
          children: [
            // Blurred Background
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.black.withOpacity(0.4)),
              ),
            ),

            // Dialog Box
            Center(
              child: Material(
                color: Colors.transparent,
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutBack,
                  ),
                  child: Container(
                    width: 320,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 15),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/icons/fennec/sad_fennec_icon.png",
                          height: 80,
                          width: 80,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Profile deleted!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black45, blurRadius: 2),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        SizedBox(height: 20),
                        _buildDialogButton(
                          "OK",
                          Colors.redAccent,
                          () => Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      LoginScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  Widget _buildDialogButton(String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.6),
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset("assets/backgrounds/bg3.jpg", fit: BoxFit.fill),
          ),

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
                      "Are you sure you want to delete your profile?",
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
                  // "Yes" Button
                  ElevatedButton(
                    onPressed: () {
                      final userData =
                          Provider.of<DataProvider>(
                            context,
                            listen: false,
                          ).userData;
                      deleteProfile(widget.profileNbr, userData);
                      _showValidationDialog(
                        context,
                        "Your account has been successfully removed.",
                      );
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
                      backgroundColor: Color(0xFFFE6D73),
                      foregroundColor: Color(0xFF56351E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text("Yes"),
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),

                  // "No" Button
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
