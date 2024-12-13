import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

/// Writes data to the specified [path] in Firebase Realtime Database.
Future<void> writeData(String path, dynamic data) async {
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child(path);
  await ref.set(data);
}

/// Reads data from the specified [path] in Firebase Realtime Database.
Future<dynamic> readData(String path) async {
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child(path);
  final DataSnapshot snapshot = await ref.get();
  if (!snapshot.exists) {
    return null;
  }

  final value = snapshot.value;
  if (value is Map) {
    // Convert Map to List
    return value.values.toList();
  }

  return value; // Return List or other types
}

/// Monitors authentication state changes and executes [onChange] when a change occurs.
void listenAuthStateChanges(Function(User?) onChange) {
  FirebaseAuth.instance.authStateChanges().listen(onChange);
}

