import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:provider/provider.dart';

/// ============================================================================
/// match_game.dart
/// ============================================================================
///
/// This file defines the match minigame,
/// where players match a name with an image with drag and drop mechanics
///
/// this is pushed by rules_ofMiniGames.dart
/// and pushes mini_games_result.dart
///
/// ============================================================================

class MatchGamePage extends StatefulWidget {
  final int profileNbr;
  final int selectedLevel;
  final bool fromAdv;

  MatchGamePage({
    required this.profileNbr,
    required this.selectedLevel,
    required this.fromAdv,
  });

  @override
  _MatchGamePageState createState() => _MatchGamePageState();
}

class _MatchGamePageState extends State<MatchGamePage>
    with TickerProviderStateMixin {
  late List<String> draggableItems;
  late List<String> ImagesPaths;
  late List<String> correctAnswers;
  late List<String?> droppedItems;
  late List<Color> imageBorders;
  late List<bool> draggableDisabled;
  int _seconds = 0;
  Timer? _timer;

  final Map<int, Map<String, dynamic>> levelData = {
    1: {
      "elements": [
        "The Roman ruins",
        "The royal Mausoleum",
        "The Roman theater",
      ],
      "images": [
        "assets/images/match_game_page/img11.png",
        "assets/images/match_game_page/img12.png",
        "assets/images/match_game_page/img13.png",
      ],
      "answers": [
        "The royal Mausoleum",
        "The Roman theater",
        "The Roman ruins",
      ],
    },
    2: {
      "elements": ["Barbary mocaque", "Yemma Gouraya", "Cap Carbon"],
      "images": [
        "assets/images/match_game_page/img21.png",
        "assets/images/match_game_page/img22.png",
        "assets/images/match_game_page/img23.png",
      ],
      "answers": ["Yemma Gouraya", "Cap Carbon", "Barbary mocaque"],
    },
    3: {
      "elements": ["Gandoura", "Ben Badis Mosque", "Arzew lighthouse"],
      "images": [
        "assets/images/match_game_page/img31.png",
        "assets/images/match_game_page/img32.png",
        "assets/images/match_game_page/img33.png",
      ],
      "answers": ["Ben Badis Mosque", "Gandoura", "Arzew lighthouse"],
    },
    4: {
      "elements": ["Sahara", "Sahara drawing", "Assekrem plateau"],
      "images": [
        "assets/images/match_game_page/img41.png",
        "assets/images/match_game_page/img42.png",
        "assets/images/match_game_page/img43.png",
      ],
      "answers": ["Sahara drawing", "Sahara", "Assekrem plateau"],
    },
  };
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
      await _sfxPlayer.play(AssetSource('audios/minigames/correct.mp3'));
    } catch (e) {
      debugPrint('\x1B[33m Error playing sound: $e\x1B[0m');
    }
  }

  Future<void> _playwrongSound() async {
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource('audios/minigames/wrong.mp3'));
    } catch (e) {
      debugPrint('\x1B[33m Error playing sound: $e\x1B[0m');
    }
  }

  List<String> _getLevelData(String key) {
    return levelData[widget.selectedLevel]?[key] ?? ["Error"];
  }

  @override
  void initState() {
    super.initState();
    draggableItems = _getLevelData("elements");
    ImagesPaths = _getLevelData("images");
    correctAnswers = _getLevelData("answers");
    droppedItems = List.filled(draggableItems.length, null);
    imageBorders = List.filled(draggableItems.length, Color(0xFFFFCB7C));
    draggableDisabled = List.filled(draggableItems.length, false);
    _startTimer();
    Provider.of<DataProvider>(
          context,
          listen: false,
        ).userData["Profiles"]["Profile_${widget.profileNbr}"]["minigames"]["Match"][widget
                .selectedLevel -
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
    if (GameLogic.sfx(context, widget.profileNbr)) _playcompleteSound();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => MiniGamesResultsPage(
                profileNbr: widget.profileNbr,
                level: widget.selectedLevel,
                minigameType: "Match",
                time: _seconds,
              ),
        ),
      );
    });
  }

  void _checkIfGameCompleted() {
    bool allCorrect = true;
    for (int i = 0; i < droppedItems.length; i++) {
      if (droppedItems[i] != correctAnswers[i]) {
        allCorrect = false;
        break;
      }
    }

    if (allCorrect) {
      _stopTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                "Match",
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
          /*
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
*/
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                //top: screenHeight * 0.02,
                //left: screenWidth * 0.14,
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
                    fontSize: screenWidth*0.025,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // ✅ White text
                  ),
                ),
              ),
            ),
          ),

          // Draggable Items Container
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenWidth * 0.04,
              ),
              child: Container(
                width: screenWidth * 0.25,
                height: screenHeight * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Color(0xFFFFCB7C), width: 5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      draggableItems.map((item) {
                        int itemIndex = draggableItems.indexOf(item);
                        return draggableDisabled[itemIndex]
                            ? Opacity(
                              opacity: 0,
                              child: DraggableItem(item),
                            ) // Disabled effect
                            : Draggable<String>(
                              data: item,
                              child: DraggableItem(item), // Normal state
                              feedback: DraggableItem(
                                item,
                                isDragging: true,
                              ), // While dragging
                              childWhenDragging: Opacity(
                                opacity: 0.3,
                                child: DraggableItem(item),
                              ), // Fade effect
                            );
                      }).toList(),
                ),
              ),
            ),
          ),

          ImageRow(
            imagePaths: ImagesPaths,
            imageWidth: screenHeight * 0.4,
            imageHeight: screenHeight * 0.4,
            spacing: screenWidth * 0.025,
            leftOffset: screenWidth * 0.32,
            topOffset: screenHeight * 0.21,
            imageBorders: imageBorders,
          ),

          // Drop Zones
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.46,
                left: screenWidth * 0.26,
              ),
              child: Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.4,
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => DragTarget<String>(
                      onWillAccept:
                          (data) =>
                              droppedItems[index] != correctAnswers[index],
                      onAccept: (data) {
                        bool isCorrect = data == correctAnswers[index];
                        if (GameLogic.sfx(context, widget.profileNbr))
                          isCorrect ? _playcorrectSound() : _playwrongSound();

                        setState(() {
                          droppedItems[index] = data;
                          imageBorders[index] =
                              isCorrect ? Colors.green : Colors.red;

                          int itemIndex = draggableItems.indexOf(data);
                          if (isCorrect && itemIndex != -1) {
                            draggableDisabled[itemIndex] = true;
                          }

                          _checkIfGameCompleted();
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color:
                                  droppedItems[index] == null
                                      ? Color(0xFFFFCB7C)
                                      : imageBorders[index],
                              width: 4,
                            ),
                          ),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width:
                                screenWidth *
                                0.175, // Ajusté pour compenser le padding
                            height:
                                screenHeight *
                                0.13, // Ajusté pour compenser le padding
                            decoration: BoxDecoration(
                              color:
                                  (droppedItems[index] != null &&
                                          droppedItems[index] ==
                                              correctAnswers[index])
                                      ? Color(0xFFFFCB7C)
                                      : const Color.fromARGB(
                                        255,
                                        255,
                                        255,
                                        255,
                                      ).withOpacity(0),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                droppedItems[index] ?? "",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Fredoka3',
                                  fontSize: screenWidth * 0.017,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF56351E),
                                ),
                              ),
                            ),

                          ),
                        );
                      },
                    ),
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

// **Draggable Item Widget**
class DraggableItem extends StatelessWidget {
  final String text;
  final bool isDragging;

  DraggableItem(this.text, {this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      width: screenWidth * 0.18,
      height: screenHeight * 0.15,
      decoration: BoxDecoration(
        color:
            isDragging ? Color.fromARGB(255, 196, 156, 96) : Color(0xFFFFCB7C),
        borderRadius: BorderRadius.circular(22),
        boxShadow:
            isDragging
                ? []
                : [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 4), // More depth
                  ),
                ],
      ),
      alignment: Alignment.center,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Fredoka3',
              fontSize: screenWidth * 0.017,
              fontWeight: FontWeight.bold,
              color: Color(0xFF56351E),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageRow extends StatelessWidget {
  final List<String> imagePaths;
  final List<Color> imageBorders;
  final double imageWidth;
  final double imageHeight;
  final double spacing;
  final double leftOffset;
  final double topOffset;

  const ImageRow({
    super.key,
    required this.imagePaths,
    required this.imageBorders,
    required this.imageWidth,
    required this.imageHeight,
    required this.spacing,
    required this.leftOffset,
    required this.topOffset,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:
          imagePaths.asMap().entries.map((entry) {
            int index = entry.key;
            String path = entry.value;
            return Positioned(
              left: (index * (imageWidth + spacing)) + leftOffset,
              top: topOffset,
              child: Container(
                width: imageWidth,
                height: imageHeight,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: imageBorders[index], width: 4),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(path, fit: BoxFit.contain),
                ),
              ),
            );
          }).toList(),
    );
  }
}
