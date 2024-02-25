import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/Login_Signup/login.dart';
import 'package:flutter_application/Teacher/create.dart';
import 'package:flutter_application/homepage.dart';

import 'Login_Signup/register.dart';
import 'Student/HomeS.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 40, 130, 163),
      ),
      home: StudentHome(),
    );
  }
}
