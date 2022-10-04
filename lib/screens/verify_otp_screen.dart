import 'dart:developer';

import 'package:demo_project/services/call_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'home_screen.dart';

class VerifyOTP extends StatefulWidget {
  final String verificationId;
  const VerifyOTP({super.key, required this.verificationId});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

// https://lifetronsphoneapi.azurewebsites.net/api/account/auth
class _VerifyOTPState extends State<VerifyOTP> {
  TextEditingController verifyController = TextEditingController();

  void verifyOTP() async {
    String opt = verifyController.text.trim();
    if (opt.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Enter OTP.'),
        ),
      );
    } else if (opt.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Enter 6 digit OTP.'),
        ),
      );
    } else {
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
                Text("Verifying..."),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        },
      );

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: opt);

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // ignore: unnecessary_null_comparison
        if (userCredential != null) {
          String token = await FirebaseAuth.instance.currentUser!.getIdToken();

          User? response = await RemoteServices().apiCalling(
            endPoint: "api/account/auth",
            method: "post",
            body: {
              "token": token,
              "provider": "firebase_phone_auth",
            },
          ) as User;
          log(response.toString());
        }
      } on FirebaseAuthException catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify OTP"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 6,
              controller: verifyController,
              decoration: const InputDecoration(
                counterText: "",
                labelText: "6 Digit OTP",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  verifyOTP();
                },
                child: const Text("Verify"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
