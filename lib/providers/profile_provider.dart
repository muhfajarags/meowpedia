import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileProvider with ChangeNotifier {
  User? _currentUser;

  ProfileProvider() {
    _fetchCurrentUser();
  }

  // Fetch the current user from FirebaseAuth
  Future<void> _fetchCurrentUser() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  // Getter for the current user
  User? get currentUser => _currentUser;

  // Getter for the user's full name
  String get fullName => _currentUser?.displayName ?? 'Anonymous User';

  // Getter for the user's email
  String get email => _currentUser?.email ?? 'No Email';

  // Logout the user
  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      print('Logout failed: $e');
    }
  }
}