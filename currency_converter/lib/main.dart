import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Types of Widget
// 1. Stateless Widget
// 2. Stateful Widget

//Design System
// 1. Material Design
// 2. Cupertino Design

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Hello Harsh"),
        ),
      ),
    );
  }
}
