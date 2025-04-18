import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/miniGames/logic.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class FindGamePage extends StatefulWidget {
  final int profileNbr;
  final int selectedLevel;
  final bool fromAdv;

  FindGamePage({
    required this.profileNbr,
    required this.selectedLevel,
    required this.fromAdv,
  });

  @override
  _FindGamePageState createState() => _FindGamePageState();
}

class _FindGamePageState extends State<FindGamePage>
    with TickerProviderStateMixin {
  late Map<String, dynamic> currentLevelData;
  late int age;
  int _seconds = 0;
  Timer? _timer;
  Set<int> _tappedButtons = {};

  Set<int> tappedElements = {}; // Store tapped elements

  @override
  void initState() {
    super.initState();

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

    _startTimer();
  }

  Map<int, Map<String, dynamic>> getLevelData(int age) {
    bool isUnder6 = age < 6;

    // Define region-specific main photos
    Map<int, String> regionPhotos = {
      1: "assets/images/find_game_page/img1.png",
      2: "assets/images/find_game_page/img2.png",
      3: "assets/images/find_game_page/img3.png",
      4: "assets/images/find_game_page/img4.png",
    };

    // Define age-specific elements for each region
    Map<int, List<String>> regionElements = {
      1:
          isUnder6
              ? [
                "assets/images/find_game_page/img11_small.png",
                "assets/images/find_game_page/img12_small.png",
                "assets/images/find_game_page/img13_small.png",
              ]
              : [
                "assets/images/find_game_page/img11_big.png",
                "assets/images/find_game_page/img12_big.png",
                "assets/images/find_game_page/img13_big.png",
              ],
      2: isUnder6 ? [
            
          ]
        : [],
      3: isUnder6 ? [
           
          ]
        : [],
      4: isUnder6 ? [
          
          ]
        : [],
    };

    Map<int, List<Map<String, dynamic>>> regionButtons = {
      1: [
        {"width": 0.2, "height": 0.2, "top": 0.33, "left": 0.74, "element": 1},
        {
          "width": 0.15,
          "height": 0.15,
          "top": 0.72,
          "left": 0.76,
          "element": 2,
        },
        {"width": 0.2, "height": 0.1, "top": 0.06, "left": 0.45, "element": 3},
        {"width": 0.1, "height": 0.1, "top": 0.05, "left": 0.02, "element": 3},
        {"width": 0.15, "height": 0.1, "top": 0.1, "left": 0.88, "element": 3},
      ],
      2: [],
      3: [],
      4: [],
    };

    // Create level data dynamically
    Map<int, Map<String, dynamic>> levelData = {};
    for (int region = 1; region <= 4; region++) {
      levelData[region] = {
        "photo": regionPhotos[region], // Same photo for all ages
        "elements": regionElements[region], // 3 elements, different by age
        "buttons": regionButtons[region], // Age-based buttons
      };
    }
    return levelData;
  }

  Widget _buildElementsContainer(
    List<String> elements,
    double width,
    double height,
  ) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color(0xFFFFCB7C), width: 4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            elements.map((elementPath) {
              bool isSmall = elementPath.contains("_small");
              double imageWidth = isSmall ? width * 0.8 : width * 0.5;
              double imageHeight = isSmall ? height * 0.22 : height * 0.1;

              int elementIndex = elements.indexOf(elementPath) + 1;
              bool isTapped = tappedElements.contains(elementIndex);

              return Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: Image.asset(
                      elementPath,
                      width: imageWidth,
                      height: imageHeight,
                      fit: BoxFit.contain,
                    ),
                  ),

                  if (isTapped)
                    Positioned(
                      top: imageHeight * 0.05,
                      child: Image.asset(
                        "assets/images/find_game_page/check_icon.png",
                        width: imageWidth * 0.3,
                        height: imageWidth * 0.3,
                        fit: BoxFit.contain,
                      ),
                    ),
                ],
              );
            }).toList(),
      ),
    );
  }

  // Function to build the right container with the region image and hidden buttons
  Widget _buildImageContainer(String imagePath, double width, double height) {
    bool allButtonsTapped =
        tappedElements.length ==
        (currentLevelData["buttons"] as List)
            .map((b) => b["element"])
            .toSet()
            .length;
    return Container(
      width: width * 1.1,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: allButtonsTapped ? Colors.green : Color(0xFFFFCB7C),
          width: 4,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.02),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            ..._generateHiddenButtons(width, height),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateHiddenButtons(
    double containerWidth,
    double containerHeight,
  ) {
    List<Map<String, dynamic>> buttonData = List<Map<String, dynamic>>.from(
      currentLevelData["buttons"] ?? [],
    );

    return buttonData.map((btn) {
      double btnWidth = containerWidth * btn["width"];
      double btnHeight = containerHeight * btn["height"];
      double centerX = containerWidth * btn["left"] + (btnWidth / 2);
      double centerY = containerHeight * btn["top"] + (btnHeight / 2);

      int element = btn["element"];

      bool isTapped = tappedElements.contains(element);

      return Stack(
        children: [
          // ✅ Highlight circle if tapped
          if (isTapped)
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
                  isTapped
                      ? null // Disable tapping again
                      : () {
                        setState(() {
                          tappedElements.add(element);
                          _tappedButtons.add(
                            element,
                          ); // ✅ Track tapped elements

                          if (_tappedButtons.length ==
                              buttonData
                                  .map((b) => b["element"])
                                  .toSet()
                                  .length) {
                            _stopTimer();
                          }
                        });
                      },
              child: Container(
                width: btnWidth,
                height: btnHeight,
                decoration: BoxDecoration(
                  color: Colors.transparent, // Keep button invisible
                ),
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

    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => MiniGamesResultsPage(
                profileNbr: widget.profileNbr,
                level: widget.selectedLevel,
                minigameType: "Find",
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

    double containerWidth = screenWidth * 0.25;
    double containerHeight = screenHeight * 0.64;

    double containerWidth2 = screenWidth * 0.4;
    double containerHeight2 = screenHeight * 0.64;

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
                "Find",
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

          Align(
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
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, //Prevent closing by tapping outside the dialog
                          builder: (BuildContext context) {
                            return PauseDialog(
                              profileNbr: widget.profileNbr,
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

          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Left Container: Column of Elements
                  _buildElementsContainer(
                    currentLevelData["elements"],
                    containerWidth,
                    containerHeight,
                  ),

                  // Right Container: Main Region Image + Hidden Buttons
                  _buildImageContainer(
                    currentLevelData["photo"],
                    containerWidth2,
                    containerHeight2,
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
