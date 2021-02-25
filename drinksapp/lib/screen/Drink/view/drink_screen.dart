import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:drinksapp/common/enums.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:drinksapp/controller/drink_controller.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:drinksapp/controller/settings_controller.dart';
=======
>>>>>>> 740481040c57cc96026497ed753fc1c54a803e0c

class DrinkScreen extends StatefulWidget {
  @override
  _DrinkScreenState createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen> {
  DrinkController _drinkController;

  TextEditingController _drinkNameController;
  TextEditingController _drinkPercentageController;
  TextEditingController _drinkAmountController;
  double _drinkPercentage;

  SettingsController _settingsController;

  @override
  void initState() {
    super.initState();
    _settingsController = Get.put(new SettingsController());
    _drinkController = Get.put(new DrinkController());
    _drinkPercentageController = TextEditingController();
    _drinkAmountController = TextEditingController();
    _drinkNameController = TextEditingController();
    _drinkPercentage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            return AlertDialog(title: Text("Generate Drink"));
          },
        ),
        body: ListView.builder(itemBuilder: (BuildContext context, int index) {
          return ExpansionCard(
            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      
                    "${_drinkController.getDrink(index).name} (${_drinkController.getDrink(index).percentage}%)",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Sub",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
