import 'package:drinksapp/models/drink_text.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class DrinkDetails extends StatelessWidget {
  static const routeName = "/drink-detail";

  @override
  Widget build(BuildContext context) {
    final DrinkText args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: Text("For this drink, you're going to need:\n"+args.ingredients+"\n"+ args.recipe),
        appBar: AppBar(
          title: Text(
            args.name,
            style: TextStyle(fontSize: 30.0, fontFamily: "Canterbury"),
          ),
        ));
  }
}
