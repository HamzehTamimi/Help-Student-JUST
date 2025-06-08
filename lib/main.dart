import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:helpstudent/screens/home.dart';
import 'package:helpstudent/screens/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Helper',
      theme: ThemeData(
        // Change this from purple to another color, e.g., blue
        primarySwatch: Colors.blue,
        // Optional: Use ColorScheme for more control (especially with Material 3)
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(1, 87, 155, 1),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
