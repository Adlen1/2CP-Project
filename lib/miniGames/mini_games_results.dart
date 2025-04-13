import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';
import 'dart:ui';

class MiniGamesResultsPage extends StatefulWidget {
  final int profileNbr;
  final String minigameType;
  final int time;
  final int level;

  const MiniGamesResultsPage({
    Key? key,
    required this.profileNbr,
    required this.minigameType,
    required this.time,
    required this.level,
  }) : super(key: key);

  @override
  _MiniGamesResultsPageState createState() => _MiniGamesResultsPageState();
}

class _MiniGamesResultsPageState extends State<MiniGamesResultsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fennecController;
  late Animation<double> _fennecAnimation;
  late String imgPath = "assets/icons/mini_games_results_page/0stars.png";

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
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    int age =
        int.tryParse(
          userData['Profiles']['Profile_${widget.profileNbr}']['age']
              .toString(),
        ) ??
        0;
    int stars = 0;

    if (age < 6) {
      if (widget.time < 60) {
        imgPath = "assets/icons/mini_games_results_page/3stars.png";
        stars = 3;
      } else if (widget.time < 120) {
        imgPath = "assets/icons/mini_games_results_page/2stars.png";
        stars = 2;
      } else if (widget.time < 180) {
        imgPath = "assets/icons/mini_games_results_page/1star.png";
        stars = 1;
      }
    } else {
      if (widget.time < 30) {
        imgPath = "assets/icons/mini_games_results_page/3stars.png";
        stars = 3;
      } else if (widget.time < 60) {
        imgPath = "assets/icons/mini_games_results_page/2stars.png";
        stars = 2;
      } else if (widget.time < 90) {
        imgPath = "assets/icons/mini_games_results_page/1star.png";
        stars = 1;
      }
    }
    userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][widget
                .level -
            1] =
        stars;
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

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}'; // ✅ Format as mm:ss
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
            child: Image.asset("assets/backgrounds/bg5.jpg", fit: BoxFit.fill),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenWidth * 0.02,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        Navigator.pop(context);
                      },

                      child: Ink.image(
                        image: AssetImage("assets/icons/back_icon.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left: -screenWidth * 0.15,
            top: screenHeight * 0.15,
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
                  "assets/icons/fennec/happy_fennec_icon.png",
                  height: screenHeight * 0.65,
                  width: screenWidth * 0.65,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "RESULTS",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: Offset(
                MediaQuery.of(context).size.width * 0.15,
                -MediaQuery.of(context).size.height * 0.02,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.55,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255).withOpacity(1),
                  borderRadius: BorderRadius.circular(30),
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
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.28,
                      ), // Décale vers le haut
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Total time  ${_formatTime(widget.time)}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Fredoka",
                            color: Color(0xFF56351E),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.25,
              left: screenWidth * 0.52,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                imgPath,
                width: screenWidth * 0.28,
                height: screenHeight * 0.28,
                fit: BoxFit.cover,
              ),
            ),
          ),

          AnimatedGameButton(
            "assets/icons/mini_games_results_page/next_button.png",
            screenWidth * 0.2,
            screenHeight * 0.2,
            screenWidth * 0.4,
            screenHeight * 0.8,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class DialogButtonData {
  final String text;
  final Color color;
  final VoidCallback onTap;

  DialogButtonData({
    required this.text,
    required this.color,
    required this.onTap,
  });
}

class ValidationDialog {
  static Future<String?> show({
    required BuildContext context,
    required String title,
    required String message,
    required String iconPath,
    required List<DialogButtonData> buttons,
  }) async {
    // Return a Future to handle the result from Navigator.pop
    return await showGeneralDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Error",
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
                        Image.asset(iconPath, height: 80, width: 80),
                        SizedBox(height: 15),
                        Text(
                          title,
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
                        // Buttons in one row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:
                              buttons.map((button) {
                                return _buildDialogButton(button, context);
                              }).toList(),
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

  static Widget _buildDialogButton(
    DialogButtonData button,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        button.onTap();
        // Close the dialog after tapping
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: button.color.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
              color: button.color.withOpacity(0.6),
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Text(
          button.text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
