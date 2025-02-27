import 'package:flutter/material.dart';
import '../../core/utils/auth_utils.dart';
import '../../main.dart';
import '../widgets/text_field.dart';
import '../widgets/submit_button.dart';
import '../widgets/google_sso_button.dart';

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
          _passwordController.text.length >= 6;
    });
  }

  Future<void> _registerWithEmailPassword() async {
    try {
      final user = await registerWithEmailPassword(
        _emailController.text,
        _passwordController.text,
        _fullNameController.text,
      );
      if (!mounted) return;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    } catch (e) {
      if (!mounted) return;
      print('Registration failed: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Failed'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _registerWithGoogle() async {
    try {
      final user = await registerWithGoogle();
      if (!mounted) return;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    } catch (e) {
      if (!mounted) return;
      print('Google Registration failed: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Google Registration Failed'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 90),
            const Text(
              'Register Account',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              'Use your email to sign up',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 32),
            CustomTextField(
              label: 'Email',
              hintText: 'Enter your email',
              controller: _emailController,
              onChanged: (value) => _checkInput(),
            ),
            const SizedBox(height: 26),
            CustomTextField(
              label: 'Full Name',
              hintText: 'Enter your full name',
              controller: _fullNameController,
              onChanged: (value) => _checkInput(),
            ),
            const SizedBox(height: 26),
            CustomTextField(
              label: 'Password',
              hintText: 'Enter your password',
              controller: _passwordController,
              isPassword: true,
              isPasswordVisible: _isPasswordVisible,
              onPasswordToggle: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              onChanged: (value) => _checkInput(),
            ),
            const SizedBox(height: 32),
            SubmitButton(
              text: 'Register',
              onPressed: _isButtonEnabled ? _registerWithEmailPassword : null,
              isEnabled: _isButtonEnabled,
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Text(
                    'Or register with',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 30),
                  GoogleSSOButton(
                    onPressed: _registerWithGoogle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Already have an account? Log in',
                style: TextStyle(
                    color: Color(0xFF3669C9), // Mengubah warna teks
                  ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
