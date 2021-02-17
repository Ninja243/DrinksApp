import 'package:drinksapp/common/enums.dart';
import 'package:flutter/material.dart';

class Ingredient {
  String name;
  double percentage;
  double amountAvailable;
  IngredientType itype;
  Ingredient({
    @required this.name, 
  @required this.percentage, 
  @required this.amountAvailable, 
  @required this.itype});

  Ingredient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    percentage = json["percentage"];
    amountAvailable = json["amountAvailable"];
    itype = json["itype"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['percentage'] = this.percentage;
    data['amountAvailable'] = this.amountAvailable;
    data['itype'] = this.itype;
    return data;
  }
}
