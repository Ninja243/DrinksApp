import 'package:drinksapp/common/enums.dart';
import 'package:flutter/material.dart';

class Ingredient {
  String name;
  double percentage;
  double amountAvailable;
  IngredientType itype;
  
  Ingredient(String name, double percentage, double amountAvailable) {
    this.name = name;
    this.percentage = percentage;
    this.amountAvailable = amountAvailable;
    this.itype = this.percentage > 35 ? IngredientType.STRONG_ALCOHOLIC_DRINK : this.percentage > 4 ? IngredientType.WEAK_ALCOHOLIC_DRINK:IngredientType.NON_ALCOHOLIC_DRINK;
  }

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
