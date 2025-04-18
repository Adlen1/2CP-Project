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
      print('\x1B[33mError fetching data: $e\x1B[0m');
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
              .doc('adventure_1')
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
              .doc('adventure_2')
              .get();

      regionsData[regionId]['adventures'] = {
        'adventure_1': adventer1Doc.exists ? adventer1Doc.data() : {},
        'adventure_2': adventer2Doc.exists ? adventer2Doc.data() : {},
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

  Future<void> updateAllData(Map<String, dynamic> userData) async {
    final String userId = _auth.currentUser!.uid;

    try {
      // Step 1: Upload user document
      if (userData.containsKey('user')) {
        await _firestore.collection('Users').doc(userId).set({
          //'currentProfile': userDocData['currentProfile'],
        });
      }

      // Step 2: Upload profiles and their nested collections
      if (userData.containsKey('Profiles')) {
        final profiles = _convertToMapStringDynamic(userData['Profiles']);
        for (var profileId in profiles.keys) {
          final profileData = _convertToMapStringDynamic(profiles[profileId]);
          await _uploadProfile(userId, profileId, profileData);
        }
      }
    } catch (e) {
      print('\x1B[33mError uploading data: $e\x1B[0m'); // Yellow text
      throw Exception('Failed to upload data: $e');
    }
  }

  // Helper method to upload a profile and its nested collections
  Future<void> _uploadProfile(
    String userId,
    String profileId,
    Map<String, dynamic> profileData,
  ) async {
    try {
      // Step 1: Upload profile document
      final profileDoc = _firestore
          .collection('Users')
          .doc(userId)
          .collection('Profiles')
          .doc(profileId);

      await profileDoc.set({
        'firstName': profileData['firstName'],
        'lastName': profileData['lastName'],
        'age': profileData['age'],
        'avatar': profileData['avatar'],
        'created': profileData['created'],
      });

      // Step 2: Upload Settings (single document)
      if (profileData.containsKey('Settings')) {
        final settings = _convertToMapStringDynamic(profileData['Settings']);
        await profileDoc.collection('Settings').doc('settings').set({
          'music': settings['music'],
          'narrator': settings['narrator'],
          'masterV': settings['masterV'],
        });
      }

      // Step 3: Upload minigames (single document)
      if (profileData.containsKey('minigames')) {
        final minigames = _convertToMapStringDynamic(profileData['minigames']);
        await profileDoc.collection('minigames').doc('minigames').set({
          //----------------------------------------
          'Find': minigames['Find'],
          'Puzzle': minigames['Puzzle'],
          'Match': minigames['Match'],
          'Choose': minigames['Choose'],
          'Memory': minigames['Memory'],
          'Spot': minigames['Spot'],

          'FindStar': minigames['FindStar'],
          'PuzzleStar': minigames['PuzzleStar'],
          'MatchStar': minigames['MatchStar'],
          'ChooseStar': minigames['ChooseStar'],
          'MemoryStar': minigames['MemoryStar'],
          'SpotStar': minigames['SpotStar'],
          //----------------------------------------
        });
      }

      // Step 4: Upload Regions (4 documents, each with adventures subcollection)
      if (profileData.containsKey('Regions')) {
        final regions = _convertToMapStringDynamic(profileData['Regions']);
        for (var regionId in regions.keys) {
          final regionData = _convertToMapStringDynamic(regions[regionId]);

          // Upload region document
          final regionDoc = profileDoc.collection('Regions').doc(regionId);
          await regionDoc.set({
            'unlocks': regionData['unlocks'],
            'completed': regionData['completed'],
            'unlocked': regionData['unlocked'],
            'landmarks': regionData['landmarks'],
          });

          // Upload adventures subcollection (2 documents)
          if (regionData.containsKey('adventures')) {
            final adventures = _convertToMapStringDynamic(
              regionData['adventures'],
            );
            for (var adventureId in adventures.keys) {
              final adventureData = _convertToMapStringDynamic(
                adventures[adventureId],
              );
              await regionDoc.collection('adventures').doc(adventureId).set({
                "alreadyStarted": adventureData['alreadyStarted'],
                "checkPoint": adventureData['checkPoint'],
                "completed": adventureData['completed'],
              });
            }
          }
        }
      }
    } catch (e) {
      print('\x1B[33mError uploading profile $profileId: $e\x1B[0m',); // Yellow text
      throw Exception('Failed to upload profile $profileId: $e');
    }
  }

  // Helper method to convert Map<dynamic, dynamic> to Map<String, dynamic>
  Map<String, dynamic> _convertToMapStringDynamic(dynamic data) {
    if (data is Map) {
      return data.cast<String, dynamic>();
    }
    throw Exception('Invalid data type: expected Map');
  }
}
