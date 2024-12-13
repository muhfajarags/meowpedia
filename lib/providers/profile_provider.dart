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

  User? get currentUser => _currentUser;

  String get fullName => _currentUser?.displayName ?? 'Anonymous User';

  String get email => _currentUser?.email ?? 'No Email';

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (!context.mounted) return;
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      print('Logout failed: $e');
    }
  }
}
