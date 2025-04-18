import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/screens/login_page.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _iconController;
  late AnimationController _textController;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();

    _iconController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _textController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _bounce = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _iconController, curve: Curves.elasticOut));

    _iconController.forward().then((_) => _textController.forward());
    _waitForData();
  }

  void _waitForData() async {
    await Future.delayed(Duration(seconds: 2));
    while (_isDataStillLoading()) {
      await Future.delayed(Duration(milliseconds: 400));
    }
    _navigateToLogin();
  }

  bool _isDataStillLoading() {
    final userData = Provider.of<DataProvider>(context, listen: false).userData;
    return userData['Profiles'] == null;
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => LoginScreen(),
        transitionsBuilder: (_, anim, __, child) {
          final curve = CurvedAnimation(parent: anim, curve: Curves.easeInOut);
          return FadeTransition(opacity: curve, child: child);
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

  Widget _buildFloatingElement(Offset position, double size, double delay) {
    return AnimatedPositioned(
      duration: Duration(seconds: 4),
      curve: Curves.easeInOut,
      left: position.dx,
      top: position.dy,
      child: Icon(
        Icons.star_rounded,
        color: Colors.white.withOpacity(0.2 + Random().nextDouble() * 0.3),
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFCB7C), Color(0xFFFE6D73),],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Floating stars
            ...List.generate(8, (index) {
              return _buildFloatingElement(
                Offset(Random().nextDouble() * size.width, Random().nextDouble() * size.height),
                20 + Random().nextDouble() * 20,
                index * 0.5,
              );
            }),

            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _bounce,
                    child: Container(
                      padding: EdgeInsets.all(18),
                      child: Image.asset(
                        "assets/icons/app_icon.png",
                        width: 130,
                        height: 130,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  FadeTransition(
                    opacity: _textController,
                    child: Column(
                      children: [
                        Text(
                          "جولة",
                          style: TextStyle(
                            fontSize: 42,
                            fontFamily: 'Baloo2',
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                color: Colors.pink.shade200,
                                blurRadius: 10,
                                offset: Offset(1, 2),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Discover, Play and Learn!",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Kavivanar',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3,
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
