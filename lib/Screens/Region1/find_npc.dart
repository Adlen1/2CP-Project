import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';

class FindNpc extends StatefulWidget {
  final String bg;
  final List<String> npcPaths;
  final List<double> topOffsets;
  final List<double> rightOffsets;
  final double imgWidth;
  final double imgHeight;
  final String text;
  final double imgOpacity;
  final double topcheck;
  final double rightcheck;

  const FindNpc({
    Key? key,
    required this.bg,
    required this.npcPaths,
    required this.topOffsets,
    required this.rightOffsets,
    required this.imgWidth,
    required this.imgHeight,
    required this.text,
    required this.imgOpacity,
    required this.rightcheck,
    required this.topcheck,
  }) : super(key: key);

  @override
  _FindNpcState createState() => _FindNpcState();
}

class _FindNpcState extends State<FindNpc> {
  List<bool> isSelectedList = [];

  @override
  void initState() {
    super.initState();
    isSelectedList = List.generate(widget.npcPaths.length, (index) => false);
  }

   void _handleSelection(int index) {
    if (isSelectedList[index]) return; 

    setState(() {
      isSelectedList[index] = true;
    });

    if (isSelectedList.every((found) => found)) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    }
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

          // NPCs
          for (int i = 0; i < widget.npcPaths.length; i++)
            Positioned(
              top: screenHeight * widget.topOffsets[i],
              right: screenWidth * widget.rightOffsets[i],
              child: GestureDetector(
                onTap: () => _handleSelection(i),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: widget.imgOpacity, 
                      child: Image.asset(
                        widget.npcPaths[i],
                        width: screenWidth * widget.imgWidth,
                        height: screenHeight * widget.imgHeight,
                        fit: BoxFit.contain,
                      ),
                    ),
                    if (isSelectedList[i])
                      Positioned(
                        top: screenHeight * widget.topcheck, 
                        right: screenWidth * widget.rightcheck,
                        child: Image.asset(
                          "assets/icons/region1/adventure1/check_icon.png",
                          width: screenWidth * 0.1, 
                          height: screenHeight * 0.1,
                        ),
                      ),
                  ],
                ),
              ),
            ),


          // Text Box
          Positioned(
            left: screenWidth * 0.65,
            top: screenHeight * 0.82,
            child: Container(
              width: screenWidth * 0.3,
              height: screenHeight * 0.15,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelectedList.every((found) => found)
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

          // Back Button & Controls
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