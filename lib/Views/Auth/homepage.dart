import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement_firebase/Views/Auth/editpage.dart';
import 'package:taskmanagement_firebase/Views/add_data.dart';
import 'package:taskmanagement_firebase/model/task_model.dart';
import 'package:taskmanagement_firebase/services/data_provider.dart';
import 'package:taskmanagement_firebase/widgets/mydrawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Tasks')
                .where('userId', isEqualTo: currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                    child: Text('Error fetching tasks: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                    child: Text('No tasks available for your account.'));
              }
              final tasks = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                child: ListView.separated(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    final taskData = Task.fromMap(task.data());

                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 249, 244, 244),
                          borderRadius: BorderRadius.circular(10),
                          border: Border(
                              left: BorderSide(
                                  color: taskData.isCompleted == false
                                      ? Colors.red
                                      : Colors.green,
                                  width: 6))),
                      child: Column(
                        children: [
                          ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditPage(
                                              task: taskData,
                                            )));
                              },
                              // leading: Checkbox(
                              //     value: taskData.isCompleted,
                              //     onChanged: (value) {}),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  taskData.isCompleted == false
                                      ? 'Pending'
                                      : 'Completed',
                                  style: TextStyle(
                                      color: taskData.isCompleted == false
                                          ? Colors.red
                                          : Colors.green),
                                ),
                              ),
                              subtitle: RichText(
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                    text: '${taskData.title}\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: taskData.discription,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                      )
                                    ]),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  context
                                      .read<DataProvider>()
                                      .deleteTask(docId: taskData.taskId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Task deleted")));
                                },
                                icon: const Icon(Icons.delete),
                              )),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddDataScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
