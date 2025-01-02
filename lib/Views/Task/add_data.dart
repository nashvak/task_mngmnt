import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement_firebase/services/data_provider.dart';
import 'package:taskmanagement_firebase/widgets/custom_button.dart';
import 'package:taskmanagement_firebase/widgets/custom_textfield.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  bool isCompleted = false;
  final addformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
      ),
      body: Form(
        key: addformKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomTextfield(
                text: "Title", controller: nameController, obscure: false),
            const SizedBox(
              height: 20,
            ),
            CustomTextfield(
              text: "Description",
              controller: discriptionController,
              obscure: false,
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<DataProvider>(builder: (context, provider, _) {
              return CustomButton(
                  ontap: () async {
                    if (addformKey.currentState!.validate()) {
                      await provider
                          .addData(
                        title: nameController.text.trim(),
                        desc: discriptionController.text.trim(),
                      )
                          .then((v) {
                        nameController.clear();
                        discriptionController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Task Added")));
                        Navigator.pop(context);
                      });
                    }
                  },
                  text: provider.addDataLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Add Data",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ));
            })
          ],
        ),
      ),
    );
  }
}
