import 'package:drinksapp/models/drink_text.dart';
import 'package:flutter/material.dart';

class DrinkDetails extends StatelessWidget {
  static const routeName = "/drink-detail";

  @override
  Widget build(BuildContext context) {
    final DrinkText args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(child: Text(args.recipe),),
      appBar: AppBar(
        title: Text(
          args.name,
          style: TextStyle(fontSize: 70.0, fontFamily: "Canterbury"),
        ),
        
      
      ),
      
    );
  }
}
