import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'signup.dart'; // Pastikan Anda mengimpor halaman signup.dart

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isPasswordVisible =
      false; // Variabel untuk mengontrol visibilitas password

  void _checkInput() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  Future<void> _login() async {
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

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email atau password salah')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Tambahkan SingleChildScrollView di sini
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 170), // Jarak 170px di atas "Welcome back"
              const Text(
                'Welcome back to Meowpedia',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              const SizedBox(height: 16),
              const Text(
                'Silahkan masukan data untuk login',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 32),
              const Text(
                'Email',
                style: TextStyle(fontSize: 14),
              ),
              TextField(
                controller: _emailController,
                onChanged: (value) => _checkInput(),
                decoration: InputDecoration(
                  hintText: 'Masukan Alamat Email Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
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
              const Text(
                'Password',
                style: TextStyle(fontSize: 14),
              ),
              TextField(
                controller: _passwordController,
                obscureText:
                    !_isPasswordVisible, // Mengatur visibilitas password
                onChanged: (value) => _checkInput(),
                decoration: InputDecoration(
                  hintText: 'Masukan Password Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
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
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible =
                            !_isPasswordVisible; // Toggle visibilitas password
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 103),
              SizedBox(
                width: double.infinity, // Button selebar text field
                height: 60,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? _login : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled
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
              Align(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: const Text(
                    'Don`t Have an Account? Register',
                    style: TextStyle(fontSize: 14),
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
