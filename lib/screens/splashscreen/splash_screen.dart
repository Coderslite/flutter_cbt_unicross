import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicross_cbt_desktop_app/screens/auth/login_screen.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  nextNextScreen() async {
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return LoginScreen();
      }));
    });
  }

  @override
  void initState() {
    nextNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue2,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.1,
            image: AssetImage("assets/images/logo.png"),
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "UNICROSS CBT",
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CircularProgressIndicator(),
          ],
        )),
      ),
    );
  }
}
