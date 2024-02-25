import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application/Login_Signup/login.dart';
import 'package:flutter_application/Login_Signup/register.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
     ()=>Navigator.pushReplacement(context,
      MaterialPageRoute(builder:(context) => SecondScreen() )
        )
   );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 44, 130, 183),
    );
  }
}
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Align(
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width:double.infinity,
          child: ElevatedButton(
            
            child: const Text('Login'),
            
            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => LoginPage())),
          ),
        ),
       
        TextButton(
           child: const Text('Register'),
          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Register())),
         
        ),
      ],
    ),
  ),
);
  }
}