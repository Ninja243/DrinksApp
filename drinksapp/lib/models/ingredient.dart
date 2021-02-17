import 'package:drinksapp/common/enums.dart';

class Ingredient {
  String name;
  int percentage;
  int amountAvailable;
  ingredientType itype;
  Ingredient({this.name, this.percentage, this.amountAvailable, this.itype});

  Ingredient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    percentage = json["percentage"];
    amountAvailable = json[amountAvailable];
    itype = json[itype];
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
