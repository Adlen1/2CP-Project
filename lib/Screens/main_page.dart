import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/Regions_page.dart';
import 'package:project_2cp_eq11/Screens/awards_page.dart';
import 'package:project_2cp_eq11/Screens/quiz_results_page.dart';
import 'package:project_2cp_eq11/miniGames/rules_ofMiniGames.dart';
import 'package:project_2cp_eq11/Screens/settings_page.dart';
import 'package:project_2cp_eq11/Screens/games_page.dart';
import 'package:project_2cp_eq11/Screens/stats_page.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';

class MainScreen extends StatefulWidget {
  final int profileNbr;

  const MainScreen({Key? key, required this.profileNbr}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map<int, bool> glowingButtons = {};

  void _triggerGlow(int buttonIndex, {VoidCallback? onComplete}) {
    setState(() {
      glowingButtons[buttonIndex] = true;
    });

    Future.delayed(Duration(milliseconds: 400), () {
      setState(() {
        glowingButtons[buttonIndex] = false;
      });
      if (onComplete != null) onComplete();
    });
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
            child: Image.asset(
              "assets/backgrounds/main_page_bg.jpg",
              fit: BoxFit.fill,
            ),
          ),

          // Story Button
          buildTransparentButton(
            0,
            screenWidth * 0.515,
            screenHeight * 0.535,
            screenWidth * 0.38,
            screenHeight * 0.7,
            () => _triggerGlow(
              0,
              onComplete: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => RegionsPage(profileNbr: widget.profileNbr),
                  ),
                );
              },
            ),
          ),

          // Settings Button
          buildTransparentButton(
            1,
            screenWidth * 0.514,
            screenHeight * 0.075,
            screenWidth * 0.15,
            screenHeight * 0.12,
            () {
              _triggerGlow(
                1,
                onComplete: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              SettingsPage(profileNbr: widget.profileNbr),
                    ),
                  );
                },
              );
            },
          ),

          // Help Button
          buildTransparentButton(
            2,
            screenWidth * 0.233,
            screenHeight * 0.31,
            screenWidth * 0.11,
            screenHeight * 0.3,
            () {
              _triggerGlow(
                2,
                onComplete: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => RulesGamePage(
                            profileNbr: widget.profileNbr,
                            gameNb: 3,
                            levelNb: 4,
                          ),
                    ),
                  );
                },
              );
            },
          ),

          // Stats Button
          buildTransparentButton(
            3,
            screenWidth * 0.237,
            screenHeight * 0.675,
            screenWidth * 0.11,
            screenHeight * 0.24,
            () => _triggerGlow(
              3,
              onComplete: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => StatsPage(profileNbr: widget.profileNbr),
                  ),
                );
              },
            ),
          ),

          // Mini-games Button
          buildTransparentButton(
            4,
            screenWidth * 0.83,
            screenHeight * 0.288,
            screenWidth * 0.155,
            screenHeight * 0.317,
            () {
              _triggerGlow(
                4,
                onComplete: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              MiniGamesPage(profileNbr: widget.profileNbr),
                    ),
                  );
                },
              );
            },
          ),

          // Rewards Button
          buildTransparentButton(
            5,
            screenWidth * 0.838,
            screenHeight * 0.66,
            screenWidth * 0.148,
            screenHeight * 0.309,
            () {
              _triggerGlow(
                5,
                onComplete: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              AwardsPage(profileNbr: widget.profileNbr),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // Function to create a transparent clickable rectangle with a subtle glow effect
  Widget buildTransparentButton(
    int index,
    double left,
    double top,
    double width,
    double height,
    VoidCallback onTap,
  ) {
    return Positioned(
      left: left - (width / 2),
      top: top - (height / 2),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.transparent, // Fully transparent background
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color:
                  glowingButtons[index] == true
                      ? Colors.white.withOpacity(0.1) // Subtle white glow
                      : Colors.transparent,
              width: 4,
            ),
            boxShadow:
                glowingButtons[index] == true
                    ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ]
                    : [],
          ),
        ),
      ),
    );
  }
}
