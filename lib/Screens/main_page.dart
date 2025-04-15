import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/Regions_page.dart';
import 'package:project_2cp_eq11/Screens/awards_page.dart';
import 'package:project_2cp_eq11/Screens/settings_page.dart';
import 'package:project_2cp_eq11/Screens/games_page.dart';
import 'package:project_2cp_eq11/Screens/stats_page.dart';
import 'package:project_2cp_eq11/Help/help_page.dart';

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
            screenWidth * 0.473,
            screenHeight * 0.538,
            screenWidth * 0.48,
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
            screenWidth * 0.47,
            screenHeight * 0.078,
            screenWidth * 0.18,
            screenHeight * 0.09,
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
            screenWidth * 0.115,
            screenHeight * 0.258,
            screenWidth * 0.13,
            screenHeight * 0.24,
            () {
              _triggerGlow(
                2,
                onComplete: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => HelpPage(profileNB: widget.profileNbr),
                    ),
                  );
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => RulesPage(
                            profileNbr: widget.profileNbr,
                            quizNbb: 1,
                          ),
                    ),
                  );*/
                },
              );
            },
          ),

          // Stats Button
          buildTransparentButton(
            3,
            screenWidth * 0.118,
            screenHeight * 0.632,
            screenWidth * 0.12,
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
            screenWidth * 0.862,
            screenHeight * 0.245,
            screenWidth * 0.168,
            screenHeight * 0.29,
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
            screenWidth * 0.865,
            screenHeight * 0.625,
            screenWidth * 0.15,
            screenHeight * 0.27,
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
            borderRadius: BorderRadius.circular(10),
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
