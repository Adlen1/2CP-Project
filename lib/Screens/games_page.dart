import 'package:flutter/material.dart';

class MiniGamesPage extends StatefulWidget {
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
              fit: BoxFit.cover,
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
                  ["assets/icons/search_icon.png", "assets/icons/puzzle_icon.png", "assets/icons/color_icon.png"],
                  ["Search", "Puzzle", "Color"],
                  screenWidth,
                  screenHeight,
                ),
                SizedBox(height: screenHeight * 0.02),
                _buildButtonRow(
                  ["assets/icons/play_icon.png", "assets/icons/memory_icon.png", "assets/icons/spot_icon.png"],
                  ["Play", "Memory", "Spot"],
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
  Widget _buildButtonRow(List<String> iconPaths, List<String> labels, double screenWidth, double screenHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedGameButton(iconPaths[0], labels[0], screenWidth * 0.18, screenHeight * 0.28),
        SizedBox(width: screenWidth * 0.01),
        AnimatedGameButton(iconPaths[1], labels[1], screenWidth * 0.18, screenHeight * 0.28),
        SizedBox(width: screenWidth * 0.01),
        AnimatedGameButton(iconPaths[2], labels[2], screenWidth * 0.18, screenHeight * 0.28),
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

  AnimatedGameButton(this.iconPath, this.label, this.width, this.height);

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
    _controller.forward().then((_) => _controller.reverse()); // Shrink, then go back
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Column(
        children: [
          ScaleTransition(
            scale: _scaleAnimation, // Applies the animated scale effect
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
