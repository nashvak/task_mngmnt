import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement_firebase/Views/Auth/homepage.dart';
import 'package:taskmanagement_firebase/Views/Auth/login_page.dart';
import 'package:taskmanagement_firebase/services/auth_service.dart';
import 'package:taskmanagement_firebase/widgets/custom_button.dart';
import 'package:taskmanagement_firebase/widgets/custom_textfield.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Register"),
                const SizedBox(
                  height: 25,
                ),
                CustomTextfield(
                  text: 'Email',
                  obscure: false,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextfield(
                  text: 'Password',
                  obscure: true,
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextfield(
                  text: 'Confirm Password',
                  obscure: true,
                  controller: confirmPassController,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                  text: 'Register',
                  ontap: () async {
                    if (formKey.currentState!.validate()) {
                      if (passwordController.text ==
                          confirmPassController.text) {
                        try {
                          await context.read<AuthService>().register(
                                emailController.text,
                                passwordController.text,
                              );
                          // context.go(AppRoutes.home);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Empty')));
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      // onTap: () => context.go(AppRoutes.login),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: const Text(
                        "Login now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
