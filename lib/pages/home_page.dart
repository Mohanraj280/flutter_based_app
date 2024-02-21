import 'package:flutter/material.dart';
import 'package:login/pages/todo.dart';

class ChildStoredDetailsPage extends StatefulWidget {
  @override
  _ChildStoredDetailsPageState createState() => _ChildStoredDetailsPageState();
}

class _ChildStoredDetailsPageState extends State<ChildStoredDetailsPage> {
  bool _isHovered1 = false;
  bool _isHovered2 = false;
  bool _isHovered3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[10],
      appBar: AppBar(
        backgroundColor: Colors.grey[10],
        title: Text(
          'Child\'s Health',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Image.asset(
                        'lib/images/homeimage.png',
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(height: 30),
                      buildCircularButton('Mohanraj', _isHovered1, () {
                        setState(() {
                          _isHovered1 = !_isHovered1;
                        });
                        _navigateToTodoPage(context);
                      }), // Circular button
                      SizedBox(height: 10),
                      buildCircularButton('John', _isHovered2, () {
                        setState(() {
                          _isHovered2 = !_isHovered2;
                        });
                        _navigateToTodoPage(context);
                      }),
                      SizedBox(height: 10),
                      buildCircularButton('Raj', _isHovered3, () {
                        setState(() {
                          _isHovered3 = !_isHovered3;
                        });
                        _navigateToTodoPage(context);
                      }),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '© 2024 Nurture Lil’ Hospital. All rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue[800], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCircularButton(String name, bool isHovered, Function() onTap) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(75),
        color: isHovered ? Colors.grey[100] : Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 9,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        onHover: (value) {
          if (name == 'Mohanraj') {
            setState(() {
              _isHovered1 = value;
            });
          } else if (name == 'John') {
            setState(() {
              _isHovered2 = value;
            });
          } else if (name == 'Raj') {
            setState(() {
              _isHovered3 = value;
            });
          }
        },
        child: Container(
          width: 120,
          height: 120,
          alignment: Alignment.center,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToTodoPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoPage()),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ChildStoredDetailsPage(),
  ));
}

