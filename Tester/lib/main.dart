import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          MaterialButton(
            onPressed: () {},
            child: Text("Image from gallery"),
            color: Colors.amber,
          ),
          MaterialButton(
            onPressed: () {},
            child: Text("Image from camera"),
            color: Colors.amber,
          ),
          _selectedImage != null
              ? Image.file(_selectedImage!)
              : Text("Please Select An Image")
        ],
      ),
    );
  }
}

Future _pickImageFromGallery() async {
  final returnedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
}
