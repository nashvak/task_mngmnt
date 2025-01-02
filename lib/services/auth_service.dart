import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // User? _user;

  // User? get user => _user;

  // bool get isAuthenticated => _user != null;

  // authProvider() {
  //   firebaseAuth.authStateChanges().listen((User? user) {
  //     _user = user;
  //     notifyListeners();
  //   });
  // }

  Future<String?> loginWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      // If login is successful, return null (no error)
      if (userCredential.user != null) {
        return null; // No error
      }

      // Return a message if login is unsuccessful (should not really get here)
      return "Failed to log in";
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> register(String email, password) async {
    try {
      //create user
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // save user info into firestore
      await firestore.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      });
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    notifyListeners();
  }
}
