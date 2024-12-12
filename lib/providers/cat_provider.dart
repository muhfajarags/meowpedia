import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CatProvider with ChangeNotifier {
  List<Map<String, dynamic>> lovedCats = [];
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child("favourites");

  Future<void> fetchLovedCats() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final snapshot = await _databaseReference.child(user.uid).get();
      if (snapshot.exists) {
        final data = snapshot.value as List<dynamic>;
        lovedCats = data
            .map((e) => Map<String, dynamic>.from(e as Map<Object?, Object?>))
            .toList();
      } else {
        lovedCats = [];
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching loved cats: $e');
    }
  }


  Future<void> addLovedCat(Map<String, dynamic> cat) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      lovedCats.add(cat);
      await _databaseReference.child(user.uid).set(lovedCats);
      notifyListeners();
    } catch (e) {
      print('Error adding loved cat: $e');
    }
  }

  Future<void> removeLovedCat(Map<String, dynamic> cat) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      lovedCats.removeWhere((item) => item['no'] == cat['no']);
      await _databaseReference.child(user.uid).set(lovedCats);
      notifyListeners();
    } catch (e) {
      print('Error removing loved cat: $e');
    }
  }

  bool isLoved(String catNo) {
    return lovedCats.any((cat) => cat['no'] == catNo);
  }
}