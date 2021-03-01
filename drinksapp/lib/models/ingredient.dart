import 'package:drinksapp/common/enums.dart';

class Ingredient {
  String name;
  double percentage;
  double amountAvailable;
  IngredientType itype;

  Ingredient(String name, double percentage, double amountAvailable) {
    this.name = name;
    this.percentage = percentage;
    this.amountAvailable = amountAvailable;
    this.itype = this.percentage > 20
        ? IngredientType.STRONG_ALCOHOLIC_DRINK
        : this.percentage > 1
            ? IngredientType.WEAK_ALCOHOLIC_DRINK
            : IngredientType.NON_ALCOHOLIC_DRINK;
  }

  Ingredient.fromData(String name, double percentage, double amountAvailable,
      IngredientType itype) {
    this.name = name;
    this.percentage = percentage;
    this.amountAvailable = amountAvailable;
    this.itype = itype;
  }

  void updateData(String name, double percentage, double amountAvailable) {
    this.name = name;
    this.percentage = percentage;
    this.amountAvailable = amountAvailable;
    this.itype = this.percentage > 35
        ? IngredientType.STRONG_ALCOHOLIC_DRINK
        : this.percentage > 4
            ? IngredientType.WEAK_ALCOHOLIC_DRINK
            : IngredientType.NON_ALCOHOLIC_DRINK;
  }

  void update() {
    this.itype = this.percentage > 35
        ? IngredientType.STRONG_ALCOHOLIC_DRINK
        : this.percentage > 4
            ? IngredientType.WEAK_ALCOHOLIC_DRINK
            : IngredientType.NON_ALCOHOLIC_DRINK;
  }

  Ingredient.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.percentage = json["percentage"];
    this.amountAvailable = json["amountAvailable"];
    this.itype =
        IngredientType.values.firstWhere((e) => e.toString() == json["itype"]);
  }

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'percentage': this.percentage,
        'amountAvailable': this.amountAvailable,
        'itype': this.itype.toString(),
      };
}
