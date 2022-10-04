import 'package:demo_project/screens/verify_otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final countryPicker = const FlCountryCodePicker();
  CountryCode countryCode =
      const CountryCode(name: "India", code: "In", dialCode: "+91");

  TextEditingController phoneController = TextEditingController();

  void sendOTP() async {
    debugPrint(countryCode.dialCode + phoneController.text);

    String phoneNumber = phoneController.text;
    if (phoneNumber == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Enter Phone Number"),
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
                Text("Loading..."),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        },
      );
      FirebaseAuth.instance
          .verifyPhoneNumber(
        phoneNumber: countryCode.dialCode + phoneController.text,
        verificationCompleted: (phoneAuthCredential) {
          Navigator.pop(context);
        },
        verificationFailed: (error) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.code.toString()),
            ),
          );
        },
        codeSent: (verificationId, resendToken) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyOTP(
                verificationId: verificationId,
              ),
            ),
          );
        },
        timeout: const Duration(seconds: 30),
        codeAutoRetrievalTimeout: (verificationId) {
          Navigator.pop(context);
        },
      )
          .catchError(
        (_) {
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
              color: Color.fromARGB(255, 224, 107, 24),
            ),
          ),
          Expanded(child: Container()),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                TextField(
                  maxLength: 10,
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterText: "",
                    border: const OutlineInputBorder(),
                    prefixIcon: Container(
                      margin: const EdgeInsets.only(left: 20, right: 15),
                      child: InkWell(
                        onTap: () async {
                          final code =
                              await countryPicker.showPicker(context: context);
                          setState(
                            () {
                              if (code != null) {
                                countryCode = code;
                              }
                            },
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: countryCode.flagImage,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(countryCode.dialCode),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      sendOTP();
                    },
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
