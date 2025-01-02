import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DataProvider extends ChangeNotifier {
  bool addDataLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = Uuid();

  Future<void> addData(Task task) async {
    addDataLoading = true;
    notifyListeners();
    try {
      String taskId = _uuid.v4();
      final data = {
        "title": task.name,
        "description": task.discription,
        "isCompleted": task.isCompleted,
        'taskId': taskId,
        'createdAt': FieldValue.serverTimestamp(),
        "userId": FirebaseAuth.instance.currentUser?.uid.toString()
      };
      await _firestore.collection("Tasks").add(data);
      addDataLoading = false;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add data: $e');
    }
  }
}

class Task {
  final String name;
  final String discription;
  final bool isCompleted;

  Task(
      {required this.name,
      required this.discription,
      required this.isCompleted});
}
