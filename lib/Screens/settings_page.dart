import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io'; 
import 'dart:ui';
import 'package:project_2cp_eq11/Screens/select_profile_page.dart';
import 'package:project_2cp_eq11/Screens/new_profile.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

UserProfile currentUser = UserProfile(
  firstName: "Someone",
  lastName: "Noone",
  age: "10",
  avatarIndex: 2,
);


class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  late AnimationController _fennecController;
  late Animation<double> _fennecAnimation;
  
  bool isSoundOn = true;
  bool isMusicOn = true;
  bool isVoiceOn = true;

Map<String, double> _buttonScales = {};

  @override
void initState() {
  super.initState();

  // Fennec Animation with Bounce Effect
  _fennecController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 400), 
  );

  _fennecAnimation = Tween<double>(begin: 1.0, end: 1.2) 
      .animate(_fennecController);
}


  void _onFennecTapDown(TapDownDetails details) {
    _fennecController.forward();
    setState(() {}); // Ensure rebuild
  }

  void _onFennecTapUp(TapUpDetails details) {
    _fennecController.reverse();
    setState(() {}); // Ensure rebuild
  }

  void _onFennecTapCancel() {
    _fennecController.reverse();
    setState(() {}); // Ensure rebuild
  }

 Widget _buildAnimatedButtonWithScale(String key, String iconPath, double width, double height, VoidCallback onTap) {
  _buttonScales.putIfAbsent(key, () => 1.0); // Ensure each button has a default scale

  return GestureDetector(
    onTapDown: (_) => setState(() => _buttonScales[key] = 0.9),
    onTapUp: (_) => setState(() => _buttonScales[key] = 1.0),
    onTapCancel: () => setState(() => _buttonScales[key] = 1.0),
    onTap: onTap,
    child: AnimatedScale(
      scale: _buttonScales[key] ?? 1.0, // Get the scale for this button
      duration: Duration(milliseconds: 150),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(32),
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          splashColor: Colors.white.withOpacity(0.3),
          highlightColor: Colors.grey.withOpacity(0.1),
          child: Ink.image(
            image: AssetImage(iconPath),
            width: width,
            height: height,
            fit: BoxFit.contain,
          ),
        ),
      ),
    ),
  );
}



  // Animated Button Builder
  Widget _buildAnimatedButton(double width , double heigth ,String activeIcon, String inactiveIcon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Image.asset(
          isActive ? activeIcon : inactiveIcon,
          key: ValueKey<bool>(isActive), // Ensure smooth animation when changing states
          width: width, // Adjust size if needed
          height: heigth,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  // Function for the window showed when quitting the app
  void _showQuitConfirmationDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Quit Confirmation",
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), 
                child: Container(
                  color: Colors.black.withOpacity(0.4), 
                ),
              ),
            ),
            Center(
              child: Material(
                color: Colors.transparent,
                child: ScaleTransition(
                  scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
                  child: Container(
                    width: 340,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15)],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/icons/fennec_settings_icon.png",
                          height: 120,
                          width: 120,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Exit the Game?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Are you sure you want to quit? Your progress is saved!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildYesNoButton("Cancel", Colors.greenAccent, () => Navigator.of(context).pop()),
                            _buildYesNoButton("Quit", const Color.fromRGBO(255, 82, 82, 1), () {
                              _exitGame();
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }


  // Quit Game Function
  void _exitGame() {
    if (Platform.isAndroid) {
      SystemNavigator.pop(); // Exit on Android
    } else if (Platform.isIOS) {
      exit(0); // Force exit on iOS
    }
  }

  // Buttons when quit clicked
  Widget _buildYesNoButton(String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.9),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.6), blurRadius: 8, offset: Offset(2, 4))
          ],
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fennecController.dispose();
    super.dispose();
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
              "assets/backgrounds/settings_page.jpg",
              fit: BoxFit.cover,
            ),
          ),

          Align(
                  alignment: Alignment.topLeft, 
                  child: Padding(
                  padding: EdgeInsets.only(top: 8, left: 16, right: 16),
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

          // **Fennec Avatar (Animated)**
          Positioned(
            left: -screenWidth * 0.1, // Adjusted to prevent off-screen positioning
            top: screenHeight * 0.2,
            child: GestureDetector(
              onTapDown: _onFennecTapDown,
              onTapUp: _onFennecTapUp,
              onTapCancel: _onFennecTapCancel,
              child: AnimatedBuilder(
                animation: _fennecAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _fennecAnimation.value,
                    child: child,
                  );
                },
                child: Image.asset(
                  "assets/icons/fennec_settings_icon.png",
                  height: screenHeight * 0.6,
                  width: screenWidth * 0.6,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // **Buttons (No Animation)**
          Positioned(
            right: screenWidth * 0.14,
            top: screenHeight * 0.2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildAnimatedButton(screenWidth * 0.09, screenWidth * 0.09,
                      "assets/icons/sound_icon.png",
                      "assets/icons/music_icon.png",
                      isSoundOn,
                      () => setState(() => isSoundOn = !isSoundOn),
                    ),
                    SizedBox(width: screenWidth * 0.06),
                    _buildAnimatedButton(screenWidth * 0.09, screenWidth * 0.09,
                      "assets/icons/music_icon.png",
                      "assets/icons/music_icon.png",
                      isMusicOn,
                      () => setState(() => isMusicOn = !isMusicOn),
                    ),
                    SizedBox(width: screenWidth * 0.06),
                    _buildAnimatedButton(screenWidth * 0.09, screenWidth * 0.09,
                      "assets/icons/voice_icon.png",
                      "assets/icons/voice_icon.png",
                      isVoiceOn,
                      () => setState(() => isVoiceOn = !isVoiceOn),
                    ),
                  ],
                ),
              ],
            ),
          ),


          Positioned(
            right: screenWidth * 0.125,
            top: screenHeight * 0.4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildAnimatedButtonWithScale("edit_profile", "assets/icons/edit_profile_icon.png", screenWidth * 0.42, screenWidth * 0.09, () {Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => UserInfoForm(isEditing: true, existingProfile: currentUser),
                      ),
                    );
                  }),
                  ],
                ),
              ],
            ),
          ),


          Positioned(
            right: screenWidth * 0.035,
            top: screenHeight * 0.6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildAnimatedButtonWithScale("change_profile", "assets/icons/change_profile.png", screenWidth * 0.42, screenWidth * 0.09, () {Navigator.push(context,MaterialPageRoute(builder: (context) => select_profile_page(),),);}),
                    SizedBox(width: screenWidth * 0.01),
                    _buildAnimatedButtonWithScale("quit","assets/icons/quit_icon.png",screenWidth * 0.085,screenWidth * 0.09,() => _showQuitConfirmationDialog(context), ),                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
