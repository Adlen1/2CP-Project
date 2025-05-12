import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ============================================================================
// firestore_service.dart
// ============================================================================
//
//
// this class contains methods to interact with
// the data base (so basically a utils class)
// ============================================================================

class FirestoreService {
  // Recursively converts all nested Map<dynamic, dynamic> to Map<String, dynamic>
  Map<String, dynamic> _convertNestedMap(dynamic item) {
    if (item is Map) {
      return Map<String, dynamic>.fromEntries(
        item.entries.map(
          (entry) => MapEntry<String, dynamic>(
            entry.key.toString(),
            entry.value is Map || entry.value is List
                ? _processValue(entry.value)
                : entry.value,
          ),
        ),
      );
    }
    return <String, dynamic>{};
  }

  // Process values to handle both maps and lists recursively
  dynamic _processValue(dynamic value) {
    if (value is Map) {
      return _convertNestedMap(value);
    } else if (value is List) {
      return value
          .map((item) => item is Map ? _convertNestedMap(item) : item)
          .toList();
    }
    return value;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Default data templates for efficient initialization
  static const Map<String, dynamic> _defaultSettings = {
    "masterV": true,
    "music": true,
    "narrator": true,
  };

  static const Map<String, dynamic> _defaultMinigames = {
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
  };

  static const Map<String, dynamic> _defaultAdventure = {
    "alreadyStarted": false,
    "checkPoint": 0,
    "completed": false,
  };

  static Map<String, dynamic> _createDefaultRegion({
    required bool unlocked,
    required String unlocks,
  }) {
    return {
      "unlocked": unlocked,
      "unlocks": unlocks,
      "completed": false,
      "landmarks": [false, false, false, false, false, false],
      "adventures": {
        "adventure_1": Map<String, dynamic>.from(_defaultAdventure),
        "adventure_2": Map<String, dynamic>.from(_defaultAdventure),
      },
    };
  }

  static Map<String, dynamic> _getDefaultRegions() {
    return {
      "region_north": _createDefaultRegion(
        unlocked: true,
        unlocks: "region_east",
      ),
      "region_east": _createDefaultRegion(
        unlocked: false,
        unlocks: "region_west",
      ),
      "region_west": _createDefaultRegion(
        unlocked: false,
        unlocks: "region_south",
      ),
      "region_south": _createDefaultRegion(unlocked: false, unlocks: ""),
    };
  }

  // Fetch all data for the current user
  Future<Map<String, dynamic>> fetchAllData() async {
    final String userId = _auth.currentUser!.uid;
    Map<String, dynamic> userData = {};

    try {
      // Fetch the user document
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(userId).get();
      userData['user'] =
          userDoc.exists ? _convertNestedMap(userDoc.data()) : {};
      userData['Profiles'] = {};

      // Fetch all profiles for the user
      QuerySnapshot profilesSnapshot =
          await _firestore
              .collection('Users')
              .doc(userId)
              .collection('Profiles')
              .get();

      // Create batch requests for parallel fetching
      List<Future> fetchOperations = [];

      for (var profileDoc in profilesSnapshot.docs) {
        String profileId = profileDoc.id;
        userData['Profiles'][profileId] = _convertNestedMap(profileDoc.data());

        // Add parallel fetch operations
        fetchOperations.add(
          _fetchProfileData(userId, profileId).then((data) {
            userData['Profiles'][profileId]['Regions'] = data['Regions'] ?? {};
            userData['Profiles'][profileId]['Settings'] =
                data['Settings'] ?? {};
            userData['Profiles'][profileId]['minigames'] =
                data['minigames'] ?? {};
          }),
        );
      }

      // Wait for all fetch operations to complete
      await Future.wait(fetchOperations);

      // Apply default values to profiles
      _applyDefaultsToProfiles(Map<String, dynamic>.from(userData['Profiles']));
    } catch (e) {
      print('\x1B[33mError fetching data: $e\x1B[0m');
    }

    return userData;
  }

  // Fetch all profile data in parallel
  Future<Map<String, dynamic>> _fetchProfileData(
    String userId,
    String profileId,
  ) async {
    Map<String, dynamic> profileData = {};

    // Execute all fetches in parallel
    final results = await Future.wait([
      _fetchRegions(userId, profileId),
      _fetchSettings(userId, profileId),
      _fetchMinigames(userId, profileId),
    ]);

    profileData['Regions'] = results[0];
    profileData['Settings'] = results[1];
    profileData['minigames'] = results[2];

    return profileData;
  }

  // Optimized regions fetching with batch operations
  Future<Map<String, dynamic>> _fetchRegions(
    String userId,
    String profileId,
  ) async {
    Map<String, dynamic> regionsData = {};

    try {
      final regionsCol = _firestore
          .collection('Users')
          .doc(userId)
          .collection('Profiles')
          .doc(profileId)
          .collection('Regions');

      QuerySnapshot regionsSnapshot = await regionsCol.get();

      // Prepare parallel fetch operations for adventures
      List<Future> adventuresFetches = [];

      for (var regionDoc in regionsSnapshot.docs) {
        String regionId = regionDoc.id;
        regionsData[regionId] = regionDoc.data();
        regionsData[regionId]['adventures'] = {};

        // Add parallel fetch operations for adventures
        adventuresFetches.add(
          regionsCol.doc(regionId).collection('adventures').get().then((
            advSnapshot,
          ) {
            for (var advDoc in advSnapshot.docs) {
              regionsData[regionId]['adventures'][advDoc.id] = advDoc.data();
            }
          }),
        );
      }

      // Wait for all adventure fetches to complete
      await Future.wait(adventuresFetches);
    } catch (e) {
      print('\x1B[33mError fetching regions: $e\x1B[0m');
    }

    return regionsData;
  }

  // Fetch settings for a specific profile
  Future<Map<String, dynamic>> _fetchSettings(
    String userId,
    String profileId,
  ) async {
    try {
      DocumentSnapshot settingsDoc =
          await _firestore
              .collection('Users')
              .doc(userId)
              .collection('Profiles')
              .doc(profileId)
              .collection('Settings')
              .doc('settings')
              .get();

      return settingsDoc.exists
          ? settingsDoc.data() as Map<String, dynamic>
          : {};
    } catch (e) {
      print('\x1B[33mError fetching settings: $e\x1B[0m');
      return {};
    }
  }

  // Fetch minigames for a specific profile
  Future<Map<String, dynamic>> _fetchMinigames(
    String userId,
    String profileId,
  ) async {
    try {
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
    } catch (e) {
      print('\x1B[33mError fetching minigames: $e\x1B[0m');
      return {};
    }
  }

  // Helper method to apply default values to profiles
  void _applyDefaultsToProfiles(Map<String, dynamic> profiles) {
    for (int j = 1; j < 5; j++) {
      final profileId = "Profile_$j";
      final profile = profiles[profileId] ??= {};

      //Set default profile properties if null
      profile["firstName"] ??= "";
      profile["lastName"] ??= "";
      profile["age"] ??= 0;
      profile["avatar"] ??= "";
      profile["created"] ??= false;
      profile["lastPlayedRegion"] ??= 0;
      profile["lastPlayedAdv"] ??= 0;

      //   Set default nested collections if null
      profile["Settings"] ??= Map<String, dynamic>.from(_defaultSettings);
      profile["minigames"] ??= Map<String, dynamic>.from(_defaultMinigames);
      profile["Regions"] ??= _getDefaultRegions();
    }
  }

  Future<void> updateAllData(Map<String, dynamic> userData) async {
    final String userId = _auth.currentUser!.uid;

    try {
      WriteBatch batch = _firestore.batch();

      // Step 1: Upload user document
      if (userData.containsKey('user')) {
        // Use merge:true to avoid overwriting existing user data
        final userRef = _firestore.collection('Users').doc(userId);
        batch.set(userRef, Map<String, dynamic>.from({}));
      }

      await batch.commit();

      // Step 2: Upload profiles and nested data
      if (userData.containsKey('Profiles')) {
        final profiles = _convertNestedMap(userData['Profiles']);

        List<Future> uploadTasks = [];
        for (var profileId in profiles.keys) {
          uploadTasks.add(
            _uploadProfile(userId, profileId, profiles[profileId]),
          );
        }

        await Future.wait(uploadTasks);
      }
    } catch (e) {
      print('\x1B[31mError uploading data: $e\x1B[0m');
      throw Exception('Failed to upload data: $e');
    }
  }

  Future<void> _uploadProfile(
    String userId,
    String profileId,
    Map<String, dynamic> profileData,
  ) async {
    try {
      final profileRef = _firestore
          .collection('Users')
          .doc(userId)
          .collection('Profiles')
          .doc(profileId);

      // Step 1: Upload profile document
      await profileRef.set({
        'firstName': profileData['firstName'] ?? "",
        'lastName': profileData['lastName'] ?? "",
        'age': profileData['age'] ?? 0,
        'avatar': profileData['avatar'] ?? "",
        'created': profileData['created'] ?? false,
        'lastPlayedRegion': profileData['lastPlayedRegion'] ?? 0,
        'lastPlayedAdv': profileData['lastPlayedAdv'] ?? 0,
      });

      List<Future> uploadTasks = [];

      // Step 2: Upload Settings
      if (profileData.containsKey('Settings')) {
        final settings = _convertNestedMap(profileData['Settings']);
        uploadTasks.add(
          profileRef.collection('Settings').doc('settings').set({
            'music': settings['music'] ?? true,
            'narrator': settings['narrator'] ?? true,
            'masterV': settings['masterV'] ?? true,
          }),
        );
      }

      // Step 3: Upload Minigames
      if (profileData.containsKey('minigames')) {
        final minigames = _convertNestedMap(profileData['minigames']);
        uploadTasks.add(
          profileRef.collection('minigames').doc('minigames').set(minigames),
        );
      }

      // Step 4: Upload Regions and Adventures
      if (profileData.containsKey('Regions')) {
        final regions = _convertNestedMap(profileData['Regions']);

        for (var regionId in regions.keys) {
          final regionData = _convertNestedMap(regions[regionId]);
          final regionRef = profileRef.collection('Regions').doc(regionId);

          // Region document
          uploadTasks.add(
            regionRef.set({
              'unlocks': regionData['unlocks'] ?? "",
              'completed': regionData['completed'] ?? false,
              'unlocked': regionData['unlocked'] ?? false,
              'landmarks':
                  regionData['landmarks'] is List
                      ? regionData['landmarks']
                      : [false, false, false, false, false, false],
            }),
          );

          // Adventures inside region
          if (regionData.containsKey('adventures')) {
            final adventures = _convertNestedMap(regionData['adventures']);
            for (var adventureId in adventures.keys) {
              final adventureData = _convertNestedMap(adventures[adventureId]);
              uploadTasks.add(
                regionRef.collection('adventures').doc(adventureId).set({
                  'alreadyStarted': adventureData['alreadyStarted'] ?? false,
                  'checkPoint': adventureData['checkPoint'] ?? 0,
                  'completed': adventureData['completed'] ?? false,
                }),
              );
            }
          }
        }
      }

      await Future.wait(uploadTasks);
    } catch (e) {
      print('\x1B[31mError uploading profile $profileId: $e\x1B[0m');
      throw Exception('Failed to upload profile $profileId: $e');
    }
  }
}
