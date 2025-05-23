import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// ============================================================================
/// init_user_data.dart
/// ============================================================================
///
/// this class take care of the anynomous sign in + the initialization of the user's data
///
/// it is called solely from the main.dart
///
/// ============================================================================

class SignIn {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? _user;

  Future<void> initializeUserData() async {
    User? user = auth.currentUser;

    if (user == null) {
      return;
    }

    // Reference to the user document
    DocumentReference userDoc = firestore.collection("Users").doc(user.uid);

    //check if it is the first time opening the app
    DocumentSnapshot userSnapshot = await userDoc.get();
    if (userSnapshot.exists) {
      return;
    }
    await userDoc.set(<String, dynamic>{});

    for (int i = 1; i <= 4; i++) {
      String profileId = "Profile_$i";

      // Add Profiles subcollection
      DocumentReference profileDoc = userDoc
          .collection("Profiles")
          .doc(profileId);

      await profileDoc.set({
        "firstName": "",
        "lastName": "",
        "age": 0,
        "avatar": "",
        "created": false,
        "lastPlayedRegion": 0,
        "lastPlayedAdv": 0,
      });

      // Add Regions subcollection
      CollectionReference regionsCollection = profileDoc.collection("Regions");

      await regionsCollection.doc("region_north").set({
        "unlocked": true, // The first region is unlocked
        "unlocks": "region_east",
        "completed": false,
        "landmarks": [false, false, false, false, false, false],
      });
      await regionsCollection
          .doc("region_north")
          .collection("adventures")
          .doc("adventure_1")
          .set({"alreadyStarted": false, "checkPoint": 0, "completed": false});
      await regionsCollection
          .doc("region_north")
          .collection("adventures")
          .doc("adventure_2")
          .set({"alreadyStarted": false, "checkPoint": 0, "completed": false});

      await regionsCollection.doc("region_east").set({
        "unlocked": false, // This region is locked initially
        "unlocks": "region_west",
        "completed": false,
        "landmarks": [false, false, false, false, false, false],
      });
      await regionsCollection
          .doc("region_east")
          .collection("adventures")
          .doc("adventure_1")
          .set({"alreadyStarted": false, "checkPoint": 0, "completed": false});
      await regionsCollection
          .doc("region_east")
          .collection("adventures")
          .doc("adventure_2")
          .set({"alreadyStarted": false, "checkPoint": 0, "completed": false});

      await regionsCollection.doc("region_west").set({
        "unlocked": false, // This region is locked initially
        "unlocks": "region_south",
        "completed": false,
        "landmarks": [false, false, false, false, false, false],
      });
      await regionsCollection
          .doc("region_west")
          .collection("adventures")
          .doc("adventure_1")
          .set({"alreadyStarted": false, "checkPoint": 0, "completed": false});
      await regionsCollection
          .doc("region_west")
          .collection("adventures")
          .doc("adventure_2")
          .set({"alreadyStarted": false, "checkPoint": 0, "completed": false});

      await regionsCollection.doc("region_south").set({
        "unlocked": false, // This region is locked initially
        "unlocks": "",
        "completed": false,
        "landmarks": [false, false, false, false, false, false],
      });
      await regionsCollection
          .doc("region_south")
          .collection("adventures")
          .doc("adventure_1")
          .set({"alreadyStarted": false, "checkPoint": 0, "completed": false});
      await regionsCollection
          .doc("region_south")
          .collection("adventures")
          .doc("adventure_2")
          .set({"alreadyStarted": false, "checkPoint": 0, "completed": false});

      CollectionReference minigamesCollection = profileDoc.collection(
        "minigames",
      );

      await minigamesCollection.doc("minigames").set({
        //----------------------------------------
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
        //----------------------------------------
      });

      CollectionReference settingsCollection = profileDoc.collection(
        "Settings",
      );

      await settingsCollection.doc("settings").set({
        "masterV": true,
        "music": true,
        "narrator": true,
      });
    }
  }

  Future<void> signInAnonymously() async {
    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }
    _user = FirebaseAuth.instance.currentUser;

    if (_user != null) {
      await initializeUserData(); // Use the same instance!
    }
  }
}
