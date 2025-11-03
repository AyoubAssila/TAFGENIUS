import 'package:flutter/material.dart';
import 'package:appelearning/signup.dart'; // import correct
import 'package:appelearning/login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TAFGENIUS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
      },
     ); 
  }
}
