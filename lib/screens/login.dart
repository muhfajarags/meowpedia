import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'signup.dart'; // Pastikan Anda mengimpor halaman signup.dart
=======
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';
import 'signup.dart';
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;
<<<<<<< HEAD
  bool _isPasswordVisible =
      false; // Variabel untuk mengontrol visibilitas password
=======
  bool _isPasswordVisible = false;
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2

  void _checkInput() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  Future<void> _login() async {
<<<<<<< HEAD
    if (_emailController.text == 'admin@gmail.com' &&
        _passwordController.text == 'admin') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // Logout otomatis setelah 2 detik
      Future.delayed(const Duration(seconds: 2), () async {
        await prefs.setBool('isLoggedIn', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });

=======
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'Email tidak terdaftar';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Password salah';
      } else {
        errorMessage = 'Terjadi kesalahan';
      }
      ScaffoldMessenger.of(context).showSnackBar(
<<<<<<< HEAD
        const SnackBar(content: Text('Email atau password salah')),
=======
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      // Ensure the user is prompted to pick an account
      await GoogleSignIn().signOut();

      // Start Google sign-in
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Extract the email from the Google user
      final String? email = googleUser.email;

      // Check if the email is already registered in Firebase
      final List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email!);

      if (signInMethods.isEmpty) {
        // If no sign-in methods exist, the user is not registered
        await GoogleSignIn().disconnect();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Account does not exist. Please sign up first.',
            ),
          ),
        );
        return;
      }

      // Authenticate with Firebase using the Google credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to the main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-disabled':
          errorMessage = 'This account has been disabled.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Google login is not enabled.';
          break;
        case 'invalid-credential':
          errorMessage = 'Invalid Google credentials.';
          break;
        default:
          errorMessage = 'An error occurred: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google login failed.')),
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
<<<<<<< HEAD
        // Tambahkan SingleChildScrollView di sini
=======
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
<<<<<<< HEAD
              const SizedBox(height: 170), // Jarak 170px di atas "Welcome back"
=======
              const SizedBox(height: 120), // Adjusted spacing
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
              const Text(
                'Welcome back to Meowpedia',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              const SizedBox(height: 16),
              const Text(
                'Silahkan masukan data untuk login',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              const Text(
                'Email',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                onChanged: (value) => _checkInput(),
                decoration: InputDecoration(
                  hintText: 'Masukan Alamat Email Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
<<<<<<< HEAD
                    borderSide: const BorderSide(
                        color:
                            Color(0xFFE5E5E5)), // Warna border saat tidak aktif
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color:
                            Color(0xFFE5E5E5)), // Warna border saat tidak aktif
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color(0xFF3669C9)), // Warna border saat fokus
                  ),
                ),
              ),
              const SizedBox(height: 32),
=======
                  ),
                ),
              ),
              const SizedBox(height: 24),
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
              const Text(
                'Password',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
<<<<<<< HEAD
                obscureText:
                    !_isPasswordVisible, // Mengatur visibilitas password
=======
                obscureText: !_isPasswordVisible,
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
                onChanged: (value) => _checkInput(),
                decoration: InputDecoration(
                  hintText: 'Masukan Sandi Akun',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
<<<<<<< HEAD
                    borderSide: const BorderSide(
                        color:
                            Color(0xFFE5E5E5)), // Warna border saat tidak aktif
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color:
                            Color(0xFFE5E5E5)), // Warna border saat tidak aktif
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color(0xFF3669C9)), // Warna border saat fokus
                  ),
                  suffixIcon: IconButton(
                    // Menambahkan ikon untuk melihat password
=======
                  ),
                  suffixIcon: IconButton(
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
<<<<<<< HEAD
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible =
                            !_isPasswordVisible; // Toggle visibilitas password
=======
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
                      });
                    },
                  ),
                ),
              ),
<<<<<<< HEAD
              const SizedBox(height: 103),
=======
              const SizedBox(height: 45),
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? _login : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled
<<<<<<< HEAD
                        ? Color(0xFF3669C9)
                        : Colors.grey, // Warna button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Corner radius yang sama dengan input field
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 40),
=======
                        ? const Color(0xFF3669C9)
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 30),
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Text(
                      'Atau login dengan',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton.icon(
                        icon: Image.asset(
                          'assets/google.png',
                          width: 24,
                          height: 24,
                        ),
                        label: const Text(
                          'Google',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: _signInWithGoogle,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
<<<<<<< HEAD
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: const Text(
                    'Don`t Have an Account? Register',
                    style: TextStyle(fontSize: 14),
=======
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(fontSize: 14, color: Color(0xFF3669C9)),
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
