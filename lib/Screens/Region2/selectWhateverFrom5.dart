import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';

/// ============================================================================
///
/// defines a simple event choosing a element from 5
/// where all choices are correct
/// called by the adventures
///
/// ============================================================================

class SelectFrom5 extends StatefulWidget {
  final String bg;
  final List<String> items;
  final double imgWidth;
  final double imgHeight;
  final String text;
  final double checkTop;
  final double checkRight;

  const SelectFrom5({
    Key? key,
    required this.bg,
    required this.items,
    required this.imgWidth,
    required this.imgHeight,
    required this.text,
    this.checkTop = 0.06,
    this.checkRight = 0,
  }) : super(key: key);

  @override
  _SelectFrom5State createState() => _SelectFrom5State();
}

class _SelectFrom5State extends State<SelectFrom5> {
  bool isAnswered = false; // Vérifie si l'utilisateur a déjà répondu
  List<bool> _showIcons = List.filled(5, false);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(child: Image.asset(widget.bg, fit: BoxFit.fill)),

          // Zone contenant les choix d'items
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.2,
            right: screenWidth * 0.2,
            child: Container(
              width: screenWidth * 0.5,
              height: screenHeight * 0.65,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                  0.8,
                ), // Fond blanc semi-transparent
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      _showIcons.contains(true)
                          ? Colors.green
                          : const Color(0xFFFFCB7C),
                  width: 4,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(2, (index) {
                      return GestureDetector(
                        onTap: () {
                          if (!_showIcons.contains(true)) {
                            setState(() {
                              _showIcons[index] = true;
                            });

                            // Attendre 2 secondes avant de revenir en arrière
                            Future.delayed(Duration(seconds: 2), () {
                              if (mounted) {
                                Navigator.pop(context);
                              }
                            });
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              child: Image.asset(
                                widget.items[index],
                                width: screenWidth * widget.imgWidth,
                                height: screenHeight * widget.imgHeight,
                                fit: BoxFit.contain,
                              ),
                            ),

                            if (_showIcons[index] == true)
                              Positioned(
                                top: screenHeight * widget.checkTop,
                                right: screenWidth * widget.checkRight,
                                child: Image.asset(
                                  "assets/icons/region1/adventure1/check_icon.png",
                                  width: screenWidth * 0.15,
                                  height: screenHeight * 0.15,
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return GestureDetector(
                        onTap: () {
                          if (!_showIcons.contains(true)) {
                            setState(() {
                              _showIcons[index + 2] = true;
                            });

                            // Attendre 2 secondes avant de revenir en arrière
                            Future.delayed(Duration(seconds: 2), () {
                              if (mounted) {
                                Navigator.pop(context);
                              }
                            });
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Image de l'item
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              child: Image.asset(
                                widget.items[index + 2],
                                width: screenWidth * widget.imgWidth,
                                height: screenHeight * widget.imgHeight,
                                fit: BoxFit.contain,
                              ),
                            ),

                            // Coche verte sur la bonne réponse
                            if (_showIcons[index + 2] == true)
                              Positioned(
                                top: screenHeight * widget.checkTop,
                                right: screenWidth * widget.checkRight,
                                child: Image.asset(
                                  "assets/icons/region1/adventure1/check_icon.png",
                                  width: screenWidth * 0.15,
                                  height: screenHeight * 0.15,
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left: screenWidth * 0.35,
            top: screenHeight * 0.82,
            child: Container(
              width: screenWidth * 0.3,
              height: screenHeight * 0.15,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color:
                      _showIcons.contains(true)
                          ? Colors.green
                          : const Color(0xFFFFCB7C),
                  width: 4,
                ),
              ),
              child: Center(
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.02,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Fredoka",
                    color: const Color(0xFF56351E),
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenWidth * 0.02,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Back Button with Confirmation Dialog
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        ValidationDialog.show(
                          context: context,
                          title: "Back to Main Menu?",
                          message: "Are you sure you want to go back?",
                          iconPath:
                              "assets/icons/fennec/fennec_settings_icon.png",
                          buttons: [
                            DialogButtonData(
                              text: "Yes",
                              color: Colors.redAccent,
                              onTap: () {
                                Navigator.pop(context); // Close dialog
                                Navigator.pop(context); // Go back
                                Navigator.pop(context);
                              },
                            ),
                            DialogButtonData(
                              text: "No",
                              color: Colors.greenAccent,
                              onTap:
                                  () => Navigator.pop(
                                    context,
                                  ), // Just close dialog
                            ),
                          ],
                        );
                      },
                      child: Ink.image(
                        image: AssetImage("assets/icons/back_icon.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01), // Spacing
                  // Question Button
                  /*Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Ink.image(
                        image: AssetImage("assets/icons/question_icon.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),*/
                  // SizedBox(width: screenWidth * 0.01), // Spacing
                  // Pause Button
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Ink.image(
                        image: AssetImage("assets/icons/pause_icon.png"),
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
        ],
      ),
    );
  }
}
