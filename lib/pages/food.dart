import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http package for API calls
import 'dart:convert'; // Import for JSON parsing
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Logging App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: FoodLoggingScreen(),
    );
  }
}

class FoodLoggingScreen extends StatefulWidget {
  @override
  _FoodLoggingScreenState createState() => _FoodLoggingScreenState();
}

class _FoodLoggingScreenState extends State<FoodLoggingScreen> {
  // Define limits for junk food categories


  int _sweetsLimit = 300; // Limit for sweets in calories
  int _chipsLimit = 300;
  int _lollipoplimit=300;

  int _chewlimit=300;
  int _jellylimit=300;
  int _chocolatelimit=300;
  int _protiendrinklimit=300;
  int _healthdrinklimit=300;
  int _marshmallowslimit=300;

  int _bakedcakelimit = 200;
  int _breadlimit = 200;
  int _jamslimit = 200;

  int _chocolatemilklimit = 200;
  int _sweetcookieslimit = 200;
  int _cookieslimit = 200;


  // Limit for chips in calories

  // Variables to track consumption
  int _sweetsConsumed = 0;
  int _chipsConsumed = 0;
  int _lollipopConsumed = 0;
  int _chewConsumed = 0;
  int _jellyConsumed = 0;
  int _chocolateConsumed = 0;
  int _protiendrinkConsumed = 0;
  int _healthdrinkConsumed = 0;
  int _marshmallowsConsumed=0;

  int _bakedcakeconsumed = 0;
  int _breadconsumed = 0;
  int _jamsconsumed = 0;

  int _chocolatemilkconsumed = 0;
  int _sweetcookiesconsumed = 0;
  int _cookiesconsumed = 0;
  // List to store notifications
  List<String> _notifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Logging'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[90],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FoodDetailsForm(
                  submitFormCallback: _submitForm,
                ),
              ),
            ),
            // Display visual progress indicators
            _buildProgressIndicator('Sweets', _sweetsConsumed, _sweetsLimit),
            _buildProgressIndicator('Chips', _chipsConsumed, _chipsLimit),
            _buildProgressIndicator('Lollipop', _lollipopConsumed, _lollipoplimit),
            _buildProgressIndicator('ChewingGum', _chewConsumed, _chewlimit),
            _buildProgressIndicator('Jellies(Gummy)', _jellyConsumed, _jellylimit),
            _buildProgressIndicator('Chocolate', _chocolateConsumed, _chocolatelimit),
            _buildProgressIndicator('Protien Drink', _protiendrinkConsumed, _protiendrinklimit),
            _buildProgressIndicator('Health Drink', _healthdrinkConsumed, _healthdrinklimit),
            _buildProgressIndicator('Marsh Mallows', _marshmallowsConsumed, _marshmallowslimit),
            _buildProgressIndicator('Baked Cake', _bakedcakeconsumed, _bakedcakelimit),
            _buildProgressIndicator('Bread', _breadconsumed, _breadlimit),
            _buildProgressIndicator('Jams', _jamsconsumed, _jamslimit),
            _buildProgressIndicator('Chocolate Milk', _chocolateConsumed, _chocolatelimit),
            _buildProgressIndicator('Sweet Cookies', _sweetcookiesconsumed, _sweetcookieslimit),
            _buildProgressIndicator('Cookies', _cookiesconsumed, _cookieslimit),




            SizedBox(height: 20),
            // Display notifications
            Column(
              children: _notifications
                  .map((notification) => Padding(
                padding: const EdgeInsets.all(10.0),

                child: Card(
                  child: ListTile(
                    title: Text(
                      notification,
                      style: TextStyle(fontSize: 16),
                    ),
                    leading: Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                  ),
                ),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(
      String category, int consumed, int limit) {
    double percentage = (consumed / limit) * 100;
    Color progressColor = percentage <= 100 ? Colors.green : Colors.red;
    bool isVisible = percentage > 100; // Set visibility based on whether consumption exceeds the limit

    return Visibility(
      visible: isVisible,
      child: GestureDetector(
        onTap: () {
          // Handle onTap event
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.all(30.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(19.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$category Consumption:',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              LinearProgressIndicator(
                value: percentage / 100,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              ),
              SizedBox(height: 10),
              Text(
                'Consumed: $consumed / $limit calories',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _submitForm(
      String mealType,
      String foodItem,
      String quantity,
      String date,
      )
  {

    if (foodItem.toLowerCase().contains('sweets')) {
      _updateConsumption('sweets', 150);
    } else if (foodItem.toLowerCase().contains('chips')) {
      _updateConsumption('chips', 200);
    }
    else if (foodItem.toLowerCase().contains('lollipop')) {
      _updateConsumption('lollipop', 200);
    }

    else if (foodItem.toLowerCase().contains('chewinggum')) {
      _updateConsumption('chewinggum', 200);
    }

    else if (foodItem.toLowerCase().contains('jelly')) {
      _updateConsumption('jelly', 200);
    }

    else if (foodItem.toLowerCase().contains('chocolate')) {
      _updateConsumption('chocolate', 200);
    }

    else if (foodItem.toLowerCase().contains('protiendrink')) {
      _updateConsumption('protiendrink', 200);
    }

    else if (foodItem.toLowerCase().contains('healthdrink')) {
      _updateConsumption('healthdrink', 200);
    }

    else if (foodItem.toLowerCase().contains('marshmallows')) {
      _updateConsumption('marshmallows', 200);
    }

    else if (foodItem.toLowerCase().contains('marshmallows')) {
      _updateConsumption('marshmallows', 200);
    }

    else if (foodItem.toLowerCase().contains('bakedcake')) {
      _updateConsumption('bakedcake', 200);
    }

    else if (foodItem.toLowerCase().contains('bread')) {
      _updateConsumption('bread', 200);
    }

    else if (foodItem.toLowerCase().contains('jams')) {
      _updateConsumption('jams', 200);
    }

    else if (foodItem.toLowerCase().contains('chocolatemilk')) {
      _updateConsumption('chocolatemilk', 200);
    }

    else if (foodItem.toLowerCase().contains('sweetcookies')) {
      _updateConsumption('sweetcookies', 200);
    }

    else if (foodItem.toLowerCase().contains('cookies')) {
      _updateConsumption('cookies', 200);
    }

  }

  void _updateConsumption(String category, int calories) {
    setState(() {
      if (category == 'sweets') {
        _sweetsConsumed += calories;
      }

      else if (category == 'chips') {
        _chipsConsumed += calories;
      }

      else if (category == 'lollipop') {
        _lollipopConsumed += calories;
      }

      else if (category == 'chewing') {
        _chewConsumed += calories;
      }

      else if (category == 'jelly') {
        _jellyConsumed += calories;
      }

      else if (category == 'chocolate') {
        _chocolateConsumed += calories;
      }

      else if (category == 'marshmallows') {
        _marshmallowsConsumed += calories;
      }

      else if (category == 'protiendrink') {
        _protiendrinkConsumed += calories;
      }

      else if (category == 'healthdrink') {
        _healthdrinkConsumed += calories;
      }

      else if (category == 'bakedcake') {
        _bakedcakeconsumed += calories;
      }

      else if (category == 'bread') {
        _breadconsumed += calories;
      }

      else if (category == 'jams') {
        _jamsconsumed += calories;
      }

      else if (category == 'chocolatemilk') {
        _chocolateConsumed += calories;
      }

      else if (category == 'sweetcookies') {
        _sweetcookiesconsumed += calories;
      }

      else if (category == 'cookies') {
        _cookiesconsumed += calories;
      }
    });

    // Check if consumption exceeds limits and trigger notifications
    if (_sweetsConsumed > _sweetsLimit) {
      _addNotification('Sweets limit exceeded!');
      _addNotification('Chemicals Present : Sugars in sweets include glucose, fructose, and sucrose');
      _addNotification('Health Issues : Eating sweets can lead to several health issues such as weight gain, tooth decay, high blood sugar levels, and an increased risk of developing chronic diseases like type 2 diabetes. ');

    }
    if (_chipsConsumed > _chipsLimit) {
      _addNotification('Chips limit exceeded!');

      _addNotification('Chemicals Present : Chips may contain preservatives, flavorings, and coloring agents.');
      _addNotification('Health Issues : High levels of sodium, fat, and calories are present in potato chips, which can lead to hypertension, weight gain, and heart disease if consumed in excess.');
    }
    if (_lollipopConsumed > _lollipoplimit) {
      _addNotification('Lollipop limit exceeded!');
      _addNotification('Chemicals Present : Artificial Food Colorings, Such as Red 40, Yellow 5, And Yellow 6. (Benzidine Or Other Carcinogens.)');
      _addNotification('Health Issues : Cause Hypersensitivity Reactions.');
    }
    if (_chewConsumed > _chewlimit) {
      _addNotification('Chewing Gum limit exceeded!');
      _addNotification('Chemicals Present : Titanium Dioxide and Artificial Food Dyes and BHT (Butylated Hydroxytoluene)');
      _addNotification('Health Issues : Hormone Disruption, Harm the Reproductive System and Potentially Increase Risk of Cancer And Genotoxic Effects-cause Damage the DNA And Induce Cancer');
    }

    if (_jellyConsumed > _jellylimit) {
      _addNotification('Jellies(Gummy) limit exceeded!');
      _addNotification('Chemicals Present : Gelatine And Gelatine-containing Products');
      _addNotification('Health Issues : Ige-mediated Hypersensitivity');
    }

    if (_chocolateConsumed > _chocolatelimit) {
      _addNotification('Chocolate limit exceeded!');
      _addNotification('Chemicals Present : Theobromine ');
      _addNotification('Health Issues : Nausea, Vomiting, Increased Heart Rate, And Even Seizures.');
    }

    if (_marshmallowsConsumed > _marshmallowslimit) {
      _addNotification('Marshmallows limit exceeded!');
      _addNotification('Chemicals Present : Corn Syrup and Added Sugars');
      _addNotification('Health Issues : Obesity, Dental Problems, And an Increased Risk of Chronic Diseases');
    }

    if (_protiendrinkConsumed > _protiendrinklimit) {
      _addNotification('Protien Drink limit exceeded!');
      _addNotification('Chemicals Present : Heavy Metal Contaminant (- Lead - Cadmium - Mercury - Arsenic)');
      _addNotification('Health Issues : Pro-hormones Disturbance (Natural Hormonal Balance in the Body and May Be Harmful in Growth or Sex Development in Adolescents and Children}');
    }
    if (_healthdrinkConsumed > _healthdrinklimit) {
      _addNotification('Health Drink limit exceeded!');
      _addNotification('Chemicals Present : Sodium And Caffeine');
      _addNotification('Health Issues : Heart Disease, Stroke, Insomnia, Nervousness');
    }

    if (_bakedcakeconsumed > _bakedcakelimit) {
      _addNotification('Baked Cake limit exceeded!');
      _addNotification('Chemicals Present : Polydextrose (E1200), Acesulfame Potassium (E950), Saccharin (E954)');
      _addNotification('Health Issues : Cause Diarrhea, Gastrointestinal Distress, Disrupt Blood Sugar Control And insulin secretion And Obesity, type 2 Diabetes, And metabolic Syndrome. Disrupt The Balance of Bacteria in the Gut');
    }

    if (_breadconsumed > _breadlimit) {
      _addNotification('Bread limit exceeded!');
      _addNotification('Chemicals Present : Processed Flour (Benzoyl Peroxide)');
      _addNotification('Health Issues : Excess Consumption Causes nausea, Dizziness, Other Poisoning, And Serious Liver Damage.');
    }

    if (_jamsconsumed > _jamslimit) {
      _addNotification('Jams limit exceeded!');
      _addNotification('Chemicals Present : Synthetic Preservative 211/E211 Or Sodium Benzoate');
      _addNotification('Health Issues : Hypersensitivity, Neurological Damage, And Even Cancer');
    }

    if (_chocolatemilkconsumed > _chocolatemilklimit) {
      _addNotification('Chocolate Milk limit exceeded!');
      _addNotification('Chemicals Present : High-fructose Corn Syrup, Additives Like Carrageenan and Caffeine.');
      _addNotification('Health Issues : Obesity And Diabetes-rich In Added Sugar , Causes Gut Tumors and Ulcers, And May Even Trigger Colon Cancer');
    }

    if (_sweetcookiesconsumed > _sweetcookieslimit) {
      _addNotification('Sweet Cookies limit exceeded!');
      _addNotification('Chemicals Present : Mono And Diglycerides , Titanium Dioxide');
      _addNotification('Health Issues : Genotoxic Effects-cause Damage the DNA And Induce Cancer');
    }

    if (_cookiesconsumed > _cookieslimit) {
      _addNotification('Cookies limit exceeded!');
      _addNotification('Chemicals Present : 5-hydroxymethylfurfural (HMF), Α-dicarbonyl Compounds (Dcs)- Furan');
      _addNotification('Health Issues : Induce Genotoxic and Mutagenic Effect and Induce Cancer');
    }
  }

  void _addNotification(String notification) {
    setState(() {
      _notifications.add(notification);
    });
  }
}
// Method to save data to SharedPreferences
void _saveData(String mealType, String foodItem, String quantity, String date) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Encode the data into a JSON string
  String jsonData = jsonEncode({
    'mealType': mealType,
    'foodItem': foodItem,
    'quantity': quantity,
    'date': date,
  });
  // Save the JSON string to SharedPreferences
  prefs.setString('foodLog', jsonData);
}


// Method to retrieve data from SharedPreferences
Future<Map<String, String>> _retrieveData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Retrieve the JSON string from SharedPreferences
  String? jsonData = prefs.getString('foodLog');
  // Decode the JSON string into a Map
  Map<String, dynamic> decodedData = jsonDecode(jsonData ?? '{}');
  // Convert dynamic values to String
  Map<String, String> data = {
    'mealType': decodedData['mealType'] ?? '',
    'foodItem': decodedData['foodItem'] ?? '',
    'quantity': decodedData['quantity'] ?? '',
    'date': decodedData['date'] ?? '',
  };
  return data;
}

class FoodDetailsForm extends StatefulWidget {
  final Function(String, String, String, String) submitFormCallback;

  const FoodDetailsForm({required this.submitFormCallback});

  @override
  _FoodDetailsFormState createState() => _FoodDetailsFormState();
}

class _FoodDetailsFormState extends State<FoodDetailsForm> {
  // Controllers for form fields
  TextEditingController _mealTypeController = TextEditingController();
  TextEditingController _foodItemController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter Food Details:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _mealTypeController,
            decoration: InputDecoration(
              labelText: 'Meal/Snack Type',
              border: OutlineInputBorder(),
              hintText: 'E.g., Breakfast, Lunch, Snack',
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _foodItemController,
            decoration: InputDecoration(
              labelText: 'Food Item',
              border: OutlineInputBorder(),
              hintText: 'E.g., Lollipop, Chewing Gum, Chocolate',
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _quantityController,
            decoration: InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder(),
              hintText: 'E.g., 1 piece, 100g',
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _dateController,
            decoration: InputDecoration(
              labelText: 'Date',
              border: OutlineInputBorder(),
              hintText: 'E.g., YYYY-MM-DD',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Submit form data
              widget.submitFormCallback(
                _mealTypeController.text,
                _foodItemController.text,
                _quantityController.text,
                _dateController.text,
              );
              // Clear form fields
              _mealTypeController.clear();
              _foodItemController.clear();
              _quantityController.clear();
              _dateController.clear();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  // Method to save form data to SharedPreferences
  Future<void> _saveFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mealType', _mealTypeController.text);
    prefs.setString('foodItem', _foodItemController.text);
    prefs.setString('quantity', _quantityController.text);
    prefs.setString('date', _dateController.text);
  }
}

