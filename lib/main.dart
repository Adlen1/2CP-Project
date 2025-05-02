import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2cp_eq11/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'account_data/init_user_data.dart';
import 'package:provider/provider.dart';
import 'package:project_2cp_eq11/account_data/user_data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    if (user == null) return;
    DocumentReference userDoc = FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid);

    DocumentSnapshot userSnapshot = await userDoc.get();
    if (userSnapshot.exists) {
      print('\x1B[33mAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH\x1B[0m');

      await _fetchDataOnStart(); // Fetch data after sign-in
      print('\x1B[33mAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH\x1B[0m');

      // return;
    } else {
      Map<String, dynamic> userData = {"Profiles": {}};

      for (int i = 1; i < 5; i++) {
        print(
          '\x1B[33mThis text is yellow!WHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAT?????\x1B[0m',
        );
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
              "unlocked": true,
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
              "unlocked": true,
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
            "Find": [true, true, true, true],
            "Puzzle": [true, true, true, true],
            "Match": [true, true, true, true],
            "Choose": [true, true, true, true],
            "Memory": [true, true, true, true],
            "Spot": [true, true, true, true],
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
    print('\x1B[33mAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH\x1B[0m');

    print(
      '\x1B[33muserData = ${Provider.of<DataProvider>(context, listen: false).userData}\x1B[0m',
    );
  }

  void _initializeApp() async {
    SignIn signIN = SignIn();
    await firstTimeInitData();
    await signIN.signInAnonymously(); // Wait for sign-in to complete
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
