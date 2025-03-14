import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2cp_eq11/Screens/select_profile_page.dart';
import 'screens/login_page.dart'; // Import the login page

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft, // Uncomment for landscape mode
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: select_profile_page(), // Show the login page first
    );
  }
}
