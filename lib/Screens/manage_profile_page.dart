import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/Screens/delete_profile_page.dart';
import 'package:project_2cp_eq11/Screens/edit_profile_page.dart';

class ManageProfilePage extends StatefulWidget {

  final int profileNbr;

  const ManageProfilePage({Key? key, required this.profileNbr}) : super(key: key);

  @override
  _ManageProfilePageState createState() => _ManageProfilePageState();
}

UserProfile currentUser = UserProfile(
  firstName: "Someone",
  lastName: "Noone",
  age: "10",
  avatarIndex: 2,
);

class AnimatedButton extends StatefulWidget {
  final String iconPath;
  final String label;
  final double width;
  final double height;
  final VoidCallback onPressed;

  AnimatedButton(this.iconPath, this.label, this.width, this.height , this.onPressed);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}


class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
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
      _controller.reverse();
      widget.onPressed(); // 👈 Call the function passed from the parent
    });
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
              fontSize: widget.width * 0.1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ManageProfilePageState extends State<ManageProfilePage> {
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
              "assets/backgrounds/bg3.jpg",
              fit: BoxFit.fill,
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01), 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                     "MANAGE",  
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                    ),
                  ),
                  Text(
                    "PROFILE",
                    style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF56351E),
                      height: MediaQuery.of(context).size.height > 700 ? 0.9 : 0.6,
                    ),
                  ),
                ],
              ),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.3), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // **Delete Button**
                  AnimatedButton("assets/icons/manage_profile_page/delete_icon.png","delete",screenWidth * 0.36,screenHeight * 0.36,() {Navigator.push(context,MaterialPageRoute(builder: (context) => DeleteProfilePage(profileNbr:widget.profileNbr)), );},),
                  SizedBox(width: screenWidth * 0.0001), 
                  // **Edit Button**
                  AnimatedButton("assets/icons/manage_profile_page/edit_icon.png","edit",screenWidth * 0.36,screenHeight * 0.36,(){Navigator.push(context,MaterialPageRoute(builder: (context) => EditProfilePage(profileNbr: widget.profileNbr)), );}),
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }

}