import 'package:flutter/material.dart';
import 'dart:math';

class QuizPage extends StatefulWidget {
  final String adventure_name;
  const QuizPage({super.key, required this.adventure_name});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int answerChosen = -1; // start from 0
  int selectedIndex = -1;
  int nbQestion = 1;
  int shuffleSeed = Random().nextInt(10000);
  List<bool> bulta = List.filled(5, false); // start from 0

  void selectImage(int index) {
    if (answerChosen == -1) {
      // Allow selection only if not confirmed
      setState(() {
        selectedIndex = index;
      });
    }
  }

  void confirmSelection(int correctAnswer) {
    if (selectedIndex != -1) {
      setState(() {
        answerChosen = selectedIndex; // Lock the selection
        if (answerChosen == correctAnswer) {
          bulta[nbQestion - 1] = true; // Mark as correct
        }
      });
    }
  }

  void incQestion() {
    if (selectedIndex != -1) {
      setState(() {
        nbQestion++;
        answerChosen = -1;
        selectedIndex = -1;
        shuffleSeed = Random().nextInt(10000); // New seed for next question
      });
    }
  }

  Widget quiz(
    String option1,
    String option2,
    String option3,
    String option4,
    String question,
    int correctAnswerIndex,
  ) {
    List<Map<String, dynamic>> imageOptions = [
      {"path": option1, "index": 0},
      {"path": option2, "index": 1},
      {"path": option3, "index": 2},
      {"path": option4, "index": 3},
    ];

    // Shuffle using the generated seed
    Random random = Random(shuffleSeed);
    imageOptions.shuffle(random);

    // Find the new correct answer index after shuffling
    int newCorrectAnswerIndex = imageOptions.indexWhere(
      (option) => option["index"] == correctAnswerIndex,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Question
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            question,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Fredoka3',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Answer Options (Images)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(imageOptions.length, (index) {
            return GestureDetector(
              onTap: () => selectImage(index),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer border container
                  Container(
                    margin: EdgeInsets.all(8),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border:
                          selectedIndex == index
                              ? Border.all(color: Color(0xFF56351E), width: 4)
                              : null,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          imageOptions[index]["path"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  if (answerChosen != -1 && index == answerChosen)
                    SizedBox(
                      width: 88,
                      height: 88,
                      child:
                          (answerChosen == newCorrectAnswerIndex)
                              ? Image.asset(
                                "assets/icons/quiz_images/checked.png",
                              )
                              : Image.asset(
                                "assets/icons/quiz_images/delete.png",
                              ),
                    ),

                  if (answerChosen != -1 &&
                      answerChosen != newCorrectAnswerIndex &&
                      index == newCorrectAnswerIndex)
                    SizedBox(
                      width: 88,
                      height: 88,
                      child: Image.asset(
                        "assets/icons/quiz_images/checked.png",
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget numberedCircle(int number, bool isActive) {
    return Container(
      width: 33,
      height: 33,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: isActive ? Colors.brown : Colors.transparent,
          width: 4,
        ),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            fontFamily: 'Fredoka3',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            height: 1, // Fixes vertical misalignment
            color: isActive ? Colors.brown : Colors.grey,
          ),
        ),
      ),
    );
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
            child: Image.asset("assets/backgrounds/bg8.jpg", fit: BoxFit.fill),
          ),

          // Top "QUIZ" Title
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: Text(
                "QUIZ",
                style: TextStyle(
                  fontFamily: 'Fredoka3',
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF56351E),
                ),
              ),
            ),
          ),

          // Back Button
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Material(
                borderRadius: BorderRadius.circular(32),
                child: InkWell(
                  borderRadius: BorderRadius.circular(32),
                  onTap: () {
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
            ),
          ),

          // Quiz Content
          Center(
            child: Container(
              height: screenHeight * 0.64,
              width: screenWidth * 0.8,
              decoration: BoxDecoration(
                color:
                    (nbQestion % 3 == 0)
                        ? Color(0xFF53C8C0)
                        : (nbQestion % 3 == 1)
                        ? Color(0xFFFE6D73)
                        : Color(0xFFFFCB7C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  // Numbered Circles
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        5,
                        (i) => numberedCircle(i + 1, i + 1 == nbQestion),
                      ),
                    ),
                  ),

                  Expanded(
                    child: quiz(
                      "assets/icons/quiz_images/makam_el_chahid.png",
                      "assets/icons/quiz_images/roman_ruins.png",
                      "assets/icons/quiz_images/timimoun_tower.png",
                      "assets/icons/quiz_images/theater.png",
                      "What big monument in Algiers was built to remember Algeria’s independence?",
                      1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.02,
              ),
              child: ElevatedButton(
                onPressed:
                    answerChosen == -1
                        ? () => confirmSelection(-1) //not modifying
                        : nbQestion == 5
                        ? () {
                          /* Navigator.push results */
                        }
                        : answerChosen != -1
                        ? () => incQestion()
                        : () {},

                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF56351E), // Brown background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ), // Fully rounded edges
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 70,
                    vertical: 5,
                  ), // Adjust size
                ),
                child: Text(
                  answerChosen == -1
                      ? "Select"
                      : nbQestion == 5
                      ? "Done"
                      : answerChosen != -1
                      ? "Next"
                      : "",
                  style: TextStyle(
                    fontFamily: 'Fredoka3', // Use the same font as your app
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
