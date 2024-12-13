import 'package:flutter/material.dart';

class GoogleSSOButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSSOButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
