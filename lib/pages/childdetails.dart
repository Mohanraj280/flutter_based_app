import 'package:flutter/material.dart';
import 'package:login/components/child.dart';

class ChildrenDetailPage extends StatelessWidget {
  final int childIndex;
  final List<Child> children;
  final Child child;

  const ChildrenDetailPage({
    Key? key,
    required this.childIndex,
    required this.children,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Child Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Child Details:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Name: ${child.name}'),
              Text('Age: ${child.age}'),
              Text('Phone Number: ${child.phoneNumber}'),
            ],
          ),
        ),
      ),
    );
  }
}
