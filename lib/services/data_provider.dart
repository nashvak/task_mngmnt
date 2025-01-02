import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagement_firebase/model/task_model.dart';

class DataProvider extends ChangeNotifier {
  bool addDataLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addData({required String title, required String desc}) async {
    addDataLoading = true;
    notifyListeners();
    try {
      final data = {
        "title": title,
        "description": desc,
        "isCompleted": false,
        'createdAt': FieldValue.serverTimestamp(),
        "userId": FirebaseAuth.instance.currentUser?.uid.toString()
      };
      DocumentReference taskRef =
          await _firestore.collection("Tasks").add(data);
      await taskRef.update({'taskId': taskRef.id});
      addDataLoading = false;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add data: $e');
    }
  }

  Future<void> deleteTask({required String docId}) async {
    try {
      await _firestore.collection('Tasks').doc(docId).delete();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _firestore.collection('Tasks').doc(task.taskId).update({
        'title': task.title,
        'description': task.discription,
        'isCompleted': task.isCompleted,
      });
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add data: $e');
    }
  }
}
