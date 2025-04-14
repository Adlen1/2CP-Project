import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';

class ViewElements extends StatefulWidget {
  final String bg;
  final List<String> items;
  final double imgWidth;
  final double imgHeight;
  final List<String> text;
  final String speakerIcon1;
  final String speakerIcon2;
  final double textWidth;

  const ViewElements({
    Key? key,
    required this.bg,
    required this.items,
    required this.imgWidth,
    required this.imgHeight,
    required this.text,
    required this.speakerIcon1,
    required this.speakerIcon2,
    required this.textWidth,
  }) : super(key: key);

  @override
  _ViewElementsState createState() => _ViewElementsState();
}

class _ViewElementsState extends State<ViewElements> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(child: Image.asset(widget.bg, fit: BoxFit.cover)),

          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.2), // Space at the top
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center align images
                  children: List.generate(widget.items.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: screenWidth * 0.042,
                      ), // Reduce space between images
                      child: Column(
                        children: [
                          // Image with Border
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFFFCB7C),
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            padding: EdgeInsets.all(2),
                            child: Image.asset(
                              widget.items[index],
                              width: screenWidth * widget.imgWidth,
                              height: screenHeight * widget.imgHeight,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ), // Reduce vertical space
                          // Text Box with Adjustable Size
                          Container(
                            constraints: BoxConstraints(
                              minWidth: screenWidth * widget.textWidth,
                              maxWidth: screenWidth * widget.textWidth,
                              minHeight: screenHeight * 0.12,
                              maxHeight: screenHeight * 0.12,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFFFCB7C),
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(1),
                            ),
                            child: Center(
                              child: Text(
                                widget.text[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.024,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Fredoka",
                                  color: const Color(0xFF56351E),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenWidth * 0.02,
              ),
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
                          message: "Are you sure you want to go back?",
                          iconPath:
                              "assets/icons/fennec/fennec_settings_icon.png",
                          buttons: [
                            DialogButtonData(
                              text: "Yes",
                              color: Colors.redAccent,
                              onTap: () {
                                Navigator.pop(context); // Close dialog
                                Navigator.pop(context); // Go back
                                Navigator.pop(context);
                              },
                            ),
                            DialogButtonData(
                              text: "No",
                              color: Colors.greenAccent,
                              onTap:
                                  () => Navigator.pop(
                                    context,
                                  ), // Just close dialog
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

          Positioned(
            left: screenWidth * 0.68,
            bottom: screenHeight * 0.05,
            child: Image.asset(
              widget.speakerIcon1,
              width: screenWidth * 0.45,
              height: screenHeight * 0.45,
            ),
          ),

          Positioned(
            left: -screenWidth * 0.2,
            bottom: screenHeight * 0.02,
            child: Image.asset(
              widget.speakerIcon2,
              width: screenWidth * 0.55,
              height: screenHeight * 0.55,
            ),
          ),

          Positioned(
            left: screenWidth * 0.18,
            bottom: -screenHeight * 0.03,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedGameButton(
                  "assets/icons/region1/adventure1/back_button.png",
                  screenWidth * 0.2,
                  screenHeight * 0.2,
                  screenWidth * 0.1,
                  screenHeight * 0.1,
                  onTap: () {
                    Navigator.pop(context, -1);
                  },
                ),
                AnimatedGameButton(
                  "assets/icons/region1/adventure1/skip_button.png",
                  screenWidth * 0.2,
                  screenHeight * 0.2,
                  screenWidth * 0.1,
                  screenHeight * 0.1,
                ),
                AnimatedGameButton(
                  "assets/icons/region1/adventure1/next_button.png",
                  screenWidth * 0.2,
                  screenHeight * 0.2,
                  screenWidth * 0.1,
                  screenHeight * 0.1,
                  onTap: () {
                    Navigator.pop(context, 1);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
