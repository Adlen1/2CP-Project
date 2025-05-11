import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2cp_eq11/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'account_data/init_user_data.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ============================================================================
// main.dart
// ============================================================================
// Entry point for the appn.
//
// this is where we call the functions to initialize firebase,
// fetch date, and upload it on close app. to and from a provider
//
//
// this class then calls the Splash screen class
// ============================================================================

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> firstTimeInitData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }
    user = FirebaseAuth.instance.currentUser;
    DocumentReference userDoc = FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid);

    DocumentSnapshot userSnapshot = await userDoc.get();
    if (userSnapshot.exists) {
      await _fetchDataOnStart(); // Fetch data after sign-in
      // return;
    } else {
      Map<String, dynamic> userData = {"Profiles": {}};
      print(
        '\x1B[33mError uploading profile : $userData \x1B[0m',
      ); // Yellow text

      for (int i = 1; i < 5; i++) {
        userData["Profiles"]["Profile_$i"] = {
          "firstName": "",
          "lastName": "",
          "age": 0,
          "avatar": "",
          "created": false,
          "lastPlayedRegion": 0,
          "lastPlayedAdv": 0,
          "Regions": {
            "region_north": {
              "unlocked": true,
              "unlocks": "region_east",
              "completed": false,
              "landmarks": [false, false, false, false, false, false],
              "adventures": {
                "adventure_1": {
                  "alreadyStarted": false,
                  "checkPoint": 0,
                  "completed": false,
                },
                "adventure_2": {
                  "alreadyStarted": false,
                  "checkPoint": 0,
                  "completed": false,
                },
              },
            },
            "region_east": {
              "unlocked": false,
              "unlocks": "region_west",
              "completed": false,
              "landmarks": [false, false, false, false, false, false],
              "adventures": {
                "adventure_1": {
                  "alreadyStarted": false,
                  "checkPoint": 0,
                  "completed": false,
                },
                "adventure_2": {
                  "alreadyStarted": false,
                  "checkPoint": 0,
                  "completed": false,
                },
              },
            },
            "region_west": {
              "unlocked": false,
              "unlocks": "region_south",
              "completed": false,
              "landmarks": [false, false, false, false, false, false],
              "adventures": {
                "adventure_1": {
                  "alreadyStarted": false,
                  "checkPoint": 0,
                  "completed": false,
                },
                "adventure_2": {
                  "alreadyStarted": false,
                  "checkPoint": 0,
                  "completed": false,
                },
              },
            },
            "region_south": {
              "unlocked": false,
              "unlocks": "",
              "completed": false,
              "landmarks": [false, false, false, false, false, false],
              "adventures": {
                "adventure_1": {
                  "alreadyStarted": false,
                  "checkPoint": 0,
                  "completed": false,
                },
                "adventure_2": {
                  "alreadyStarted": false,
                  "checkPoint": 0,
                  "completed": false,
                },
              },
            },
          },
          "minigames": {
            "Find": [false, false, false, false],
            "Puzzle": [false, false, false, false],
            "Match": [false, false, false, false],
            "Choose": [false, false, false, false],
            "Memory": [false, false, false, false],
            "Spot": [false, false, false, false],
            "FindStar": [0, 0, 0, 0],
            "PuzzleStar": [0, 0, 0, 0],
            "MatchStar": [0, 0, 0, 0],
            "ChooseStar": [0, 0, 0, 0],
            "MemoryStar": [0, 0, 0, 0],
            "SpotStar": [0, 0, 0, 0],
          },
          "Settings": {"masterV": true, "music": true, "narrator": true},
        };
      }
      Provider.of<DataProvider>(
        context,
        listen: false,
      ).updateLocalData(userData);
    }
  }

  void _initializeApp() async {
    SignIn signIN = SignIn();
    await signIN.signInAnonymously(); // Wait for sign-in to complete
    await firstTimeInitData();
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
    return PopScope(
      canPop: false, // This prevents back navigation globally
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
