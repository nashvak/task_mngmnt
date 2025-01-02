import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement_firebase/Views/Auth/login_page.dart';
import 'package:taskmanagement_firebase/Views/add_data.dart';
import 'package:taskmanagement_firebase/router/app_router.dart';
import 'package:taskmanagement_firebase/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await context.read<AuthService>().signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout failed: ${e.toString()}')),
                );
              }
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Tasks')
                .where('userId', isEqualTo: currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                    child: Text('Error fetching tasks: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Text('No tasks available for your account.'));
              }
              final tasks = snapshot.data!.docs;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final taskData = task.data() as Map<String, dynamic>;

                  return ListTile(
                    title: Text(taskData['title'] ?? 'No Title'),
                    subtitle: Text(taskData['description'] ?? 'No Description'),
                    trailing: Text(
                      (taskData['isCompleted'] == false)
                          ? 'Pending'
                          : 'Completed',
                      style: TextStyle(
                        color: taskData['status'] == 'Completed'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  );
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddDataScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
