import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String title;
  final String discription;
  final bool isCompleted;
  final String taskId;
  final String userId;
  final Timestamp createdAt;

  Task(
      {required this.title,
      required this.taskId,
      required this.userId,
      required this.createdAt,
      required this.discription,
      required this.isCompleted});
  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(
      title: data['title'] ?? 'No Title',
      discription: data['description'] ?? 'No Description',
      isCompleted: data['isCompleted'] ?? false,
      taskId: data['taskId'] ?? 'No id',
      userId: data['userId'] ?? 'No userId',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }
}
