import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';

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
          'Hello and welcome again!  let me show you a few things to help you get started',
      'voice': 'audios/firstSteps/1.mp3',
    },
    {
      'text':
          'When you launch the application for the first time you will be directed to the login page ',
      'voice': 'audios/firstSteps/2.mp3',
    },
    {
      'text': 'From the login page, you have two options:',
      'voice': 'audios/firstSteps/3.mp3',
    },
    {
      'text':
          'Create: If you are a new user, you can create an account to save your progress',
      'voice': 'audios/firstSteps/4.mp3',
    },
    {
      'text':
          'you enter your informations (first name, last name, age, and profile picture) ',
      'voice': 'audios/firstSteps/5.mp3',
    },
    {
      'text':
          'select: If you already have an account, select your account and continue your adventure !',
      'voice': 'audios/firstSteps/6.mp3',
    },
    {
      'text': 'After logging in you will access the main menu of the game',
      'voice': 'audios/firstSteps/7.mp3',
    },
    {
      'text':
          'You will find 5 different frames and main board each one is a button you can tap',
      'voice': 'audios/firstSteps/8.mp3',
    },
    {
      'text':
          'the board with the Algerian map will allow you to access the main story mode',
      'voice': 'audios/firstSteps/9.mp3',
    },
    {
      'text':
          'after chosing the board you will navigate the four main regions of algeria',
      'voice': 'audios/firstSteps/10.mp3',
    },
    {
      'text':
          'each region contain 2 adventures ... each one will take place in a different wilaya ',
      'voice': 'audios/firstSteps/11.mp3',
    },
    {
      'text':
          'some adventures need to be unlocked by progressing the story before you can access them ... ',
      'voice': 'audios/firstSteps/12.mp3',
    },
    {
      'text':
          'each adventure will have different places to discover and learn from',
      'voice': 'audios/firstSteps/13.mp3',
    },
    {
      'text':
          'and of course i will stick by your side along your journey and together we will meet many friends',
      'voice': 'audios/firstSteps/14.mp3',
    },
    {
      'text': 'you will learn plenty of informations from me and my friends ',
      'voice': 'audios/firstSteps/15.mp3',
    },
    {
      'text':
          'and we will get the chance to play too !\nwe 3 mini games to check in every adventure',
      'voice': 'audios/firstSteps/16.mp3',
    },
    {
      'text':
          'after finish exploring the whole region , you need to pass a quick test to check your learning',
      'voice': 'audios/firstSteps/17.mp3',
    },
    {
      'text': 'you need a certain number of correct answers to pass the quiz',
      'voice': 'audios/firstSteps/18.mp3',
    },
    {
      'text': 'after finishing the quiz a new region will be unlocked ',
      'voice': 'audios/firstSteps/19.mp3',
    },
    {
      'text': 'next let me show the mini-games window ',
      'voice': 'audios/firstSteps/20.mp3',
    },
    {
      'text':
          'here you can replay all the games that you encountered in the story mode',
      'voice': 'audios/firstSteps/21.mp3',
    },
    {
      'text':
          'This section offers six educational games (puzzles, spot, memory, play, search, and choose)',
      'voice': 'audios/firstSteps/22.mp3',
    },
    {
      'text':
          'each mini-game will have four levels corresponding to one of the four regions',
      'voice': 'audios/firstSteps/23.mp3',
    },
    {
      'text':
          'you need to play the mini-game first in the story in order to unlock them here',
      'voice': 'audios/firstSteps/24.mp3',
    },
    {
      'text': 'try finishing the games as fast as you can to get more stars .',
      'voice': 'audios/firstSteps/25.mp3',
    },
    {
      'text':
          'The second button in the main menu gives access to the Achievements section',
      'voice': 'audios/firstSteps/26.mp3',
    },
    {
      'text': 'here you can keep track on your progress and get your rewards.',
      'voice': 'audios/firstSteps/27.mp3',
    },
    {
      'text':
          'there are 4 Cups: A cup is obtained when an entire region is completed.',
      'voice': 'audios/firstSteps/28.mp3',
    },
    {
      'text':
          'there is also 8 Medals: A medal is awarded at the end of each successful adventure.',
      'voice': 'audios/firstSteps/29.mp3',
    },
    {
      'text':
          'Clicking on a cup or a medal will give you more details on the trophy',
      'voice': 'audios/firstSteps/30.mp3',
    },
    {
      'text': 'The third button in the main menu gives access to the Settings',
      'voice': 'audios/firstSteps/31.mp3',
    },
    {
      'text':
          'here you can customize tour  game experience This section contains six buttons',
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
      'text':
          'Manage Profile: Displays two options:you can ethier edit or delete your profile ',
      'voice': 'audios/firstSteps/36.mp3',
    },
    {
      'text': 'change profile: where you can change the user profile .',
      'voice': 'audios/firstSteps/37.mp3',
    },
    {
      'text':
          'Quit the Game: A confirmation message appears before fully exiting the game.',
      'voice': 'audios/firstSteps/38.mp3',
    },
    {
      'text':
          'The fourth button in the main menu gives you to the Statistics, where you can track their detailed progress.',
      'voice': 'audios/firstSteps/39.mp3',
    },
    {
      'text':
          'you can choose between the statistics of the four regions: North, East, West, and South.',
      'voice': 'audios/firstSteps/40.mp3',
    },
    {
      'text': 'For each region, the table displays the following stats:',
      'voice': 'audios/firstSteps/41.mp3',
    },
    {
      'text': 'Mini-games completed: Number of mini-games finished out of 6',
      'voice': 'audios/firstSteps/42.mp3',
    },
    {
      'text': 'Adventures completed: Number of successful adventures out of 2.',
      'voice': 'audios/firstSteps/43.mp3',
    },
    {
      'text':
          'Stars collected: Total number of stars obtained out of 18 (each mini-game contains 3 stars).',
      'voice': 'audios/firstSteps/44.mp3',
    },
    {
      'text': 'Monuments visited: Number of monuments explored out of 6.',
      'voice': 'audios/firstSteps/45.mp3',
    },
    {
      'text':
          'Progress Rate: A percentage representing the player’s overall advancement in the region based on the past elements.',
      'voice': 'audios/firstSteps/46.mp3',
    },
    {
      'text':
          'The fifth button in the main menu gives access to the Help section, where you can find explanations about the game’s features.',
      'voice': 'audios/firstSteps/47.mp3',
    },
    {
      'text':
          'here you can repeat the tutorial if you wish and you can also read more on the game mechanics in details !',
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
                    SizedBox(height: 10),

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
                    SizedBox(height: 10),
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
                            fontSize: 20,
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
                                fontSize: 18,
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
                              fontSize: 18,
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
                              fontSize: 18,
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
