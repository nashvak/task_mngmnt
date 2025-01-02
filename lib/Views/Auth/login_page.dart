import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement_firebase/Views/Auth/homepage.dart';
import 'package:taskmanagement_firebase/Views/Auth/signup_page.dart';
import 'package:taskmanagement_firebase/services/auth_service.dart';
import 'package:taskmanagement_firebase/widgets/custom_button.dart';
import 'package:taskmanagement_firebase/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
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
            CustomButton(
              text: 'Login',
              ontap: () async {
                try {
                  final error =
                      await context.read<AuthService>().loginWithEmailPassword(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                  if (error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error)),
                    );
                  } else {
                    // context.go(AppRoutes.home);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not a member? "),
                GestureDetector(
                  // onTap: () => context.go(AppRoutes.signup),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                  child: const Text(
                    "Register now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
