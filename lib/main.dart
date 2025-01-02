import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement_firebase/Views/splash_screen/splash.dart';
import 'package:taskmanagement_firebase/services/auth_service.dart';
import 'package:taskmanagement_firebase/services/data_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
      title: 'Task management',
      home: SplashScreen(),
    );
  }
}
