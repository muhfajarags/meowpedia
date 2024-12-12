import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meowpedia/main.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isButtonEnabled = false;

  void _checkInput() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty &&
          _fullNameController.text.isNotEmpty &&
<<<<<<< HEAD
          _passwordController.text.length >=
              6; // Pastikan password minimal 6 karakter
    });
  }

  void _continue() {
    // Validasi email
    if (_emailController.text == 'admin@gmail.com') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email sudah terdaftar')),
=======
          _passwordController.text.length >= 6; // Ensure password is >= 6 chars
    });
  }

  Future<void> _signInWithGoogle() async {
    try {
      // Force user to pick an account by signing out first
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

      // Authenticate with Firebase
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to the main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google signup failed')),
      );
    }
  }

  void _continue() async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Update display name
      await userCredential.user?.updateDisplayName(_fullNameController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );

      Navigator.pop(context); // Navigate back to login screen
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Email sudah terdaftar';
          break;
        case 'invalid-email':
          errorMessage = 'Email tidak valid';
          break;
        case 'weak-password':
          errorMessage = 'Kata sandi terlalu lemah';
          break;
        default:
          errorMessage = 'Terjadi kesalahan: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 130),
=======
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100), // Adjust spacing for design
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
            const Text(
              'Register Account',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
            ),
<<<<<<< HEAD
            const SizedBox(height: 16),
            const Text(
              'Gunakan Email untuk mendaftar',
              style: TextStyle(fontSize: 14),
=======
            const SizedBox(height: 8),
            const Text(
              'Masukan Email untuk mendaftar',
              style: TextStyle(fontSize: 14, color: Colors.grey),
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
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
            const SizedBox(height: 22),
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
            const Text(
              'Full Name',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _fullNameController,
              onChanged: (value) => _checkInput(),
              decoration: InputDecoration(
                hintText: 'Masukan Nama Anda',
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
            const SizedBox(height: 22),
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
            const Text(
              'Password',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
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
=======
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
<<<<<<< HEAD
            const SizedBox(height: 8),
=======
            const SizedBox(height: 6),
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
            const Row(
              children: [
                Icon(Icons.info, size: 16),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Kata sandi harus 6 karakter atau lebih',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
<<<<<<< HEAD
            const SizedBox(height: 50),
=======
            const SizedBox(height: 25),
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isButtonEnabled ? _continue : null,
                style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                  backgroundColor: _isButtonEnabled
                      ? Color(0xFF3669C9)
                      : Colors.grey, // Warna button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16), // Sesuaikan padding
                ),
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white), // Sesuaikan warna teks
                ),
              ),
            ),
            const SizedBox(height: 40), // Tambahkan jarak di bawah button
=======
                  backgroundColor:
                      _isButtonEnabled ? const Color(0xFF3669C9) : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Text(
                    'Atau daftar dengan',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 24),
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
            const SizedBox(height: 20),
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to login
                },
                child: const Text(
<<<<<<< HEAD
                  'Have an Account? Log In',
                  style: TextStyle(fontSize: 14),
=======
                  'Sudah punya akun? Log in',
                  style: TextStyle(fontSize: 14, color: Color(0xFF3669C9)),
>>>>>>> 9849888d92ee4e1bc20acf49b9bc3eb5cab9bab2
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
