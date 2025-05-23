// this the jigsaw Puzzle game called by the rules and then it calls the results page

import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:audioplayers/audioplayers.dart';

/// ============================================================================
/// jigsaw.dart
/// ============================================================================
///
/// This file defines the puzzle minigame,
/// where players solve a 2*2 jigsaw puzzle
///
/// this is pushed by rules_ofMiniGames.dart
/// and pushes mini_games_result.dart
///
/// ============================================================================

class JigsawPuzzle extends StatefulWidget {
  final int profileNb;
  final int level;
  final bool fromAdv;
  const JigsawPuzzle({
    super.key,
    required this.profileNb,
    required this.level,
    required this.fromAdv,
  });

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
  final AudioPlayer _sfxPlayer = AudioPlayer();
  final AudioPlayer _completePlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    _startTimer();
    _sfxPlayer.setSource(AssetSource('audios/minigames/piece_snap.mp3'));
    Provider.of<DataProvider>(
          context,
          listen: false,
        ).userData["Profiles"]["Profile_${widget.profileNb}"]["minigames"]["Puzzle"][widget
                .level -
            1] =
        true;
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
                          message: "Are you sure you want to go back?",
                          iconPath:
                              "assets/icons/fennec/fennec_settings_icon.png",
                          buttons: [
                            DialogButtonData(
                              text: "Yes",
                              color: Colors.redAccent,
                              onTap: () {
                                if (!widget.fromAdv) {
                                  Navigator.pop(context); // Close dialog
                                  Navigator.pop(context);
                                } else {
                                  GameLogic.decCheckpoint(
                                    context,
                                    widget.profileNb,
                                    widget.level == 1
                                        ? "north"
                                        : widget.level == 2
                                        ? "east"
                                        : widget.level == 3
                                        ? "west"
                                        : "south",
                                    1,
                                  );
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                                // Then go back
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
                  /*
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
                  SizedBox(width: 12),*/
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () async {
                        _stopTimer();

                        await showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Prevent closing by tapping outside the dialog
                          builder: (BuildContext context) {
                            return PauseDialog(
                              profileNbr: widget.profileNb,
                            ); // This will display the PauseDialog
                          },
                        );

                        _startTimer();
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
                                "assets/images/jigsaw/${widget.level}fullImage.png", // Replace with your image path
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
                              onDragEnd: (details) {
                                final isPlaced = part[index];
                                if (!isPlaced &&
                                    GameLogic.sfx(context, widget.profileNb)) {
                                  _sfxPlayer.stop();
                                  _sfxPlayer.play(
                                    AssetSource(
                                      'audios/minigames/puzzle-error.mp3',
                                    ),
                                    volume: 0.4,
                                  );
                                }
                              },
                              feedback: SizedBox(
                                width: 130,
                                height: 130,
                                child: Image.asset(
                                  "assets/images/jigsaw/${widget.level}part${index + 1}.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              childWhenDragging: Opacity(
                                opacity: 0.0,
                                child: SizedBox(
                                  width: 130,
                                  height: 130,
                                  child: Image.asset(
                                    "assets/images/jigsaw/${widget.level}part${index + 1}.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              child: SizedBox(
                                width: 130,
                                height: 130,
                                child: Image.asset(
                                  "assets/images/jigsaw/${widget.level}part${index + 1}.png",
                                  fit: BoxFit.contain,
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
      alignment: alignment,
      child: DragTarget<int>(
        onWillAcceptWithDetails: (details) {
          return details.data == index;
        },
        onAcceptWithDetails: (details) {
          setState(() {
            part[details.data] = true;

            if (GameLogic.sfx(context, widget.profileNb)) {
              _sfxPlayer.stop();
              _sfxPlayer.play(
                volume: 0.4,
                AssetSource('audios/minigames/piece_snap.mp3'),
              );
            }

            if (!part.contains(false)) {
              _stopTimer();
              if (GameLogic.sfx(context, widget.profileNb))
                _completePlayer.play(
                  volume: 0.5,
                  AssetSource('audios/minigames/completeGame.mp3'),
                );
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
                );
              });
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
