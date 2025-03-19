import 'package:flutter/material.dart';
import 'firestore_service.dart';

class DataProvider with ChangeNotifier {
  Map<String, dynamic> _userData = {};
  final FirestoreService _firestoreService = FirestoreService();

  // Getter for user data
  Map<String, dynamic> get userData => _userData;

  // Fetch all data for the current user
  Future<void> fetchData() async {
    _userData = await _firestoreService.fetchAllData();
    notifyListeners(); // Notify listeners to rebuild dependent widgets
  }

  // Update all data for the current user
  Future<void> updateData() async {
    await _firestoreService.updateAllData(_userData);
  }

  // Update local data (e.g., when modifying data in the UI)
  void updateLocalData(Map<String, dynamic> newData) {
    _userData = newData;
    notifyListeners(); // Notify listeners to rebuild dependent widgets
  }
}
