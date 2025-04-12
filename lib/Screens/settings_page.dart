import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/manage_profile_page.dart';
import 'package:project_2cp_eq11/Screens/SelectProfilePage.dart';
import 'package:project_2cp_eq11/Screens/quit_page.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:project_2cp_eq11/Screens/quiz_page.dart';
import 'package:project_2cp_eq11/miniGames/jigsaw.dart';
import 'package:project_2cp_eq11/miniGames/choose.dart';

class SettingsPage extends StatefulWidget {
  final int profileNbr;

  const SettingsPage({Key? key, required this.profileNbr}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fennecController;
  late Animation<double> _fennecAnimation;

  bool masterV = true;
  bool music = true;
  bool narrator = true;

  Map<String, double> _buttonScales = {};

  @override
  void initState() {
    super.initState();

    // Fennec Animation with Bounce Effect
    _fennecController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _fennecAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(_fennecController);
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

  Widget _buildAnimatedButtonWithScale(
    String key,
    String iconPath,
    double width,
    double height,
    VoidCallback onTap,
  ) {
    _buttonScales.putIfAbsent(key, () => 1.0);

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

  @override
  void dispose() {
    _fennecController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    masterV =
        userData['Profiles']['Profile_${widget.profileNbr}']['Settings']['masterV'];
    music =
        userData['Profiles']['Profile_${widget.profileNbr}']['Settings']['music'];
    narrator =
        userData['Profiles']['Profile_${widget.profileNbr}']['Settings']['narrator'];

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset("assets/backgrounds/bg4.jpg", fit: BoxFit.fill),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "SETTINGS",
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

          Positioned(
            left: screenWidth * 0.07,
            top: screenHeight * 0.2,
            child: SizedBox(
              height: screenHeight * 0.62,
              width: screenWidth * 0.275,
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
                    "assets/icons/fennec/fennec_settings_icon.png",
                    height: screenHeight * 0.6,
                    width: screenWidth * 0.6,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            right: screenWidth * 0.147,
            top: screenHeight * 0.2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,

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
              ],
            ),
          ),

          Positioned(
            right: screenWidth * 0.13,
            top: screenHeight * 0.4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildAnimatedButtonWithScale(
                      "manage_profile",
                      "assets/icons/settings_page/manage_profile_icon.png",
                      screenWidth * 0.42,
                      screenWidth * 0.09,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ManageProfilePage(
                                  profileNbr: widget.profileNbr,
                                ),
                          ),
                        );
                      },
                    ),
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
                    _buildAnimatedButtonWithScale(
                      "change_profile",
                      "assets/icons/settings_page/change_profile.png",
                      screenWidth * 0.42,
                      screenWidth * 0.09,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectProfilePage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    _buildAnimatedButtonWithScale(
                      "quit",
                      "assets/icons/settings_page/quit_icon.png",
                      screenWidth * 0.085,
                      screenWidth * 0.09,
                      () {
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
        ],
      ),
    );
  }
}
