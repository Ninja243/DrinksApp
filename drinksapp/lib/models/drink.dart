class Drink {
  String name;
  Ingredient[] i;
  int percentage;
  String recepie;

  Drink(
      {
        required this.name,
        required this.i,
        required this.percentage,
        required this.recepie
      });

  Drink.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    i = json["ingredients"];
    percentage = json["percentage"];
    recepie = json["recepie"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['ingredients'] = this.i;
    data['percentage'] = this.percentage;
    data['recepie'] = this.recepie;
    return data;
  }
}
