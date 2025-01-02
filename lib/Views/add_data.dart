import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement_firebase/services/data_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
      ),
      body: Column(
        children: [
          CustomTextfield(
              text: "Title", controller: nameController, obscure: false),
          SizedBox(
            height: 20,
          ),
          CustomTextfield(
              text: "Discription",
              controller: discriptionController,
              obscure: false),
          Consumer<DataProvider>(builder: (context, provider, _) {
            return ElevatedButton(
                onPressed: () async {
                  await provider
                      .addData(Task(
                          name: nameController.text,
                          discription: discriptionController.text,
                          isCompleted: false))
                      .then((v) {
                    nameController.clear();
                    discriptionController.clear();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Data Added")));
                  });
                },
                child: provider.addDataLoading
                    ? CircularProgressIndicator()
                    : Text("Add Data"));
          })
        ],
      ),
    );
  }
}
