import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
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
          _passwordController.text.length >= 6; // Pastikan password minimal 6 karakter
    });
  }

  void _continue() {
    // Validasi email
    if (_emailController.text == 'admin@gmail.com') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email sudah terdaftar')),
      );
    } else {
      // Navigasi ke halaman login
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Tambahkan SingleChildScrollView di sini
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 130),
            Text(
              'Register Account',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
            SizedBox(height: 16),
            Text(
              'Gunakan Email untuk mendaftar',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 32),
            Text(
              'Email',
              style: TextStyle(fontSize: 14),
            ),
            TextField(
              controller: _emailController,
              onChanged: (value) => _checkInput(),
              decoration: InputDecoration(
                hintText: 'Masukkan Alamat Email Anda',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFE5E5E5)), // Warna border saat tidak aktif
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFE5E5E5)), // Warna border saat tidak aktif
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF3669C9)), // Warna border saat fokus
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Full Name',
              style: TextStyle(fontSize: 14),
            ),
            TextField(
              controller: _fullNameController,
              onChanged: (value) => _checkInput(),
              decoration: InputDecoration(
                hintText: 'Muhammad Fajar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFE5E5E5)), // Warna border saat tidak aktif
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFE5E5E5)), // Warna border saat tidak aktif
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF3669C9)), // Warna border saat fokus
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Password',
              style: TextStyle(fontSize: 14),
            ),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              onChanged: (value) => _checkInput(),
              decoration: InputDecoration(
                hintText: 'Masukkan Kata Sandi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFE5E5E5)), // Warna border saat tidak aktif
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFE5E5E5)), // Warna border saat tidak aktif
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF3669C9)), // Warna border saat fokus
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility
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
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.info, size: 16),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Kata sandi harus 6 karakter atau lebih',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isButtonEnabled ? _continue : null,
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20, color: Colors.white), // Sesuaikan warna teks
                ),
                style: ElevatedButton.styleFrom(
                  primary: _isButtonEnabled ? Color(0xFF3669C9) : Colors.grey, // Warna button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16), // Sesuaikan padding
                ),
              ),
            ),
            SizedBox(height: 40), // Tambahkan jarak di bawah button
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context); // Navigasi kembali ke login
                },
                child: Text(
                  'Have an Account? Log In',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}