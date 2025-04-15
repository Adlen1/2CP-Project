import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';
import 'package:project_2cp_eq11/miniGames/logic.dart';
import 'package:project_2cp_eq11/miniGames/mini_games_results.dart';



class Level0 extends StatefulWidget {
  final int profileNbr;
  const Level0({required this.profileNbr ,Key? key}) : super(key: key);

  @override
  _Level0State createState() => _Level0State();
}

class _Level0State extends State<Level0> with SingleTickerProviderStateMixin {
  bool lockview = false;
  int currentPointIndex = 0;

  // Define your map points with text, image path, and audio path
  final List<Map<String, dynamic>> mapPoints = [
    {
      'text': "Hey there, little explorer!",
      'imagePath': "assets/images/level0/img1.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.05,
      'top': - 0.03 ,
      'width':  0.7,
      'height':  0.7, 
    },
    {
      'text': "before we start our journey together , let us take a bit of time to learn some basic concept  ",
      'imagePath': "assets/images/level0/img2.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.05,
      'top':- 0.03 ,
      'width':  0.7,
      'height':  0.7, 
    },
    {
      'text': "these concept will help you explore and understand better the wonders of ALGERIA !",
      'imagePath': "assets/images/level0/img3.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.05,
      'top':- 0.03 ,
      'width':  0.7,
      'height':  0.7, 
    },
    {
      'text': "let’s start then , this is the map of ALGERIA in other words this is the shape of ALGERIA",
      'imagePath': "assets/images/level0/img4.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.12,
      'top': 0.05 ,
      'width':  0.6,
      'height':  0.6, 
    },
    {
      'text': "and as you can see ALGERIA is a big country in fact its the biggest country in africa ",
      'imagePath': "assets/images/level0/img5.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.12,
      'top': 0.05 ,
      'width':  0.6,
      'height':  0.6, 
    },
    {
      'text': "and because ALGERIA is so big it’s devided into 58 small city or wilaya ",
      'imagePath': "assets/images/level0/img6.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.12,
      'top': 0.05 ,
      'width':  0.6,
      'height':  0.6, 
    },
    {
      'text': "some famous algerian cities are :",
      'imagePath': "assets/images/level0/img7.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.17,
      'top': 0.08 ,
      'width':  0.5,
      'height':  0.6, 
    },
    {
      'text': "some famous algerian cities are :",
      'imagePath': "assets/images/level0/img8.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.18,
      'top': 0.02 ,
      'width':  0.5,
      'height':  0.6, 
    },
    {
      'text': "and since ALGERIA is so big , it has many different landscapes ... aaah you dont know this word yet do you ?  ",
      'imagePath': "assets/images/level0/img9.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.17,
      'top': 0.08 ,
      'width':  0.5,
      'height':  0.6, 
    },
    {
      'text': "let me explain with exemples so you can understand better !!",
      'imagePath': "assets/images/level0/img9.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.17,
      'top': 0.08 ,
      'width':  0.5,
      'height':  0.6, 
    },
    {
      'text': " you see this all this water ? it’s called The Sea and it’s one of the landscapes , the sea is so Big We swim, sail, and fish there.",
      'imagePath': "assets/images/level0/img10.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.17,
      'top': 0.1 ,
      'width':  0.5,
      'height':  0.5, 
    },
    {
      'text': "no this is not a yellow sea hehe , it’s called the desert and it’s filled with sand ! the weather is often so hot in here ",
      'imagePath': "assets/images/level0/img11.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.17,
      'top': 0.1 ,
      'width':  0.5,
      'height':  0.5, 
    },
    {
      'text': "this giant thing is called a mountain , it reach up into the sky. Some even have snow on top!",
      'imagePath': "assets/images/level0/img12.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.17,
      'top': 0.1 ,
      'width':  0.5,
      'height':  0.5, 
    },
    {
      'text': "another landscape is the forest , this is a Place filled with trees, animals, and shade. They’re green and full of life!",
      'imagePath': "assets/images/level0/img13.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.17,
      'top': 0.1 ,
      'width':  0.5,
      'height':  0.5, 
    },
    {
      'text': "all of these are what we call landscapes aren’t they wonderful ?",
      'imagePath': "assets/images/level0/img14.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.17,
      'top': 0.08 ,
      'width':  0.5,
      'height':  0.6, 
    },
    {
      'text': "now you may be asking again where are all this landscapes  located in ALGERIA ?",
      'imagePath': "assets/images/level0/img15.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.17,
      'top': 0.08 ,
      'width':  0.5,
      'height':  0.6, 
    },
    {
      'text': "to answer this you must first know the four main directions ",
      'imagePath': "assets/images/level0/img16.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.17,
      'top': 0.08 ,
      'width':  0.5,
      'height':  0.6, 
    },
    {
      'text': "the NORTH is up , the SOUTH is downthe EST is right and the WEST is left  ",
      'imagePath': "assets/images/level0/img17.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.14,
      'top': 0.08 ,
      'width':  0.55,
      'height':  0.55, 
    },
    {
      'text': "for example CONSTANTINE is in the EST and ORAN is in the WEST",
      'imagePath': "assets/images/level0/img18.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.12,
      'top': 0.05 ,
      'width':  0.6,
      'height':  0.6, 
    },
    {
      'text': "Excelent you passed the level, I think you are ready to start this journey together , i promise it will be so fun !!! ",
      'imagePath': "assets/images/level0/img19.png",
      'audioPath': "audios/level0/1.mp3",
      'left': 0.16,
      'top': 0.06 ,
      'width':  0.5,
      'height':  0.6, 
    },
  ];

  final AudioPlayer _player = AudioPlayer();
  late AnimationController _fennecController;
  late Animation<double> _fennecAnimation;

  Future<void> _playAudio(String assetPath) async {
    // Stop any currently playing audio
    await _player.stop();

    // Set the asset and play the audio
    await _player.setAsset(assetPath); // Use setAsset for just_audio
    await _player.play();
  }

  void _stopAudio() async {
    await _player.stop();
  }

  @override
  void initState() {
    super.initState();
    _fennecController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _fennecAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(_fennecController);
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
    _player.dispose(); 
    _fennecController.dispose();
    super.dispose();
  }

  void _showNextPoint() {
    if (currentPointIndex < mapPoints.length - 1) {
      _stopAudio();
      setState(() {
        currentPointIndex++;
        _playAudio(mapPoints[currentPointIndex]['audioPath']!);
      });
    }
    else {
      Navigator.pop(context);
    }
  }

  void _showPreviousPoint() {
    _stopAudio();
    if (currentPointIndex > 0) {
      setState(() {
        currentPointIndex--;
        _playAudio(mapPoints[currentPointIndex]['audioPath']!);
      });
    }
    else {
      Navigator.pop(context);
    }
  }

  void _skipMap() {
    setState(() {
      _stopAudio();
      currentPointIndex = mapPoints.length - 1;
      _playAudio(mapPoints[currentPointIndex]['audioPath']!);
    });
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var currentPoint = mapPoints[currentPointIndex];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/backgrounds/bg9.jpg", // Your background image path
              fit: BoxFit.cover,
            ),
          ),

          // Button Stack Positioned Vertically on the Left
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.02, top: screenHeight * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button with Confirmation Dialog
                  Material(
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
                  SizedBox(height: screenHeight * 0.02), // Spacing

                  // Question Button
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {},
                      child: Ink.image(
                        image: AssetImage("assets/icons/question_icon.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02), // Spacing

                  // Pause Button
                  Material(
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        // Show the PauseDialog
                        showDialog(
                          context: context,
                          barrierDismissible: false, // Prevent closing by tapping outside the dialog
                          builder: (BuildContext context) {
                            return PauseDialog(profileNbr: widget.profileNbr); // This will display the PauseDialog
                          },
                        );
                      },
                      child: Ink.image(
                        image: AssetImage("assets/icons/pause_icon.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02), // Spacing
                ],
              ),
            ),
          ),

          Positioned(
            left: screenWidth * 0.55, // Adjust horizontal position
            top: screenHeight * 0.38, // Adjust vertical position
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
                  "assets/icons/region1/adventure1/fennec.png",
                  height: screenHeight * 0.6,
                  width: screenWidth * 0.6,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Positioned(
            left: screenWidth * 0.16,
            top: screenHeight * 0.62,
            child: SizedBox(
              width: screenWidth * 0.5, // optional: set max width
              child: Text(
                currentPoint['text'],
                style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: screenWidth * 0.024,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF56351E),
                  ),
                textAlign: TextAlign.center,
              ),
            ),
          ),


          Positioned(
            left: screenWidth *currentPoint['left'],
            top: screenHeight * currentPoint['top'] ,
            child: Container(
              width: screenWidth * currentPoint['width'],
              height: screenHeight * currentPoint['height'], 
              child: Image.asset(
                currentPoint['imagePath']!,
                fit: BoxFit.contain, // Fit the image properly within the container
              ),
            ),
          ),



          Positioned(
            left: screenWidth * 0.12,
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
                  onTap: _showPreviousPoint, // Assign the function for the back button
                ),
                AnimatedGameButton(
                  "assets/icons/region1/adventure1/skip_button.png",
                  screenWidth * 0.2,
                  screenHeight * 0.2,
                  screenWidth * 0.1,
                  screenHeight * 0.1,
                  onTap: _skipMap, // Skip action
                ),
                AnimatedGameButton(
                  "assets/icons/region1/adventure1/next_button.png",
                  screenWidth * 0.2,
                  screenHeight * 0.2,
                  screenWidth * 0.1,
                  screenHeight * 0.1,
                  onTap: _showNextPoint, // Assign the function for the next button
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
