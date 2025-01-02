import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:taskmanagement_firebase/Views/Auth/homepage.dart';
import 'package:taskmanagement_firebase/Views/Auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    Future.delayed(const Duration(seconds: 4), () {
      if (currentUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Welcome"),
      ),
    );
  }
}
