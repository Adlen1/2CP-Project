import 'package:flutter/material.dart';

var main_menu = "assets/backgrounds/main_menu.jpg";
var help_icon = "assets/icons/help_icon.png";
var main_story_icon = "assets/icons/main-story_icon.png";
var mini_games_icon = "assets/icons/mini-games_icon.png";
var rewards_icon = "assets/icons/rewards_icon.png";
var settings_icon = "assets/icons/settings_icon.png";
var stats_icon = "assets/icons/stats_icon.png";

bool isGlowing = false;

void _triggerGlow() {
  isGlowing = true;
  Future.delayed(Duration(milliseconds: 300), () {
    isGlowing = false;
  });
}


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        main_menu,
        fit: BoxFit.cover, // Ensures the image fills the screen
      ),
    ),


          // Story button with glowing border
Align(
  alignment: Alignment(0.07, 0.25),
  child: GestureDetector(
    onTap: () => _triggerGlow(),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 300), // Smooth animation
      padding: EdgeInsets.all(8), // Space for the glow effect
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isGlowing ? Colors.blue.withOpacity(0.8) : Colors.transparent, 
          width: 5, // Border thickness
        ),
        boxShadow: isGlowing
            ? [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 15)]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              // Handle button tap
            },
            child: Opacity(
              opacity: 0, // **Only the image is hidden**
              child: Ink.image(
                image: AssetImage(main_story_icon),
                height: 290,
                width: 318,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ),
  ),
),


          //Settings button
          Align(
  alignment: Alignment(0.038, -1.041),
  child: GestureDetector(
    onTap: () => _triggerGlow(),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 300), // Smooth animation
      padding: EdgeInsets.all(8), // Space for the glow effect
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isGlowing ? Colors.blue.withOpacity(0.8) : Colors.transparent, 
          width: 5, // Border thickness
        ),
        boxShadow: isGlowing
            ? [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 15)]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              // Handle button tap
            },
            child: Opacity(
              opacity: 0, // **Only the image is hidden**
              child: Ink.image(
                image: AssetImage(settings_icon),
                height: 52,
                width: 130,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ),
  ),
),

          //help button
           Align(
  alignment: Alignment(-0.78, -0.59),
  child: GestureDetector(
    onTap: () => _triggerGlow(),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 300), // Smooth animation
      padding: EdgeInsets.all(8), // Space for the glow effect
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isGlowing ? Colors.blue.withOpacity(0.8) : Colors.transparent, 
          width: 5, // Border thickness
        ),
        boxShadow: isGlowing
            ? [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 15)]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              // Handle button tap
            },
            child: Opacity(
              opacity: 0, // **Only the image is hidden**
              child: Ink.image(
                image: AssetImage(settings_icon),
                height: 119,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ),
  ),
),

          //stats button
           Align(
  alignment: Alignment(-0.775, 0.49),
  child: GestureDetector(
    onTap: () => _triggerGlow(),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 300), // Smooth animation
      padding: EdgeInsets.all(8), // Space for the glow effect
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isGlowing ? Colors.blue.withOpacity(0.8) : Colors.transparent, 
          width: 5, // Border thickness
        ),
        boxShadow: isGlowing
            ? [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 15)]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              // Handle button tap
            },
            child: Opacity(
              opacity: 0, // **Only the image is hidden**
              child: Ink.image(
                image: AssetImage(settings_icon),
                height: 93,
                width: 89,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ),
  ),
),

          //mini-games button
           Align(
  alignment: Alignment(1.05, -0.68),
  child: GestureDetector(
    onTap: () => _triggerGlow(),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 300), // Smooth animation
      padding: EdgeInsets.all(8), // Space for the glow effect
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isGlowing ? Colors.blue.withOpacity(0.8) : Colors.transparent, 
          width: 5, // Border thickness
        ),
        boxShadow: isGlowing
            ? [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 15)]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              // Handle button tap
            },
            child: Opacity(
              opacity: 0, // **Only the image is hidden**
              child: Ink.image(
                image: AssetImage(settings_icon),
                height: 130,
                width: 130,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ),
  ),
),

          //Rewards button
           Align(
  alignment: Alignment(1.06, 0.5),
  child: GestureDetector(
    onTap: () => _triggerGlow(),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 300), // Smooth animation
      padding: EdgeInsets.all(8), // Space for the glow effect
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isGlowing ? Colors.blue.withOpacity(0.8) : Colors.transparent, 
          width: 5, // Border thickness
        ),
        boxShadow: isGlowing
            ? [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 15)]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              // Handle button tap
            },
            child: Opacity(
              opacity: 0, // **Only the image is hidden**
              child: Ink.image(
                image: AssetImage(settings_icon),
                height: 124,
                width: 124,
                fit: BoxFit.cover,
              ),
            ),
          ),
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
