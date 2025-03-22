import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

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
      "Regions": {
        "region_north": {
          "unlocked": true,
          "unlocks": "region_east",
          "completed": false,
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
        "Search": [false, false, false, false],
        "Puzzle": [false, false, false, false],
        "Color": [false, false, false, false],
        "Play": [false, false, false, false],
        "Memory": [false, false, false, false],
        "Spot": [false, false, false, false],
      },
      "Settings": {"masterV": true, "music": true, "narrator": true},
    };
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset("assets/backgrounds/bg3.jpg", fit: BoxFit.cover),
          ),

          Positioned(
            left: screenWidth * 0.48,
            top: screenHeight * 0.12,
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
                  "assets/icons/sad_fennec_icon.png",
                  height: screenHeight * 0.65,
                  width: screenWidth * 0.65,
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
                width: MediaQuery.of(context).size.width * 0.48,
                height: MediaQuery.of(context).size.height * 0.5,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFCB7C),
                  borderRadius: BorderRadius.circular(15),
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
                bottom: MediaQuery.of(context).size.height * 0.28,
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
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  LoginScreen(),
                        ),
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
                        borderRadius: BorderRadius.circular(12),
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
                        borderRadius: BorderRadius.circular(12),
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
