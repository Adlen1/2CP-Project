import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:project_2cp_eq11/Screens/quiz_results_page.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:project_2cp_eq11/miniGames/utils.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';

class QuizPage extends StatefulWidget {
  final int profileNbrr;
  final int quizNb;
  const QuizPage({super.key, required this.quizNb, required this.profileNbrr});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int answerChosen = -1; // start from 0
  int selectedIndex = -1;
  int nbQestion = 1;
  int age = 20;
  int shuffleSeed = Random().nextInt(10000);
  List<bool> bulta = List.filled(10, false); // start from 0
  int currentCorrectAnswer = -1;
  double screenWidth = 0;
  double screenHeight = 0;
  final AudioPlayer _sfxPlayer = AudioPlayer();

  Map<String, List<Map<String, dynamic>>> quizzes = {
    "quiz1": [
      {
        "qNB": 1,
        "question":
            "What big monument in Algiers that  was built to remember Algeria’s independence?",
        "afterRandom": 1,
        'audioPath': 'audios/quiz/quiz1/1.mp3',
      },
      {
        "qNB": 2,
        "question":
            "Which of these foods comes from the northern region of Algeria?",
        "afterRandom": 2,
        'audioPath': 'audios/quiz/quiz1/2.mp3',
      },
      {
        "qNB": 3,
        "question":
            "What is the long white cloth that women wear in Algiers and Tipaza?",
        "afterRandom": 3,
        'audioPath': 'audios/quiz/quiz1/3.mp3',
      },
      {
        "qNB": 4,
        "question": "What color are the houses in the Casbah?",
        "afterRandom": 4,
        'audioPath': 'audios/quiz/quiz1/4.mp3',
      },
      {
        "qNB": 5,
        "question": "What colorful egg dish is popular in Tipaza?",
        "afterRandom": 5,
        'audioPath': 'audios/quiz/quiz1/5.mp3',
      },
      {
        "qNB": 6,
        "question":
            "What is the name of the ancient city we explored in Tipaza?",
        "afterRandom": 6,
        'audioPath': 'audios/quiz/quiz1/6.mp3',
      },
      {
        "qNB": 7,
        "question":
            "What is a popular traditional dish in northern Algeria that people eat on Fridays?",
        "afterRandom": 7,
        'audioPath': 'audios/quiz/quiz1/7.mp3',
      },
      {
        "qNB": 8,
        "question": "What is special about the Great Mosque of Algiers?",
        "afterRandom": 8,
        'audioPath': 'audios/quiz/quiz1/8.mp3',
      },
      {
        "qNB": 9,
        "question": "What is the most famous mountain in Tipaza?",
        "afterRandom": 9,
        'audioPath': 'audios/quiz/quiz1/9.mp3',
      },
      {
        "qNB": 10,
        "question": "Which sea is next to Algiers? ",
        "afterRandom": 10,
        'audioPath': 'audios/quiz/quiz1/10.mp3',
      },
    ],
    "quiz2": [
      {
        "qNB": 1,
        "question": "What is the name of the famous palace in Constantine?",
        "afterRandom": 1,
        'audioPath': 'audios/quiz/quiz2/1.mp3',
      },
      {
        "qNB": 2,
        "question": "Which of these clothes comes from Béjaïa?",
        "afterRandom": 2,
        'audioPath': 'audios/quiz/quiz2/2.mp3',
      },
      {
        "qNB": 3,
        "question":
            "What is the famous mountain in Béjaïa that looks like a sleeping woman?",
        "afterRandom": 3,
        'audioPath': 'audios/quiz/quiz2/3.mp3',
      },
      {
        "qNB": 4,
        "question": "What animal did we see in Béjaïa?",
        "afterRandom": 4,
        'audioPath': 'audios/quiz/quiz2/4.mp3',
      },
      {
        "qNB": 5,
        "question": "What is the famous mosque in Constantine?",
        "afterRandom": 5,
        'audioPath': 'audios/quiz/quiz2/5.mp3',
      },
      {
        "qNB": 6,
        "question":
            "What is the name of the most famous bridge in Constantine?",
        "afterRandom": 6,
        'audioPath': 'audios/quiz/quiz2/6.mp3',
      },
      {
        "qNB": 7,
        "question":
            "What ingredient from Béjaïa is often used in traditional Friday dishes in northern Algeria?",
        "afterRandom": 7,
        'audioPath': 'audios/quiz/quiz2/7.mp3',
      },
      {
        "qNB": 8,
        "question": "What is the Ahmed Bey Palace known for?",
        "afterRandom": 8,
        'audioPath': 'audios/quiz/quiz2/8.mp3',
      },
      {
        "qNB": 9,
        "question": "What do people celebrate during Yennayer?",
        "afterRandom": 9,
        'audioPath': 'audios/quiz/quiz2/9.mp3',
      },
      {
        "qNB": 10,
        "question": "What is the significance of the Casbah of Béjaïa?",
        "afterRandom": 10,
        'audioPath': 'audios/quiz/quiz2/10.mp3',
      },
    ],
    "quiz3": [
      {
        "qNB": 1,
        "question": "What is the famous mosque in Oran?",
        "afterRandom": 1,
        'audioPath': 'audios/quiz/quiz3/1.mp3',
      },
      {
        "qNB": 2,
        "question": "What kind of trees are in the Sidi Boumedien’s garden?",
        "afterRandom": 2,
        'audioPath': 'audios/quiz/quiz3/2.mp3',
      },
      {
        "qNB": 3,
        "question": "What color are the houses in the Casbah?",
        "afterRandom": 3,
        'audioPath': 'audios/quiz/quiz3/3.mp3',
      },
      {
        "qNB": 4,
        "question": "Which of these clothes comes from Tlemcen?",
        "afterRandom": 4,
        'audioPath': 'audios/quiz/quiz3/4.mp3',
      },
      {
        "qNB": 5,
        "question": "What does the lighthouse in Arzew help?",
        "afterRandom": 5,
        'audioPath': 'audios/quiz/quiz3/5.mp3',
      },
      {
        "qNB": 6,
        "question": "Who were the Beys of Oran?",
        "afterRandom": 6,
        'audioPath': 'audios/quiz/quiz3/6.mp3',
      },
      {
        "qNB": 7,
        "question":
            "What is the name of the scholar buried in the mosque of Tlemcen?",
        "afterRandom": 7,
        'audioPath': 'audios/quiz/quiz3/7.mp3',
      },
      {
        "qNB": 8,
        "question": "What happened to the Mansourah Mosque over time?",
        "afterRandom": 8,
        'audioPath': 'audios/quiz/quiz3/8.mp3',
      },
      {
        "qNB": 9,
        "question": "Who built the Mechouar Palace in Telemcen?",
        "afterRandom": 9,
        'audioPath': 'audios/quiz/quiz3/9.mp3',
      },
      {
        "qNB": 10,
        "question": "Where is Oran situated?",
        "afterRandom": 10,
        'audioPath': 'audios/quiz/quiz3/10.mp3',
      },
    ],
    "quiz4": [
      {
        "qNB": 1,
        "question": "What sculpted the big red rocks in the desert?",
        "afterRandom": 1,
        'audioPath': 'audios/quiz/quiz4/1.mp3',
      },
      {
        "qNB": 2,
        "question": "What is the large area of dunes in Illizi called?",
        "afterRandom": 2,
        'audioPath': 'audios/quiz/quiz4/2.mp3',
      },
      {
        "qNB": 3,
        "question":
            "What does Ace the fennec wear to protect itself from the desert sun?",
        "afterRandom": 3,
        'audioPath': 'audios/quiz/quiz4/3.mp3',
      },
      {
        "qNB": 4,
        "question": "What is the Sahara famous for?",
        "afterRandom": 4,
        'audioPath': 'audios/quiz/quiz4/4.mp3',
      },
      {
        "qNB": 5,
        "question": "What food is baked by people on hot stones?",
        "afterRandom": 5,
        'audioPath': 'audios/quiz/quiz4/5.mp3',
      },
      {
        "qNB": 6,
        "question": "What animal hides in the sand to stay cool?",
        "afterRandom": 6,
        'audioPath': 'audios/quiz/quiz4/6.mp3',
      },
      {
        "qNB": 7,
        "question": "Where are Tamanrasset and Illizi located?",
        "afterRandom": 7,
        'audioPath': 'audios/quiz/quiz4/7.mp3',
      },
      {
        "qNB": 8,
        "question": "What did ancient people paint on the rocks?",
        "afterRandom": 8,
        'audioPath': 'audios/quiz/quiz4/8.mp3',
      },
      {
        "qNB": 9,
        "question": "Where can you find special ancient rock drawings?",
        "afterRandom": 9,
        'audioPath': 'audios/quiz/quiz4/9.mp3',
      },
      {
        "qNB": 10,
        "question": "What makes Djanet special?",
        "afterRandom": 10,
        'audioPath': 'audios/quiz/quiz4/10.mp3',
      },
    ],
  };

  Future<void> _playWrongSound() async {
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource('audios/minigames/wrong.mp3'));
    } catch (e) {
      debugPrint('\x1B[33m Error playing flip sound: $e\x1B[0m');
    }
  }

  Future<void> _playCorrectSound() async {
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource('audios/minigames/correct.mp3'));
    } catch (e) {
      debugPrint('\x1B[33m Error playing flip sound: $e\x1B[0m');
    }
  }

  @override
  void initState() {
    super.initState();
    final userData = Provider.of<DataProvider>(context, listen: false).userData;

    age =
        int.tryParse(
          userData['Profiles']['Profile_${widget.profileNbrr}']['age']
              .toString(),
        ) ??
        0;
    randomizeQuiz();

    int nbquestion_afterRandom =
        quizzes["quiz${widget.quizNb}"]![nbQestion - 1]["afterRandom"];
    final audioPath =
        quizzes["quiz${widget.quizNb}"]![nbquestion_afterRandom -
            1]['audioPath'];
    if (GameLogic.narrator(context, widget.profileNbrr)) {
      _playQuestionAudio(audioPath);
    }
  }

  void randomizeQuiz() {
    List<int> randomNumbers = List.generate(10, (index) => index + 1);
    randomNumbers.shuffle(); // Shuffle the list

    for (int i = 0; i < quizzes["quiz${widget.quizNb}"]!.length; i++) {
      quizzes["quiz${widget.quizNb}"]![i]["afterRandom"] = randomNumbers[i];
    }
  }

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
          if (GameLogic.sfx(context, widget.profileNbrr)) _playCorrectSound();
          bulta[nbQestion - 1] = true; // Mark as correct
        } else {
          if (GameLogic.sfx(context, widget.profileNbrr)) _playWrongSound();
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
      int nbquestion_afterRandom =
          quizzes["quiz${widget.quizNb}"]![nbQestion - 1]["afterRandom"];
      final audioPath =
          quizzes["quiz${widget.quizNb}"]![nbquestion_afterRandom -
              1]['audioPath'];
      if (GameLogic.narrator(context, widget.profileNbrr)) {
        _playQuestionAudio(audioPath);
      }
    }
  }

  Future<void> _playQuestionAudio(String audioPath) async {
    try {
      await _sfxPlayer.stop(); // Stop any previous audio
      await _sfxPlayer.play(AssetSource(audioPath));
    } catch (e) {
      debugPrint('Error playing question audio: $e');
    }
  }

  Widget quiz(
    List<String> options, // Changed from individual options to a list
    String question,
    int correctAnswerIndex,
  ) {
    // Create image options list with their original indices
    List<Map<String, dynamic>> imageOptions = [
      for (int i = 0; i < options.length; i++) {"path": options[i], "index": i},
    ];

    // Shuffle using the generated seed
    Random random = Random(shuffleSeed);
    imageOptions.shuffle(random);

    // Find the new correct answer index after shuffling
    int newCorrectAnswerIndex = imageOptions.indexWhere(
      (option) => option["index"] == correctAnswerIndex,
    );
    currentCorrectAnswer = newCorrectAnswerIndex;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Question
        Padding(
          padding: EdgeInsets.all(8),
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
                    width: screenWidth * 0.16,
                    height: screenWidth * 0.16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27),
                      border:
                          selectedIndex == index
                              ? Border.all(color: Color(0xFF56351E), width: 3)
                              : null,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          imageOptions[index]["path"],
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                // Fallback if image fails to load
                                color: Colors.grey[300],
                                child: Icon(Icons.error),
                              ),
                        ),
                      ),
                    ),
                  ),

                  // Show result indicators
                  if (answerChosen != -1 && index == answerChosen)
                    SizedBox(
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
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
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
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
      width: screenWidth * 0.04,
      height: screenWidth * 0.04,
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

  Widget quizManager() {
    int nbquestion_afterRandom =
        quizzes["quiz${widget.quizNb}"]![nbQestion - 1]["afterRandom"];
    return quiz(
      [
        "assets/images/quiz/quiz${widget.quizNb}/${nbquestion_afterRandom}op1.png",
        "assets/images/quiz/quiz${widget.quizNb}/${nbquestion_afterRandom}op2.png",
        "assets/images/quiz/quiz${widget.quizNb}/${nbquestion_afterRandom}op3.png",
        "assets/images/quiz/quiz${widget.quizNb}/${nbquestion_afterRandom}op4.png",
      ],

      quizzes["quiz${widget.quizNb}"]![nbquestion_afterRandom - 1]["question"],
      0,
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
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
                            Navigator.pop(context); // Close dialog
                            Navigator.pop(context); // Then go back
                            Navigator.pop(context);
                            Navigator.pop(context);
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

          // quiz Content
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
                      children:
                          nbQestion < 6
                              ? List.generate(
                                5,
                                (i) =>
                                    numberedCircle(i + 1, i + 1 == nbQestion),
                              )
                              : List.generate(
                                5,
                                (i) =>
                                    numberedCircle(i + 6, i + 6 == nbQestion),
                              ),
                    ),
                  ),

                  Expanded(child: quizManager()),
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
                onPressed: () {
                  if (selectedIndex == -1) {
                    // Do nothing if no answer is selected except playing a sound
                    if (GameLogic.sfx(context, widget.profileNbrr))
                      _playWrongSound();
                    return;
                  }

                  // If the answer hasn't been confirmed yet
                  if (answerChosen == -1) {
                    confirmSelection(currentCorrectAnswer);
                    return;
                  }

                  // If it's the last question, go to results
                  if ((age < 7 && nbQestion == 5) ||
                      (age >= 7 && nbQestion == 10)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => QuizResultsPage(
                              profileNbr: widget.profileNbrr,
                              results: bulta,
                              region:
                                  widget.quizNb == 1
                                      ? "north"
                                      : widget.quizNb == 2
                                      ? "east"
                                      : widget.quizNb == 3
                                      ? "west"
                                      : "south",
                            ),
                      ),
                    );
                    return;
                  }

                  // Otherwise, move to next question
                  incQestion();
                },

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
                      : ((age < 7 && nbQestion == 5) ||
                          (age >= 7 && nbQestion == 10))
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
