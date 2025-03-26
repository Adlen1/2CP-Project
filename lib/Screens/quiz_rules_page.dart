import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/quiz_page.dart';

class RulesPage extends StatefulWidget {
  final int profileNbr;
  final String advName;
  const RulesPage({Key? key, required this.profileNbr, required this.advName})
    : super(key: key);

  @override
  _RulesPageState createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> rules = [
    "1 - There is only one correct answer.",
    "2 - you need three correct answers to pass the quiz",
    "3 - once you pass the quiz a new region will be unlocked",
    "Are you ready for \n QUIZ ?",
  ];

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
                    Navigator.pop(context);
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
            child: Transform.translate(
              offset: Offset(0, MediaQuery.of(context).size.height * 0.001),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.5,
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
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: rules.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        MediaQuery.of(context).size.height * 0.05,
                      ), // Move text up by 5% of screen height
                      child: Text(
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

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_currentIndex != 0)
                    ElevatedButton(
                      onPressed: _prevRule,
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
                        backgroundColor: Color(0xFFFE6D73),
                        foregroundColor: Color(0xFF56351E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("Back"),
                    ),
                  if (_currentIndex != 0)
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),

                  ElevatedButton(
                    onPressed: () {
                      if (_currentIndex == 3) {
                        //NEXT PAGE INSTEAD
                        //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MainScreen(profileNbr: widget.profileNbr),),);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => QuizPage(
                                  adventure_name: widget.advName,
                                  profileNbrr: widget.profileNbr,
                                ),
                          ),
                        );
                      } else {
                        _nextRule();
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
                    child: Text(
                      _currentIndex == rules.length - 1 ? "Start" : "Next",
                    ),
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
