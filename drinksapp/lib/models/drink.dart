import 'package:drinksapp/models/ingredient.dart';

class Drink {
  String name = "";
  List<Ingredient> i = <Ingredient>[];
  int percentage = -1;
  String recipe = "";

  Drink();
  Drink.withArgs({this.name, this.i, this.percentage, this.recipe});

  Drink.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['i'] != null) {
      i = new List<Ingredient>();
      json['i'].forEach((v) {
        i.add(new Ingredient.fromJson(v));
      });
    }
    percentage = json['percentage'];
    recipe = json['recipe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.i != null) {
      data['i'] = this.i.map((v) => v.toJson()).toList();
    }
    data['percentage'] = this.percentage;
    data['recipe'] = this.recipe;
    return data;
  }

  String generateIngredientString() {
    String out = "";
    for (Ingredient s in i) {
      out = out + "\n" + s.name;
    }
    return out;
  }
}
