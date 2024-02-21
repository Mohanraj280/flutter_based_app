import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _activityController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _sleepController = TextEditingController();

  List<TodoItem> _todoList = [];
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Children\'s Daily Activity'),
        backgroundColor: Colors.grey[100],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(

                children: [
                  SizedBox(height: 20),
                  TextFormField(

                    controller: _activityController,
                    decoration: InputDecoration(
                      labelText: 'Food',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an activity';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _sleepController,
                    decoration: InputDecoration(
                      labelText: 'Sleep',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter sleep duration';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _selectedIndex == null ? _addTodo : _editTodo,
                    child: Text(_selectedIndex == null ? 'Add Activity' : 'Edit Activity'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Children\'s Daily Activity List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text(
                      _todoList[index].activity,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Amount: ${_todoList[index].amount}, Sleep: ${_todoList[index].sleep}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _showEditDialog(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteTodo(index),
                        ),
                      ],
                    ),
                    onTap: () => _showEditDialog(index),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addTodo() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _todoList.add(TodoItem(
          activity: _activityController.text,
          amount: _amountController.text,
          sleep: _sleepController.text,
        ));
        _activityController.clear();
        _amountController.clear();
        _sleepController.clear();
      });
    }
  }

  void _editTodo() {

    if (_formKey.currentState!.validate()) {
      setState(() {
        _todoList[_selectedIndex!] = TodoItem(
          activity: _activityController.text,
          amount: _amountController.text,
          sleep: _sleepController.text,
        );
        _activityController.clear();
        _amountController.clear();
        _sleepController.clear();
        _selectedIndex = null;
      });
    }
  }

  void _deleteTodo(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  void _showEditDialog(int index) {
    _selectedIndex = index;
    _activityController.text = _todoList[index].activity;
    _amountController.text = _todoList[index].amount;
    _sleepController.text = _todoList[index].sleep;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Activity'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _activityController,
                    decoration: InputDecoration(
                      labelText: 'Food',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an activity';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _sleepController,
                    decoration: InputDecoration(
                      labelText: 'Sleep',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter sleep duration';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _selectedIndex = null;
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _editTodo,
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class TodoItem {
  final String activity;
  final String amount;
  final String sleep;

  TodoItem({required this.activity, required this.amount, required this.sleep});
}

void main() {
  runApp(MaterialApp(
    home: TodoPage(),
  ));
}
