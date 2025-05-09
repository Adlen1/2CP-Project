import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/screens/login_page.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late AnimationController _textController;
  late Animation<double> _bounce;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    _iconController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _textController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _bounce = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.elasticOut),
    );

    _iconController.forward().then((_) => _textController.forward());

    _waitForData();
    _startTimeoutChecker();
  }

  void _startTimeoutChecker() async {
    while (mounted && !_navigated) {
      await Future.delayed(Duration(seconds: 30));
      if (_isDataStillLoading()) {
        if (mounted && !_navigated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Connection failed... Please check your internet."),
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        break; // Stop loop once data is loaded
      }
    }
  }

  void _waitForData() async {
    await Future.delayed(Duration(seconds: 3));
    print(
      '\x1B[31mCurrent userData: ${Provider.of<DataProvider>(context, listen: false).userData}\x1B[0m',
    );

    while (_isDataStillLoading()) {
      print('\x1B[31m[ERROR] DATA IS STILL LOADING\x1B[0m');

      await Future.delayed(Duration(milliseconds: 500));
    }
    print('\x1B[32m[SUCCESS] Data initialized\x1B[0m');

    _navigateToLogin();
  }

  bool _isDataStillLoading() {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;

    final profiles = userData['Profiles'];
    if (profiles == null) return true;

    for (int i = 1; i <= 4; i++) {
      final profile = profiles['Profile_$i'];
      if (profile == null || profile['created'] == null) return true;
    }

    return false;
  }

  void _navigateToLogin() {
    if (_navigated) return;
    _navigated = true;
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
    _iconController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final iconSize = size.width * 0.15; // ~30% of screen width
    final padding = size.width * 0.01; // 5% padding
    final spacing = size.height * 0.03; // ~3% vertical spacing
    final progressSize =
        size.width * 0.04; // ~8% of width for progress indicator
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFCB7C), Color(0xFFFE6D73)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _bounce,
                    child: Container(
                      padding: EdgeInsets.all(padding),
                      child: Image.asset(
                        "assets/icons/app_icon.png",
                        width: iconSize,
                        height: iconSize,
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _textController,
                    child: Column(
                      children: [
                        Text(
                          "Jawla",
                          style: TextStyle(
                            fontSize: size.width * 0.04, // Dynamic font size
                            fontFamily: 'Kavivanar',
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                color: Colors.pink.shade200,
                                blurRadius: 10,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: spacing * 0.7),
                        Text(
                          "Discover, Play and Learn!",
                          style: TextStyle(
                            fontSize: size.width * 0.03,
                            color: Colors.white,
                            fontFamily: 'Kavivanar',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spacing * 1.7),
                  SizedBox(
                    width: progressSize,
                    height: progressSize,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
