// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Fungsi untuk login menggunakan email dan password
Future<User?> loginWithEmailPassword(String email, String password) async {
  try {
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  } catch (e) {
    print('Error in loginWithEmailPassword: $e');
    throw Exception('Login failed: $e');
  }
}

/// Fungsi untuk login menggunakan Google
Future<User?> loginWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null; // Login dibatalkan oleh pengguna

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.user;
  } catch (e) {
    print('Error in loginWithGoogle: $e');
    throw Exception('Google Sign-In failed: $e');
  }
}

/// Fungsi untuk mendaftar menggunakan email dan password
Future<User?> registerWithEmailPassword(
    String email, String password, String fullName) async {
  try {
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    await userCredential.user?.updateDisplayName(fullName);
    return userCredential.user;
  } catch (e) {
    print('Error in registerWithEmailPassword: $e');
    throw Exception('Registration failed: $e');
  }
}

/// Fungsi untuk mendaftar menggunakan Google
Future<User?> registerWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null; // Registrasi dibatalkan oleh pengguna

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.user;
  } catch (e) {
    print('Error in registerWithGoogle: $e');
    throw Exception('Google Registration failed: $e');
  }
}

/// Fungsi untuk logout
Future<void> logout() async {
  try {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  } catch (e) {
    print('Error in logout: $e');
    throw Exception('Logout failed: $e');
  }
}

/// Fungsi untuk mendapatkan pengguna saat ini
User? getCurrentUser() {
  return FirebaseAuth.instance.currentUser;
}
