import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:project_2cp_eq11/miniGames/choose.dart';
import 'package:project_2cp_eq11/miniGames/find_game_page.dart';
import 'package:project_2cp_eq11/miniGames/match_game_page.dart';
import 'package:project_2cp_eq11/miniGames/spot_game_page.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/miniGames/jigsaw.dart';
import 'package:project_2cp_eq11/miniGames/memory_game_page.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';
import 'package:project_2cp_eq11/miniGames/logic.dart';

class RulesGamePage extends StatefulWidget {
  final int profileNbr;
  final int gameNb, levelNb;
  final bool fromAdv;

  const RulesGamePage({
    Key? key,
    required this.profileNbr,
    required this.gameNb,
    required this.levelNb,
    required this.fromAdv,
  }) : super(key: key);

  @override
  _RulesGamePageState createState() => _RulesGamePageState();
}

class _RulesGamePageState extends State<RulesGamePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  List<String> rules = [];

  @override
  void initState() {
    super.initState();
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    String regionn = "";
    switch (widget.levelNb) {
      case (1):
        regionn = "wilaya1";
        break;
      case (2):
        regionn = "wilaya2";
        break;
      case (3):
        regionn = "wilaya3";
        break;
      case (4):
        regionn = "wilaya4";
        break;
    }
    int age =
        int.tryParse(
          userData['Profiles']['Profile_${widget.profileNbr}']['age']
              .toString(),
        ) ??
        0;
    String st3 =
        (age <= 6)
            ? "Finish under 0:30 to get\nFinish under 1:00 to get\nFinish under 1:30 to get"
            : "Finish under 1:00 to get\nFinish under 2:00 to get\nFinish under 3:00 to get";

    switch (widget.gameNb) {
      case 1: // Puzzle
        rules = [
          "1 -You need to assemble the scrambled puzzle pieces..",
          "2 -try to finish as fast as possible !!",
          st3,
          "Are you ready for\nthe puzzle",
        ];
        break;
      case 2: // Memory
        rules = [
          "1 - You need to memorize the \nplaces of the similair cards ",
          "2 - try to find all the matches as \nfast as possible !!",
          st3,
          "Are you ready for\nthe puzzle",
        ];
        break;
      case 3: // Spot
        rules = [
          "1 - there are five differences \nbetween these two pictures",
          "2 - try to find them as fast \nas possible !!",
          st3,
          "Are you ready for\nthe puzzle",
        ];
        break;
      case 4: //Match
        rules = [
          "1 - these are some monuments \nand some names",
          "2 - drag the names and drop \nthem in thier correspending \nplaces as fast as possible !!",
          st3,
          "Are you ready for\nthe puzzle",
        ];
        break;
      case 5: //Find
        rules = [
          "1 -You have a list of hidden \nobjects .",
          "2 -try to find the hidden objects \nas fast as possible !!",
          st3,
          "Are you ready for\nthe puzzle",
        ];
        break;
      case 6: //Choose
        rules = [
          "1 - here are some cards with \ndifferent pictures",
          "2 - try to select all the pictures \nrelated to $regionn  as fast as \npossible !!",
          st3,
          "Are you ready for\nthe puzzle",
        ];
        break;
      default:
        rules = ["No rules available for this game."];
    }
  }

  void _nextRule() {
    if (_currentIndex < rules.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevRule() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToGame() {
    switch (widget.gameNb) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => JigsawPuzzle(
                  profileNb: widget.profileNbr,
                  level: widget.levelNb,
                  fromAdv: widget.fromAdv,
                ),
          ),
        ).then((_) {
          Navigator.pop(context);
        });
        break;

      case 2:
        callMemorizeGame();
        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => SpotGamePage(
                  profileNbr: widget.profileNbr,
                  selectedLevel: widget.levelNb,
                  fromAdv: widget.fromAdv,
                ),
          ),
        ).then((_) {
          Navigator.pop(context);
        });
        break;

      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => MatchGamePage(
                  profileNbr: widget.profileNbr,
                  selectedLevel: widget.levelNb,
                  fromAdv: widget.fromAdv,
                ),
          ),
        ).then((_) {
          Navigator.pop(context);
        });
        break;

      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => FindGamePage(
                  profileNbr: widget.profileNbr,
                  selectedLevel: widget.levelNb,
                  fromAdv: widget.fromAdv,
                ),
          ),
        ).then((_) {
          Navigator.pop(context);
        });
        break;

      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ChooseGame(
                  profileNb: widget.profileNbr,
                  level: widget.levelNb,
                  fromAdv: widget.fromAdv,
                ),
          ),
        ).then((_) {
          Navigator.pop(context);
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset("assets/backgrounds/bg8.jpg", fit: BoxFit.fill),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 8, left: 16),
              child: Material(
                borderRadius: BorderRadius.circular(32),
                child: InkWell(
                  borderRadius: BorderRadius.circular(32),
                  onTap: () {
                    ValidationDialog.show(
                      context: context,
                      title: "Back ?",
                      message: "Are you sure you want to go back?",
                      iconPath: "assets/icons/fennec/fennec_settings_icon.png",
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
                                widget.levelNb == 1
                                    ? "north"
                                    : widget.levelNb == 2
                                    ? "east"
                                    : widget.levelNb == 3
                                    ? "west"
                                    : "south",
                                1,
                              );
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
                              () => Navigator.pop(context), // Just close dialog
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
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Color(0xFFFFCB7C), width: 5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween, // This distributes space evenly
                children: [
                  // This Expanded widget ensures the PageView takes available space
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: rules.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Center(
                          child:
                              index ==
                                      2 // Special formatting for rule[2]
                                  ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildRuleRow(
                                        rules[2].split('\n')[0],
                                        "assets/images/relatedTogames/3star.png",
                                      ),
                                      _buildRuleRow(
                                        rules[2].split('\n')[1],
                                        "assets/images/relatedTogames/2star.png",
                                      ),
                                      _buildRuleRow(
                                        rules[2].split('\n')[2],
                                        "assets/images/relatedTogames/1star.png",
                                      ),
                                    ],
                                  )
                                  : Text(
                                    rules[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Fredoka",
                                      color: Color(0xFF56351E),
                                    ),
                                  ),
                        );
                      },
                    ),
                  ),
                  // Button row at the bottom
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (_currentIndex != 0)
                        ElevatedButton(
                          onPressed: _prevRule,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.055,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.02,
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

                      if (_currentIndex != 3)
                        ElevatedButton(
                          onPressed: () {
                            _navigateToGame();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.055,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.02,
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
                          if (_currentIndex == rules.length - 1) {
                            _navigateToGame();
                          } else {
                            _nextRule();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.055,
                            vertical: MediaQuery.of(context).size.height * 0.02,
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
                        child: Text(
                          _currentIndex == rules.length - 1 ? "Start" : "Next",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
              ),
              child: Text(
                "RULES",
                style: TextStyle(
                  fontFamily: 'Fredoka',
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF56351E),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void callMemorizeGame() {
    final age = int.parse(
      Provider.of<DataProvider>(
        context,
        listen: false,
      ).userData['Profiles']["Profile_${widget.profileNbr}"]["age"],
    );

    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder:
                (context) => MemoryGamePage(
                  cardImages: [
                    "assets/images/match/1image1.png",
                    "assets/images/match/1image2.png",
                    "assets/images/match/1image3.png",
                    "assets/images/match/1image4.png",
                    "assets/images/match/1image5.png",
                  ],
                  mode: age < 7 ? 3 : 5,
                  profileNbb: widget.profileNbr,
                  level: 1,
                  fromAdv: widget.fromAdv,
                ),
          ),
        )
        .then((_) {
          Navigator.pop(context);
        });
  }

  Widget _buildRuleRow(String text, String imagePath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Rule text
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: "Fredoka",
            color: Color(0xFF56351E),
          ),
        ),
        SizedBox(width: 10), // Space between text and image
        // Star image
        Image.asset(
          imagePath,
          width: 100, // Adjust size as needed
          height: 32,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.error,
              color: Colors.red,
              size: 20,
            ); // Error fallback
          },
        ),
      ],
    );
  }
}
