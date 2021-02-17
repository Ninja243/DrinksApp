import 'package:drinksapp/models/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:drinksapp/common/enums.dart';

class IngredientScreen extends StatefulWidget {
  @override
  _IngredientScreenState createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  final items = List<Ingredient>.generate(
      1500,
      (index) => Ingredient(
          name: "Ingredient $index",
          amountAvailable: index,
          percentage: index,
          itype: ingredientType.noAlcohol));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${items[index].name} (${items[index].percentage}%)"),
            subtitle: Text("${items[index].itype}"),
            tileColor: items[index].percentage > 40? Colors.red : items[index].percentage > 25 ? Colors.amber : Colors.white,
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
