import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';

class PpickTrash extends StatefulWidget {
  final int profileNb;
  const PpickTrash({Key? key, required this.profileNb}) : super(key: key);

  @override
  _PpickTrashState createState() => _PpickTrashState();
}

class _PpickTrashState extends State<PpickTrash> {
  List<bool> _showIcons = List.filled(3, false);

  void _handleTap(int index) {
    // Allow tap only if no buttons have been tapped yet
    if (!(_showIcons.contains(false))) return;

    setState(() {
      _showIcons[index] = true;
    });
    if (!(_showIcons.contains(false))) {
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final positionsPercent = [
      Offset(0.375, 0.07),
      Offset(0.21, 0.74),
      Offset(0.84, 0.7),
    ];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/backgrounds/region3/adventure2/trash.jpg",
              fit: BoxFit.fill,
            ),
          ),
          ...List.generate(3, (index) {
            final pos = positionsPercent[index];
            final dx = screenWidth * pos.dx;
            final dy = screenHeight * pos.dy;
            final double checkSize =
                index == 0
                    ? screenWidth * 0.044
                    : index == 1
                    ? screenWidth * 0.07
                    : screenWidth * 0.044;
            final containerSize =
                index == 0
                    ? screenWidth * 0.07
                    : index == 1
                    ? screenWidth * 0.1
                    : screenWidth * 0.07;
            return Positioned(
              left: dx,
              top: dy,
              child: GestureDetector(
                onTap: () => _handleTap(index),
                child: Container(
                  width: containerSize,
                  height: containerSize,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child:
                      _showIcons[index]
                          ? Image.asset(
                            'assets/icons/region1/adventure1/check_icon.png',
                            width: checkSize,
                            height: checkSize,
                          )
                          : null,
                ),
              ),
            );
          }),

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
                      !_showIcons.contains(false)
                          ? Colors.green
                          : const Color(0xFFFFCB7C),
                  width: 4,
                ),
              ),
              child: Center(
                child: Text(
                  "Collect the trash",
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
                  // Pause Button
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Prevent closing by tapping outside the dialog
                          builder: (BuildContext context) {
                            return PauseDialog(
                              profileNbr: widget.profileNb,
                            ); // This will display the PauseDialog
                          },
                        );
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
