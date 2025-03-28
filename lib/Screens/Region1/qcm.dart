import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';

class QCM extends StatefulWidget {
  final String bg;
  final List<String> imagePaths;
  final double imgWidth;
  final double imgHeight;
  final String text;
  final int correctIndex;
  final bool check;

  const QCM({
    Key? key,
    required this.bg,
    required this.imagePaths,
    required this.imgWidth,
    required this.imgHeight,
    required this.text,
    required this.correctIndex,
    this.check = true,
  }) : super(key: key);

  @override
  _QCMState createState() => _QCMState();
}

class _QCMState extends State<QCM> {
  int? selectedIndex;
  bool? isCorrect;

  void _handleSelection(int index) {
  setState(() {
    selectedIndex = index;
    isCorrect = (index == widget.correctIndex);
  });

  // Add a delay before popping the screen
  Future.delayed(Duration(seconds: 2), () {
  Navigator.pop(context); // Passing the result if needed
  });
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
            child: Image.asset(
              widget.bg,
              fit: BoxFit.fill,
            ),
          ),

          Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.02),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Back Button with Confirmation Dialog
                Material(
                  borderRadius: BorderRadius.circular(32),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () {
                      ValidationDialog.show(
                        context: context,
                        title: "Back to Main Menu?",
                        message: "Are you sure you want to go back? Your progress will be lost.",
                        iconPath: "assets/icons/fennec/fennec_settings_icon.png",
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
                            onTap: () => Navigator.pop(context), // Just close dialog
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
                SizedBox(width: screenWidth * 0.01), // Spacing

                // Question Button
                Material(
                  borderRadius: BorderRadius.circular(32),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Ink.image(
                      image: AssetImage("assets/icons/question_icon.png"),
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01), // Spacing

                // Pause Button
                Material(
                  borderRadius: BorderRadius.circular(32),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Ink.image(
                      image: AssetImage("assets/icons/pause_icon.png"),
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

          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: screenHeight * 0.07),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(widget.imagePaths.length, (index) {
                    bool isSelected = selectedIndex == index;
                    bool isAnswerCorrect = isCorrect ?? false;
                    Color borderColor = isSelected
                        ? (isAnswerCorrect ? Colors.green : Colors.red)
                        : Color(0xFFFFCB7C);

                    return GestureDetector(
                      onTap: () => _handleSelection(index),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: screenWidth * widget.imgWidth,
                            height: screenHeight * widget.imgHeight,
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor, width: 4),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3),
                              child: Image.asset(
                                widget.imagePaths[index],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.error, size: 50, color: Colors.red);
                                },
                              ),
                            ),
                          ),
                          if (isSelected && widget.check)
                            Positioned(
                              top: screenHeight * 0.12,
                              right: screenWidth * 0.115,
                              child: Icon(
                                isAnswerCorrect ? Icons.check_circle : Icons.cancel,
                                color: isAnswerCorrect ? Colors.green : Colors.red,
                                size: screenWidth * 0.15,
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(height: screenHeight * 0.05),

                // Text Box
                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.15,
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: selectedIndex != null
                          ? (isCorrect! ? Colors.green : Colors.red)
                          : Color(0xFFFFCB7C),
                      width: 4,
                    ),
                  ),
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.02,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Fredoka",
                      color: Color(0xFF56351E),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
