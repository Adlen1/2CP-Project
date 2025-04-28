import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';

class PickAll extends StatefulWidget {
  final String bg;
  final List<String> items;
  final double imgWidth;
  final double imgHeight;
  final String text;
  final int profileNb;
  final List<int> correctIndexes;
  final double checkTop;
  final double checkRight;

  const PickAll({
    Key? key,
    required this.bg,
    required this.items,
    required this.imgWidth,
    required this.imgHeight,
    required this.text,
    required this.correctIndexes,
    required this.profileNb,
    this.checkTop = 0.15,
    this.checkRight = 0.02,
  }) : super(key: key);

  @override
  _PickAllState createState() => _PickAllState();
}

class _PickAllState extends State<PickAll> {
  Set<int> selectedIndexes = {}; // Store all selected indexes
  bool isCompleted = false; // Whether the user has answered

  void _finishSelection() {
    setState(() {
      isCompleted = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pop(context);
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
          // Background
          Positioned.fill(child: Image.asset(widget.bg, fit: BoxFit.fill)),

          // Items
          Positioned(
            top: screenHeight * 0.2,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFFFCB7C), // Always yellow border
                  width: 4,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(widget.items.length, (index) {
                  bool isSelected = selectedIndexes.contains(index);
                  bool isCorrect = widget.correctIndexes.contains(index);

                  return GestureDetector(
                    onTap: () {
                      if (!isCompleted) {
                        setState(() {
                          selectedIndexes.add(index);
                        });
                        if (widget.correctIndexes.every(
                          (element) => selectedIndexes.contains(element),
                        )) {
                          _finishSelection();
                        }
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          child: Image.asset(
                            widget.items[index],
                            width: screenWidth * widget.imgWidth,
                            height: screenHeight * widget.imgHeight,
                            fit: BoxFit.contain,
                          ),
                        ),

                        // Show check or wrong mark after selection
                        if (isSelected)
                          Positioned(
                            top: screenHeight * widget.checkTop,
                            right: screenWidth * widget.checkRight,
                            child: Image.asset(
                              isCorrect
                                  ? "assets/icons/region1/adventure1/check_icon.png"
                                  : "assets/icons/region1/adventure1/wrong_icon.png",
                              width: screenWidth * 0.15,
                              height: screenHeight * 0.15,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),

          // Text Box
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
                  color: const Color(0xFFFFCB7C), // Always yellow border
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

          // Top buttons (Back + Pause)
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
                  // BACK
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
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                            DialogButtonData(
                              text: "No",
                              color: Colors.greenAccent,
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      },
                      child: Ink.image(
                        image: const AssetImage("assets/icons/back_icon.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  // PAUSE
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return PauseDialog(profileNbr: widget.profileNb);
                          },
                        );
                      },
                      child: Ink.image(
                        image: const AssetImage("assets/icons/pause_icon.png"),
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
