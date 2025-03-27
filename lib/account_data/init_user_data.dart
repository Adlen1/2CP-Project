import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      });

      // Add Regions subcollection
      CollectionReference regionsCollection = profileDoc.collection("Regions");

      await regionsCollection.doc("region_north").set({
        "unlocked": true, // The first region is unlocked
        "unlocks": "region_east",
        "completed": true,
      });
      await regionsCollection
          .doc("region_north")
          .collection("adventures")
          .doc("adventure_1")
          .set({"alreadyStarted": true, "checkPoint": 0, "completed": true});
      await regionsCollection
          .doc("region_north")
          .collection("adventures")
          .doc("adventure_2")
          .set({"alreadyStarted": true, "checkPoint": 0, "completed": true});

      await regionsCollection.doc("region_east").set({
        "unlocked": true, // This region is locked initially
        "unlocks": "region_west",
        "completed": true,
      });
      await regionsCollection
          .doc("region_east")
          .collection("adventures")
          .doc("adventure_1")
          .set({"alreadyStarted": true, "checkPoint": 0, "completed": true});
      await regionsCollection
          .doc("region_east")
          .collection("adventures")
          .doc("adventure_2")
          .set({"alreadyStarted": true, "checkPoint": 0, "completed": true});

      await regionsCollection.doc("region_west").set({
        "unlocked": true, // This region is locked initially
        "unlocks": "region_south",
        "completed": true,
      });
      await regionsCollection
          .doc("region_west")
          .collection("adventures")
          .doc("adventure_1")
          .set({"alreadyStarted": true, "checkPoint": 0, "completed": true});
      await regionsCollection
          .doc("region_west")
          .collection("adventures")
          .doc("adventure_2")
          .set({"alreadyStarted": true, "checkPoint": 0, "completed": true});

      await regionsCollection.doc("region_south").set({
        "unlocked": true, // This region is locked initially
        "unlocks": "",
        "completed": true,
      });
      await regionsCollection
          .doc("region_south")
          .collection("adventures")
          .doc("adventure_1")
          .set({"alreadyStarted": true, "checkPoint": 0, "completed": true});
      await regionsCollection
          .doc("region_south")
          .collection("adventures")
          .doc("adventure_2")
          .set({"alreadyStarted": true, "checkPoint": 0, "completed": true});

      CollectionReference minigamesCollection = profileDoc.collection(
        "minigames",
      );

      await minigamesCollection.doc("minigames").set({
        "Search": [true, true, true, true],
        "Puzzle": [true, true, true, true],
        "Choose": [true, true, true, true],
        "Play": [true, true, true, true],
        "Memory": [true, true, true, true],
        "Spot": [true, true, true, true],

        "SearchStar": [0, 0, 0, 0],
        "PuzzleStar": [0, 0, 0, 0],
        "ChooseStar": [0, 0, 0, 0],
        "PlayStar": [0, 0, 0, 0],
        "MemoryStar": [0, 0, 0, 0],
        "SpotStar": [0, 0, 0, 0],
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
    await FirebaseAuth.instance.signInAnonymously();
    _user = FirebaseAuth.instance.currentUser;

    if (_user != null) {
      await initializeUserData(); // Use the same instance!
    }
  }
}
/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      });

      // Add Regions subcollection
      CollectionReference regionsCollection = profileDoc.collection("Regions");

      await regionsCollection.doc("region_north").set({
        "unlocked": true, // The first region is unlocked
        "unlocks": "region_east",
        "completed": false,
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
        "Search": [false, false, false, false],
        "Puzzle": [false, false, false, false],
        "Choose": [false, false, false, false],
        "Play": [false, false, false, false],
        "Memory": [false, false, false, false],
        "Spot": [false, false, false, false],

        "SearchStar": [0, 0, 0, 0],
        "PuzzleStar": [0, 0, 0, 0],
        "ChooseStar": [0, 0, 0, 0],
        "PlayStar": [0, 0, 0, 0],
        "MemoryStar": [0, 0, 0, 0],
        "SpotStar": [0, 0, 0, 0],
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
    await FirebaseAuth.instance.signInAnonymously();
    _user = FirebaseAuth.instance.currentUser;

    if (_user != null) {
      await initializeUserData(); // Use the same instance!
    }
  }
}
*/