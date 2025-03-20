/*
import 'package:flutter/material.dart';
import 'package:project_2cp_eq11/screens/login_page.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:provider/provider.dart';

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

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Animation duration
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    _waitForData(); // Start the loading process
  }

  void _waitForData() async {
    await Future.delayed(Duration(seconds: 6)); // Ensure minimum splash time

    while (_isDataStillLoading()) {
      await Future.delayed(Duration(milliseconds: 500)); // Check every 500ms
    }

    _navigateToLogin();
  }

  bool _isDataStillLoading() {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;

    // Ensure the necessary data structure exists
    return userData['Profiles'] == null;
  }

  void _navigateToLogin() {
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
            child: FadeTransition(opacity: curvedAnimation, child: child),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFCB7C), Color(0xFFFE6D73), Color(0xFF53C8C1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset(
                  "assets/icons/app_icon.png",
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 20),
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
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/screens/login_page.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

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

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Animation duration
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
    _waitForData();
  }

  void _waitForData() async {
    await Future.delayed(Duration(seconds: 4)); // Ensure minimum splash time

    while (_isDataStillLoading()) {
      await Future.delayed(Duration(milliseconds: 500)); // Check every 500ms
    }

    _navigateToLogin();
  }

  bool _isDataStillLoading() {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;

    // Ensure the necessary data structure exists
    return userData['Profiles'] == null;
  }

  void _navigateToLogin() {
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
            child: FadeTransition(opacity: curvedAnimation, child: child),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFCB7C), Color(0xFFFE6D73), Color(0xFF53C8C1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset(
                  "assets/icons/app_icon.png",
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 20),
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
