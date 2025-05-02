import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2cp_eq11/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'account_data/init_user_data.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    runApp(
      ChangeNotifierProvider(create: (_) => DataProvider(), child: MyApp()),
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Register lifecycle observer
    _initializeApp();
  }

  void _initializeApp() async {
    SignIn signIN = SignIn();
    await signIN.signInAnonymously(); // Wait for sign-in to complete
    await _fetchDataOnStart(); // Fetch data after sign-in
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Fetch data when the app starts
  Future<void> _fetchDataOnStart() async {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    await dataProvider.fetchData();
  }

  // Upload data when the app closes or goes into the background
  Future<void> _uploadDataOnClose() async {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    await dataProvider.updateData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      // App is closing or going into the background
      _uploadDataOnClose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Entry point to your app
    );
  }
}
