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
    if (json.containsKey("name")){
       name = json['name'];
    } 
    if (json.containsKey("ingredients")) {
       i = json["ingredients"];
    }
    if (json.containsKey("percentage")) {
      percentage = json["percentage"];
    }
    if (json.containsKey("recepie")) {
      recepie = json["recepie"];
    }
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
