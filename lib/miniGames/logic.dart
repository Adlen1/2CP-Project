import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:ui';

class GameLogic {
  // Private constructor to prevent instantiation
  GameLogic._();

  static String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}'; // ✅ Format as mm:ss
  }
}

class PauseDialog extends StatefulWidget {
  final int profileNbr;

  PauseDialog({required this.profileNbr}); // Constructor

  @override
  _PauseDialogState createState() => _PauseDialogState();
}

class _PauseDialogState extends State<PauseDialog> {
  bool masterV = true;
  bool music = true;
  bool narrator = true;

  void _updateSetting(String key, bool value) {
    setState(() {
      if (key == 'masterV') masterV = value;
      if (key == 'music') music = value;
      if (key == 'narrator') narrator = value;
    });

    final userData = Provider.of<DataProvider>(context, listen: false).userData;

    userData['Profiles']['Profile_${widget.profileNbr}']['Settings'][key] =
        value;
  }

  Widget _buildAnimatedButton(
    double width,
    double heigth,
    String activeIcon,
    String inactiveIcon,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Image.asset(
          isActive ? activeIcon : inactiveIcon,
          key: ValueKey<bool>(
            isActive,
          ), // Ensure smooth animation when changing states
          width: width, // Adjust size if needed
          height: heigth,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget buildAnimatedImageButton({
    required double width,
    required double height,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Image.asset(
          imagePath,
          key: ValueKey<String>(
            imagePath,
          ), // Key based on path to animate on change
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.transparent, // Transparent background
      child: Stack(
        children: [
          // Background blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0),
              ),
            ),
          ),
          // Custom content inside the dialog
          Center(
            child: Container(
              width: screenWidth * 0.5,
              height: screenHeight * 0.8,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255).withOpacity(1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFFFFCB7C), width: 6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // First row: Time label and current time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Time :",
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Fredoka",
                          color: Color(0xFF56351E),
                        ),
                      ),
                      Text(
                        "5 : 00",
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Fredoka",
                          color: Color(0xFF56351E),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  // Second row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAnimatedButton(
                        screenWidth * 0.09,
                        screenWidth * 0.09,
                        "assets/icons/settings_page/sound_on_icon.png",
                        "assets/icons/settings_page/sound_off_icon.png",
                        masterV,
                        () => _updateSetting('masterV', !masterV),
                      ),
                      SizedBox(width: screenWidth * 0.06),
                      _buildAnimatedButton(
                        screenWidth * 0.09,
                        screenWidth * 0.09,
                        "assets/icons/settings_page/music_on_icon.png",
                        "assets/icons/settings_page/music_off_icon.png",
                        music,
                        () => _updateSetting('music', !music),
                      ),
                      SizedBox(width: screenWidth * 0.06),
                      _buildAnimatedButton(
                        screenWidth * 0.09,
                        screenWidth * 0.09,
                        "assets/icons/settings_page/voice_on_icon.png",
                        "assets/icons/settings_page/voice_off_icon.png",
                        narrator,
                        () => _updateSetting('narrator', !narrator),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Third row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildAnimatedImageButton(
                        width: screenWidth * 0.16,
                        height: screenHeight * 0.18,
                        imagePath: "assets/icons/pause_page/resume.png",
                        onTap: () => Navigator.pop(context),
                      ),
                      SizedBox(width: screenWidth * 0.06),
                      buildAnimatedImageButton(
                        width: screenWidth * 0.16,
                        height: screenHeight * 0.18,
                        imagePath: "assets/icons/pause_page/quit.png",
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
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

class DialogueBox extends StatefulWidget {
  final List<Map<String, String>> dialogues;
  final VoidCallback? onDialogueEnd;
  final bool lockview;
  final Function proceedToNextDialogue;
  final Function proceedToPreviousDialogue;
  final Function skipDialogue;
  final int profileNbr;
  final String region;
  final int adventure;
  final int initIndex;

  const DialogueBox({
    required this.initIndex,
    required this.adventure,
    required this.region,
    required this.profileNbr,
    required this.dialogues,
    this.onDialogueEnd,
    required this.lockview,
    required this.proceedToNextDialogue,
    required this.proceedToPreviousDialogue,
    required this.skipDialogue,
  });

  @override
  _DialogueBoxState createState() => _DialogueBoxState();
}

class _DialogueBoxState extends State<DialogueBox> {
  String displayedText = "";
  int charIndex = 0;
  Timer? timer;
  bool isTyping = false;
  bool isVisible = true;
  double boxWidth = 0.3;
  double boxHeight = 0.18;
  double boxTop = 0.8;
  double boxLeft = 0.65;
  String boxText = "Default Text";

  final AudioPlayer _player = AudioPlayer();

  Future<void> _playAudio(String assetPath) async {
    // Stop any currently playing audio
    await _player.stop();

    // Set the source and play

    await _player.play(AssetSource(assetPath));
  }

  void _stopAudio() async {
    await _player.stop();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"] =
        widget.initIndex;
    startTyping(
      userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
      userData["Profiles"]['Profile_${widget.profileNbr}']["Settings"]["narrator"],
    );
  }

  void startTyping(int index, bool voice) async {
    final dialogue = widget.dialogues[index];

    setState(() {
      displayedText = "";
      charIndex = 0;
      isTyping = true;
    });

    bool hasPlayedAudio = false;

    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds: 40), (Timer t) {
      if (charIndex < dialogue["text"]!.length) {
        setState(() {
          displayedText += dialogue["text"]![charIndex];
          charIndex++;

          // Start audio at the first character
          if (!hasPlayedAudio && voice) {
            _playAudio(dialogue["voice"]!);
            hasPlayedAudio = true;
          }
        });
      } else {
        t.cancel();

        setState(() {
          isTyping = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final userData = Provider.of<DataProvider>(context, listen: false).userData;

    String? speakerIcon1 =
        widget
            .dialogues[userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]]["speakerIcon1"];
    String? speakerIcon2 =
        widget
            .dialogues[userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]]["speakerIcon2"];

    String? speaker =
        widget
            .dialogues[userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]]["speaker"];
    String bg =
        widget
            .dialogues[userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]]["bg"] ??
        "assets/backgrounds/region1/adventure1/bg1.jpg";

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned.fill(child: Image.asset(bg, fit: BoxFit.fill)),

        if (isVisible && !widget.lockview)
          Positioned(
            left:
                (speakerIcon1 != null &&
                        speaker != null &&
                        speakerIcon1.contains(speaker))
                    ? screenWidth * 0.12
                    : screenWidth * 0.08,

            bottom: screenHeight * 0.1,
            child: Stack(
              alignment: Alignment.center, // Centers everything in the stack
              children: [
                // Dialogue Box Background
                Image.asset(
                  widget
                      .dialogues[userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]]["textBoxIcon"]!,
                  width: screenWidth * 0.75,
                  height: screenHeight * 0.3,
                ),

                // Text Container
                Container(
                  width: screenWidth * 0.7, // Ensures text doesn't overflow
                  padding: EdgeInsets.fromLTRB(
                    (speakerIcon1 != null &&
                            speaker != null &&
                            speakerIcon1.contains(speaker))
                        ? screenWidth *
                            0.05 // Shift text to the right
                        : screenWidth * 0.1, // Default left padding
                    screenHeight * 0.015,
                    (speakerIcon1 != null &&
                            speaker != null &&
                            speakerIcon1.contains(speaker))
                        ? screenWidth *
                            0.11 // Default right padding
                        : screenWidth * 0.05, // Shift text to the left
                    screenHeight * 0.015,
                  ),
                  child: Text(
                    displayedText,
                    style: TextStyle(
                      fontFamily: 'Fredoka2',
                      fontSize: screenWidth * 0.024,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                    textAlign:
                        TextAlign.center, // Center text inside the container
                    softWrap: true, // Allows text wrapping
                  ),
                ),
              ],
            ),
          ),

        if (isVisible && !widget.lockview)
          if (speakerIcon1 != null)
            Positioned(
              left: screenWidth * 0.68,
              bottom: screenHeight * 0.05,
              child: Image.asset(
                widget
                    .dialogues[userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]]["speakerIcon1"]!,
                width: screenWidth * 0.45,
                height: screenHeight * 0.45,
              ),
            ),

        if (isVisible && !widget.lockview)
          if (speakerIcon2 != null)
            Positioned(
              left: -screenWidth * 0.2,
              bottom: screenHeight * 0.02,
              child: Image.asset(
                widget
                    .dialogues[userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]]["speakerIcon2"]!,
                width: screenWidth * 0.55,
                height: screenHeight * 0.55,
              ),
            ),

        if (!isVisible && !widget.lockview)
          Positioned(
            top: screenHeight * boxTop,
            left: screenWidth * boxLeft,
            child: Container(
              width: screenWidth * boxWidth,
              height: screenHeight * boxHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Color(0xFFFFCB7C), // Couleur de la bordure
                  width: 3, // Épaisseur de la bordure
                ),
              ),

              child: Center(
                child: Text(
                  boxText,
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: screenWidth * 0.024,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF56351E),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

        if (!widget.lockview && isVisible)
          Stack(
            children: [
              Positioned(
                left: screenWidth * 0.18,
                bottom: -screenHeight * 0.03,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedGameButton(
                      "assets/icons/region1/adventure1/back_button.png",
                      screenWidth * 0.2,
                      screenHeight * 0.2,
                      screenWidth * 0.1,
                      screenHeight * 0.1,
                      onTap:
                          userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"] !=
                                  0
                              ? () {
                                widget.proceedToPreviousDialogue(
                                  context: context,
                                  dialogues: widget.dialogues,
                                  currentDialogueIndex:
                                      userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
                                  onDialogueEnd: widget.onDialogueEnd,
                                  startTyping: startTyping,
                                  isTyping: isTyping,
                                  displayedText: displayedText,
                                  stopAudio: _stopAudio,

                                  completeText: () {
                                    setState(() {
                                      displayedText =
                                          widget
                                              .dialogues[userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]]["text"]!;
                                      isTyping = false;
                                    });
                                    timer?.cancel();
                                    return;
                                  },
                                  updateDialogueIndex: () {
                                    setState(() {
                                      userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]--;
                                    });
                                    startTyping(
                                      userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
                                      userData["Profiles"]['Profile_${widget.profileNbr}']["Settings"]["narrator"],
                                    );
                                  },
                                  pauseView: (String Text) {
                                    setState(() {
                                      isVisible = false;
                                      boxText =
                                          Text; // Décrémente l'index immédiatement
                                    });

                                    Future.delayed(Duration(seconds: 3), () {
                                      userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]--;
                                      setState(() {
                                        isVisible = true;
                                      });
                                      startTyping(
                                        userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
                                        userData["Profiles"]['Profile_${widget.profileNbr}']["Settings"]["narrator"],
                                      );
                                    });
                                  },
                                );
                              }
                              : null,
                    ),
                    AnimatedGameButton(
                      "assets/icons/region1/adventure1/skip_button.png",
                      screenWidth * 0.2,
                      screenHeight * 0.2,
                      screenWidth * 0.1,
                      screenHeight * 0.1,
                      onTap: () {
                        widget.skipDialogue(
                          context: context,
                          dialogues: widget.dialogues,
                          currentDialogueIndex:
                              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
                          onDialogueEnd: widget.onDialogueEnd,
                          startTyping: startTyping,
                          isTyping: isTyping,
                          displayedText: displayedText,

                          completeText: () {
                            setState(() {
                              displayedText =
                                  widget
                                      .dialogues[userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]]["text"]!;
                              isTyping = false;
                            });
                            timer?.cancel();
                            return;
                          },
                          updateDialogueIndex: (int x) {
                            setState(() {
                              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"] =
                                  x;
                            });
                            startTyping(
                              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
                              userData["Profiles"]['Profile_${widget.profileNbr}']["Settings"]["narrator"],
                            );
                          },
                        );
                      },
                    ),
                    AnimatedGameButton(
                      "assets/icons/region1/adventure1/next_button.png",
                      screenWidth * 0.2,
                      screenHeight * 0.2,
                      screenWidth * 0.1,
                      screenHeight * 0.1,
                      onTap: () {
                        widget.proceedToNextDialogue(
                          context: context,
                          dialogues: widget.dialogues,
                          currentDialogueIndex:
                              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
                          onDialogueEnd: widget.onDialogueEnd,
                          startTyping:
                              () => startTyping(
                                userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
                                userData["Profiles"]['Profile_${widget.profileNbr}']["Settings"]["narrator"],
                              ),
                          isTyping: isTyping,
                          displayedText: displayedText,
                          stopAudio: _stopAudio,
                          completeText: () {
                            setState(() {
                              displayedText =
                                  widget
                                      .dialogues[userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]]["text"]!;
                              isTyping = false;
                            });
                            timer?.cancel();
                            return;
                          },
                          updateDialogueIndex: () {
                            setState(() {
                              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]++;
                            });
                          },
                          pauseView: (String Text) {
                            setState(() {
                              isVisible = false;
                              boxText = Text;
                            });
                            Future.delayed(Duration(seconds: 3), () {
                              setState(() {
                                isVisible = true;
                              });
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
