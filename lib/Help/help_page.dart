import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Help/firstSteps.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  final int profileNB;
  const HelpPage({Key? key, required this.profileNB}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  Future<void> _adjustVolume(double volume) async {
    await MusicController().setVolume(volume);
  }

  void _showValidationDialog(BuildContext context, String message) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Open link",
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
                          "assets/icons/fennec/helpFennec.png",
                          height: 80,
                          width: 80,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Open Link",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildDialogButton(
                              "OK",
                              Colors.greenAccent,
                              () => openPdfLink(
                                "https://docs.google.com/document/d/1SrVzgT56aRU2mCN02DYzmdzQvXHlpqpkRwhymSoTK3k/edit?tab=t.0",
                              ),
                            ),
                            _buildDialogButton(
                              "cancel",
                              Colors.redAccent,
                              () => Navigator.of(context).pop(),
                            ),
                          ],
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

  void openPdfLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
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
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: Colors.white),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 8, left: 16, right: 16),
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
                        Navigator.of(context).pop();
                      },
                      child: Ink.image(
                        image: AssetImage("assets/icons/back_icon.png"),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "HELP",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 42),
                    Material(
                      borderRadius: BorderRadius.circular(32),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32),
                          onTap: () {
                            _showValidationDialog(
                              context,
                              "Are you sure you want to open the link to the doc?",
                            );
                          },
                          child: Ink.image(
                            image: AssetImage(
                              "assets/images/Help/bookButton.png",
                            ),
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "read more",
                      style: TextStyle(
                        fontFamily: "Fredoka",
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                        color: Color(0xFF56351E),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 42),
                    Material(
                      borderRadius: BorderRadius.circular(32),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32),
                          onTap: () {
                            _adjustVolume(0.2);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => FirstSteps(
                                      profileNbr: widget.profileNB,
                                    ),
                              ),
                            ).then((_) {
                              _adjustVolume(0.4);
                            });
                          },
                          child: Ink.image(
                            image: AssetImage(
                              "assets/images/Help/stepsButton.png",
                            ),
                            height: 140,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "first steps",
                      style: TextStyle(
                        fontFamily: "Fredoka",
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                        color: Color(0xFF56351E),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
