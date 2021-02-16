class Drink {
  String name = "<error>";
  Ingredient[] i = {};
  int percentage = -1;
  String recipe = "<error>";

  Drink(
      {
        required this.name,
        required this.i,
        required this.percentage,
        required this.recipe
      });

  Drink.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    i = json["ingredients"];
    percentage = json["percentage"];
    recipe = json["recipe"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['ingredients'] = this.i;
    data['percentage'] = this.percentage;
    data['recepie'] = this.recipe;
    return data;
  }
}
