import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:login/pages/food.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Tracking and Reports',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: ProgressTrackingScreen(),
    );
  }
}

class ProgressTrackingScreen extends StatefulWidget {
  @override
  _ProgressTrackingScreenState createState() =>
      _ProgressTrackingScreenState();
}

class _ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
  List<ConsumptionData> _consumptionData = [];
  int _sweetsConsumed = 0;
  int _chipsConsumed = 0;
  final int _sweetsLimit = 200;
  final int _chipsLimit = 300;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  Future<void> initializeNotifications() async {
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings('app_icon'),
      iOS: IOSInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        // Handle notification selection
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Tracking and Reports'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            _buildTrackConsumptionButton(),
            SizedBox(height: 20),
            _buildReports(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackConsumptionButton() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodLoggingScreen(),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Track Consumption',
            style: TextStyle(fontSize: 16),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white10, // Changed button color to blue accent
          onPrimary: Colors.black,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Increased border radius
          ),
          minimumSize: Size(150, 90), // Set minimum button size
        ),
      ),
    );
  }

  Widget _buildExportReportsButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          _exportReports();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Export Reports',
            style: TextStyle(fontSize: 16),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.grey.withOpacity(0.7), // Slightly transparent grey color
          onPrimary: Colors.black,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Increased border radius
          ),
          minimumSize: Size(150, 90), // Set minimum button size
        ),
      ),
    );
  }

  Widget _buildReports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Reports',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _consumptionData.length,
          itemBuilder: (context, index) {
            final data = _consumptionData[index];
            return ListTile(
              title: Text('${data.date}: ${data.consumedItems.join(', ')}'),
              subtitle: Text('Total Calories: ${data.totalCalories}'),
            );
          },
        ),
        _buildExportReportsButton(),
      ],
    );
  }



  void _addConsumptionData(ConsumptionData data) {
    setState(() {
      _consumptionData.add(data);
    });
    _trackSweetConsumption(data);
    _trackChipsConsumption(data);
    _triggerNotifications(data);
  }

  void _trackSweetConsumption(ConsumptionData data) {
    for (String item in data.consumedItems) {
      if (item.toLowerCase().contains('sweet')) {
        _sweetsConsumed += data.totalCalories;
        break;
      }
    }
  }

  void _trackChipsConsumption(ConsumptionData data) {
    for (String item in data.consumedItems) {
      if (item.toLowerCase().contains('chips')) {
        _chipsConsumed += data.totalCalories;
        break;
      }
    }
  }

  void _triggerNotifications(ConsumptionData data) {
    if (_sweetsConsumed > _sweetsLimit) {
      _showNotification('Sweets Limit Exceeded!',
          'You have exceeded the sweets consumption limit.');
    }
    if (_chipsConsumed > _chipsLimit) {
      _showNotification('Chips Limit Exceeded!',
          'You have exceeded the chips consumption limit.');
    }
  }

  Future<void> _showNotification(String title, String body) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  void _exportReports() {
    print('Exporting reports:');
    for (var data in _consumptionData) {
      print(
          '${data.date}: ${data.consumedItems.join(', ')} - Total Calories: ${data.totalCalories}');
    }
    print('Sweets Consumed: $_sweetsConsumed calories');
    print('Chips Consumed: $_chipsConsumed calories');
  }
}

class ConsumptionData {
  final String date;
  final List<String> consumedItems;
  final int totalCalories;

  ConsumptionData({
    required this.date,
    required this.consumedItems,
    required this.totalCalories,
  });
}

class TrackConsumptionScreen extends StatefulWidget {
  final Function(ConsumptionData) onTrackConsumption;

  const TrackConsumptionScreen({Key? key, required this.onTrackConsumption})
      : super(key: key);

  @override
  _TrackConsumptionScreenState createState() =>
      _TrackConsumptionScreenState();
}

class _TrackConsumptionScreenState extends State<TrackConsumptionScreen> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _itemsController = TextEditingController();
  TextEditingController _caloriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Consumption'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyTextField(
              controller: _dateController,
              hintText: 'Date',
            ),
            SizedBox(height: 10),
            MyTextField(
              controller: _itemsController,
              hintText: 'Consumed Items (comma-separated)',
            ),
            SizedBox(height: 10),
            MyTextField(
              controller: _caloriesController,
              hintText: 'Total Calories',
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Track'),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                onPrimary: Colors.black,
                elevation: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    final date = _dateController.text;
    final items = _itemsController.text.split(',');
    final totalCalories = int.tryParse(_caloriesController.text) ?? 0;

    if (date.isNotEmpty && items.isNotEmpty && totalCalories > 0) {
      final data = ConsumptionData(
          date: date,
          consumedItems: items.map((e) => e.trim()).toList(),
          totalCalories: totalCalories);
      widget.onTrackConsumption(data);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill all fields correctly.')));
    }
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
