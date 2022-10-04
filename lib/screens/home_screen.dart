import 'package:demo_project/screens/login_phone_email.dart';
import 'package:demo_project/screens/login_with_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void signOut() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                height: 15,
              ),
              Text("Signout..."),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
    );
    FirebaseAuth.instance.signOut().then(
      (value) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginWithPhoneAndEmail(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              child: const Text("Log Out"),
              onPressed: () {
                signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
