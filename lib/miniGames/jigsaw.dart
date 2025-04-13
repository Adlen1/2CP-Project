import 'package:flutter/material.dart';
import 'dart:math';
import 'package:project_2cp_eq11/Screens/quiz_results_page.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/logic.dart';

class JigsawPuzzle extends StatefulWidget {
  final int profileNb;
  final int level;
  const JigsawPuzzle({super.key, required this.profileNb, required this.level});

  @override
  State<JigsawPuzzle> createState() => _JigsawPuzzleState();
}

class _JigsawPuzzleState extends State<JigsawPuzzle> {
  int _seconds = 0;
  Timer? _timer;

  List<bool> part = List.generate(4, (index) => false);
  List<Offset> piecePositions = [
    Offset(50, 500), // Initial draggable positions
    Offset(150, 500),
    Offset(250, 500),
    Offset(350, 500),
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final int age = int.parse(
      Provider.of<DataProvider>(
        context,
      ).userData['Profiles']["Profile_${widget.profileNb}"]["age"],
    );
    double containerSize = 220;
    double pieceSize = containerSize / 2;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset("assets/backgrounds/bg5.jpg", fit: BoxFit.fill),
          ),

          // Back Button
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Row(
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        ValidationDialog.show(
                          context: context,
                          title: "Back to Main Menu?",
                          message:
                              "Are you sure you want to go back? Your progress will be lost.",
                          iconPath:
                              "assets/icons/fennec/fennec_settings_icon.png",
                          buttons: [
                            DialogButtonData(
                              text: "Yes",
                              color: Colors.redAccent,
                              onTap: () {
                                Navigator.pop(context); // Close dialog
                                Navigator.pop(context); // Then go back
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
                        image: const AssetImage("assets/icons/back_icon.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),

                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        //to add
                      },
                      child: Ink.image(
                        image: const AssetImage("assets/icons/help_icon.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        //to add
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
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "PUZZLE",
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
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.04,
                right: MediaQuery.of(context).size.width * 0.03,
              ),
              child: Container(
                // ✅ Replace SizedBox with Container
                decoration: BoxDecoration(
                  color: Color(0xFF56351E), // ✅ Background color
                  borderRadius: BorderRadius.circular(20), // ✅ Rounded edges
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 5,
                ), // ✅ Add padding inside container
                child: Text(
                  GameLogic.formatTime(_seconds),
                  style: TextStyle(
                    fontFamily: 'Fredoka3',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // ✅ White text
                  ),
                ),
              ),
            ),
          ),
          // Match Cards Game Content
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(
                        0xFFFFCB7C,
                      ), // Black border around the whole container
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(
                      24,
                    ), // Rounded corners for the whole container
                  ),
                  child: ClipRRect(
                    // Clip content inside the border radius
                    borderRadius: BorderRadius.circular(
                      20,
                    ), // Slightly smaller to fit inside the outer border
                    child: SizedBox(
                      width: 220, // Adjust size
                      height: 220,
                      child: Stack(
                        children: [
                          // Background image
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                "assets/images/jigsaw/1fullImage.png", // Replace with your image path
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          // Semi-transparent overlay
                          Positioned.fill(
                            child: Container(
                              color: Colors.white.withOpacity(
                                (age < 7) ? 0.5 : 1,
                              ), // Adjust transparency
                            ),
                          ),
                          part[3]
                              ? Padding(
                                padding: const EdgeInsets.all(4),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    height: 220,
                                    width: 220,
                                    child: Image.asset(
                                      "assets/images/jigsaw/${widget.level}paart4.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              )
                              : const SizedBox.shrink(),

                          // Top-left piece
                          part[0]
                              ? Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    height: 220,
                                    width: 220,
                                    child: Image.asset(
                                      "assets/images/jigsaw/${widget.level}paart1.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              )
                              : const SizedBox.shrink(),

                          // Top-right piece
                          part[1]
                              ? Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    height: 220,
                                    width: 220,
                                    child: Image.asset(
                                      "assets/images/jigsaw/${widget.level}paart2.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              )
                              : const SizedBox.shrink(),

                          // Bottom-left piece
                          part[2]
                              ? Padding(
                                padding: const EdgeInsets.all(4),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: SizedBox(
                                    height: 220,
                                    width: 220,
                                    child: Image.asset(
                                      "assets/images/jigsaw/${widget.level}paart3.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              )
                              : const SizedBox.shrink(),

                          // Bottom-right piece
                          _buildDragTarget(0, Alignment.topLeft, pieceSize),
                          _buildDragTarget(1, Alignment.topRight, pieceSize),
                          _buildDragTarget(2, Alignment.bottomLeft, pieceSize),
                          _buildDragTarget(3, Alignment.bottomRight, pieceSize),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 25),
                Container(
                  width: 350, // Adjust width
                  height: 240, // Adjust height
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    border: Border.all(
                      color: Color(0xFFFFCB7C),
                      width: 4,
                    ), // Black border
                    borderRadius: BorderRadius.circular(24), // Rounded corners
                  ),
                  child: Stack(
                    children: List.generate(4, (index) {
                      return part[index] //  If part is true, don't render the piece
                          ? SizedBox.shrink() //  Hide the piece if placed
                          : Positioned(
                            left:
                                index == 0
                                    ? 20
                                    : index == 1
                                    ? 50
                                    : index == 2
                                    ? 200
                                    : 200, // // Adjust starting positions
                            top:
                                index == 0
                                    ? 100
                                    : index == 1
                                    ? 10
                                    : index == 2
                                    ? 100
                                    : 10, // Center inside the container
                            child: Draggable<int>(
                              data: index,
                              feedback: SizedBox(
                                width: 130,
                                height: 130,
                                child: Image.asset(
                                  "assets/images/jigsaw/${widget.level}part${index + 1}.png",
                                  fit:
                                      BoxFit
                                          .contain, // Ensures all images are the same size
                                ),
                              ),
                              childWhenDragging: Opacity(
                                opacity: 0.0,
                                child: SizedBox(
                                  width: 130,
                                  height: 130,
                                  child: Image.asset(
                                    "assets/images/jigsaw/${widget.level}part${index + 1}.png",
                                    fit:
                                        BoxFit
                                            .contain, // Ensures all images are the same size
                                  ),
                                ),
                              ),
                              child: SizedBox(
                                width: 130,
                                height: 130,
                                child: Image.asset(
                                  "assets/images/jigsaw/${widget.level}part${index + 1}.png",
                                  fit:
                                      BoxFit
                                          .contain, // Ensures all images are the same size
                                ),
                              ),
                            ),
                          );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragTarget(int index, Alignment alignment, double size) {
    return Align(
      alignment: alignment, // ✅ Correct usage
      child: DragTarget<int>(
        onWillAcceptWithDetails: (details) {
          return details.data == index; // ✅ Correct piece only
        },
        onAcceptWithDetails: (details) {
          setState(() {
            part[details.data] = true; // Mark piece as placed

            // Check if all parts are placed
            if (!part.contains(false)) {
              _stopTimer(); // Stop the timer

              Future.delayed(Duration(seconds: 3), () {
    Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => MiniGamesResultsPage(
                          profileNbr: widget.profileNb,
                          level: widget.level,
                          minigameType: "Puzzle",
                          time: _seconds,
                        ),
              ),
            );});

              
            }
          });
        },
        builder: (context, candidateData, rejectedData) {
          return Container(
            width: size,
            height: size,
            color: Colors.transparent,
          );
        },
      ),
    );
  }
}
