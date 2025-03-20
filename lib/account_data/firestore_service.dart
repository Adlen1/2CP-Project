import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fetch all data for the current user
  Future<Map<String, dynamic>> fetchAllData() async {
    final String userId = _auth.currentUser!.uid;
    Map<String, dynamic> userData = {};

    try {
      // Fetch the user document
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        userData['user'] = userDoc.data();

        // Fetch all profiles for the user
        QuerySnapshot profilesSnapshot =
            await _firestore
                .collection('Users')
                .doc(userId)
                .collection('Profiles')
                .get();
        userData['Profiles'] = {};

        for (var profileDoc in profilesSnapshot.docs) {
          String profileId = profileDoc.id;
          userData['Profiles'][profileId] = profileDoc.data();

          // Fetch regions, settings, and minigames for each profile
          userData['Profiles'][profileId]['Regions'] = await _fetchRegions(
            userId,
            profileId,
          );
          userData['Profiles'][profileId]['Settings'] = await _fetchSettings(
            userId,
            profileId,
          );
          userData['Profiles'][profileId]['minigames'] = await _fetchMinigames(
            userId,
            profileId,
          );
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    return userData;
  }

  // Fetch regions and their adventures for a specific profile
  Future<Map<String, dynamic>> _fetchRegions(
    String userId,
    String profileId,
  ) async {
    Map<String, dynamic> regionsData = {};

    QuerySnapshot regionsSnapshot =
        await _firestore
            .collection('Users')
            .doc(userId)
            .collection('Profiles')
            .doc(profileId)
            .collection('Regions')
            .get();

    for (var regionDoc in regionsSnapshot.docs) {
      String regionId = regionDoc.id;
      regionsData[regionId] = regionDoc.data();

      // Fetch adventures for each region (adventer_1 and adventer_2)
      DocumentSnapshot adventer1Doc =
          await _firestore
              .collection('Users')
              .doc(userId)
              .collection('Profiles')
              .doc(profileId)
              .collection('Regions')
              .doc(regionId)
              .collection('adventures')
              .doc('adventer_1')
              .get();

      DocumentSnapshot adventer2Doc =
          await _firestore
              .collection('Users')
              .doc(userId)
              .collection('Profiles')
              .doc(profileId)
              .collection('Regions')
              .doc(regionId)
              .collection('adventures')
              .doc('adventer_2')
              .get();

      regionsData[regionId]['adventures'] = {
        'adventer_1': adventer1Doc.exists ? adventer1Doc.data() : {},
        'adventer_2': adventer2Doc.exists ? adventer2Doc.data() : {},
      };
    }

    return regionsData;
  }

  // Fetch settings for a specific profile
  Future<Map<String, dynamic>> _fetchSettings(
    String userId,
    String profileId,
  ) async {
    DocumentSnapshot settingsDoc =
        await _firestore
            .collection('Users')
            .doc(userId)
            .collection('Profiles')
            .doc(profileId)
            .collection('Settings')
            .doc('settings')
            .get();

    return settingsDoc.exists ? settingsDoc.data() as Map<String, dynamic> : {};
  }

  // Fetch minigames for a specific profile
  Future<Map<String, dynamic>> _fetchMinigames(
    String userId,
    String profileId,
  ) async {
    DocumentSnapshot minigamesDoc =
        await _firestore
            .collection('Users')
            .doc(userId)
            .collection('Profiles')
            .doc(profileId)
            .collection('minigames')
            .doc('minigames')
            .get();

    return minigamesDoc.exists
        ? minigamesDoc.data() as Map<String, dynamic>
        : {};
  }

  // Update all data for the current user
  Future<void> updateAllData(Map<String, dynamic> userData) async {
    final String userId = _auth.currentUser!.uid;

    try {
      // Update user document
      if (userData.containsKey('user')) {
        await _firestore
            .collection('Users')
            .doc(userId)
            .set(userData['user'], SetOptions(merge: true));
      }

      // Update profiles, regions, settings, and minigames
      if (userData.containsKey('Profiles')) {
        for (var profileId in userData['Profiles'].keys) {
          await _firestore
              .collection('Users')
              .doc(userId)
              .collection('Profiles')
              .doc(profileId)
              .set(userData['Profiles'][profileId], SetOptions(merge: true));

          // Update regions and adventures
          if (userData['Profiles'][profileId].containsKey('Regions')) {
            for (var regionId
                in userData['Profiles'][profileId]['Regions'].keys) {
              await _firestore
                  .collection('Users')
                  .doc(userId)
                  .collection('Profiles')
                  .doc(profileId)
                  .collection('Regions')
                  .doc(regionId)
                  .set(
                    userData['Profiles'][profileId]['Regions'][regionId],
                    SetOptions(merge: true),
                  );

              // Update adventures (adventer_1 and adventer_2)
              if (userData['Profiles'][profileId]['Regions'][regionId]
                  .containsKey('adventures')) {
                await _firestore
                    .collection('Users')
                    .doc(userId)
                    .collection('Profiles')
                    .doc(profileId)
                    .collection('Regions')
                    .doc(regionId)
                    .collection('adventures')
                    .doc('adventer_1')
                    .set(
                      userData['Profiles'][profileId]['Regions'][regionId]['adventures']['adventer_1'],
                      SetOptions(merge: true),
                    );

                await _firestore
                    .collection('Users')
                    .doc(userId)
                    .collection('Profiles')
                    .doc(profileId)
                    .collection('regions')
                    .doc(regionId)
                    .collection('adventures')
                    .doc('adventer_2')
                    .set(
                      userData['Profiles'][profileId]['regions'][regionId]['adventures']['adventer_2'],
                      SetOptions(merge: true),
                    );
              }
            }
          }

          // Update settings
          if (userData['Profiles'][profileId].containsKey('Settings')) {
            await _firestore
                .collection('Users')
                .doc(userId)
                .collection('Profiles')
                .doc(profileId)
                .collection('Settings')
                .doc('settings')
                .set(
                  userData['Profiles'][profileId]['Settings'],
                  SetOptions(merge: true),
                );
          }

          // Update minigames
          if (userData['Profiles'][profileId].containsKey('minigames')) {
            await _firestore
                .collection('Users')
                .doc(userId)
                .collection('Profiles')
                .doc(profileId)
                .collection('minigames')
                .doc('minigames')
                .set(
                  userData['Profiles'][profileId]['minigames'],
                  SetOptions(merge: true),
                );
          }
        }
      }
    } catch (e) {
      print('Error updating data: $e');
    }
  }
}
