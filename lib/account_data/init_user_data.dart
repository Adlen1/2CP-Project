import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  Future<void> initializeUserData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        "unlocks": "region_",
        "completed": false,
      });
      await regionsCollection.doc("region_south").set({
        "unlocked": false, // This region is locked initially
        "unlocks": "region_",
        "completed": false,
      });

      await regionsCollection.doc("region_west").set({
        "unlocked": false, // This region is locked initially
        "unlocks": "region_",
        "completed": false,
      });

      await regionsCollection.doc("region_east").set({
        "unlocked": false, // This region is locked initially
        "unlocks": "region_",
        "completed": false,
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
      SignIn signIN = SignIn();
      await signIN.initializeUserData(); // Initialize Firestore after sign-in
    }
  }
}
