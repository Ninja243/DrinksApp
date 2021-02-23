import 'package:drinksapp/models/drink.dart';
import 'package:flutter/material.dart';
import 'package:drinksapp/common/enums.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

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
