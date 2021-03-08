import 'package:drinksapp/models/drink_text.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:progressive_image/progressive_image.dart';


extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this
      .split(" ")
      .map((str) => str[0].toUpperCase() + str.substring(1))
      .join(" ");
  String get normalize => this.split(".").map((str) {
        if (str.length > 1) {
          int j = 0;
          while (str[j] == " ") {
            j = j + 1;
          }
          return str[j].toUpperCase() + str.substring(j + 1);
        }
        return "";
      }).join(".\n");
}

class DrinkDetails extends StatelessWidget {
  static const routeName = "/drink-detail";

  @override
  Widget build(BuildContext context) {
    final DrinkText args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: Center(child:Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: ListView(shrinkWrap: true,children: [
              Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 40),child:ProgressiveImage(

                placeholder: AssetImage('lib/assets/cocktail.png'),
                // size: 1.87KB
                thumbnail: NetworkImage('https://picsum.photos/200/2800'),
                // size: 1.29MB
                image: NetworkImage('https://picsum.photos/200/2800'),
                height: 200,
                fit: BoxFit.fill, width: double.infinity,)),
              Text(
                "For this drink, you're going to need:\n" +
                    args.ingredients +
                    "\n\n",
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
              Text(
                args.recipe.normalize,
                style: TextStyle(),
              )
            ]))),
            appBar: AppBar(
              title: Text(
                args.name+" (${args.percentage})%",
                style: TextStyle(fontSize: 30.0, fontFamily: "Canterbury"),
              ),
            ));
  }
}
