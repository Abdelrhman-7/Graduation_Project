import 'package:flutter/material.dart';

class AuthHeaderLogo extends StatelessWidget {
  final String title;

  const AuthHeaderLogo({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/splach_screen.png',
          height: 150,
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
