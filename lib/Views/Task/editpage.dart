import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement_firebase/model/task_model.dart';
import 'package:taskmanagement_firebase/services/data_provider.dart';

class EditPage extends StatefulWidget {
  final Task task;
  EditPage({required this.task, super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  late bool isCompleted;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.task.title);
    contentController = TextEditingController(text: widget.task.discription);
    isCompleted = widget.task.isCompleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  Task task = Task(
                      title: titleController.text.trim(),
                      taskId: widget.task.taskId,
                      userId: widget.task.userId,
                      createdAt: widget.task.createdAt,
                      discription: contentController.text.trim(),
                      isCompleted: isCompleted);
                  await context.read<DataProvider>().updateTask(task).then((v) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Task updated")));
                  });
                }
                // else {
                //   ScaffoldMessenger.of(context)
                //       .showSnackBar(SnackBar(content: Text("Fill the fields")));
                // }
              },
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.save,
                size: 33,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(children: [
            Expanded(
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          shape: const CircleBorder(),
                          value: isCompleted,
                          onChanged: (value) {
                            setState(() {
                              isCompleted = value!;
                            });
                          },
                        ),
                        const Text(
                          "Add to Completed",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Hero(
                      tag: 'task-title-${widget.task.taskId}',
                      child: TextFormField(
                        controller: titleController,
                        // cursorColor: style.color,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 30),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 30),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    TextFormField(
                      controller: contentController,
                      // cursorColor: style.color,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type something here...',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 17),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
