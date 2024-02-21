import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedImageSlider extends StatefulWidget {
  final List<String> imagePaths;
  final Duration duration;
  final Curve curve;

  const AnimatedImageSlider({
    Key? key,
    required this.imagePaths,
    this.duration = const Duration(seconds: 2),
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  _AnimatedImageSliderState createState() => _AnimatedImageSliderState();
}

class _AnimatedImageSliderState extends State<AnimatedImageSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(widget.duration, (Timer timer) {
      if (_currentPageIndex == widget.imagePaths.length - 1) {
        _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: widget.curve);
      } else {
        _pageController.nextPage(duration: Duration(milliseconds: 500), curve: widget.curve);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Adjust the height as needed
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.imagePaths.length,
        itemBuilder: (context, index) {
          return _buildImage(widget.imagePaths[index]);
        },
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
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
}
