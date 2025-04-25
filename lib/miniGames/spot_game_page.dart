import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class SpotGamePage extends StatefulWidget {
  final int profileNbr;
  final int selectedLevel;
  final bool fromAdv;
  SpotGamePage({
    required this.profileNbr,
    required this.selectedLevel,
    required this.fromAdv,
  });

  @override
  _SpotGamePageState createState() => _SpotGamePageState();
}

class _SpotGamePageState extends State<SpotGamePage>
    with TickerProviderStateMixin {
  late List<String> ImagesPaths;
  late Map<String, dynamic> currentLevelData;
  late int age;
  int _seconds = 0;
  Timer? _timer;
  Set<int> _tappedButtons = {};
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

  Future<void> _playcorrectSound() async {
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(
        volume: 85,
        AssetSource('audios/minigames/correct.mp3'),
      );
    } catch (e) {
      debugPrint('\x1B[33m Error playing sound: $e\x1B[0m');
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(
          context,
        ).userData["Profiles"]["Profile_${widget.profileNbr}"]["minigames"]["Puzzle"]["${widget.selectedLevel - 1}"] =
        true;
    // Fetch age from Provider
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    age =
        int.tryParse(
          userData['Profiles']['Profile_${widget.profileNbr}']['age']
              .toString(),
        ) ??
        0;

    // Load level data based on age
    final levelData = getLevelData(age);
    currentLevelData = levelData[widget.selectedLevel] ?? {};

    ImagesPaths = List<String>.from(currentLevelData["images"] ?? []);

    _startTimer();
  }

  Map<int, Map<String, dynamic>> getLevelData(int age) {
    int buttonCount = (age < 6) ? 3 : 5;

    List<Map<String, dynamic>> buttonPositions1 = [
      {"width": 0.2, "height": 0.1, "top": 0.06, "left": 0.07},
      {"width": 0.18, "height": 0.12, "top": 0.24, "left": 0.65},
      {"width": 0.22, "height": 0.14, "top": 0.75, "left": 0.7},
      {"width": 0.1, "height": 0.2, "top": 0.58, "left": 0.42},
      {"width": 0.03, "height": 0.15, "top": 0.05, "left": 0.44},
    ];

    List<Map<String, dynamic>> buttonPositions2 = [
      {"width": 0.15, "height": 0.18, "top": 0.12, "left": 0.32},
      {"width": 0.12, "height": 0.22, "top": 0.6, "left": 0.45},
      {"width": 0.12, "height": 0.22, "top": 0.4, "left": 0.7},
      {"width": 0.2, "height": 0.12, "top": 0.03, "left": 0.6},
      {"width": 0.12, "height": 0.12, "top": 0.03, "left": 0.08},
    ];

    List<Map<String, dynamic>> buttonPositions3 = [
      {"width": 0.2, "height": 0.1, "top": 0.06, "left": 0.07},
      {"width": 0.18, "height": 0.12, "top": 0.24, "left": 0.65},
      {"width": 0.22, "height": 0.14, "top": 0.75, "left": 0.7},
      {"width": 0.1, "height": 0.2, "top": 0.58, "left": 0.42},
      {"width": 0.03, "height": 0.15, "top": 0.05, "left": 0.44},
    ];

    List<Map<String, dynamic>> buttonPositions4 = [
      {"width": 0.2, "height": 0.1, "top": 0.06, "left": 0.07},
      {"width": 0.18, "height": 0.12, "top": 0.24, "left": 0.65},
      {"width": 0.22, "height": 0.14, "top": 0.75, "left": 0.7},
      {"width": 0.1, "height": 0.2, "top": 0.58, "left": 0.42},
      {"width": 0.03, "height": 0.15, "top": 0.05, "left": 0.44},
    ];

    return {
      1: {
        "images":
            (age < 6)
                ? [
                  "assets/images/spot_game_page/img1_original.png",
                  "assets/images/spot_game_page/img1_small.png",
                ]
                : [
                  "assets/images/spot_game_page/img1_original.png",
                  "assets/images/spot_game_page/img1_big.png",
                ],
        "buttons": buttonPositions1.sublist(
          0,
          buttonCount,
        ), // Prend 3 ou 5 boutons
      },
      2: {
        "images":
            (age < 6)
                ? [
                  "assets/images/spot_game_page/img2_original.png",
                  "assets/images/spot_game_page/img2_small.png",
                ]
                : [
                  "assets/images/spot_game_page/img2_original.png",
                  "assets/images/spot_game_page/img2_big.png",
                ],
        "buttons": buttonPositions2.sublist(
          0,
          buttonCount,
        ), // Prend 3 ou 5 boutons
      },
      3: {
        "images":
            (age < 6)
                ? [
                  "assets/images/spot_game_page/img1_original.png",
                  "assets/images/spot_game_page/img1_small.png",
                ]
                : [
                  "assets/images/spot_game_page/img1_original.png",
                  "assets/images/spot_game_page/img1_big.png",
                ],
        "buttons": buttonPositions3.sublist(
          0,
          buttonCount,
        ), // Prend 3 ou 5 boutons
      },
      4: {
        "images":
            (age < 6)
                ? [
                  "assets/images/spot_game_page/img1_original.png",
                  "assets/images/spot_game_page/img1_small.png",
                ]
                : [
                  "assets/images/spot_game_page/img1_original.png",
                  "assets/images/spot_game_page/img1_big.png",
                ],
        "buttons": buttonPositions4.sublist(
          0,
          buttonCount,
        ), // Prend 3 ou 5 boutons
      },
    };
  }

  // Function to build image containers with buttons
  Widget _buildImageContainer(String imagePath, double width, double height) {
    bool allButtonsTapped =
        _tappedButtons.length == (currentLevelData["buttons"] as List).length;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: allButtonsTapped ? Colors.green : Color(0xFFFFCB7C),
          width: 4,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          width * 0.02,
        ), // Adds equal padding inside the container
        child: Stack(
          children: [
            Positioned.fill(child: Image.asset(imagePath, fit: BoxFit.contain)),
            ..._generateHiddenButtons(width, height),
          ],
        ),
      ),
    );
  }

  // Generate buttons for the respective container
  List<Widget> _generateHiddenButtons(
    double containerWidth,
    double containerHeight,
  ) {
    List<Map<String, dynamic>> buttonData = List<Map<String, dynamic>>.from(
      currentLevelData["buttons"] ?? [],
    );

    return buttonData.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> btn = entry.value;

      double btnWidth = containerWidth * btn["width"];
      double btnHeight = containerHeight * btn["height"];
      double centerX = containerWidth * btn["left"] + (btnWidth / 2);
      double centerY = containerHeight * btn["top"] + (btnHeight / 2);

      return Stack(
        children: [
          // ✅ Circle highlight when tapped
          if (_tappedButtons.contains(index))
            Positioned(
              left: centerX - (btnWidth * 1), // Adjust for centering
              top: centerY - (btnHeight * 0.9),
              child: Container(
                width: btnWidth * 2,
                height: btnHeight * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 3),
                ),
              ),
            ),
          Positioned(
            top: containerHeight * btn["top"],
            left: containerWidth * btn["left"],
            child: GestureDetector(
              onTap:
                  _tappedButtons.contains(index)
                      ? null // Disable tapping again
                      : () {
                        if (GameLogic.sfx(context, widget.profileNbr))
                          _playcorrectSound();

                        setState(() {
                          _tappedButtons.add(index);
                          if (_tappedButtons.length == buttonData.length) {
                            _stopTimer();
                          }
                        });
                      },
              child: Container(
                width: btnWidth,
                height: btnHeight,
                decoration: BoxDecoration(color: Colors.transparent),
              ),
            ),
          ),
        ],
      );
    }).toList();
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
    if (GameLogic.sfx(context, widget.profileNbr)) _playcompleteSound();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => MiniGamesResultsPage(
                profileNbr: widget.profileNbr,
                level: widget.selectedLevel,
                minigameType: "Spot",
                time: _seconds,
              ),
        ),
      );
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double containerWidth = screenWidth * 0.3; // Adjust as needed
    double containerHeight = screenHeight * 0.64;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset("assets/backgrounds/bg8.jpg", fit: BoxFit.fill),
          ),

          // Title
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: Text(
                "Spot",
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF56351E),
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
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } else {
                                  GameLogic.decCheckpoint(
                                    context,
                                    widget.profileNbr,
                                    widget.selectedLevel == 1
                                        ? "north"
                                        : widget.selectedLevel == 2
                                        ? "east"
                                        : widget.selectedLevel == 3
                                        ? "west"
                                        : "south",
                                    1,
                                  );
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
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
                ],
              ),
            ),
          ),

          /*          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenWidth * 0.08,
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
                        Navigator.of(context).pop();
                      },
                      child: Ink.image(
                        image: AssetImage("assets/icons/question_icon.png"),
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
*/
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenWidth * 0.14,
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
                      onTap: () async {
                        _stopTimer();

                        await showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Prevent closing by tapping outside the dialog
                          builder: (BuildContext context) {
                            return PauseDialog(
                              profileNbr: widget.profileNbr,
                            ); // This will display the PauseDialog
                          },
                        );

                        _startTimer();
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

          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
              ), // Adjust the value as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImageContainer(
                    ImagesPaths[0],
                    containerWidth,
                    containerHeight,
                  ),
                  _buildImageContainer(
                    ImagesPaths[1],
                    containerWidth,
                    containerHeight,
                  ),
                ],
              ),
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
                  _formatTime(_seconds),
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
        ],
      ),
    );
  }
}
