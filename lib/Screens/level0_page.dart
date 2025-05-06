import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:provider/provider.dart';

class Level0 extends StatefulWidget {
  final int profileNbr;
  const Level0({required this.profileNbr, Key? key}) : super(key: key);

  @override
  _Level0State createState() => _Level0State();
}

class _Level0State extends State<Level0> with SingleTickerProviderStateMixin {
  bool lockview = false;
  int currentPointIndex = 0;


  // Define your map points with text, image path, and audio path
  final List<Map<String, dynamic>> mapPoints = [
    {
      'text': "Hey there, little explorer!",
      'imagePath': "assets/images/level0/img1.png",
      'audioPath': "assets/audios/level0/1.mp3",
      'left': 0.05,
      'top': -0.03,
      'width': 0.7,
      'height': 0.7,
    },
    {
      'text': "Before we start our journey together, let us take a bit of time to learn some basic concepts.",
      'imagePath': "assets/images/level0/img2.png",
      'audioPath': "assets/audios/level0/2.mp3",
      'left': 0.05,
      'top': -0.03,
      'width': 0.7,
      'height': 0.7,
    },
    {
      'text': "These concepts will help you explore and better understand the wonders of ALGERIA!",
      'imagePath': "assets/images/level0/img3.png",
      'audioPath': "assets/audios/level0/3.mp3",
      'left': 0.05,
      'top': -0.03,
      'width': 0.7,
      'height': 0.7,
    },
    {
      'text': "Let’s start then. This is the map of ALGERIA — in other words, this is the shape of ALGERIA.",
      'imagePath': "assets/images/level0/img4.png",
      'audioPath': "assets/audios/level0/4.mp3",
      'left': 0.12,
      'top': 0.05,
      'width': 0.6,
      'height': 0.6,
    },
    {
      'text': "And as you can see, ALGERIA is a big country — in fact, it's the biggest country in Africa.",
      'imagePath': "assets/images/level0/img5.png",
      'audioPath': "assets/audios/level0/5.mp3",
      'left': 0.12,
      'top': 0.05,
      'width': 0.6,
      'height': 0.6,
    },
    {
      'text': "And because ALGERIA is so big, it’s divided into 58 small cities or wilayas.",
      'imagePath': "assets/images/level0/img6.png",
      'audioPath': "assets/audios/level0/6.mp3",
      'left': 0.12,
      'top': 0.05,
      'width': 0.6,
      'height': 0.6,
    },
    {
      'text': "Some famous Algerian cities are:",
      'imagePath': "assets/images/level0/img7.png",
      'audioPath': "assets/audios/level0/7.mp3",
      'left': 0.17,
      'top': 0.08,
      'width': 0.5,
      'height': 0.6,
    },
    {
      'text': "Some famous Algerian cities are:",
      'imagePath': "assets/images/level0/img8.png",
      'audioPath': "assets/audios/level0/7.mp3",
      'left': 0.18,
      'top': 0.02,
      'width': 0.5,
      'height': 0.6,
    },
    {
      'text': "And since ALGERIA is so big, it has many different landscapes... Aaah, you don't know this word yet, do you?",
      'imagePath': "assets/images/level0/img9.png",
      'audioPath': "assets/audios/level0/8.mp3",
      'left': 0.17,
      'top': 0.08,
      'width': 0.5,
      'height': 0.6,
    },
    {
      'text': "Let me explain with examples so you can understand better!!",
      'imagePath': "assets/images/level0/img9.png",
      'audioPath': "assets/audios/level0/9.mp3",
      'left': 0.17,
      'top': 0.08,
      'width': 0.5,
      'height': 0.6,
    },
    {
      'text': "You see all this water? It’s called the Sea, and it’s one of the landscapes. The sea is so big we swim, sail, and fish there.",
      'imagePath': "assets/images/level0/img10.png",
      'audioPath': "assets/audios/level0/10.mp3",
      'left': 0.17,
      'top': 0.1,
      'width': 0.5,
      'height': 0.5,
    },
    {
      'text': "And no, this is not a yellow sea, hehe. It’s called the desert, and it’s filled with sand! The weather is often so hot here.",
      'imagePath': "assets/images/level0/img11.png",
      'audioPath': "assets/audios/level0/11.mp3",
      'left': 0.17,
      'top': 0.1,
      'width': 0.5,
      'height': 0.5,
    },
    {
      'text': "This giant thing is called a mountain. It reaches up into the sky. Some even have snow on top!",
      'imagePath': "assets/images/level0/img12.png",
      'audioPath': "assets/audios/level0/12.mp3",
      'left': 0.17,
      'top': 0.1,
      'width': 0.5,
      'height': 0.5,
    },
    {
      'text': "Another landscape is the forest. This is a place filled with trees, animals, and shade. They’re green and full of life!",
      'imagePath': "assets/images/level0/img13.png",
      'audioPath': "assets/audios/level0/13.mp3",
      'left': 0.17,
      'top': 0.1,
      'width': 0.5,
      'height': 0.5,
    },
    {
      'text': "All of these are what we call landscapes. Aren’t they wonderful?",
      'imagePath': "assets/images/level0/img14.png",
      'audioPath': "assets/audios/level0/14.mp3",
      'left': 0.17,
      'top': 0.08,
      'width': 0.5,
      'height': 0.6,
    },
    {
      'text': "Now you may be asking again, where are all these landscapes located in ALGERIA?",
      'imagePath': "assets/images/level0/img15.png",
      'audioPath': "assets/audios/level0/15.mp3",
      'left': 0.17,
      'top': 0.08,
      'width': 0.5,
      'height': 0.6,
    },
    {
      'text': "To answer this, you must first know the four main directions.",
      'imagePath': "assets/images/level0/img16.png",
      'audioPath': "assets/audios/level0/16.mp3",
      'left': 0.17,
      'top': 0.08,
      'width': 0.5,
      'height': 0.6,
    },
    {
      'text': "The NORTH is up, the SOUTH is down, the EAST is right, and the WEST is left.",
      'imagePath': "assets/images/level0/img17.png",
      'audioPath': "assets/audios/level0/17.mp3",
      'left': 0.14,
      'top': 0.08,
      'width': 0.55,
      'height': 0.55,
    },
    {
      'text': "For example, CONSTANTINE is in the EAST and ORAN is in the WEST.",
      'imagePath': "assets/images/level0/img18.png",
      'audioPath': "assets/audios/level0/18.mp3",
      'left': 0.12,
      'top': 0.05,
      'width': 0.6,
      'height': 0.6,
    },
    {
      'text': "Excellent! You passed the level. I think you are ready to start this journey together. I promise it will be so fun!!!",
      'imagePath': "assets/images/level0/img19.png",
      'audioPath': "assets/audios/level0/19.mp3",
      'left': 0.16,
      'top': 0.06,
      'width': 0.5,
      'height': 0.6,
    },
  ];

  final AudioPlayer _player = AudioPlayer();
  late AnimationController _fennecController;
  late Animation<double> _fennecAnimation;
  late Map<String, dynamic> userData;

  Future<void> _playAudio(String assetPath) async {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    if (userData['Profiles']['Profile_${widget.profileNbr}']['Settings']["narrator"]) {
      await _player.stop();
      await _player.setAsset(assetPath);
      await _player.play();
    }
  }

  @override
  void initState() {
    super.initState();
    GameLogic.setAdv(context, widget.profileNbr, null);
    GameLogic.setRegion(context, widget.profileNbr, 0);
    _fennecController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _fennecAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(_fennecController);
    _playAudio(mapPoints[currentPointIndex]['audioPath']!);
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
    _player.dispose();
    _fennecController.dispose();
    super.dispose();
  }

  void _showNextPoint() {
    _player.stop();
    if (currentPointIndex < mapPoints.length - 1) {
      setState(() {
        currentPointIndex++;
        _playAudio(mapPoints[currentPointIndex]['audioPath']!);
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _showPreviousPoint() {
    _player.stop();
    if (currentPointIndex > 0) {
      setState(() {
        currentPointIndex--;
        _playAudio(mapPoints[currentPointIndex]['audioPath']!);
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _skipMap() {
    setState(() {
      currentPointIndex = mapPoints.length - 1;
      _playAudio(mapPoints[currentPointIndex]['audioPath']!);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var currentPoint = mapPoints[currentPointIndex];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/backgrounds/bg9.jpg", // Your background image path
              fit: BoxFit.cover,
            ),
          ),

          // Button Stack Positioned Vertically on the Left
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.02,
                top: screenHeight * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button with Confirmation Dialog
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
                                Navigator.pop(context); // Close dialog
                                Navigator.pop(context); // Go back
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
                  SizedBox(height: screenHeight * 0.02), // Spacing
                  // Question Button
                  /*  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {},
                      child: Ink.image(
                        image: AssetImage("assets/icons/question_icon.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02), // Spacing*/
                  // Pause Button
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        // Show the PauseDialog
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Prevent closing by tapping outside the dialog
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
                  SizedBox(height: screenHeight * 0.02), // Spacing
                ],
              ),
            ),
          ),

          Positioned(
            left: screenWidth * 0.55, // Adjust horizontal position
            top: screenHeight * 0.38, // Adjust vertical position
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
                  "assets/icons/region1/adventure1/fennec.png",
                  height: screenHeight * 0.6,
                  width: screenWidth * 0.6,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Positioned(
            left: screenWidth * 0.14,
            top: screenHeight * 0.65,
            child: SizedBox(
              width: screenWidth * 0.55, // optional: set max width
              child: Text(
                currentPoint['text'],
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: screenWidth * 0.02,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF56351E),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Positioned(
            left: screenWidth * currentPoint['left'],
            top: screenHeight * currentPoint['top'],
            child: Container(
              width: screenWidth * currentPoint['width'],
              height: screenHeight * currentPoint['height'],
              child: Image.asset(
                currentPoint['imagePath']!,
                fit:
                    BoxFit
                        .contain, // Fit the image properly within the container
              ),
            ),
          ),

          AnimatedGameButton(
            "assets/icons/region1/adventure1/back_button.png",
            screenWidth * 0.2,
            screenHeight * 0.2,
            screenWidth * 0.15,
            screenHeight * 0.827,
            onTap:
                _showPreviousPoint, // Assign the function for the back button
          ),
          AnimatedGameButton(
            "assets/icons/region1/adventure1/skip_button.png",
            screenWidth * 0.2,
            screenHeight * 0.2,
            screenWidth * 0.38,
            screenHeight * 0.827,
            onTap: _skipMap, // Skip action
          ),
          AnimatedGameButton(
            "assets/icons/region1/adventure1/next_button.png",
            screenWidth * 0.2,
            screenHeight * 0.2,
            screenWidth * 0.61,
            screenHeight * 0.827,
            onTap: _showNextPoint, // Assign the function for the next button
          ),
        ],
      ),
    );
  }
}
