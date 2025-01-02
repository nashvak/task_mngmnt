import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement_firebase/Views/Auth/login_page.dart';
import 'package:taskmanagement_firebase/Views/add_data.dart';
import 'package:taskmanagement_firebase/services/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.assignment,
                      color: Theme.of(context).colorScheme.primary,
                      size: 64,
                    ),
                    Text(currentUser?.email ?? ""),
                  ],
                ),
              )),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text("HOME"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text("ADD TASK"),
                  leading: Icon(Icons.note_alt_outlined),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDataScreen()));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25, left: 25),
            child: ListTile(
              title: Text("LOGOUT"),
              leading: Icon(Icons.logout),
              onTap: () {
                context.read<AuthService>().signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
