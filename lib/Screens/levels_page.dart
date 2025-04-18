import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:project_2cp_eq11/miniGames/rules_ofMiniGames.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class LevelsPage extends StatefulWidget {
  final int profileNbr;
  final String minigameType;

  const LevelsPage({
    Key? key,
    required this.profileNbr,
    required this.minigameType,
  }) : super(key: key);

  @override
  _LevelsPageState createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fennecController;
  late Animation<double> _fennecAnimation;

  @override
  void initState() {
    super.initState();
    _fennecController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _fennecAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(_fennecController);
  }

  Future<void> _adjustVolume(double volume) async {
    await MusicController().setVolume(volume);
  }

  void _onFennecTapDown(TapDownDetails details) {
    _fennecController.forward();
  }

  void _onFennecTapUp(TapUpDetails details) {
    _fennecController.reverse();
  }

  void _onFennecTapCancel() {
    _fennecController.reverse();
  }

  @override
  void dispose() {
    _fennecController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    int gameNb = 1;

    switch (widget.minigameType) {
      case 'Find':
        gameNb = 5;
        break;
      case 'Puzzle':
        gameNb = 1;
        break;
      case 'Match':
        gameNb = 4;
        break;
      case 'Choose':
        gameNb = 6;
        break;
      case 'Memory':
        gameNb = 2;
        break;
      case 'Spot':
        gameNb = 3;
        break;
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset("assets/backgrounds/bg5.jpg", fit: BoxFit.fill),
          ),

          // Back Button (Top Left)
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
            left: -screenWidth * 0.15,
            top: screenHeight * 0.15,
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
                  "assets/icons/fennec/happy_fennec_icon.png",
                  height: screenHeight * 0.65,
                  width: screenWidth * 0.65,
                  fit: BoxFit.contain,
                ),
              ),
            ),
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
                    "LEVELS",
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

          Stack(
            children: [
              Stack(
                children: [
                  Positioned(
                    left: screenWidth * 0.27,
                    top: screenHeight * 0.53,
                    child: Image.asset(
                      "assets/icons/levels_page/red_stars_container_icon.png",
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.14,
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    left: screenWidth * 0.44,
                    top: screenHeight * 0.4,
                    child: Image.asset(
                      "assets/icons/levels_page/blue_stars_container_icon.png",
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.14,
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    left: screenWidth * 0.61,
                    top: screenHeight * 0.53,
                    child: Image.asset(
                      "assets/icons/levels_page/yellow_stars_container_icon.png",
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.14,
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    left: screenWidth * 0.77,
                    top: screenHeight * 0.4,
                    child: Image.asset(
                      "assets/icons/levels_page/red_stars_container_icon.png",
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.14,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames'][widget
                  .minigameType][0])
                AnimatedGameButton(
                  "assets/icons/levels_page/level1_icon.png",
                  screenWidth * 0.35,
                  screenHeight * 0.35,
                  screenWidth * 0.22,
                  screenHeight * 0.2,
                  onTap: () {
                    _adjustVolume(0);
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder:
                                (context) => RulesGamePage(
                                  profileNbr: widget.profileNbr,
                                  gameNb: gameNb,
                                  levelNb: 1,
                                  fromAdv: false,
                                ),
                          ),
                        )
                        .then((_) {
                          _adjustVolume(0.4);
                          setState(() {});
                        });
                  },
                )
              else
                AnimatedGameButton(
                  "assets/icons/levels_page/level1_4_locked_icon.png",
                  screenWidth * 0.35,
                  screenHeight * 0.35,
                  screenWidth * 0.22,
                  screenHeight * 0.2,
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames'][widget
                  .minigameType][1])
                AnimatedGameButton(
                  "assets/icons/levels_page/level2_icon.png",
                  screenWidth * 0.35,
                  screenHeight * 0.35,
                  screenWidth * 0.39,
                  screenHeight * 0.52,
                  onTap: () {
                    _adjustVolume(0);
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder:
                                (context) => RulesGamePage(
                                  profileNbr: widget.profileNbr,
                                  gameNb: gameNb,
                                  levelNb: 2,
                                  fromAdv: false,
                                ),
                          ),
                        )
                        .then((_) {
                          _adjustVolume(0.4);
                          setState(() {});
                        });
                  },
                )
              else
                AnimatedGameButton(
                  "assets/icons/levels_page/level2_locked_icon.png",
                  screenWidth * 0.35,
                  screenHeight * 0.35,
                  screenWidth * 0.39,
                  screenHeight * 0.52,
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames'][widget
                  .minigameType][2])
                AnimatedGameButton(
                  "assets/icons/levels_page/level3_icon.png",
                  screenWidth * 0.35,
                  screenHeight * 0.35,
                  screenWidth * 0.56,
                  screenHeight * 0.2,
                  onTap: () {
                    _adjustVolume(0);
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder:
                                (context) => RulesGamePage(
                                  profileNbr: widget.profileNbr,
                                  gameNb: gameNb,
                                  levelNb: 3,
                                  fromAdv: false,
                                ),
                          ),
                        )
                        .then((_) {
                          _adjustVolume(0.4);
                          setState(() {});
                        });
                  },
                )
              else
                AnimatedGameButton(
                  "assets/icons/levels_page/level3_locked_icon.png",
                  screenWidth * 0.35,
                  screenHeight * 0.35,
                  screenWidth * 0.56,
                  screenHeight * 0.2,
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames'][widget
                  .minigameType][3])
                AnimatedGameButton(
                  "assets/icons/levels_page/level4_icon.png",
                  screenWidth * 0.35,
                  screenHeight * 0.35,
                  screenWidth * 0.72,
                  screenHeight * 0.52,
                  onTap: () {
                    _adjustVolume(0);
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder:
                                (context) => RulesGamePage(
                                  profileNbr: widget.profileNbr,
                                  gameNb: gameNb,
                                  levelNb: 4,
                                  fromAdv: false,
                                ),
                          ),
                        )
                        .then((_) {
                          _adjustVolume(0.4);
                          setState(() {});
                        });
                  },
                )
              else
                AnimatedGameButton(
                  "assets/icons/levels_page/level1_4_locked_icon.png",
                  screenWidth * 0.35,
                  screenHeight * 0.35,
                  screenWidth * 0.72,
                  screenHeight * 0.52,
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][0] ==
                  0)
                Positioned(
                  left: screenWidth * 0.325,
                  top: screenHeight * 0.555,
                  child: Image.asset(
                    "assets/icons/levels_page/0stars_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][0] ==
                  1)
                Positioned(
                  left: screenWidth * 0.325,
                  top: screenHeight * 0.555,
                  child: Image.asset(
                    "assets/icons/levels_page/1star_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][0] ==
                  2)
                Positioned(
                  left: screenWidth * 0.325,
                  top: screenHeight * 0.555,
                  child: Image.asset(
                    "assets/icons/levels_page/2stars_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][0] ==
                  3)
                Positioned(
                  left: screenWidth * 0.325,
                  top: screenHeight * 0.555,
                  child: Image.asset(
                    "assets/icons/levels_page/3stars_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][1] ==
                  0)
                Positioned(
                  left: screenWidth * 0.495,
                  top: screenHeight * 0.425,
                  child: Image.asset(
                    "assets/icons/levels_page/0stars_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][1] ==
                  1)
                Positioned(
                  left: screenWidth * 0.495,
                  top: screenHeight * 0.425,
                  child: Image.asset(
                    "assets/icons/levels_page/1star_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][1] ==
                  2)
                Positioned(
                  left: screenWidth * 0.495,
                  top: screenHeight * 0.425,
                  child: Image.asset(
                    "assets/icons/levels_page/2stars_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][1] ==
                  3)
                Positioned(
                  left: screenWidth * 0.495,
                  top: screenHeight * 0.425,
                  child: Image.asset(
                    "assets/icons/levels_page/3stars_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][2] ==
                  0)
                Positioned(
                  left: screenWidth * 0.665,
                  top: screenHeight * 0.555,
                  child: Image.asset(
                    "assets/icons/levels_page/0stars_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][2] ==
                  1)
                Positioned(
                  left: screenWidth * 0.665,
                  top: screenHeight * 0.555,
                  child: Image.asset(
                    "assets/icons/levels_page/1star_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][2] ==
                  2)
                Positioned(
                  left: screenWidth * 0.665,
                  top: screenHeight * 0.555,
                  child: Image.asset(
                    "assets/icons/levels_page/2stars_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][2] ==
                  3)
                Positioned(
                  left: screenWidth * 0.665,
                  top: screenHeight * 0.555,
                  child: Image.asset(
                    "assets/icons/levels_page/3stars_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][3] ==
                  0)
                Positioned(
                  left: screenWidth * 0.825,
                  top: screenHeight * 0.425,
                  child: Image.asset(
                    "assets/icons/levels_page/0stars_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][3] ==
                  1)
                Positioned(
                  left: screenWidth * 0.825,
                  top: screenHeight * 0.425,
                  child: Image.asset(
                    "assets/icons/levels_page/1star_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][3] ==
                  2)
                Positioned(
                  left: screenWidth * 0.825,
                  top: screenHeight * 0.425,
                  child: Image.asset(
                    "assets/icons/levels_page/2stars_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),

              if (userData['Profiles']['Profile_${widget.profileNbr}']['minigames']["${widget.minigameType}Star"][3] ==
                  3)
                Positioned(
                  left: screenWidth * 0.825,
                  top: screenHeight * 0.425,
                  child: Image.asset(
                    "assets/icons/levels_page/3stars_icon.png",
                    width: screenWidth * 0.14,
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class AnimatedGameButton extends StatefulWidget {
  final String iconPath;
  final double width;
  final double height;
  final double left;
  final double top;
  final Widget? destination;
  final VoidCallback? onTap;

  AnimatedGameButton(
    this.iconPath,
    this.width,
    this.height,
    this.left,
    this.top, {
    this.destination,
    this.onTap,
  });

  @override
  _AnimatedGameButtonState createState() => _AnimatedGameButtonState();
}

class _AnimatedGameButtonState extends State<AnimatedGameButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
      lowerBound: 0.75,
      upperBound: 1.2,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.forward().then((_) => _controller.reverse());

    if (widget.onTap != null) {
      widget.onTap!();
    }

    if (widget.destination != null) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => widget.destination!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: GestureDetector(
        onTap: _onTap,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset(
            widget.iconPath,
            width: widget.width,
            height: widget.height,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
