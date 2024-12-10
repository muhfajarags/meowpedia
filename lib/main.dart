import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meowpedia/firebase_options.dart';
import 'screens/Home.dart'; // Import the Home screen
import 'screens/Favourite.dart'; // Import the Favourite screen
import 'screens/Profile.dart'; // Import the Profile screen
import 'screens/login.dart'; // Import the Login screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meowpedia',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return snapshot.data == true
                ? const MainScreen()
                : const LoginScreen();
          }
        },
      ),
    );
  }

  Future<bool> checkLoginStatus() async {
    final User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Track the selected index for bottom navigation

  // List of screens to display without 'const'
  final List<Widget> _screens = [
    Home(), // Home screen
    const Favourite(), // Favourite screen
    const Profile(), // Profile screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Current selected index
        onTap: _onItemTapped, // Handle tap on bottom navigation items
      ),
    );
  }
}
