import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/Regions_page.dart';
import 'package:project_2cp_eq11/Screens/awards_page.dart';
import 'package:project_2cp_eq11/Screens/settings_page.dart';
import 'package:project_2cp_eq11/Screens/games_page.dart';
import 'package:project_2cp_eq11/Screens/stats_page.dart';
import 'package:project_2cp_eq11/Help/help_page.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';

class MainScreen extends StatefulWidget {
  final int profileNbr;

  const MainScreen({Key? key, required this.profileNbr}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  Map<int, bool> glowingButtons = {};
  Map<int, bool> disabledButtons = {}; // Track disabled state of buttons

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Initialize all buttons as enabled
    for (int i = 0; i < 6; i++) {
      disabledButtons[i] = false;
    }

    if (GameLogic.music(context, widget.profileNbr)) {
      _initializeMusic();
    } else {
      _stopMusic();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // if the phone sleeps or the game quit without closing or the user lock the screen the music get paused and get resumed once back to the game
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!GameLogic.music(context, widget.profileNbr)) return;
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      MusicController().pause();
    } else if (state == AppLifecycleState.resumed) {
      MusicController().play();
    }
  }

  Future<void> _stopMusic() async {
    await MusicController().stop(); // Stop the music
  }

  Future<void> _initializeMusic() async {
    // Initialize the music controller
    await MusicController().init(); // Initialize the music player
    MusicController().play(); // Start the music
    MusicController().setVolume(1.0); // Set the volume to maximum (1.0)
  }

  // Method to change the volume
  Future<void> _adjustVolume(double volume) async {
    await MusicController().setVolume(volume);
  }

  void _triggerGlow(int buttonIndex, {VoidCallback? onComplete}) {
    setState(() {
      glowingButtons[buttonIndex] = true;
    });

    Future.delayed(Duration(milliseconds: 400), () {
      setState(() {
        glowingButtons[buttonIndex] = false;
      });
      if (onComplete != null) onComplete();
    });
  }

  // Method to handle button click with anti-spam protection
  void _handleButtonClick(int buttonIndex, VoidCallback action) {
    // If the button is disabled, ignore the click
    if (disabledButtons[buttonIndex] == true) {
      return;
    }

    // Disable the button
    setState(() {
      disabledButtons[buttonIndex] = true;
    });

    // Trigger glow effect
    _triggerGlow(buttonIndex, onComplete: action);

    // Re-enable the button after 1 second
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          disabledButtons[buttonIndex] = false;
        });
      }
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
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/backgrounds/main_page_bg.jpg",
              fit: BoxFit.fill,
            ),
          ),

          // Story Button
          buildTransparentButton(
            0,
            screenWidth * 0.473,
            screenHeight * 0.538,
            screenWidth * 0.48,
            screenHeight * 0.7,
            () => _handleButtonClick(0, () {
              _adjustVolume(0.4);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RegionsPage(profileNbr: widget.profileNbr),
                ),
              ).then((_) {
                _adjustVolume(1.0);
              });
            }),
          ),

          // Settings Button
          buildTransparentButton(
            1,
            screenWidth * 0.47,
            screenHeight * 0.078,
            screenWidth * 0.18,
            screenHeight * 0.09,
            () => _handleButtonClick(1, () {
              _adjustVolume(0.4);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => SettingsPage(profileNbr: widget.profileNbr),
                ),
              ).then((_) {
                _adjustVolume(1.0);
              });
            }),
          ),

          // Help Button
          buildTransparentButton(
            2,
            screenWidth * 0.115,
            screenHeight * 0.258,
            screenWidth * 0.13,
            screenHeight * 0.24,
            () => _handleButtonClick(2, () {
              _adjustVolume(0.4);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelpPage(profileNB: widget.profileNbr),
                ),
              ).then((_) {
                _adjustVolume(1.0);
              });
            }),
          ),

          // Stats Button
          buildTransparentButton(
            3,
            screenWidth * 0.118,
            screenHeight * 0.632,
            screenWidth * 0.12,
            screenHeight * 0.24,
            () => _handleButtonClick(3, () {
              _adjustVolume(0.4);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => StatsPage(profileNbr: widget.profileNbr),
                ),
              ).then((_) {
                _adjustVolume(1.0);
              });
            }),
          ),

          // Mini-games Button
          buildTransparentButton(
            4,
            screenWidth * 0.862,
            screenHeight * 0.245,
            screenWidth * 0.168,
            screenHeight * 0.29,
            () => _handleButtonClick(4, () {
              _adjustVolume(0.4);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => MiniGamesPage(profileNbr: widget.profileNbr),
                ),
              ).then((_) {
                _adjustVolume(1.0);
              });
            }),
          ),

          // Rewards Button
          buildTransparentButton(
            5,
            screenWidth * 0.865,
            screenHeight * 0.625,
            screenWidth * 0.15,
            screenHeight * 0.27,
            () => _handleButtonClick(5, () {
              _adjustVolume(0.4);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => AwardsPage(profileNbr: widget.profileNbr),
                ),
              ).then((_) {
                _adjustVolume(1.0);
              });
            }),
          ),
        ],
      ),
    );
  }

  // Function to create a transparent clickable rectangle with a subtle glow effect
  Widget buildTransparentButton(
    int index,
    double left,
    double top,
    double width,
    double height,
    VoidCallback onTap,
  ) {
    return Positioned(
      left: left - (width / 2),
      top: top - (height / 2),
      child: GestureDetector(
        onTap: disabledButtons[index] == true ? null : onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.transparent, // Fully transparent background
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  glowingButtons[index] == true
                      ? Colors.white.withOpacity(0.1) // Subtle white glow
                      : Colors.transparent,
              width: 4,
            ),
            boxShadow:
                glowingButtons[index] == true
                    ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ]
                    : [],
          ),
        ),
      ),
    );
  }
}
