import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String username;
  final String emailAddress;
  final String mobileNumber;
  final int age;
  final DateTime dateOfBirth;

  // Constructor to receive user details
  const ProfilePage({
    Key? key,
    required this.username,
    required this.emailAddress,
    required this.mobileNumber,
    required this.age,
    required this.dateOfBirth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                child: Icon(
                  Icons.child_care,
                  size: 60,
                  color: Colors.white,
                ),
                backgroundColor: Colors.black12,
              ),
              SizedBox(height: 20),
              Text(
                'Username: $username', // Display user's name
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Email: $emailAddress', // Display user's email address
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Mobile Number: $mobileNumber', // Display user's mobile number
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Age: $age', // Display user's age
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Date of Birth: ${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year}', // Display user's date of birth
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Add functionality to update profile
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  primary: Colors.lightGreen,
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                  ),
                ),
                child: Text(
                  'Update Profile',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.favorite,
                    size: 40,
                    color: Colors.red,
                  ),
                  Icon(
                    Icons.star,
                    size: 40,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.school,
                    size: 40,
                    color: Colors.blue,
                  ),
                  Icon(
                    Icons.toys,
                    size: 40,
                    color: Colors.orange,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
