import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';

class FirstSteps extends StatefulWidget {
  const FirstSteps({Key? key}) : super(key: key);

  @override
  _FirstStepsState createState() => _FirstStepsState();
}

class _FirstStepsState extends State<FirstSteps>
    with SingleTickerProviderStateMixin {
  late AnimationController _fennecController;
  late Animation<double> _fennecAnimation;
  int index = 1;

  Map<String, double> _buttonScales = {};
  List<String> textArray = [
    'Hello and welcome again!  let me show you a few things to help you get started',
    'When you launch the application for the first time you will be directed to the login page ',
    'From the login page, you have two options:',
    'Create: If you are a new user, you can create an account to save your progress',
    'you enter your informations (first name, last name, age, and profile picture) ',
    'select: If you already have an account, select your account and continue your adventure !',
    'After logging in you will access the main menu of the game',
    'You will find 5 different frames and main board each one is a button you can tap',
    'the board with the Algerian map will allow you to access the main story mode',
    'after chosing the board you will navigate the four main regions of algeria',
    'each region contain 2 adventures ... each one will take place in a different wilaya ',
    'some adventures need to be unlocked by progressing the story before you can access them ... ',
    'each adventure will have different places to discover and learn from',
    'and of course i will stick by your side along your journey and together we will meet many friends',
    'you will learn plenty of informations from me and my friends ',
    'and we will get the chance to play too !\nwe 3 mini games to check in every adventure',
    'after finish exploring the whole region , you need to pass a quick test to check your learning',
    'you need a certain number of correct answers to pass the quiz',
    'after finishing the quiz a new region will be unlocked ',
    'next let me show the mini-games window ',
    'here you can replay all the games that you encountered in the story mode',
    'This section offers six educational games (puzzles, spot, memory, play, search, and choose)',
    'each mini-game will have four levels corresponding to one of the four regions',
    'you need to play the mini-game first in the story in order to unlock them here',
    'try finishing the games as fast as you can to get more stars .',
    'The second button in the main menu gives access to the Achievements section',
    'here you can keep track on your progress and get your rewards.',
    'there are 4 Cups: A cup is obtained when an entire region is completed.',
    'there is also 8 Medals: A medal is awarded at the end of each successful adventure.',
    'Clicking on a cup or a medal will give you more details on the trophy',
    'The third button in the main menu gives access to the Settings',
    'here you can customize tour  game experience This section contains six buttons',
    'Toggles sound effects on or off.',
    'Enable/Disable Music: Toggles background music on or off.',
    ' Toggles dialogues on or off.',
    'Manage Profile: Displays two options:you can ethier edit or delete your profile ',
    'change profile: where you can change the user profile .',
    'Quit the Game: A confirmation message appears before fully exiting the game.',
    'The fourth button in the main menu gives you to the Statistics, where you can track their detailed progress.',
    'you can choose between the statistics of the four regions: North, East, West, and South.',
    'For each region, the table displays the following stats:',
    'Mini-games completed: Number of mini-games finished out of 6',
    'Adventures completed: Number of successful adventures out of 2.',
    'Stars collected: Total number of stars obtained out of 18 (each mini-game contains 3 stars).',
    'Monuments visited: Number of monuments explored out of 6.',
    'Progress Rate: A percentage representing the player’s overall advancement in the region based on the past elements.',
    'The fifth button in the main menu gives access to the Help section, where you can find explanations about the game’s features.',
    'here you can repeat the tutorial if you wish and you can also read more on the game mechanics in details !',
  ];

  int lastPageNb = 0;

  @override
  void initState() {
    super.initState();
    index = 1;
    lastPageNb = textArray.length;
    // Fennec Animation with Bounce Effect
    _fennecController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _fennecAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(_fennecController);
  }

  void _onFennecTapDown(TapDownDetails details) {
    _fennecController.forward();
    setState(() {}); // Ensure rebuild
  }

  void _onFennecTapUp(TapUpDetails details) {
    _fennecController.reverse();
    setState(() {}); // Ensure rebuild
  }

  void _onFennecTapCancel() {
    _fennecController.reverse();
    setState(() {}); // Ensure rebuild
  }

  Widget _buildAnimatedButtonWithScale(
    String key,
    String iconPath,
    double width,
    double height,
    VoidCallback onTap,
  ) {
    _buttonScales.putIfAbsent(key, () => 1.0);

    return GestureDetector(
      onTapDown: (_) => setState(() => _buttonScales[key] = 0.9),
      onTapUp: (_) => setState(() => _buttonScales[key] = 1.0),
      onTapCancel: () => setState(() => _buttonScales[key] = 1.0),
      onTap: onTap,
      child: AnimatedScale(
        scale: _buttonScales[key] ?? 1.0, // Get the scale for this button
        duration: Duration(milliseconds: 150),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(32),
          child: InkWell(
            borderRadius: BorderRadius.circular(32),
            splashColor: Colors.white.withOpacity(0.3),
            highlightColor: Colors.grey.withOpacity(0.1),
            child: Ink.image(
              image: AssetImage(iconPath),
              width: width,
              height: height,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  // Animated Button Builder
  Widget _buildAnimatedButton(
    double width,
    double heigth,
    String activeIcon,
    String inactiveIcon,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Image.asset(
          isActive ? activeIcon : inactiveIcon,
          key: ValueKey<bool>(
            isActive,
          ), // Ensure smooth animation when changing states
          width: width, // Adjust size if needed
          height: heigth,
          fit: BoxFit.contain,
        ),
      ),
    );
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
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: Colors.white),
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
                      },
                      child: Ink.image(
                        image: AssetImage("assets/icons/back_icon.png"),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: screenHeight * 0.62,
                width: screenWidth * 0.275,
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
                      "assets/icons/fennec/helpFennec.png",
                      height: screenHeight * 0.7,
                      width: screenWidth * 0.7,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              Container(
                height: screenHeight * 0.90,
                width: screenWidth * 0.62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Color(0xFFFFCB7C), // You can change the color
                    width: 7.0, // You can adjust the thickness
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),

                    Container(
                      height: screenHeight * 0.5,
                      width: screenWidth * 0.56,
                      child: Image.asset(
                        "assets/images/Help/image${index.toString().padLeft(2, '0')}.png",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ), // adjust as needed
                      child: SizedBox(
                        height: 60,
                        child: Text(
                          textArray[index - 1],
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF56351E),
                            fontFamily: "Fredoka",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        index > 1
                            ? AnimatedGameButton(
                              "assets/icons/region1/adventure1/back_button.png",
                              screenWidth * 0.2,
                              screenHeight * 0.1,
                              screenWidth * 0.1,
                              screenHeight * 0.1,
                              onTap: () {
                                setState(() {
                                  index--;
                                });
                              },
                            )
                            : SizedBox(height: 0),
                        AnimatedGameButton(
                          "assets/icons/region1/adventure1/skip_button.png",
                          screenWidth * 0.2,
                          screenHeight * 0.1,
                          screenWidth * 0.1,
                          screenHeight * 0.1,
                          onTap: () {
                            if (index < 9) {
                              setState(() {
                                index = 9;
                              });
                            } else if (index < 20) {
                              setState(() {
                                index = 20;
                              });
                            } else if (index < 26) {
                              setState(() {
                                index = 26;
                              });
                            } else if (index < 31) {
                              setState(() {
                                index = 31;
                              });
                            } else if (index < 39) {
                              setState(() {
                                index = 39;
                              });
                            } else if (index < 47) {
                              setState(() {
                                index = 47;
                              });
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        ),
                        AnimatedGameButton(
                          index < lastPageNb
                              ? "assets/icons/region1/adventure1/next_button.png"
                              : "assets/icons/region1/adventure1/done.png",
                          screenWidth * 0.2,
                          screenHeight * 0.1,
                          screenWidth * 0.1,
                          screenHeight * 0.1,
                          onTap: () {
                            index < lastPageNb
                                ? setState(() {
                                  index++;
                                })
                                : Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
