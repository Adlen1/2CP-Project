import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/screens/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _textOpacityAnimation;
  
  @override
  void initState() {
    super.initState();
    // Setup the animation controller for both the logo and text animations
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    );
    
    // Scale animation for the logo from half size to full size
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut)
    );

    // Fade in animation for the tagline starting halfway through
    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 1.0, curve: Curves.easeIn))
    );

    // Start the animation
    _controller.forward();

    // After 6 seconds, navigate to LoginScreen with a combined slide and fade transition
    Future.delayed(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 0.2),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: FadeTransition(
                opacity: curvedAnimation,
                child: child,
              ),
            );
          },
        ),
      );
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background with the provided colors
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFCB7C), 
              Color(0xFFFE6D73), 
              Color(0xFF53C8C1),  
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated scaling of the logo
              ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset(
                  "assets/icons/app_icon.png",
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 20),
              // Tagline text that fades in
              FadeTransition(
                opacity: _textOpacityAnimation,
                child: Text(
                  "Discover, Play and Learn!",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Loading indicator
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
