import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:demo_project/model/send_token_model.dart';
import 'package:demo_project/screens/login_phone_email.dart';
import 'package:demo_project/services/call_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Profile? profile;
  // String? name;
  // String? surname;
  // String? emailId;
  // String? gen;
  String? v1;
  String? v2;
  String? v3;
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

  void getorgData() async {
    final prefs = await SharedPreferences.getInstance();
    final value1 = prefs.getString('stringValue1');
    String? value2 = prefs.getString('stringValue2');
    final value3 = prefs.getString('stringValue3');
    setState(() {
      v1 = value1;
      v2 = value2;
      v3 = value3;
    });

    int id = int.parse(value1.toString());
    final snapshot = await RemoteServices()
        .apiCalling(endPoint: "api/member/profile/$id", method: 'get', header: {
      'accept': 'application/json',
      "Authorization": "Bearer $value2",
    });
    final snap = Profile.fromJson(snapshot);

    // setState(() {
    //   name = snap.orgMember.firstName;
    //   surname = snap.orgMember.lastName;
    //   emailId = snap.orgMember.email;
    //   gen = snap.orgMember.gender;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${profile != null ? profile!.orgMember.firstName : ""}",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          // Text(
          //   surname != null ? "Last Name : $surname" : "",
          //   style: const TextStyle(
          //     fontSize: 20,
          //   ),
          // ),
          // Text(
          //   emailId != null ? "Email Id : $emailId" : "",
          //   style: const TextStyle(
          //     fontSize: 20,
          //   ),
          // ),
          // Text(
          //   gen != null ? "Gender : $gen" : "",
          //   style: const TextStyle(
          //     fontSize: 20,
          //   ),
          // ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: ElevatedButton(
              child: const Text("Get Org Data"),
              onPressed: () async {
                getorgData();
              },
            ),
          ),
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
