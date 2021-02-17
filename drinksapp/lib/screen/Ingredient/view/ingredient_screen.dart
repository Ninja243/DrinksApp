import 'dart:ffi';

import 'package:drinksapp/models/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:drinksapp/common/enums.dart';
import 'package:drinksapp/controller/ingredient_controller.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class IngredientScreen extends StatefulWidget {
  @override
  _IngredientScreenState createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  IngredientController _itemController;
  TextEditingController _ingredientNameController;
  double _ingredientPercentage;
  double _ingredientAmount;
  IngredientType _ingredientType;

  @override
  void initState() {
    super.initState();
    _itemController = Get.put(new IngredientController());
    _ingredientNameController = TextEditingController();
    _ingredientPercentage = 0;
    _ingredientAmount = 0;
    _ingredientType = IngredientType.NON_ALCOHOLIC_DRINK;
  }

  @override
  void dispose() {
    _ingredientNameController.dispose();
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Add Ingredient"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _ingredientNameController,
                          decoration:
                              InputDecoration(hintText: "Ingredient name"),
                        ),
                        NumberPicker.decimal(
                            initialValue: 1,
                            minValue: 0,
                            maxValue: 50,
                            onChanged: (i) =>
                                this._ingredientPercentage = i),
                        NumberPicker.decimal(
                            initialValue: 1,
                            minValue: 0,
                            maxValue: 50,
                            onChanged: (i) => this._ingredientAmount = i),
                        DropdownButton<IngredientType>(
                            items: IngredientType.values
                                .map((IngredientType it) {
                          return DropdownMenuItem<IngredientType>(
                              child: Text(it.toString()), value: it);
                        }).toList())
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Add"),
                        onPressed: () {
                          // TODO add to getX
                          _itemController.addIngredient(new Ingredient(
                              amountAvailable: _ingredientAmount,
                              name: _ingredientNameController.text,
                              percentage: _ingredientPercentage, itype: _ingredientType));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          },
        ),
        body: Obx(() {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                    "${_itemController.getIngredient(index).name} (${_itemController.getIngredient(index).percentage}%)"),
                subtitle: Text("${_itemController.getIngredient(index).itype}"),
                tileColor: _itemController.getIngredient(index).percentage > 40
                    ? Colors.red
                    : _itemController.getIngredient(index).percentage > 25
                        ? Colors.amber
                        : Colors.white,
              );
            },
            itemCount: _itemController.getIngredients().length,
          );
        }));
  }
}
