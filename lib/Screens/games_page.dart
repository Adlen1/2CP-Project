import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/levels_page.dart';

class MiniGamesPage extends StatefulWidget {

  final int profileNbr;

  const MiniGamesPage({Key? key, required this.profileNbr}) : super(key: key);
  
  @override
  _MiniGamesPageState createState() => _MiniGamesPageState();
}

class _MiniGamesPageState extends State<MiniGamesPage> {
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
              "assets/backgrounds/bg5.jpg",
              fit: BoxFit.fill,
            ),
          ),

          // Back Button (Top Left)
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

          // Centered Grid of Buttons
          Positioned(
            top: screenHeight * 0.1,
            left: 0,
            right: 0,
            child: Column(
              children: [
                _buildButtonRow(
                  ["assets/icons/games_page/search_icon.png", "assets/icons/games_page/puzzle_icon.png", "assets/icons/games_page/play_icon.png"],
                  ["Find", "Puzzle", "Match"],
                  [LevelsPage(profileNbr: widget.profileNbr,minigameType: "Find"), LevelsPage(profileNbr: widget.profileNbr,minigameType: "Puzzle"), LevelsPage(profileNbr: widget.profileNbr,minigameType: "Match")],
                  screenWidth,
                  screenHeight,
                ),
                SizedBox(height: screenHeight * 0.02),
                _buildButtonRow(
                  ["assets/icons/games_page/choose_icon.png", "assets/icons/games_page/memory_icon.png", "assets/icons/games_page/spot_icon.png"],
                  ["Choose", "Memory", "Spot"],
                  [LevelsPage(profileNbr: widget.profileNbr,minigameType: "Choose"), LevelsPage(profileNbr: widget.profileNbr,minigameType: "Memory"), LevelsPage(profileNbr: widget.profileNbr,minigameType: "Spot")],
                  screenWidth,
                  screenHeight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to build a row of 3 animated buttons
  Widget _buildButtonRow(List<String> iconPaths, List<String> labels, List<Widget> pages, double screenWidth, double screenHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedGameButton(iconPaths[0], labels[0], screenWidth * 0.18, screenHeight * 0.28 , pages[0]),
        SizedBox(width: screenWidth * 0.01),
        AnimatedGameButton(iconPaths[1], labels[1], screenWidth * 0.18, screenHeight * 0.28 , pages[1]),
        SizedBox(width: screenWidth * 0.01),
        AnimatedGameButton(iconPaths[2], labels[2], screenWidth * 0.18, screenHeight * 0.28 , pages[2]),
      ],
    );
  }
}

// **Optimized Animated Button without _isTapped**
class AnimatedGameButton extends StatefulWidget {
  final String iconPath;
  final String label;
  final double width;
  final double height;
  final Widget destination;

  AnimatedGameButton(this.iconPath, this.label, this.width, this.height , this.destination);

  @override
  _AnimatedGameButtonState createState() => _AnimatedGameButtonState();
}

class _AnimatedGameButtonState extends State<AnimatedGameButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Create Animation Controller
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
      lowerBound: 0.55, // Minimum scale (shrinking effect)
      upperBound: 1.5,  // Normal size
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
  _controller.forward().then((_) {
    Future.delayed(Duration(milliseconds: 100), () {
      _controller.reverse();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget.destination),
      );
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Column(
        children: [
          ScaleTransition(
            scale: _scaleAnimation, 
            child: Image.asset(
              widget.iconPath,
              width: widget.width,
              height: widget.height,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 2),
          Text(
            widget.label,
            style: TextStyle(
              color: Color(0xFF56351E),
              fontFamily: "Fredoka",
              fontSize: widget.width * 0.16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
