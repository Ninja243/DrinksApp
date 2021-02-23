import 'package:flutter/material.dart';

class DrinkScreen extends StatefulWidget {
  @override
  _DrinkScreenState createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text("Drinks Screen"),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            return AlertDialog(title: Text("Generate Drink"));
          },
        ));
  }
}
