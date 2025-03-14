import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2cp_eq11/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'init_user_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // runs once when the app is open
    super.initState();

    SignIn signIN = SignIn();
    signIN.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
=======
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    
    );
>>>>>>> 45da4cbfa7cbdf66eb456ce7691235969d43a6fd
  }
}
