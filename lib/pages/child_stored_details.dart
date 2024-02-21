import 'package:flutter/material.dart';

class HomePages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[10],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Nurture Lil',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Image.asset(
                  'lib/images/homeimage.png',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome to Nurture Lil\' Hospital',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Empowering Parental Oversight',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 400,
                  height: 450,// Set the desired width here
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'A Mobile Application for Healthy Childhood Dietary Habits',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Welcome to Nurture Lil\' Hospital, the mobile application designed to empower parents in monitoring and managing their children\'s dietary choices effectively. Our app provides a user-friendly platform allowing parents to securely log in and input key details about their child food consumption, focusing on limiting unhealthy junk foods. We aim to bridge the gap between busy lifestyles and the need for comprehensive child health management, fostering a healthier lifestyle for children. Join us in our mission to nurture healthier generations!',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  '© 2024 Nurture Lil’ Hospital. All rights reserved.',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
