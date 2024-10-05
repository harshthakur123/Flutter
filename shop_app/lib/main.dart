import 'package:flutter/material.dart';
import 'package:shop_app/home_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guitar Collections',
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 150, 0, 102),
          primary: const Color.fromARGB(255, 150, 0, 102),
        ),
        inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey),
            prefixIconColor: Colors.grey),
      ),
      home: const HomePage(),
    );
  }
}
