import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/components/child.dart';
import 'package:login/pages/childdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildRegisterPage extends StatefulWidget {
  ChildRegisterPage({Key? key}) : super(key: key);

  @override
  _ChildRegisterPageState createState() => _ChildRegisterPageState();
}

class _ChildRegisterPageState extends State<ChildRegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> registerChild(BuildContext context) async {
    String name = nameController.text;
    int age = int.tryParse(ageController.text) ?? 0;
    String phoneNumber = phoneNumberController.text;

    Child newChild = Child(name: name, age: age, phoneNumber: phoneNumber);

    // Save child details to shared preferences
    await saveChildDetails(newChild);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChildrenDetailPage(
          childIndex: 0, // Always display the latest child details
          children: [],
          child: newChild,
        ),
      ),
    );

    // Clear the text fields after registering a child
    nameController.clear();
    ageController.clear();
    phoneNumberController.clear();
    setState(() {
      _image = null; // Clear the image selection
    });
  }

  Future<void> saveChildDetails(Child child) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> childDetails = [
      child.name,
      child.age.toString(),
      child.phoneNumber,
    ];
    List<List<String>> allChildrenDetails = prefs.getStringList('children')?.map((e) => e.split(','))?.toList() ?? [];
    allChildrenDetails.add(childDetails);
    prefs.setStringList('children', allChildrenDetails.map((e) => e.join(',')).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Register Your Child'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: _getImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Register Your Child',
                  style: TextStyle(color: Colors.grey[700], fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      MyTextField(
                        controller: nameController,
                        hintText: 'Child\'s Name',
                        obscureText: false,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: ageController,
                        hintText: 'Age',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: phoneNumberController,
                        hintText: 'Phone Number',
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                MyButton(
                  onTap: () => registerChild(context),
                  buttonText: 'Register',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;

  const MyButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue, // Change color as needed
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent, // Transparent background
          elevation: 0, // No shadow
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Adjust padding here
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14, // Adjust font size as needed
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
