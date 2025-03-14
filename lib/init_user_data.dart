import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> initializeUserData() async {
  FirebaseAuth auth = FirebaseAuth.instance;
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

    CollectionReference settingsCollection = profileDoc.collection("Settings");

    await settingsCollection.doc("settings").set({
      "masterV": true,
      "music": true,
      "narrator": true,
    });
  }
}
