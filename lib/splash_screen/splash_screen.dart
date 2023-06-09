import 'dart:async';

import 'package:day2/login/ui/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  navigate() {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return LoginPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo1.png',
              height: 100.0,
              width: 100.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text("Welcome to"),
          const Text(
            "Vishwa Adarsha College",
            style: TextStyle(
                color: Colors.lightGreen,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
          const Text("Itahari, Sunasri")
        ],
      ),
    );
  }
}
