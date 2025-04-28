import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class QuizResultsPage extends StatefulWidget {
  final int profileNbr;
  final List<bool> results;
  final String region;

  QuizResultsPage({
    required this.region,
    required this.profileNbr,
    required this.results,
  }) : assert(
         results.length == 10,
         "Results list must have exactly 10 elements.",
       );

  @override
  _QuizResultsPageState createState() => _QuizResultsPageState();
}

class _QuizResultsPageState extends State<QuizResultsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fennecController;
  late Animation<double> _fennecAnimation;
  late bool isPassed;
  bool page2 = false;
  final AudioPlayer _sfxPlayer = AudioPlayer();

  Future<void> _playGoodSound() async {
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource('audios/minigames/goodresult.mp3'));
    } catch (e) {
      debugPrint('\x1B[33m Error playing sound: $e\x1B[0m');
    }
  }

  Future<void> _playBadSound() async {
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource('audios/minigames/0stars.mp3'));
    } catch (e) {
      debugPrint('\x1B[33m Error playing sound: $e\x1B[0m');
    }
  }

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

    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    int age =
        int.tryParse(
          userData['Profiles']['Profile_${widget.profileNbr}']['age']
              .toString(),
        ) ??
        0;

    List<bool> relevantResults =
        age <= 6
            ? widget.results
                .take(5)
                .toList() // Consider only the first 5
            : widget.results; // Consider all 10

    int correctAnswers = relevantResults.where((result) => result).length;

    isPassed = (age < 7) ? correctAnswers >= 3 : correctAnswers >= 7;

    if (isPassed) {
      if (GameLogic.sfx(context, widget.profileNbr)) _playGoodSound();
      userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["adventures"]["adventure_2"]["completed"] =
          true;
      userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["completed"] =
          true;
      userData['Profiles']['Profile_${widget.profileNbr}']["Regions"]["${userData["Profiles"]['Profile_${widget.profileNbr}']["Regions"]["region_${widget.region.toLowerCase()}"]["unlocks"]}"]["unlocked"] =
          true;
    } else {
      if (GameLogic.sfx(context, widget.profileNbr)) _playBadSound();
    }
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    int age =
        int.tryParse(
          userData['Profiles']['Profile_${widget.profileNbr}']['age']
              .toString(),
        ) ??
        0;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset("assets/backgrounds/bg8.jpg", fit: BoxFit.fill),
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
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
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
            left: -screenWidth * 0.13, // Adjust horizontal position
            top: screenHeight * 0.17, // Adjust vertical position
            child: GestureDetector(
              onTapDown: _onFennecTapDown,
              onTapUp: _onFennecTapUp,
              onTapCancel: _onFennecTapCancel,
              child: AnimatedBuilder(
                animation: _fennecAnimation,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform:
                        Matrix4.identity()..scale(
                          isPassed ? 1.0 : -1.0,
                          1.0,
                          1.0,
                        ), // Flip only if failed
                    child: Transform.scale(
                      scale: _fennecAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  isPassed
                      ? "assets/icons/fennec/happy_fennec_icon.png" // Happy fennec (Normal)
                      : "assets/icons/fennec/sad_fennec_icon.png", // Sad fennec (Flipped)
                  height: screenHeight * 0.6,
                  width: screenWidth * 0.6,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "RESULTS",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: Offset(MediaQuery.of(context).size.width * 0.125, 0),
              child: Container(
                width:
                    age > 6
                        ? MediaQuery.of(context).size.width * 0.65
                        : MediaQuery.of(context).size.width * 0.6,

                height:
                    age > 6
                        ? MediaQuery.of(context).size.height * 0.65
                        : MediaQuery.of(context).size.height * 0.6,

                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255).withOpacity(1),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Color(0xFFFFCB7C), width: 5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (!page2)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.28,
                  left: MediaQuery.of(context).size.width * 0.25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ), // Spacing between icons
                      child: Image.asset(
                        widget.results[index]
                            ? "assets/icons/quiz_results_page/passed_${index + 1}.png" // Passed icon (1-5)
                            : "assets/icons/quiz_results_page/failed_${index + 1}.png", // Failed icon (1-5)
                        width:
                            MediaQuery.of(context).size.width *
                            0.07, // Adjust size
                        height: MediaQuery.of(context).size.width * 0.07,
                      ),
                    );
                  }),
                ),
              ),
            ),

          if (!page2)
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: MediaQuery.of(context).size.width * 0.25,
                ),
                child:
                    age <= 6
                        ? Column(
                          // Two lines for age <= 6
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.04,
                              ),
                              child: Text(
                                "TEST",
                                style: TextStyle(
                                  fontFamily: 'Fredoka',
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isPassed
                                          ? const Color(0xFF53C8C1)
                                          : const Color(0xFFFE6D73),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: Text(
                                isPassed ? "PASSED" : "FAILED",
                                style: TextStyle(
                                  fontFamily: 'Fredoka',
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isPassed
                                          ? const Color(0xFF53C8C1)
                                          : const Color(0xFFFE6D73),
                                ),
                              ),
                            ),
                          ],
                        )
                        : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.2,
                              ),
                              child: Text(
                                "TEST  ",
                                style: TextStyle(
                                  fontFamily: 'Fredoka',
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isPassed
                                          ? const Color(0xFF53C8C1)
                                          : const Color(0xFFFE6D73),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.2,
                              ),
                              child: Text(
                                isPassed ? "PASSED" : "FAILED",
                                style: TextStyle(
                                  fontFamily: 'Fredoka',
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isPassed
                                          ? const Color(0xFF53C8C1)
                                          : const Color(0xFFFE6D73),
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
            ),

          if (!page2)
            AnimatedGameButton(
              "assets/icons/quiz_results_page/next_button.png",
              screenWidth * 0.2,
              screenHeight * 0.2,
              screenWidth * 0.4,
              screenHeight * 0.8,
              onTap: () {
                setState(() {
                  page2 = true;
                });
              },
            ),

          if (!page2)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.28,
                  left: MediaQuery.of(context).size.width * 0.25,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // First row (Always present)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(
                            widget.results[index]
                                ? "assets/icons/quiz_results_page/passed_${index + 1}.png"
                                : "assets/icons/quiz_results_page/failed_${index + 1}.png",
                            width: MediaQuery.of(context).size.width * 0.07,
                            height: MediaQuery.of(context).size.width * 0.07,
                          ),
                        );
                      }),
                    ),

                    // Second row (Only for age >= 6)
                    if (age >= 6) SizedBox(height: 10), // Space between rows
                    if (age >= 6)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(
                              widget.results[index + 5]
                                  ? "assets/icons/quiz_results_page/passed_${index + 6}.png"
                                  : "assets/icons/quiz_results_page/failed_${index + 6}.png",
                              width: MediaQuery.of(context).size.width * 0.07,
                              height: MediaQuery.of(context).size.width * 0.07,
                            ),
                          );
                        }),
                      ),
                  ],
                ),
              ),
            ),

          if (page2)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isPassed) ...[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.07,
                            vertical: MediaQuery.of(context).size.height * 0.02,
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
                        child: Text("No"),
                      ),
                      SizedBox(width: screenWidth * 0.1),
                    ],

                    ElevatedButton(
                      onPressed: () {
                        int count = isPassed ? 4 : 2;
                        for (int i = 0; i < count; i++) {
                          Navigator.of(context).pop();
                        }
                       Navigator.of(context).pop();
                        
                        GameLogic.setRegion(context, widget.profileNbr, GameLogic.region(context, widget.profileNbr) + 1);
                        if (int.parse(userData['Profiles']['Profile_${widget.profileNbr}']['age']) > 6 && GameLogic.region(context, widget.profileNbr) == 4){
                          GameLogic.region(context, widget.profileNbr) == 3 ;
                        }

                        if (int.parse(userData['Profiles']['Profile_${widget.profileNbr}']['age']) < 7 && GameLogic.region(context, widget.profileNbr) == 5){
                          GameLogic.region(context, widget.profileNbr) == 4 ;
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.07,
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
                      child: Text(isPassed ? "Continue" : "Yes"),
                    ),
                  ],
                ),
              ),
            ),

          if (page2)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.28,
                  left: MediaQuery.of(context).size.width * 0.25,
                ),
                child: Text(
                  isPassed
                      ? "You have unlocked a new region"
                      : "you have failed the\nquiz do you want to\ntry again   ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: MediaQuery.of(context).size.width * 0.035,
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
}
