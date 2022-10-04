import 'package:demo_project/screens/login_with_email.dart';
import 'package:demo_project/screens/login_with_phone.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneAndEmail extends StatelessWidget {
  const LoginWithPhoneAndEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginWithPhone(),
                ),
              );
            },
            label: const Text("Login With Phone"),
            icon: const Icon(Icons.phone),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginWithEmail(),
                ),
              );
            },
            label: const Text("Login With Email"),
            icon: const Icon(Icons.email),
          ),
        ],
      ),
    );
  }
}
