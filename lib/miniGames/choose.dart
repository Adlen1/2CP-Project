// this the choose game called by the rules and then it calls the results page

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';

class ChooseGame extends StatefulWidget {
  final int profileNb;
  final int level;
  final bool fromAdv;
  const ChooseGame({
    super.key,
    required this.profileNb,
    required this.level,
    required this.fromAdv,
  });

  @override
  State<ChooseGame> createState() => _ChooseGameState();
}

class _ChooseGameState extends State<ChooseGame> {
  double dimention = 100;
  int state = 0; //0 not done; 1 correct; -1 false
  int _seconds = 0;
  Set<int> selectedIndices = {}; // Stores multiple selected indices
  Timer? _timer;
  bool _isCooldown = false;
  final AudioPlayer _sfxPlayer = AudioPlayer();
  final AudioPlayer _completePlayer = AudioPlayer();

  Future<void> _playcompleteSound() async {
    try {
      await _completePlayer.stop();
      await _completePlayer.play(
        AssetSource('audios/minigames/completeGame.mp3'),
      );
    } catch (e) {
      debugPrint('\x1B[33m Error playing sound: $e\x1B[0m');
    }
  }

  Future<void> _playWrongSound() async {
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource('audios/minigames/wrong.mp3'));
    } catch (e) {
      debugPrint('\x1B[33m Error playing sound: $e\x1B[0m');
    }
  }

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

  void updateClick(int index) {
    setState(() {
      if (selectedIndices.contains(index)) {
        selectedIndices.remove(index); // Deselect if already selected
      } else {
        selectedIndices.add(index); // Select if not selected
      }
    });
  }

  Set<int> getCorrectAnswers(int level) {
    switch (level) {
      case 1:
        return {0, 2, 4};
      case 2:
        return {4, 5, 7, 9};
      case 3:
        return {0, 1, 2, 3};
      case 4:
        return {2, 3, 4, 5};
      default:
        return {}; // Empty set for safety
    }
  }

  void checkSelection() async {
    setState(() {
      _isCooldown = true;
    });

    // Cooldown of 4.5 seconds
    Future.delayed(Duration(milliseconds: 4500), () {
      if (mounted) {
        setState(() {
          _isCooldown = false;
        });
      }
    });

    Set<int> correctAnswers = getCorrectAnswers(widget.level);

    if (selectedIndices.length == correctAnswers.length &&
        selectedIndices.containsAll(correctAnswers)) {
      state = 1;
      _stopTimer();

      if (!mounted) return;
      if (GameLogic.sfx(context, widget.profileNb)) _playcompleteSound();
      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => MiniGamesResultsPage(
                  profileNbr: widget.profileNb,
                  level: widget.level,
                  minigameType: "Choose",
                  time: _seconds,
                ),
          ),
        );
      });

      // ✅ After result page is popped, pop ChooseGame to go back to Rules
    } else {
      state = -1;

      if (GameLogic.sfx(context, widget.profileNb)) _playWrongSound();
      await Future.delayed(Duration(seconds: 3));

      if (mounted) {
        setState(() {
          state = 0;
          selectedIndices.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          title: "Back ?",
                          message: "Are you sure you want to go back?",
                          iconPath:
                              "assets/icons/fennec/fennec_settings_icon.png",
                          buttons: [
                            DialogButtonData(
                              text: "Yes",
                              color: Colors.redAccent,
                              onTap: () {
                                if (!widget.fromAdv) {
                                  Navigator.pop(context);

                                  Navigator.pop(context); // Close dialog
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
                              },
                            ),
                            DialogButtonData(
                              text: "No",
                              color: Colors.greenAccent,
                              onTap: () {
                                Navigator.pop(context);
                              }, // Just close dialog
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
                  "choose",
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        updateClick(index);
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                state == 0
                                    ? selectedIndices.contains(index)
                                        ? Color(0xFF56351E)
                                        : Color(0xFFFFCB7C)
                                    : state == -1
                                    ? Color(0xFFEC0B43)
                                    : Color(0xFF53C861),
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(27),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            'assets/images/choose/${widget.level}${index + 1}.png', // Replace with actual image paths
                            width: dimention,
                            height: dimention,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10), // Space between rows
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        updateClick(index + 5);
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                state == 0
                                    ? selectedIndices.contains(index + 5)
                                        ? Color(0xFF56351E)
                                        : Color(0xFFFFCB7C)
                                    : state == -1
                                    ? Color(0xFFEC0B43)
                                    : Color(0xFF53C861),
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(27),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset(
                            'assets/images/choose/${widget.level}${index + 6}.png', // Replace with actual image paths
                            width: dimention,
                            height: dimention,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.02,
              ),
              child: ElevatedButton(
                onPressed: () {
                  _isCooldown ? null : checkSelection();
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF56351E), // Brown background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ), // Fully rounded edges
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 70,
                    vertical: 5,
                  ), // Adjust size
                ),
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    fontFamily: 'Fredoka3', // Use the same font as your app
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
