import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';
import 'package:project_2cp_eq11/Screens/quit_page.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:ui';

/// ============================================================================
/// utils.dart
/// ============================================================================
///
/// a file filed with things that are reused to avoid redundancy
///
/// ============================================================================

class GameLogic {
  // Private constructor to prevent instantiation
  GameLogic._();

  static String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}'; // ✅ Format as mm:ss
  }

  static bool sfx(BuildContext context, int profileNb) {
    return Provider.of<DataProvider>(
      context,
      listen: false,
    ).userData['Profiles']['Profile_$profileNb']['Settings']['masterV'];
  }

  static int region(BuildContext context, int profileNb) {
    return Provider.of<DataProvider>(
      context,
      listen: false,
    ).userData['Profiles']['Profile_$profileNb']['lastPlayedRegion'];
  }

  static int getCheckpoint(
    BuildContext context,
    int profileNb,
    int adventure,
    String region,
  ) {
    return Provider.of<DataProvider>(
      context,
      listen: false,
    ).userData['Profiles']['Profile_$profileNb']["Regions"]["region_${region.toLowerCase()}"]["adventures"]["adventure_$adventure"]["checkPoint"];
  }

  static void setCheckpoint(
    BuildContext context,
    int profileNb,
    int adventure,
    String region,
    int value,
  ) {
    Provider.of<DataProvider>(
          context,
          listen: false,
        ).userData['Profiles']['Profile_$profileNb']["Regions"]["region_${region.toLowerCase()}"]["adventures"]["adventure_$adventure"]["checkPoint"] =
        value;
  }

  static void setRegion(BuildContext context, int profileNb, int value) {
    Provider.of<DataProvider>(
          context,
          listen: false,
        ).userData['Profiles']['Profile_$profileNb']['lastPlayedRegion'] =
        value;
  }

  static int? adv(BuildContext context, int profileNb) {
    return Provider.of<DataProvider>(
      context,
      listen: false,
    ).userData['Profiles']['Profile_$profileNb']['lastPlayedAdv'];
  }

  static void setAdv(BuildContext context, int profileNb, int? value) {
    Provider.of<DataProvider>(
          context,
          listen: false,
        ).userData['Profiles']['Profile_$profileNb']['lastPlayedAdv'] =
        value;
  }

  static bool narrator(BuildContext context, int profileNb) {
    return Provider.of<DataProvider>(
      context,
      listen: false,
    ).userData['Profiles']['Profile_$profileNb']['Settings']['narrator'];
  }

  static bool music(BuildContext context, int profileNb) {
    return Provider.of<DataProvider>(
      context,
      listen: false,
    ).userData['Profiles']['Profile_$profileNb']['Settings']['music'];
  }

  static int getAge(BuildContext context, int profileNb) {
    return Provider.of<DataProvider>(
      context,
      listen: false,
    ).userData['Profiles']['Profile_$profileNb']['age'];
  }

  static void decCheckpoint(
    BuildContext context,
    int profileNb,
    String region,
    int adventure,
  ) {
    Provider.of<DataProvider>(
          context,
          listen: false,
        ).userData['Profiles']['Profile_$profileNb']["Regions"]["region_${region.toLowerCase()}"]["adventures"]["adventure_$adventure"]["checkPoint"] =
        Provider.of<DataProvider>(
          context,
          listen: false,
        ).userData['Profiles']['Profile_$profileNb']["Regions"]["region_${region.toLowerCase()}"]["adventures"]["adventure_$adventure"]["checkPoint"] -
        1;
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
  void initState() {
    super.initState();
    masterV = GameLogic.sfx(context, widget.profileNbr);
    music = GameLogic.music(context, widget.profileNbr);
    narrator = GameLogic.narrator(context, widget.profileNbr);
  }

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
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // First row: Time label and current time
                  Text(
                    "Pause",
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Fredoka",
                      color: Color(0xFF56351E),
                    ),
                  ),

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
                        () async {
                          _updateSetting(
                            'music',
                            !music,
                          ); // Update the music setting
                          if (!music) {
                            await MusicController()
                                .pause(); // Pause the music if it's turned off
                          } else {
                            await MusicController()
                                .play(); // Play the music if it's turned on
                          }
                        },
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QuitPage()),
                          );
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
  String pauseText = "";
  String currentBg = "assets/bg_normal.png";
  bool isPaused = false;

  final TextForFirstPaiseView = {
    'north': ['Algeria', 'TIPAZA'],
    'east': ['CONSTANTINE', 'BEJAIA'],
    'west': ['Oran', 'Telemcen'],
    'south': ['Tamanrasset', 'Illizi'],
  };

  late Map<String, dynamic> userData;

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

    if (GameLogic.getCheckpoint(
          context,
          widget.profileNbr,
          widget.adventure,
          widget.region.toLowerCase(),
        ) ==
        0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          boxText =
              TextForFirstPaiseView[widget.region
                  .toLowerCase()]?[widget.adventure - 1] ??
              'Default Text';
          isVisible = false;
        });

        Future.delayed(const Duration(seconds: 3), () {
          startTyping(
            userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
            userData["Profiles"]['Profile_${widget.profileNbr}']["Settings"]["narrator"],
          );
          setState(() {
            isVisible = true;
          });
        });
      });
    } else {
      startTyping(
        userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
        userData["Profiles"]['Profile_${widget.profileNbr}']["Settings"]["narrator"],
      );
    }
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
          if (!hasPlayedAudio &&
              voice &&
              dialogue["voice"] != null &&
              dialogue["voice"]!.isNotEmpty) {
            try {
              _playAudio(dialogue["voice"]!);
              hasPlayedAudio = true;
            } catch (_) {
              // Silently skip if audio can't be played
            }
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
                    ? screenWidth *
                        0.135 // For speaker 1
                    : (speakerIcon2 != null &&
                        speaker != null &&
                        speakerIcon2.contains(speaker))
                    ? screenWidth *
                        0.12 // For speaker 2
                    : screenWidth *
                        0.08, // Default position if neither speaker matches

            bottom: screenHeight * 0.1,
            child: Stack(
              alignment: Alignment.center, // Centers everything in the stack
              children: [
                // Dialogue Box Background
                Image.asset(
                  widget
                      .dialogues[userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]]["textBoxIcon"]!,
                  width: screenWidth * 0.72,
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
                      fontSize: screenWidth * 0.021,
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
          AnimatedGameButton(
            "assets/icons/region1/adventure1/back_button.png",
            screenWidth * 0.2,
            screenHeight * 0.2,
            screenWidth * 0.15,
            screenHeight * 0.827,
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
                          if (GameLogic.getCheckpoint(
                                context,
                                widget.profileNbr,
                                widget.adventure,
                                widget.region.toLowerCase(),
                              ) >
                              0) {
                            setState(() {
                              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]--;
                            });
                            startTyping(
                              userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
                              userData["Profiles"]['Profile_${widget.profileNbr}']["Settings"]["narrator"],
                            );
                          }
                        },
                        pauseView: (String text) async {
                          setState(() {
                            isVisible = false;
                            boxText = text;
                          });

                          await Future.delayed(const Duration(seconds: 3));

                          userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"]--;

                          setState(() {
                            isVisible = true;
                          });

                          startTyping(
                            userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_${widget.adventure}"]["checkPoint"],
                            userData["Profiles"]['Profile_${widget.profileNbr}']["Settings"]["narrator"],
                          );
                        },
                      );
                    }
                    : null,
          ),
        if (!widget.lockview && isVisible)
          AnimatedGameButton(
            "assets/icons/region1/adventure1/skip_button.png",
            screenWidth * 0.2,
            screenHeight * 0.2,
            screenWidth * 0.38,
            screenHeight * 0.827,
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
        if (!widget.lockview && isVisible)
          AnimatedGameButton(
            "assets/icons/region1/adventure1/next_button.png",
            screenWidth * 0.2,
            screenHeight * 0.2,
            screenWidth * 0.61,
            screenHeight * 0.827,
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
                pauseView: (String text) async {
                  setState(() {
                    isVisible = false;
                    boxText = text;
                  });

                  await Future.delayed(const Duration(seconds: 3));

                  setState(() {
                    isVisible = true;
                  });
                },
              );
            },
          ),
      ],
    );
  }
}

class MusicController {
  static final MusicController _instance = MusicController._internal();
  factory MusicController() => _instance;
  MusicController._internal();

  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;

  // Getter to access _isPlaying state
  bool get isPlaying => _isPlaying;

  Future<void> init() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setSource(AssetSource('audios/bg/bg_music.mp3'));
  }

  Future<void> play() async {
    if (!_isPlaying) {
      await _player.resume(); // Resume playing if it was paused
      _isPlaying = true;
    }
  }

  Future<void> pause() async {
    if (_isPlaying) {
      await _player.pause(); // Pause the music
      _isPlaying = false;
    }
  }

  Future<void> stop() async {
    await _player.stop(); // This stops the music completely
    _isPlaying = false;
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume); // 0.0 to 1.0
  }

  // Toggle play/pause state
  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await pause(); // If music is playing, pause it
    } else {
      await play(); // If music is paused, resume it
    }
  }
}
