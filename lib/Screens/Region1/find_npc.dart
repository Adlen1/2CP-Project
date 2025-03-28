import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';

class FindNpc extends StatefulWidget {
  final String bg;
  final String npcPath;
  final double imgWidth;
  final double imgHeight;
  final double topOfsset;
  final double rightOfsset;
  final String text;

  const FindNpc({
    Key? key,
    required this.bg,
    required this.npcPath,
    required this.imgWidth,
    required this.imgHeight,
    required this.text,
    required this.rightOfsset,
    required this.topOfsset,
  }) : super(key: key);

  @override
  _FindNpcState createState() => _FindNpcState();
}

class _FindNpcState extends State<FindNpc> {
  bool isSelected = false;

  void _handleSelection() {
  setState(() {
    isSelected = true;
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

          // NPC Button
         Align(
          alignment: Alignment.bottomLeft,
          child: GestureDetector(
            onTap: () => _handleSelection(),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset(
                  widget.npcPath,
                  width: screenWidth * widget.imgWidth,
                  height: screenHeight * widget.imgHeight,
                  fit: BoxFit.contain,
                ),
                if (isSelected)
                  Positioned(
                    top: screenHeight * 0.1,  // Correction du nom de variable
                    right: screenWidth * 0.12,  // Correction du nom de variable
                    child: Image.asset(
                      "assets/icons/region1/adventure1/check_icon.png",
                      width: screenWidth * 0.15,
                      height: screenHeight * 0.15,
                    ),
                  ),
              ],
            ),
          ),
        ),



          // Text Box
          Positioned(
            left: screenWidth * 0.65,  // Ajuste manuellement la position horizontale
            top: screenHeight * 0.82,  // Ajuste la position verticale
            child: Container(
              width: screenWidth * 0.3,
              height: screenHeight * 0.15,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected
                      ? Colors.green 
                      : const Color(0xFFFFCB7C),
                  width: 4,
                ),
              ),
              child: Center(
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.02,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Fredoka",
                    color: const Color(0xFF56351E),
                  ),
                ),
              ),
            ),
                ),


          // Back Button
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
        ],
      ),
    );
  }
}
