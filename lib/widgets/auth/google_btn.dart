import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: const Icon(
          Ionicons.logo_google,
          color: Colors.white,
        ),
        label: const Text(
          "Sign in with Google",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {},
      ),
    );
  }
}
