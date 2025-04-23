import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';

class SelectJewel extends StatefulWidget {
  final String bg;

  const SelectJewel({Key? key, required this.bg}) : super(key: key);

  @override
  _SelectJewelState createState() => _SelectJewelState();
}

class _SelectJewelState extends State<SelectJewel> {
  List<bool> _showIcons = List.filled(7, false);

  void _handleTap(int index) {
    // Allow tap only if no buttons have been tapped yet
    if (_showIcons.contains(true)) return;

    setState(() {
      _showIcons[index] = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final positionsPercent = [
      Offset(0.1, 0.1),
      Offset(0.39, 0.087),
      Offset(0.62, 0.11),
      Offset(0.96, 0.17),
      Offset(0.17, 0.5),
      Offset(0.52, 0.52),
      Offset(0.87, 0.51),
    ];

    double containerWidth = screenWidth * 0.5;
    double containerHeight = screenHeight * 0.67;
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: containerWidth,
                  height: containerHeight,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/jewels.png'),
                      fit: BoxFit.fill,
                    ),
                    border: Border.all(
                      color:
                          _showIcons.contains(true)
                              ? Colors.green
                              : const Color(0xFFFFCB7C),
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(44),
                  ),
                  child: Stack(
                    children: List.generate(7, (index) {
                      final pos = positionsPercent[index];
                      final dx = containerWidth * pos.dx;
                      final dy = containerHeight * pos.dy;

                      return Positioned(
                        left: dx,
                        top: dy,
                        child: GestureDetector(
                          onTap: () => _handleTap(index),
                          child: Container(
                            width: screenWidth * 0.07,
                            height: screenWidth * 0.07,
                            color: Colors.transparent,
                            child:
                                _showIcons[index]
                                    ? Image.asset(
                                      'assets/icons/region1/adventure1/check_icon.png',
                                      width: screenWidth * 0.07,
                                      height: screenWidth * 0.07,
                                    )
                                    : null,
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
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
                  "Choose a piece of jewelry",
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
