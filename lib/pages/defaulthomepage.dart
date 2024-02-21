import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login/pages/animated.dart';
import 'package:login/pages/child_stored_details.dart';
import 'package:login/pages/childdetails.dart';
import 'package:login/pages/childregister.dart';
import 'package:login/pages/food.dart';
import 'package:login/pages/home_page.dart';
import 'package:login/pages/notifications.dart';
import 'package:login/pages/profile.dart';
import 'package:login/pages/temp.dart';
import 'package:login/pages/todo.dart'; // Import the ProfilePage

class DefaultHomePage extends StatefulWidget {
  @override
  _DefaultHomePageState createState() => _DefaultHomePageState();
}

class _DefaultHomePageState extends State<DefaultHomePage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    //_startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  final List<Widget> _pages = [
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[10], // Set Scaffold background color
      appBar: AppBar(
        backgroundColor: Colors.grey[10], // Set AppBar background color
        title: Text(
          'Nurture Lil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.receipt_long, size: 39,),
              onPressed: () { Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProgressTrackingScreen()),
              );;
              },
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey, // Set Drawer background color
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.blue[100],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mohanraj S',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'email@example.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                // Navigate to edit profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(username: 'Mohanraj', emailAddress: 'mohanraj@gmail.com', mobileNumber: '9323489987', age: 12, dateOfBirth: DateTime(2022, 1, 31, 12, 30, 0) ,)),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Add logout functionality
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 3) {
            // If the "About" icon is tapped, navigate to the HomePage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePages()),
            );

          }
          if (index == 2) {
            // If the "About" icon is tapped, navigate to the HomePage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChildStoredDetailsPage()),
            );

          }

          if (index == 1) {
            // If the "About" icon is tapped, navigate to the HomePage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Notifications()),
            );

          }

          else {
            onTap(index){
              setState(() {
                _selectedIndex = index;
                //  _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
              });
            }}
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 35,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, size: 35,),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt, size: 35,),
            label: 'Child Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book, size: 35,),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> imagePaths = [
    'lib/images/img_4.png',
    'lib/images/img_7.png',
    'lib/images/img_6.png',
    'lib/images/img_9.png',
    'lib/images/img_10.png',
    'lib/images/img_11.png',
    'lib/images/img_8.png',
    // Add more image paths here as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          AnimatedImageSlider(imagePaths: imagePaths),
          const SizedBox(height: 20.0),
          Text(
            'Who are you ?',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, height: 1, wordSpacing: 3, color: Colors.blue[900]),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRoundedOverflowButton(
                onTap: () {
                  // Navigate to child register page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChildRegisterPage()),
                  );
                },
                imagePath: 'lib/images/img_3.png',
                name: 'Boys',
                backgroundColor: Colors.blue[100]!,
                textColor: Colors.blue[900]!,
              ),
              _buildRoundedOverflowButton(
                onTap: () {
                  // Navigate to child register page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChildRegisterPage()),
                  );
                },
                imagePath: 'lib/images/img_1.png',
                name: 'Girls',
                backgroundColor: Colors.orange[100]!,
                textColor: Colors.orange[900]!,
              ),
              _buildRoundedOverflowButton(
                onTap: () {
                  // Navigate to child register page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChildRegisterPage()),
                  );
                },
                imagePath: 'lib/images/img.png',
                name: 'Expecting',
                backgroundColor: Colors.pink[100]!,
                textColor: Colors.pink[900]!,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Column(
            children: [
              AnimatedHealthCareQuote(),
              SizedBox(height: 10.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Image.asset(
        imagePath,
        width: 200, // Adjust image width as needed
        height: 200, // Adjust image height as needed
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRoundedOverflowButton({
    required VoidCallback onTap,
    required String imagePath,
    required String name,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Column(
      children: [
        _RoundedOverflowButton(
          onTap: onTap,
          imagePath: imagePath,
          name: name,
          backgroundColor: backgroundColor,
          textColor: textColor,
        ),
        SizedBox(height: 10),
        Text(
          name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        ),
      ],
    );
  }
}

class _RoundedOverflowButton extends StatefulWidget {
  final VoidCallback onTap;
  final String imagePath;
  final String name;
  final Color backgroundColor;
  final Color textColor;

  const _RoundedOverflowButton({
    Key? key,
    required this.onTap,
    required this.imagePath,
    required this.name,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  __RoundedOverflowButtonState createState() => __RoundedOverflowButtonState();
}

class __RoundedOverflowButtonState extends State<_RoundedOverflowButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 90,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: _isHovering ? Colors.grey.withOpacity(0.5) : Colors.transparent,
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
            color: widget.backgroundColor,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedHealthCareQuote extends StatefulWidget {
  @override
  _AnimatedHealthCareQuoteState createState() => _AnimatedHealthCareQuoteState();
}

class _AnimatedHealthCareQuoteState extends State<AnimatedHealthCareQuote> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Text(
            getHealthCareQuote(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

String getHealthCareQuote() {
  List<String> quotes = [
    "A healthy child is a happy child.",
    "Prevention is better than cure.",
    "Nourish the body, feed the mind.",
    "Healthy habits, happy lives.",
    "Growing strong and healthy."
  ];
  return quotes[DateTime.now().second % quotes.length];
}
