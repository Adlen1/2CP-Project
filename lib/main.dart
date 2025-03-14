import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2cp_eq11/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}*/

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  void signInAnonymously() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    _user = FirebaseAuth.instance.currentUser;

    if (_user != null) {
      await initializeUserData(); // Initialize Firestore after sign-in
    }
  }

  @override
  void initState() {
    super.initState();
    signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Anonymous User Example")),
        body: Center(
          child: Text(
            _user != null ? "User ID: ${_user!.uid}" : "Signing in...",
          ),
        ),
      ),
    );
  }
}
