import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';

/// ============================================================================
/// firstSteps.dart
/// ============================================================================
/// this screen shows a quick tutorial about the game
///
/// called from help_page.dart
/// ============================================================================

class FirstSteps extends StatefulWidget {
  final int profileNbr;

  const FirstSteps({Key? key, required this.profileNbr}) : super(key: key);

  @override
  _FirstStepsState createState() => _FirstStepsState();
}

class _FirstStepsState extends State<FirstSteps>
    with SingleTickerProviderStateMixin {
  late AnimationController _fennecController;
  late Animation<double> _fennecAnimation;
  int index = 1;
  late AudioPlayer _audioPlayer;
  bool voice = true;

  List<Map<String, String>> steps = [
    {
      'text':
          'Hello and welcome again! Let me show you a few things to help you get started.',
      'voice': 'audios/firstSteps/1.mp3',
    },
    {
      'text':
          'When you launch the application for the first time, you will be directed to the profiles page.',
      'voice': 'audios/firstSteps/2.mp3',
    },
    {
      'text': 'From the profiles page, you have two options:',
      'voice': 'audios/firstSteps/3.mp3',
    },
    {
      'text':
          'Create: If you are a new user, you can create a new profile to save your progress.',
      'voice': 'audios/firstSteps/4.mp3',
    },
    {
      'text':
          'You’ll enter your information (first name, last name, age, and profile picture).',
      'voice': 'audios/firstSteps/5.mp3',
    },
    {
      'text':
          'Select: If you already have a profile, just select it and continue your adventure!',
      'voice': 'audios/firstSteps/6.mp3',
    },
    {
      'text':
          'After Creating or selecting a profile, you will access the main menu of the game.',
      'voice': 'audios/firstSteps/7.mp3',
    },
    {
      'text':
          'You will find 5 different frames and the main board. Each one is a button you can tap.',
      'voice': 'audios/firstSteps/8.mp3',
    },
    {
      'text':
          'The board with the Algerian map will take you to the main story mode.',
      'voice': 'audios/firstSteps/9.mp3',
    },
    {
      'text':
          'After choosing the board, you will explore the four main regions of Algeria.',
      'voice': 'audios/firstSteps/10.mp3',
    },
    {
      'text':
          'Each region contains 2 adventures, each taking place in a different wilaya.',
      'voice': 'audios/firstSteps/11.mp3',
    },
    {
      'text':
          'Some adventures need to be unlocked by progressing through the story.',
      'voice': 'audios/firstSteps/12.mp3',
    },
    {
      'text':
          'Each adventure will have different places to discover and learn about.',
      'voice': 'audios/firstSteps/13.mp3',
    },
    {
      'text':
          'And of course, I’ll stick by your side along the journey! We’ll meet many friends together.',
      'voice': 'audios/firstSteps/14.mp3',
    },
    {
      'text': 'You’ll learn a lot from me and my friends.',
      'voice': 'audios/firstSteps/15.mp3',
    },
    {
      'text':
          'And we’ll get the chance to play too! Each adventure has 3 mini-games to enjoy.',
      'voice': 'audios/firstSteps/16.mp3',
    },
    {
      'text':
          'After finishing a whole region, you’ll take a quick test to check what you’ve learned.',
      'voice': 'audios/firstSteps/17.mp3',
    },
    {
      'text':
          'You’ll need a certain number of correct answers to pass the quiz.',
      'voice': 'audios/firstSteps/18.mp3',
    },
    {
      'text': 'When you pass the quiz, a new region will be unlocked!',
      'voice': 'audios/firstSteps/19.mp3',
    },
    {
      'text': 'Next, let me show you the mini-games window.',
      'voice': 'audios/firstSteps/20.mp3',
    },
    {
      'text':
          'Here you can replay all the games you encountered in the story mode.',
      'voice': 'audios/firstSteps/21.mp3',
    },
    {
      'text':
          'This section offers six educational games: puzzles, spot the difference, memory, play, search, and choose.',
      'voice': 'audios/firstSteps/22.mp3',
    },
    {
      'text': 'Each mini-game has four levels, one for each region.',
      'voice': 'audios/firstSteps/23.mp3',
    },
    {
      'text':
          'You need to play the mini-game first in the story to unlock it here.',
      'voice': 'audios/firstSteps/24.mp3',
    },
    {
      'text': 'Try to finish the games as fast as you can to earn more stars!',
      'voice': 'audios/firstSteps/25.mp3',
    },
    {
      'text':
          'The second button in the main menu gives you access to the Achievements section.',
      'voice': 'audios/firstSteps/26.mp3',
    },
    {
      'text':
          'Here, you can keep track of your progress and collect your rewards.',
      'voice': 'audios/firstSteps/27.mp3',
    },
    {
      'text':
          'There are 4 Cups: A cup is earned when an entire region is completed.',
      'voice': 'audios/firstSteps/28.mp3',
    },
    {
      'text':
          'There are also 8 Medals: A medal is awarded at the end of each successful adventure.',
      'voice': 'audios/firstSteps/29.mp3',
    },
    {
      'text':
          'Clicking on a cup or medal gives you more details about the trophy.',
      'voice': 'audios/firstSteps/30.mp3',
    },
    {
      'text': 'The third button in the main menu gives you access to Settings.',
      'voice': 'audios/firstSteps/31.mp3',
    },
    {
      'text':
          'Here, you can customize your game experience. This section has six buttons:',
      'voice': 'audios/firstSteps/32.mp3',
    },
    {
      'text': 'Toggles sound effects on or off.',
      'voice': 'audios/firstSteps/33.mp3',
    },
    {
      'text': 'Enable/Disable Music: Toggles background music on or off.',
      'voice': 'audios/firstSteps/34.mp3',
    },
    {
      'text': ' Toggles dialogues on or off.',
      'voice': 'audios/firstSteps/35.mp3',
    },
    {
      'text': 'Manage Profile: You can edit or delete your profile.',
      'voice': 'audios/firstSteps/36.mp3',
    },
    {
      'text': 'Change Profile: Switch between user profiles.',
      'voice': 'audios/firstSteps/37.mp3',
    },
    {
      'text':
          'Quit the Game: A confirmation message will appear before exiting.',
      'voice': 'audios/firstSteps/38.mp3',
    },
    {
      'text':
          'The fourth button in the main menu gives you access to the Statistics section.',
      'voice': 'audios/firstSteps/39.mp3',
    },
    {
      'text':
          'You can view statistics for each region: North, East, West, and South.',
      'voice': 'audios/firstSteps/40.mp3',
    },
    {
      'text': 'For each region, the table displays the following stats:',
      'voice': 'audios/firstSteps/41.mp3',
    },
    {
      'text': 'Mini-games completed: Number of games finished out of 6.',
      'voice': 'audios/firstSteps/42.mp3',
    },
    {
      'text': 'Adventures completed: Number of completed adventures out of 2.',
      'voice': 'audios/firstSteps/43.mp3',
    },
    {
      'text':
          'Stars collected: Total stars earned out of 18 (each mini-game has 3 stars).',
      'voice': 'audios/firstSteps/44.mp3',
    },
    {
      'text': 'Monuments visited: Number of monuments explored out of 6.',
      'voice': 'audios/firstSteps/45.mp3',
    },
    {
      'text': 'Progress Rate: Your overall progress percentage for the region.',
      'voice': 'audios/firstSteps/46.mp3',
    },
    {
      'text':
          'The fifth button in the main menu gives access to the Help section.',
      'voice': 'audios/firstSteps/47.mp3',
    },
    {
      'text':
          'Here, you can replay the tutorial and read more about the game mechanics in detail!',
      'voice': 'audios/firstSteps/48.mp3',
    },
  ];

  int lastPageNb = 0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(); // Initialize the audio player
    index = 1;
    lastPageNb = steps.length;
    // Fennec Animation with Bounce Effect
    _fennecController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _fennecAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(_fennecController);

    voice = GameLogic.narrator(context, widget.profileNbr);

    if (voice) {
      _audioPlayer.play(AssetSource(steps[index - 1]['voice']!));
    }
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

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose the audio player
    _fennecController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttomWidth = MediaQuery.of(context).size.width * 0.055;
    double buttomHeight = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: Colors.white),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenWidth*0.01),
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Ink.image(
                        image: AssetImage("assets/icons/back_icon.png"),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
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
                      "assets/icons/fennec/helpFennec.png",
                      height: screenHeight * 0.7,
                      width: screenWidth * 0.7,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              Container(
                height: screenHeight * 0.90,
                width: screenWidth * 0.62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Color(0xFFFFCB7C), // You can change the color
                    width: 7.0, // You can adjust the thickness
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenWidth*0.01),

                    Container(
                      height: screenHeight * 0.5,
                      width: screenWidth * 0.56,
                      child: Image.asset(
                        "assets/images/Help/image${index.toString().padLeft(2, '0')}.png",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 60,
                        child: Text(
                          steps[index - 1]["text"]!,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF56351E),
                            fontFamily: "Fredoka",
                            fontSize: screenWidth*0.022,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (index > 1)
                          ElevatedButton(
                            onPressed: () {
                              if (index > 1) {
                                setState(() {
                                  index--;
                                  if (voice) {
                                    _audioPlayer.play(
                                      AssetSource(steps[index - 1]['voice']!),
                                    );
                                  }
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: buttomWidth,

                                vertical: buttomHeight,
                              ),
                              textStyle: TextStyle(
                                fontSize: screenWidth*0.02,
                                fontFamily: "Fredoka",
                                fontWeight: FontWeight.bold,
                              ),
                              backgroundColor: Color(0xFFFE6D73),
                              foregroundColor: Color(0xFF56351E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text("Back"),
                          ),
                        ElevatedButton(
                          onPressed: () {
                            if (index > 0) {
                              if (index < 9) {
                                setState(() {
                                  index = 9;
                                  voice = GameLogic.narrator(
                                    context,
                                    widget.profileNbr,
                                  );
                                });
                              } else if (index < 20) {
                                setState(() {
                                  index = 20;
                                });
                              } else if (index < 26) {
                                setState(() {
                                  index = 26;
                                });
                              } else if (index < 31) {
                                setState(() {
                                  index = 31;
                                });
                              } else if (index < 39) {
                                setState(() {
                                  index = 39;
                                });
                              } else if (index < 47) {
                                setState(() {
                                  index = 47;
                                });
                              } else {
                                Navigator.pop(context);
                              }

                              if (voice) {
                                _audioPlayer.play(
                                  AssetSource(steps[index - 1]['voice']!),
                                );
                              }
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: buttomWidth,
                              vertical: buttomHeight,
                            ),
                            textStyle: TextStyle(
                              fontSize: screenWidth*0.02,
                              fontFamily: "Fredoka",
                              fontWeight: FontWeight.bold,
                            ),
                            backgroundColor: Color(0xFFFFCB7C),
                            foregroundColor: Color(0xFF56351E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text("Skip"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (index < lastPageNb) {
                              setState(() {
                                index++;
                                if (voice) {
                                  _audioPlayer.play(
                                    AssetSource(steps[index - 1]['voice']!),
                                  );
                                }
                              });
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: buttomWidth,
                              vertical: buttomHeight,
                            ),
                            textStyle: TextStyle(
                              fontSize: screenWidth*0.02,
                              fontFamily: "Fredoka",
                              fontWeight: FontWeight.bold,
                            ),
                            backgroundColor: Color(0xFF53C8C1),
                            foregroundColor: Color(0xFF56351E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text("Next"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
