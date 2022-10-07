import 'dart:convert';
import 'dart:developer';

import 'package:demo_project/model/send_token_model.dart';
import 'package:demo_project/screens/home_screen.dart';
import 'package:demo_project/services/call_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWithEmail extends StatefulWidget {
  const LoginWithEmail({
    super.key,
  });

  @override
  State<LoginWithEmail> createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  addStringToSF({string1, string2, string3}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringValue1', string1);
    prefs.setString('stringValue2', string2);
    prefs.setString('stringValue3', string3);
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void loginWithEmail() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the fields.'),
        ),
      );
    } else {
      try {
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
        String data = md5.convert(utf8.encode(password)).toString();
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          final snapshot = await RemoteServices()
              .apiCalling(endPoint: "api/account/login", method: "post", body: {
            "email": email,
            "password": data,
          });
          UserData useData = UserData.fromJson(snapshot);
          if (useData != null) {
            addStringToSF(
              string1:
                  useData.tokenIdentity.userIdentity.orgMemberId.toString(),
              string2: useData.tokenIdentity.token,
              string3: useData.tokenIdentity.firebaseToken,
            );
          }

          // if (snapshot != null) {
          //   log("Success");
          //   log(snapshot.respMsg);
          // }

          // if ( "Invalid username or password.") {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text("Invalid username and password"),
          //     ),
          //   );
          // }
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
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

          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          String data = md5.convert(utf8.encode(password)).toString();
          final snapshot = await RemoteServices()
              .apiCalling(endPoint: "api/account/login", method: "post", body: {
            "email": email,
            "password": data,
          });

          if (snapshot != null) {
            log("Success");
            // log(snapshot.respMsg);
          }
          // ignore: use_build_context_synchronously
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const HomeScreen(),
          //   ),
          // );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Wrong Password."),
            ),
          );
        }
      }
    }
  }

  bool passwordEnable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 224, 107, 24),
        elevation: 0,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(100)),
                  color: Color.fromARGB(255, 224, 107, 24),
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        counterText: "",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: passwordEnable,
                      decoration: InputDecoration(
                        label: const Text("Password"),
                        counterText: "",
                        border: const OutlineInputBorder(),
                        suffix: InkWell(
                          onTap: () {
                            setState(
                              () {
                                if (passwordEnable) {
                                  passwordEnable = false;
                                } else {
                                  passwordEnable = true;
                                }
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              passwordEnable == true
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 120,
                          vertical: 15,
                        ),
                      ),
                      onPressed: () {
                        loginWithEmail();
                      },
                      child: const Text("Login"),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
