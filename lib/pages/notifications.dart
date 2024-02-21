import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text(
          'Notifications',
          style: TextStyle(color:Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
